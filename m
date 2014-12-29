From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Dec 2014 14:33:42 -0200
Subject: Generic slave capabilities reporting
In-Reply-To: <CAOMZO5CPcRFJEsnYuATESSArcCbiVCGuAhdq67iR7hF3UPbs6Q@mail.gmail.com>
References: <CAOMZO5CPcRFJEsnYuATESSArcCbiVCGuAhdq67iR7hF3UPbs6Q@mail.gmail.com>
Message-ID: <CAOMZO5BuAU552XVWe-dDRBS-0vFJmxonJPS1ztgyCm3Aiz0Edw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 2:25 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Maxime,
>
> Since commit ecc19d17868be9c ("dmaengine: Add a warning for drivers
> not using the generic slave caps retrieval") I am getting the
> following warning on mx6:
>
> [    0.113023] ------------[ cut here ]------------
> [    0.113053] WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:830
> dma_async_device_register+0x2a0/0x4c8()
> [    0.113063] this driver doesn't support generic slave capabilities reporting
> [    0.113073] Modules linked in:
> [    0.113094] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.19.0-rc1-next-20141226 #2297
> [    0.113104] Hardware name: Freescale i.MX6 SoloX (Device Tree)
>
> What dma driver could I take as an example to implement this generic
> slave capabilities reporting?

It seems I need to do the same as you did in the sunxi dma driver:

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1595,6 +1595,14 @@ static int sdma_probe(struct platform_device *pdev)
     sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
     sdma->dma_device.device_config = sdma_config;
     sdma->dma_device.device_terminate_all = sdma_disable_channel;
+    sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+                          BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+                          BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+    sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+                          BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+                          BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+    sdma->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+    sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
     sdma->dma_device.device_issue_pending = sdma_issue_pending;
     sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
     dma_set_max_seg_size(sdma->dma_device.dev, 65535);

Regards,

Fabio Estevam
