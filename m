From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 20 Jan 2014 11:05:03 +0000
Subject: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20140120093541.GX26823@intel.com>
References: <1389938684-29467-1-git-send-email-b35083@freescale.com>
 <1389938684-29467-3-git-send-email-b35083@freescale.com>
 <20140120074019.GF26823@intel.com>
 <43d79ce905e24e9bb58ef49ac19db7d7@BL2PR03MB467.namprd03.prod.outlook.com>
 <20140120093541.GX26823@intel.com>
Message-ID: <f173c2531461478899818365e06df437@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, January 20, 2014 5:36 PM
> To: Lu Jingchang-B35083
> Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org;
> pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Wang Huan-B18965
> Subject: Re: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
> 
> On Mon, Jan 20, 2014 at 09:06:43AM +0000, Jingchang Lu wrote:
> >
> >
> > > -----Original Message-----
> > > From: Vinod Koul [mailto:vinod.koul at intel.com]
> > > Sent: Monday, January 20, 2014 3:40 PM
> > > To: Lu Jingchang-B35083
> > > Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org;
> > > pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org;
> linux-
> > > kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > > devicetree at vger.kernel.org; Wang Huan-B18965
> > > Subject: Re: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver
> support
> > >
> > > On Fri, Jan 17, 2014 at 02:04:44PM +0800, Jingchang Lu wrote:
> > > > Add Freescale enhanced direct memory(eDMA) controller support.
> > > > This module can be found on Vybrid and LS-1 SoCs.
> > > >
> > > > Signed-off-by: Alison Wang <b18965@freescale.com>
> > > > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > >
> > > > +static int fsl_edma_control(struct dma_chan *chan, enum
> dma_ctrl_cmd
> > > cmd,
> > > > +		unsigned long arg)
> > > > +{
> > > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > > +	struct dma_slave_config *cfg = (void *)arg;
> > > > +	unsigned long flags;
> > > > +	LIST_HEAD(head);
> > > > +
> > > > +	switch (cmd) {
> > > > +	case DMA_TERMINATE_ALL:
> > > > +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> > > > +		fsl_edma_disable_request(fsl_chan);
> > > > +		fsl_chan->edesc = NULL;
> > > > +		vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> > > > +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> > > > +		vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> > > > +		return 0;
> > > well what happens to the current ongoing transactions, i don't see
> those
> > > getting
> > > terminated?
> > The fsl_edma_disable_request(fsl_chan) would end the channel's ongoing
> transaction, then
> > the eDMA would not response to device dma request, and the
> vchan_dma_desc_free_list()
> > will release all associate memory. Thanks.
> Can you explain a bit more how terminate will happen, given taht you are
> using
> same thing for pause?
It works just like an interrupt controller on irq enable and disable. It has a register called
set/clear enable request register(SERQ/CERQ) to enable or disable the DMA request for a given
channel. It won't transfer data any more with the enable request register cleared. So for the
pause and terminate the pause is the same. And there is no other way to stop the channels.
Thanks.



> > > > +static struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> > > > +		struct dma_chan *chan, dma_addr_t dma_addr, size_t
> buf_len,
> > > > +		size_t period_len, enum dma_transfer_direction
> direction,
> > > > +		unsigned long flags, void *context)
> > > > +{
> > > you may want to implement the capablities api subsequently for audio
> > > usage.
> > Do you mean the device_slave_caps function? If it is, I will add it.
> Yes, that can be incrementally added..
I have send the v11 patch out with a basic device_slave_caps definition. I notice
that there is some new update of the dma capabilities, so if possible and others ok,
could you please merge this patch first and leave me improving the driver in subsequent
patches. Thanks.


Best Regards,
Jingchang
