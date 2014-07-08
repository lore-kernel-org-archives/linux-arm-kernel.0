From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 8 Jul 2014 10:13:03 -0400
Subject: [PATCH v2 0/8] DMAEngine support for sun4i, sun5i & sun7i
In-Reply-To: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAKON4OzB4fY3HEOkQTL_YgnWk3YDGoU+o2eApt-XhxN-q63i4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ALSA SOC needs support for cyclic DMA. Here's my attempt at
implementing it, but I have not succeeded in getting it working with
ALSA yet.

Code based on previous generation of this patch series....
Let me know if you are interested in the ALSA code supporting the on-chip codec.

+static struct dma_async_tx_descriptor *sun4i_dma_prep_dma_cyclic(
+ struct dma_chan *chan, dma_addr_t buf, size_t len,
+ size_t period_len, enum dma_transfer_direction dir,
+ unsigned long flags, void *context) {
+ struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+ struct dma_slave_config *sconfig = &vchan->cfg;
+ struct sun4i_ddma_promise *promise;
+ struct sun4i_ddma_contract *contract;
+ dma_addr_t src, dest;
+
+ if (!is_slave_direction(dir)) {
+ dev_err(chan2dev(chan), "Invalid DMA direction\n");
+ return NULL;
+ }
+
+ contract = generate_ddma_contract();
+ if (!contract)
+ return NULL;
+
+ /* Figure out addresses */
+ if (dir == DMA_MEM_TO_DEV) {
+ src = buf;
+ dest = sconfig->dst_addr;
+ } else {
+ src = sconfig->src_addr;
+ dest = buf;
+ }
+
+ if (vchan->is_dedicated)
+ promise = generate_ddma_promise(chan, src, dest, len, sconfig);
+ else
+ promise = generate_ndma_promise(chan, src, dest, len, sconfig);
+
+ if (!promise) {
+ kfree(contract);
+ return NULL;
+ }
+
+ /* Figure out endpoints */
+ if (vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
+ promise->cfg |= DDMA_CFG_CONT_MODE |
DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+    DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_LINEAR) |
+    DDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
+    DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_IO);
+ } else if (!vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
+ promise->cfg |= NDMA_CFG_CONT_MODE |
NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
+    NDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
+    NDMA_CFG_DEST_FIXED_ADDR;
+ } else if (vchan->is_dedicated) {
+ promise->cfg |= DDMA_CFG_CONT_MODE | DDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+    DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_IO) |
+    DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+    DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_LINEAR);
+ } else {
+ promise->cfg |= NDMA_CFG_CONT_MODE | NDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+    NDMA_CFG_SRC_FIXED_ADDR |
+    NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM);
+ }
+
+ /* Fill the contract with our only promise */
+ list_add_tail(&promise->list, &contract->demands);
+
+ /* And add it to the vchan */
+ return vchan_tx_prep(&vchan->vc, &contract->vd, flags);
+}
+

+static int sun4i_dma_device_slave_caps(struct dma_chan *dchan,
+      struct dma_slave_caps *caps)
+{
+ caps->src_addr_widths = 32;
+ caps->dstn_addr_widths = 32;
+ caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+ caps->cmd_pause = true;
+ caps->cmd_terminate = true;
+ caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+ return 0;
+}
+
 static int sun4i_dma_probe(struct platform_device *pdev)
 {
  struct sun4i_ddma_dev *priv;
@@ -962,7 +1057,9 @@ static int sun4i_dma_probe(struct platform_device *pdev)
  priv->slave.device_issue_pending = sun4i_dma_issue_pending;
  priv->slave.device_prep_slave_sg = sun4i_dma_prep_slave_sg;
  priv->slave.device_prep_dma_memcpy = sun4i_dma_prep_dma_memcpy;
+ priv->slave.device_prep_dma_cyclic = sun4i_dma_prep_dma_cyclic;
  priv->slave.device_control = sun4i_dma_control;
+ priv->slave.device_slave_caps = sun4i_dma_device_slave_caps;
  priv->slave.chancnt = DDMA_NR_MAX_VCHANS;

  priv->slave.dev = &pdev->dev;

On Sun, Jul 6, 2014 at 12:05 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi everyone,
>
> As part of Google Summer of Code, I've tasked myself with implementing
> DMA support for the earlier Allwinner platforms. This second round of
> patches is the result of said effort.
>
> The first patch is the actual driver to support these platforms. Patches
> three, four and five add the corresponding DMA node to the sun4i,
> sun5i and sun7i device trees.
>
> The second patch, involving the sunxi SPI driver, lets users do SPI
> transfers of >=64 bytes by using DMA. The first round of patches also
> had a patch for 8250_dw letting it use DMA as well, but there were some
> issues causing underruns and "too much work for IRQ", so I have dropped
> them. It's worth noting that Allwinner themselves don't use DMA
> transfers on their 8250 driver on the SDK.
>
> Patches six, seven and eight add the DMA properties to SPI so the first
> two patches can be used. Patches nine, ten and eleven are *only intended
> for testing*, and add a dummy SPIdev device to cubieboard, cubietruck
> and A10S-OLinuXino to facilitate testing with spidev_test.
>
> My main testing procedure for SPI has been modified versions of
> spidev_test from the kernel tree, with and without shorting MISO and
> MOSI. For memory to memory transfers, I have used dmatest.ko with
> various configurations. I have done testing on a cubieboard (A10, sun4i)
> and cubietruck (A20, sun7i) as well as an A10S-OLinuXino.
>
> You will find some extra remarks on individual patches after their
> descriptions. All comments are welcome.
>
> Thanks!
>
> Emilio L?pez (8):
>   dma: sun4i: Add support for the DMA engine on sun[457]i SoCs
>   spi: sun4i: add DMA support
>   ARM: sun4i: Add node to represent the DMA controller
>   ARM: sun5i: Add nodes to represent the DMA controllers
>   ARM: sun7i: Add node to represent the DMA controller
>   ARM: sun4i: enable DMA on SPI
>   ARM: sun5i: enable DMA on SPI
>   ARM: sun7i: enable DMA on SPI
>
>  .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
>  arch/arm/boot/dts/sun4i-a10.dtsi                   |   16 +
>  arch/arm/boot/dts/sun5i-a10s.dtsi                  |   14 +
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |   14 +
>  arch/arm/boot/dts/sun7i-a20.dtsi                   |   16 +
>  drivers/dma/Kconfig                                |   10 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/sun4i-dma.c                            | 1025 ++++++++++++++++++++
>  drivers/spi/spi-sun4i.c                            |  155 ++-
>  9 files changed, 1285 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
>  create mode 100644 drivers/dma/sun4i-dma.c
>
> --
> 2.0.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Jon Smirl
jonsmirl at gmail.com
