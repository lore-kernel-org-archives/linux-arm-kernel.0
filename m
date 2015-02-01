From: plaes@plaes.org (Priit Laes)
Date: Sun, 01 Feb 2015 12:03:58 +0200
Subject: [linux-sunxi] [PATCH v4] dma: sun4i: Add support for the DMA
 engine on sun[457]i SoCs
In-Reply-To: <1422745124-22103-2-git-send-email-emilio@elopez.com.ar>
References: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>
 <1422745124-22103-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <1422785038.28275.34.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-01-31 at 19:58 -0300, Emilio L?pez wrote:
> This patch adds support for the DMA engine present on Allwinner A10, 
> A13, A10S and A20 SoCs. This engine has two kinds of channels: 
> normal and dedicated. The main difference is in the mode of 
> operation; while a single normal channel may be operating at any 
> given time, dedicated channels may operate simultaneously provided 
> there is no overlap of source or destination.
> 
> Hardware documentation can be found on A10 User Manual (section 12), 
> A13 User Manual (section 14) and A20 User Manual (section 1.12)
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> (Partial?) changes from v3:
>  * Drop threaded IRQ to get lower latency
>  * Drop chancnt
>  * Fix crash on first use when using a DMA-aware bootloader (eg., one
>    that supports NAND)
> 
> Changes from v2:
>  * Faster memcpy
>  * Quicker cyclic transfers
>  * Address some stylistic and locking comments from Maxime
>  * probably some more stuff I'm forgetting
> 
> Changes from v1:
>  * address comments from Chen-Yu and Maxime
>  * fix issue converting bus width
>  * switch to using a threaded IRQ instead of a tasklet on
>    recommendation from Maxime
>  * fix issue setting magic timing parameter for SPI transfers
>  * fix an issue with list handling reported by the kbuild 0-DAY robot (thanks!)
>  * drop a lot of unused #define
>  * probably some more stuff I'm forgetting
> 
>  .../devicetree/bindings/dma/sun4i-dma.txt          |   46 +
>  drivers/dma/Kconfig                                |   11 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/sun4i-dma.c                            | 1264 ++++++++++++++++++++
>  4 files changed, 1322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
>  create mode 100644 drivers/dma/sun4i-dma.c
> 
> diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
> new file mode 100644
> index 0000000..f1634a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
> @@ -0,0 +1,46 @@
> +Allwinner A10 DMA Controller

Don't you want to mention A13, A10S and A20 too?

> +
> +This driver follows the generic DMA bindings defined in dma.txt.
> +
> +Required properties:
> +
> +- compatible:  Must be "allwinner,sun4i-a10-dma"
> +- reg:         Should contain the registers base address and length
> +- interrupts:  Should contain a reference to the interrupt used by this device
> +- clocks:      Should contain a reference to the parent AHB clock
> +- #dma-cells : Should be 2, first cell denoting normal or dedicated dma,
> +               second cell holding the request line number.
> +
> +Example:
> +       dma: dma-controller at 01c02000 {
> +               compatible = "allwinner,sun4i-a10-dma";
> +               reg = <0x01c02000 0x1000>;
> +               interrupts = <27>;
> +               clocks = <&ahb_gates 6>;
> +               #dma-cells = <2>;
> +       };
> +
> +Clients:
> +
> +DMA clients connected to the Allwinner A10 DMA controller must use the

Ditto.

> +format described in the dma.txt file, using a three-cell specifier 
> for
> +each channel: a phandle plus two integer cells.
> +The three cells in order are:
> +
> +1. A phandle pointing to the DMA controller.
> +2. Whether it is using normal (0) or dedicated (1) channels
> +3. The port ID as specified in the datasheet
> +
> +Example:
> +       spi2: spi at 01c17000 {
> +               compatible = "allwinner,sun4i-a10-spi";
> +               reg = <0x01c17000 0x1000>;
> +               interrupts = <0 12 4>;
> +               clocks = <&ahb_gates 22>, <&spi2_clk>;
> +               clock-names = "ahb", "mod";
> +               dmas = <&dma 1 29>, <&dma 1 28>;
> +               dma-names = "rx", "tx";
> +               status = "disabled";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index f2b2c4e..a15374e 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -416,6 +416,17 @@ config NBPFAXI_DMA
>         help
>                         Support for "Type-AXI" NBPF DMA IPs from Renesas
>  
> +config SUN4I_DMA
> +       tristate "Allwinner A10 DMA support"
Ditto.

> +       depends on (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || 
> (COMPILE_TEST && OF && ARM))
> +       default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
> +       select DMA_ENGINE
> +       select DMA_OF
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +                       Enable support for the DMA controller present in the sun4i,
> +                       sun5i and sun7i Allwinner ARM SoCs.
> +
>  config DMA_ENGINE
>         bool
>  
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 2022b54..675b98f 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -50,3 +50,4 @@ obj-y += xilinx/
>  obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
>  obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>  obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
> +obj-$(CONFIG_SUN4I_DMA) += sun4i-dma.o
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c new file mode 100644
> index 0000000..a025405
> --- /dev/null
> +++ b/drivers/dma/sun4i-dma.c
> @@ -0,0 +1,1264 @@
> +/*
> + * Copyright (C) 2014 Emilio L?pez

2014, 2015 ?

> + * Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +#include 
> +
> +#include "virt-dma.h"
> +

[...]

> +static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device 
> *dev)
> +{
> +       return container_of(dev, struct sun4i_dma_dev, slave);
> +}
> +
> +static struct sun4i_dma_vchan *to_sun4i_dma_vchan(struct dma_chan *chan)
> +{
> +       return container_of(chan, struct sun4i_dma_vchan, vc.chan);
> +}
> +
> +static struct sun4i_dma_contract *to_sun4i_dma_contract(struct virt_dma_desc *vd)
> +{
> +       return container_of(vd, struct sun4i_dma_contract, vd);
> +}
> +
> +static struct device *chan2dev(struct dma_chan *chan)
> +{
> +       return &chan->dev->device;
> +}
> +
> +static int convert_burst(u32 maxburst)
> +{
> +       if (maxburst > 8)
> +               return -EINVAL;
Would it make sense to add check for maxburst = 0 too?



> +
> +       /* 1 -> 0, 4 -> 1, 8 -> 2 */
> +       return (maxburst >> 2);
> +}
> +
> +static int convert_buswidth(enum dma_slave_buswidth addr_width)
> +{
> +       if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
> +               return -EINVAL;
> +
> +       /* 8 (1 byte) -> 0, 16 (2 bytes) -> 1, 32 (4 bytes) -> 2 */
> +       return (addr_width >> 1);
> +}
> +
> +static int choose_optimal_buswidth(dma_addr_t addr)
> +{
> +       /* On 32 bit aligned addresses, we can use a 32 bit bus width */
> +       if (addr % 4 == 0)

Not sure, whether it makes sense to optimize or not, but this can be 
calculated like this:

(addr & (4 - 1)) == 0

> +               return DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       /* On 16 bit aligned addresses, we can use a 16 bit bus width */
> +       else if (addr % 2 == 0)
(addr & (2 - 1)) == 0
> +               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> +
> +       /* Worst-case scenario, we need to do byte aligned reads */
> +       return DMA_SLAVE_BUSWIDTH_1_BYTE;
> +}
> +
> 

...


> 
> +
> +static void configure_pchan(struct sun4i_dma_pchan *pchan,
> +                                                       struct sun4i_dma_promise *d)
> +{
> +       /*
> +               * Configure addresses and misc parameters depending on type
> +               * DDMA has an extra field with timing parameters
> +               */
> +       if (pchan->is_dedicated) {
> +               writel_relaxed(d->src, pchan->base + DDMA_SRC_ADDR_REG);
> +               writel_relaxed(d->dst, pchan->base + DDMA_DEST_ADDR_REG);
> +               writel_relaxed(d->len, pchan->base + DDMA_BYTE_COUNT_REG);
> +               writel_relaxed(d->para, pchan->base + DDMA_PARA_REG);
> +               writel_relaxed(d->cfg, pchan->base + DDMA_CFG_REG);
> +       } else {
> +               writel_relaxed(d->src, pchan->base + NDMA_SRC_ADDR_REG);
> +               writel_relaxed(d->dst, pchan->base + NDMA_DEST_ADDR_REG);
> +               writel_relaxed(d->len, pchan->base + NDMA_BYTE_COUNT_REG);
> +               writel_relaxed(d->cfg, pchan->base + NDMA_CFG_REG);
> +       }
> +}
> +
> +static void set_pchan_interrupt(struct sun4i_dma_dev *priv,
> +                               struct sun4i_dma_pchan *pchan,
> +                               int half, int end)
> +{
> +       u32 reg;
> +       int pchan_number = pchan - priv->pchans;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +
> +       reg = readl_relaxed(priv->base + DMA_IRQ_ENABLE_REG);
> +
> +       if (half)
> +               reg |= BIT(pchan_number * 2);
> +       else
> +               reg &= ~BIT(pchan_number * 2);
> +
> +       if (end)
> +               reg |= BIT(pchan_number * 2 + 1);
> +       else
> +               reg &= ~BIT(pchan_number * 2 + 1);
> +
> +       writel_relaxed(reg, priv->base + DMA_IRQ_ENABLE_REG);
> +
> +       spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +/**
> + * Generate a promise, to be used in a dedicated DMA contract.
> + *
> + * A DDMA promise contains all the information required to program the
> + * Dedicated part of the DMA Engine and get data copied. A non-executed
> + * promise will live in the demands list on a contract. Once it has been
> + * completed, it will be moved to the completed demands list for later freeing.
> + * All linked promises will be freed when the corresponding contract is freed
> + */
> +static struct sun4i_dma_promise *
> +generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
> +                                                               size_t len, struct dma_slave_config *sconfig)
> +{
> +       struct sun4i_dma_promise *promise;
> +       int ret;
> +
> +       promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
> +       if (!promise)
> +               return NULL;
> +
> +       promise->src = src;
> +       promise->dst = dest;
> +       promise->len = len;
> +

No timing parameters or this is just a quirk required for SPI?

>        promise->cfg = DDMA_CFG_LOADING | 
> DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
> +
> +       /* Source burst */
> +       ret = convert_burst(sconfig->src_maxburst);
> +       if (IS_ERR_VALUE(ret))
> +               goto fail;
> +       promise->cfg |= DDMA_CFG_SRC_BURST_LENGTH(ret);
> +
> +       /* Destination burst */
> +       ret = convert_burst(sconfig->dst_maxburst);
> +       if (IS_ERR_VALUE(ret))
> +               goto fail;
> +       promise->cfg |= DDMA_CFG_DEST_BURST_LENGTH(ret);
> +
> +       /* Source bus width */
> +       ret = convert_buswidth(sconfig->src_addr_width);
> +       if (IS_ERR_VALUE(ret))
> +               goto fail;
> +       promise->cfg |= DDMA_CFG_SRC_DATA_WIDTH(ret);
> +
> +       /* Destination bus width */
> +       ret = convert_buswidth(sconfig->dst_addr_width);
> +       if (IS_ERR_VALUE(ret))
> +               goto fail;
> +       promise->cfg |= DDMA_CFG_DEST_DATA_WIDTH(ret);
> +
> +       return promise;
> +
> +fail:
> +       kfree(promise);
> +       return NULL;
> +}
> +
[...]

P?ikest,
Priit :)
