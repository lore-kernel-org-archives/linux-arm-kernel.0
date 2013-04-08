From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 16:07:55 +0200
Subject: [RFC v2 PATCH] at_hdmac: move to generic DMA binding
In-Reply-To: <20130408121930.GB6398@ludovic.desroches@atmel.com>
References: <1365403409-18381-1-git-send-email-ludovic.desroches@atmel.com>
 <20130408105515.GU20693@game.jcrosoft.org>
 <20130408121930.GB6398@ludovic.desroches@atmel.com>
Message-ID: <20130408140755.GZ20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:19 Mon 08 Apr     , Ludovic Desroches wrote:
> On Mon, Apr 08, 2013 at 12:55:15PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 08:43 Mon 08 Apr     , ludovic.desroches at atmel.com wrote:
> > > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > 
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > Here is a second try to move at_hdmac to generic DMA binding. I have updated
> > > bindings according to Arnd comments ie I have removed chunk transfer size.
> > > 
> > > I have added the implementation but I am not very happy with the translation
> > > function. I have tried to not break old stuff: slave ask for a channel giving
> > > an atslave structure (passed through pdata) as a parameter for the filter
> > > function which saves this structure into chan->private. Then chan->private
> > > contains the configuration for the channel CFG register which is done when
> > > calling device_alloc_chan_resources.
> > > 
> > > If I allocate the atslave structure in the xlate function, where should be the
> > > right place to deallocate it? For the moment, I choose to add the atslave
> > > structure to the at_dma_chan structure but I am not happy with writing the
> > > channel configuration register into the xlate function. I would like to keep
> > > the same path as before.
> > so allow with devm_
> 
> To my mind it's channel related and not controller related. If the channel is
> released, will the deallocation be done automatically?
when the device is free yes

so free on slave device it's ok

Best Regards,
J.
> 
> > > 
> > > Regards
> > > 
> > > Ludovic
> > > 
> > > 
> > >  .../devicetree/bindings/dma/atmel-dma.txt          | 27 +++++++-
> > >  arch/arm/boot/dts/sama5d3.dtsi                     |  2 +
> > >  drivers/dma/at_hdmac.c                             | 71 ++++++++++++++++++++--
> > >  drivers/dma/at_hdmac_regs.h                        |  7 +++
> > >  4 files changed, 99 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/dma/atmel-dma.txt b/Documentation/devicetree/bindings/dma/atmel-dma.txt
> > > index 3c046ee..2d6f0f3 100644
> > > --- a/Documentation/devicetree/bindings/dma/atmel-dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/atmel-dma.txt
> > > @@ -4,11 +4,34 @@ Required properties:
> > >  - compatible: Should be "atmel,<chip>-dma"
> > >  - reg: Should contain DMA registers location and length
> > >  - interrupts: Should contain DMA interrupt
> > > +- #dma-cells: Must be <2>
> > >  
> > > -Examples:
> > > +Example:
> > >  
> > > -dma at ffffec00 {
> > > +dma0: dma at ffffec00 {
> > >  	compatible = "atmel,at91sam9g45-dma";
> > >  	reg = <0xffffec00 0x200>;
> > >  	interrupts = <21>;
> > > +	#dma-cells = <2>;
> > > +};
> > > +
> > > +DMA clients connected to the Atmel DMA controller must use the format
> > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > +The three cells in order are:
> > > +
> > > +1. A phandle pointing to the DMA controller
> > > +2. The memory interface (16 most significant bits), the peripheral interface
> > > +(16 less significant bits)
> > > +3. The peripheral identifier (can be different for tx and rx)
> > > +
> > > +Example:
> > > +
> > > +i2c0 at i2c@f8010000 {
> > > +	compatible = "atmel,at91sam9x5-i2c";
> > > +	reg = <0xf8010000 0x100>;
> > > +	interrupts = <9 4 6>;
> > > +	dmas = <&dma0 1 7>,
> > > +	       <&dma0 1 8>;
> > > +	dma-names = "tx", "rx"
> > >  };
> > > diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> > > index 39b0458..9232143 100644
> > > --- a/arch/arm/boot/dts/sama5d3.dtsi
> > > +++ b/arch/arm/boot/dts/sama5d3.dtsi
> > > @@ -349,6 +349,7 @@
> > >  				reg = <0xffffe600 0x200>;
> > >  				interrupts = <30 4 0>;
> > >  				#dma-cells = <1>;
> > > +				#dma-cells = <2>;
> > ??
> > 
> > 2 dma-cells?
> 
> Yes 2 dma-cells, mistake in the patch, the work is still in progress.
> 
> > >  			};
> > >  
> > >  			dma1: dma-controller at ffffe800 {
> > > @@ -356,6 +357,7 @@
> > >  				reg = <0xffffe800 0x200>;
> > >  				interrupts = <31 4 0>;
> > >  				#dma-cells = <1>;
> > > +				#dma-cells = <2>;
> > ditto
> > >  			};
> > >  
> > >  			ramc0: ramc at ffffea00 {
> > > diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> > > index 8415467..ec7f561 100644
> > > --- a/drivers/dma/at_hdmac.c
> > > +++ b/drivers/dma/at_hdmac.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/of_dma.h>
> > >  
> > >  #include "at_hdmac_regs.h"
> > >  #include "dmaengine.h"
> > > @@ -676,7 +677,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > >  		ctrlb |=  ATC_DST_ADDR_MODE_FIXED
> > >  			| ATC_SRC_ADDR_MODE_INCR
> > >  			| ATC_FC_MEM2PER
> > > -			| ATC_SIF(AT_DMA_MEM_IF) | ATC_DIF(AT_DMA_PER_IF);
> > > +			| ATC_SIF(atchan->mem_if) | ATC_DIF(atchan->per_if);
> > >  		reg = sconfig->dst_addr;
> > >  		for_each_sg(sgl, sg, sg_len, i) {
> > >  			struct at_desc	*desc;
> > > @@ -715,7 +716,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > >  		ctrlb |=  ATC_DST_ADDR_MODE_INCR
> > >  			| ATC_SRC_ADDR_MODE_FIXED
> > >  			| ATC_FC_PER2MEM
> > > -			| ATC_SIF(AT_DMA_PER_IF) | ATC_DIF(AT_DMA_MEM_IF);
> > > +			| ATC_SIF(atchan->per_if) | ATC_DIF(atchan->mem_if);
> > >  
> > >  		reg = sconfig->src_addr;
> > >  		for_each_sg(sgl, sg, sg_len, i) {
> > > @@ -821,8 +822,8 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
> > >  		desc->lli.ctrlb = ATC_DST_ADDR_MODE_FIXED
> > >  				| ATC_SRC_ADDR_MODE_INCR
> > >  				| ATC_FC_MEM2PER
> > > -				| ATC_SIF(AT_DMA_MEM_IF)
> > > -				| ATC_DIF(AT_DMA_PER_IF);
> > > +				| ATC_SIF(atchan->mem_if)
> > > +				| ATC_DIF(atchan->per_if);
> > >  		break;
> > >  
> > >  	case DMA_DEV_TO_MEM:
> > > @@ -832,8 +833,8 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
> > >  		desc->lli.ctrlb = ATC_DST_ADDR_MODE_INCR
> > >  				| ATC_SRC_ADDR_MODE_FIXED
> > >  				| ATC_FC_PER2MEM
> > > -				| ATC_SIF(AT_DMA_PER_IF)
> > > -				| ATC_DIF(AT_DMA_MEM_IF);
> > > +				| ATC_SIF(atchan->per_if)
> > > +				| ATC_DIF(atchan->mem_if);
> > >  		break;
> > >  
> > >  	default:
> > > @@ -1189,6 +1190,55 @@ static void atc_free_chan_resources(struct dma_chan *chan)
> > >  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
> > >  }
> > >  
> > > +static bool at_dma_filter(struct dma_chan *chan, void *dma_dev)
> > > +{
> > > +	if (dma_dev == chan->device->dev)
> > > +		return true;
> > > +	else
> > > +		return false;
> > > +}
> > > +
> > > +static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
> > > +				     struct of_dma *of_dma)
> > > +{
> > > +	struct dma_chan *chan;
> > > +	struct at_dma_chan *atchan;
> > > +	struct at_dma_slave *atslave;
> > > +	dma_cap_mask_t mask;
> > > +	unsigned int per_id;
> > > +	struct platform_device *dmac_pdev;
> > > +
> > > +	if (dma_spec->args_count != 2)
> > > +		return NULL;
> > > +
> > > +	dmac_pdev = of_find_device_by_node(dma_spec->np);
> > > +
> > > +	dma_cap_zero(mask);
> > > +	dma_cap_set(DMA_SLAVE, mask);
> > > +
> > > +	chan = dma_request_channel(mask, at_dma_filter, &dmac_pdev->dev);
> > > +	if (!chan)
> > > +		return NULL;
> > > +
> > > +	atchan = to_at_dma_chan(chan);
> > > +	atchan->per_if = dma_spec->args[0] & 0xff;
> > > +	atchan->mem_if = (dma_spec->args[0] >> 16) & 0xff;
> > > +
> > > +	atslave = &atchan->atslave;
> > > +	/*
> > > +	 * We can fill both SRC_PER and DST_PER, one of these fields will be
> > > +	 * ignored depending on DMA transfer direction.
> > > +	 */
> > > +	per_id = dma_spec->args[1];
> > > +	atslave->cfg = ATC_FIFOCFG_HALFFIFO | ATC_DST_H2SEL_HW
> > > +		      | ATC_SRC_H2SEL_HW | ATC_DST_PER(per_id)
> > > +		      | ATC_SRC_PER(per_id);
> > > +	atslave->dma_dev = &dmac_pdev->dev;
> > > +	chan->private = atslave;
> > > +	channel_writel(atchan, CFG, atslave->cfg);
> > > +
> > > +	return chan;
> > > +}
> > >  
> > >  /*--  Module Management  -----------------------------------------------*/
> > >  
> > > @@ -1389,6 +1439,15 @@ static int __init at_dma_probe(struct platform_device *pdev)
> > >  
> > >  	dma_async_device_register(&atdma->dma_common);
> > >  
> > > +	if (pdev->dev.of_node) {
> > more simple return if NULL
> > > +		printk("=== of_dma_controller_register ===\n");
> > drop this
> 
> of course, I'll drop it for the submission
> 
> > > +		err = of_dma_controller_register(pdev->dev.of_node,
> > > +						 at_dma_xlate, atdma);
> > > +		if (err && err != -ENODEV)
> > > +			dev_err(&pdev->dev,
> > > +				"could not register of_dma_controller\n");
> > 		if err you need to return err
> 
> ok
> 
> > > +	}
> > > +
> > >  	return 0;
> > >  
> > >  err_pool_create:
> > > diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> > > index 0eb3c13..e3d2f12 100644
> > > --- a/drivers/dma/at_hdmac_regs.h
> > > +++ b/drivers/dma/at_hdmac_regs.h
> > > @@ -220,6 +220,8 @@ enum atc_status {
> > >   * @device: parent device
> > >   * @ch_regs: memory mapped register base
> > >   * @mask: channel index in a mask
> > > + * @per_if: peripheral interface
> > > + * @mem_if: memory interface
> > >   * @status: transmit status information from irq/prep* functions
> > >   *                to tasklet (use atomic operations)
> > >   * @tasklet: bottom half to finish transaction work
> > > @@ -227,6 +229,8 @@ enum atc_status {
> > >   * @save_dscr: for cyclic operations, preserve next descriptor address in
> > >   *             the cyclic list on suspend/resume cycle
> > >   * @dma_sconfig: configuration for slave transfers, passed via DMA_SLAVE_CONFIG
> > > + * @atslave: hardware configuration for slave transfers which is not passed via
> > > + * DMA_SLAVE_CONFIG
> > >   * @lock: serializes enqueue/dequeue operations to descriptors lists
> > >   * @active_list: list of descriptors dmaengine is being running on
> > >   * @queue: list of descriptors ready to be submitted to engine
> > > @@ -238,11 +242,14 @@ struct at_dma_chan {
> > >  	struct at_dma		*device;
> > >  	void __iomem		*ch_regs;
> > >  	u8			mask;
> > > +	u8			per_if;
> > > +	u8			mem_if;
> > >  	unsigned long		status;
> > >  	struct tasklet_struct	tasklet;
> > >  	u32			save_cfg;
> > >  	u32			save_dscr;
> > >  	struct dma_slave_config dma_sconfig;
> > > +	struct at_dma_slave	atslave;
> > >  
> > >  	spinlock_t		lock;
> > >  
> > > -- 
> > > 1.7.11.3
> > > 
