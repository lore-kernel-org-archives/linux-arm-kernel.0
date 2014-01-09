From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 9 Jan 2014 10:17:04 +0000
Subject: [PATCHv8 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <5890639.zaOC7MRE09@wuerfel>
References: <1388645544-5596-1-git-send-email-b35083@freescale.com>
 <1388645544-5596-3-git-send-email-b35083@freescale.com>
 <5e626cf3587f4a0eb325dd7032b8b60a@BL2PR03MB467.namprd03.prod.outlook.com>
 <5890639.zaOC7MRE09@wuerfel>
Message-ID: <4efd24a1219547cbbf0ce8ec66d762e5@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, January 08, 2014 6:54 PM
> To: Lu Jingchang-B35083
> Cc: vinod.koul at intel.com; dan.j.williams at intel.com; shawn.guo at linaro.org;
> pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCHv8 2/2] dma: Add Freescale eDMA engine driver support
> 
> On Wednesday 08 January 2014 10:24:38 Jingchang Lu wrote:
> 
> > > +- clocks : Phandle of the DMA channel group block clock of the eDMA
> > > module
> > > +- clock-names : The channel group block clock names
> 
> Turn these around and first define the required names, then state
> that 'clocks' should contain none clock specifier for each clock
> name.
I will turn them around, thanks.

> 
> > > +sai2: sai at 40031000 {
> > > +	compatible = "fsl,vf610-sai";
> > > +	reg = <0x40031000 0x1000>;
> > > +	interrupts = <0 86 0x04>;
> > > +	clocks = <&clks VF610_CLK_SAI2>;
> > > +	clock-names = "sai";
> > > +	dma-names = "tx", "rx";
> > > +	dmas = <&edma0 VF610_EDMA_DMAMUX0 VF610_EDMA0_MUX0_SAI2_TX>,
> > > +		<&edma0 VF610_EDMA_DMAMUX0 VF610_EDMA0_MUX0_SAI2_RX>;
> > > +	status = "disabled";
> > > +};
> 
> It seems wrong to have macros defined like VF610_EDMA0_MUX0_SAI2_TX,
> in particular in the example. These should just be literal numbers.
[Lu Jingchang-b35083] 
This eDMA engineer requires two specifiers, one is a mux group id, the other is a request source id.
The VF610_EDMA0_MUX0_SAI2_TX is sai's tx dma request source id, it is defined as a literal number.
There are totally more than 100 request source id, I have them macros defined to make it referenced
easily and clearly, just like some clock binding done.
The macros are defined in include/dt-bindings/dma/vf610-edma.h.
Thanks.

> 
> It's ok to have macros for the VF610_EDMA_DMAMUX0, but I suspect
> that the possible values are just '0' and '1', which means a literal
> would be just as easy here.
> 
> > > +struct fsl_edma_hw_tcd {
> > > +	u32	saddr;
> > > +	u16	soff;
> > > +	u16	attr;
> > > +	u32	nbytes;
> > > +	u32	slast;
> > > +	u32	daddr;
> > > +	u16	doff;
> > > +	u16	citer;
> > > +	u32	dlast_sga;
> > > +	u16	csr;
> > > +	u16	biter;
> > > +} __packed;
> 
> The structure is packed already, and marking it __packed
> will just mean that the compiler can't access the members
> atomically. Please remove the __packed keyword.
Ok, I will remove it, thanks.

> 
> > > +/* bytes swapping according to eDMA controller's endian */
> > > +#define EDMA_SWAP16(e, v)	(__force u16)(e->big_endian ?
> > > cpu_to_be16(v) : cpu_to_le16(v))
> > > +#define EDMA_SWAP32(e, v)	(__force u32)(e->big_endian ?
> > > cpu_to_be32(v) : cpu_to_le32(v))
> 
> Maybe use inline functions for these?
> 
> > > +/*
> > > + * copying of ARM read{b,w,l) and write{b,w,l) macro definations
> > > + * except for doing default swap of cpu_to_le32, the bytes swap
> > > + * is done depending on eDMA controller's endian defination,
> > > + * which may be big-endian or little-endian.
> > > + */
> > > +static inline u16 edma_readw(void __iomem *addr)
> > > +{
> > > +	u16 __v = (__force u16) __raw_readw(addr);
> > > +
> > > +	__iormb();
> > > +	return __v;
> > > +}
> 
> The comment doesn't seem to match the implementation: You don't
> actually do swaps here at all, which means this will fail when
> your kernel is running in big-endian mode. Just use the regular
> readw() etc, or use ioread16/ioread16be depending on the flag,
> and get rid of your EDMA_SWAP macros.
> 
> No need to come up with your own scheme when the problem has
> been solved already elsewhere.
The working scenario for this device is, the cpu running in little-endian mode,
While the eDMA module running in little- or big-endian mode. This device is currently
running on ARM architecture only, and I notice that ARM's little-endian readl/writel
treats all value as little-endian. This is not matching our scenario here. So I removed
the default cpu_to_le32() in the readl(), and put it in EDMA_SWAP32() to satisfy the
required.
Thanks.

> 
> > > +static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
> > > +{
> > > +	if (fsl_edma_tx_handler(irq, dev_id) == IRQ_HANDLED)
> > > +		return IRQ_HANDLED;
> > > +
> > > +	return fsl_edma_err_handler(irq, dev_id);
> > > +}
> 
> Does this do the right thing if both completion and error are
> signalled at the same time? It seems you'd miss the error interrupt.
I think the error would occur rarely, so if the transmission irq entered,
it will return directly after handling. If there is really an error occur,
the interrupt will be raised again without transmission interrupt flag, then
the irq handler would execute fsl_edma_err_handler() function.
Thanks.

> 
> > > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void *mux)
> > > +{
> > > +	 return (chan->chan_id / DMAMUX_NR) == (u32)mux;
> > > +}
> > > +
> > > +static struct dma_chan *fsl_edma_xlate(struct of_phandle_args
> *dma_spec,
> > > +		struct of_dma *ofdma)
> > > +{
> > > +	struct dma_chan *chan;
> > > +	dma_cap_mask_t mask;
> > > +
> > > +	if (dma_spec->args_count != 2)
> > > +		return NULL;
> > > +
> > > +	dma_cap_zero(mask);
> > > +	dma_cap_set(DMA_SLAVE, mask);
> > > +	dma_cap_set(DMA_CYCLIC, mask);
> > > +	chan = dma_request_channel(mask, fsl_edma_filter_fn, (void
> > > *)dma_spec->args[0]);
> > > +	if (chan)
> > > +		fsl_edma_chan_mux(to_fsl_edma_chan(chan), dma_spec->args[1],
> > > true);
> > > +	return chan;
> > > +}
> 
> Please remove the filter function now and use dma_get_slave_chan
> with the correct channel as an argument. No need to walk all
> available channels in the system and introduce bugs by not
> ignoring other dma engines.
The dma slave request can only be allocated to channel of particular channels group indicated by
the mux group id specifier. and the second specifier is the request id, not the channel number,
so to use the dma_get_slave_chan, I would find the channel for this request by walking all the
available channels manually.
Thanks!
