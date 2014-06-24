From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 24 Jun 2014 10:02:21 -0300
Subject: [PATCH 01/10] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <CAGb2v642rbCo18MqMicspCavbSPjfH8qR5eAVKqwVBspSm+vEQ@mail.gmail.com>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
 <1402890635-12342-2-git-send-email-emilio@elopez.com.ar>
 <CAGb2v642rbCo18MqMicspCavbSPjfH8qR5eAVKqwVBspSm+vEQ@mail.gmail.com>
Message-ID: <53A976DD.6060005@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 21/06/14 10:51, Chen-Yu Tsai escribi?:
> On Mon, Jun 16, 2014 at 11:50 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> This patch adds support for the DMA engine present on Allwinner A10,
>> A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
>> and dedicated. The main difference is in the mode of operation;
>> while a single normal channel may be operating at any given time,
>> dedicated channels may operate simultaneously provided there is no
>> overlap of source or destination.
>>
>> Hardware documentation can be found on A10 User Manual (section 12), A13
>> User Manual (section 14) and A20 User Manual (section 1.12)
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>>
>> For some mem2dev/dev2mem transfers, we need to configure some magic delays
>> for things to work - on my experimental testing, 0x00010001 seems to work
>> for SPI. Is there some place in the API to pass these kinds of values from
>> client drivers when configuring a transfer? Currently I have just hardcoded
>> this value on the driver, but it'll probably cause trouble in the future
>> for other devices.
>>
>>   .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
>>   drivers/dma/Kconfig                                |   10 +
>>   drivers/dma/Makefile                               |    1 +
>>   drivers/dma/sun4i-dma.c                            | 1065 ++++++++++++++++++++
>>   4 files changed, 1121 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
>>   create mode 100644 drivers/dma/sun4i-dma.c
>>
>> diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
>> new file mode 100644
>> index 0000000..f5661a5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
>> @@ -0,0 +1,45 @@
>> +Allwinner A10 DMA Controller
>> +
>> +This driver follows the generic DMA bindings defined in dma.txt.
>> +
>> +Required properties:
>> +
>> +- compatible:  Must be "allwinner,sun4i-a10-dma"
>> +- reg:         Should contain the registers base address and length
>> +- interrupts:  Should contain a reference to the interrupt used by this device
>> +- clocks:      Should contain a reference to the parent AHB clock
>> +- #dma-cells : Should be 1, a single cell holding a line request number
>> +
>> +Example:
>> +       dma: dma-controller at 01c02000 {
>> +               compatible = "allwinner,sun4i-a10-dma";
>> +               reg = <0x01c02000 0x1000>;
>> +               interrupts = <27>;
>> +               clocks = <&ahb_gates 6>;
>> +               #dma-cells = <1>;
>> +       };
>> +
>> +Clients:
>> +
>> +DMA clients connected to the Allwinner A10 DMA controller must use the
>> +format described in the dma.txt file, using a three-cell specifier for
>> +each channel: a phandle plus two integer cells.
>> +The three cells in order are:
>> +
>> +1. A phandle pointing to the DMA controller.
>> +2. Whether it is using normal (0) or dedicated (1) channels
>> +2. The port ID as specified in the datasheet
>> +
>> +Example:
>> +       spi2: spi at 01c17000 {
>> +               compatible = "allwinner,sun4i-a10-spi";
>> +               reg = <0x01c17000 0x1000>;
>> +               interrupts = <0 12 4>;
>> +               clocks = <&ahb_gates 22>, <&spi2_clk>;
>> +               clock-names = "ahb", "mod";
>> +               dmas = <&dma 1 29>, <&dma 1 28>;
>> +               dma-names = "rx", "tx";
>> +               status = "disabled";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +       };
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index ba06d1d..a9ee0c9 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -361,6 +361,16 @@ config FSL_EDMA
>>            multiplexing capability for DMA request sources(slot).
>>            This module can be found on Freescale Vybrid and LS-1 SoCs.
>>
>> +config SUN4I_DMA
>> +       tristate "Allwinner A10/A10S/A13/A20 DMA support"
>> +       depends on ARCH_SUNXI
>> +       select DMA_ENGINE
>> +       select DMA_OF
>> +       select DMA_VIRTUAL_CHANNELS
>> +       help
>> +         Enable support for the DMA controller present in the sun4i,
>> +         sun5i and sun7i Allwinner ARM SoCs.
>> +
>
> Conflict here and in drivers/dma/Makefile when applied to 3.16-rc1.

I worked on this on top of 3.15, so it's not really unexpected :) I'll 
rebase it for v2.

>
>>   config DMA_ENGINE
>>          bool
>>
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 5150c82..13a7d5d 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -46,3 +46,4 @@ obj-$(CONFIG_K3_DMA) += k3dma.o
>>   obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
>>   obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>>   obj-$(CONFIG_QCOM_BAM_DMA) += qcom_bam_dma.o
>> +obj-$(CONFIG_SUN4I_DMA) += sun4i-dma.o
>> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
>> new file mode 100644
>> index 0000000..0b14b3f
>> --- /dev/null
>> +++ b/drivers/dma/sun4i-dma.c
(...)
>> +/* A contract is a set of promises */
>> +struct sun4i_dma_contract {
>> +       struct virt_dma_desc            vd;
>> +       struct list_head                demands;
>> +       struct list_head                completed_demands;
>> +};
>> +
>> +struct sun4i_dma_dev {
>> +       DECLARE_BITMAP(pchans_used, DDMA_NR_MAX_CHANNELS);
>
> Should be DMA_NR_MAX_CHANNELS, right?

Indeed, I'll fix it.

>
>> +       struct tasklet_struct           tasklet;
>> +       struct dma_device               slave;
>> +       struct sun4i_dma_pchan          *pchans;
>> +       struct sun4i_dma_vchan          *vchans;
>> +       void __iomem                    *base;
>> +       struct clk                      *clk;
>> +       int                             irq;
>> +       spinlock_t                      lock;
>> +};
(...)
>> +static struct dma_async_tx_descriptor *
>> +sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
>> +                         dma_addr_t src, size_t len, unsigned long flags)
>> +{
>> +       struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>> +       struct dma_slave_config *sconfig = &vchan->cfg;
>> +       struct sun4i_dma_promise *promise;
>> +       struct sun4i_dma_contract *contract;
>> +
>> +       contract = generate_dma_contract();
>> +       if (!contract)
>> +               return NULL;
>> +
>> +       if (vchan->is_dedicated)
>> +               promise = generate_ddma_promise(chan, src, dest, len, sconfig);
>> +       else
>> +               promise = generate_ndma_promise(chan, src, dest, len, sconfig);
>> +
>> +       if (!promise) {
>> +               kfree(contract);
>> +               return NULL;
>> +       }
>> +
>> +       /* Configure memcpy mode */
>> +       if (vchan->is_dedicated) {
>> +               promise->cfg |= DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
>> +                               DDMA_CFG_SRC_NON_SECURE |
>> +                               DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
>> +                               DDMA_CFG_DEST_NON_SECURE;
>
> Are you sure this works? The manual says dedicated DMA can only do
> device to memory or memory to device.

I started by implementing dedicated DMA, and dmatest was happy with it, 
so I suppose it works ok, despite what the manual says.

> Anyway we won't be using this I guess.
>
>> +       } else {
>> +               promise->cfg |= NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
>> +                               NDMA_CFG_SRC_NON_SECURE |
>> +                               NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
>> +                               NDMA_CFG_DEST_NON_SECURE;
>> +       }
>> +
>> +       /* Fill the contract with our only promise */
>> +       list_add_tail(&promise->list, &contract->demands);
>> +
>> +       /* And add it to the vchan */
>> +       return vchan_tx_prep(&vchan->vc, &contract->vd, flags);
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +                       unsigned int sg_len, enum dma_transfer_direction dir,
>> +                       unsigned long flags, void *context)
>> +{
>> +       struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>> +       struct dma_slave_config *sconfig = &vchan->cfg;
>> +       struct sun4i_dma_promise *promise;
>> +       struct sun4i_dma_contract *contract;
>> +       struct scatterlist *sg;
>> +       dma_addr_t srcaddr, dstaddr;
>> +       u32 endpoints, para;
>> +       int i;
>> +
>> +       if (!sgl)
>> +               return NULL;
>> +
>> +       if (!is_slave_direction(dir)) {
>> +               dev_err(chan2dev(chan), "Invalid DMA direction\n");
>> +               return NULL;
>> +       }
>> +
>> +       contract = generate_dma_contract();
>> +       if (!contract)
>> +               return NULL;
>> +
>> +       /* Figure out endpoints */
>> +       if (vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
>> +               endpoints = DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
>> +                           DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_LINEAR) |
>> +                           DDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
>> +                           DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_IO);
>> +       } else if (!vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
>> +               endpoints = NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
>> +                           NDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
>> +                           NDMA_CFG_DEST_FIXED_ADDR;
>> +       } else if (vchan->is_dedicated) {
>> +               endpoints = DDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
>> +                           DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_IO) |
>> +                           DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
>> +                           DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_LINEAR);
>> +       } else {
>> +               endpoints = NDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
>> +                           NDMA_CFG_SRC_FIXED_ADDR |
>> +                           NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM);
>> +       }
>> +
>> +       for_each_sg(sgl, sg, sg_len, i) {
>> +               /* Figure out addresses */
>> +               if (dir == DMA_MEM_TO_DEV) {
>> +                       srcaddr = sg_dma_address(sg);
>> +                       dstaddr = sconfig->dst_addr;
>> +                       para = 0;
>> +               } else {
>> +                       srcaddr = sconfig->src_addr;
>> +                       dstaddr = sg_dma_address(sg);
>> +                       para = 0x00010001; /* TODO spi magic? */
>> +               }
>> +
>> +               /* And make a suitable promise */
>> +               promise = generate_ddma_promise(chan, srcaddr, dstaddr,
>> +                                               sg_dma_len(sg), sconfig);
>
> What about ndma?

Good question :)

>
>> +               if (!promise)
>> +                       return NULL; /* TODO */
>> +
>> +               promise->cfg |= endpoints;
>> +               promise->para = para;
>> +
>> +               /* Then add it to the contract */
>> +               list_add_tail(&promise->list, &contract->demands);
>> +       }
>> +
>> +       /* Once we've got all the promises ready, add the contract
>> +        * to the pending list on the vchan */
>> +       return vchan_tx_prep(&vchan->vc, &contract->vd, flags);
>> +}
(...)
>> +static struct platform_driver sun4i_dma_driver = {
>> +       .probe  = sun4i_dma_probe,
>> +       .remove = sun4i_dma_remove,
>> +       .driver = {
>> +               .name           = "sun4i-dma",
>> +               .of_match_table = sun4i_dma_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(sun4i_dma_driver);
>> +
>> +MODULE_DESCRIPTION("Allwinner A10 Dedicated DMA Controller Driver");
>> +MODULE_AUTHOR("Emilio L?pez <emilio@elopez.com.ar>");
>> +MODULE_LICENSE("GPL");
>
> The rest looks OK, but I'm not very familiar with the dmaengine API.
> Best have a second pair of eyes on it.

Thanks for the review!

Cheers,

Emilio
