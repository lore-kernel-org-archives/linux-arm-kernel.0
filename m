From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 20 Jan 2014 14:26:39 +0000
Subject: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20140120102007.GC26823@intel.com>
References: <1389938684-29467-1-git-send-email-b35083@freescale.com>
 <1389938684-29467-3-git-send-email-b35083@freescale.com>
 <20140120074019.GF26823@intel.com>
 <43d79ce905e24e9bb58ef49ac19db7d7@BL2PR03MB467.namprd03.prod.outlook.com>
 <20140120093541.GX26823@intel.com>
 <f173c2531461478899818365e06df437@BL2PR03MB467.namprd03.prod.outlook.com>,
 <20140120102007.GC26823@intel.com>
Message-ID: <d2d7153f082c46ee93d62fe56e6a80db@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


________________________________________
From: Vinod Koul <vinod.koul@intel.com>
Sent: Monday, January 20, 2014 6:20 PM
To: Lu Jingchang-B35083
Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org; pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Wang Huan-B18965
Subject: Re: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support

On Mon, Jan 20, 2014 at 11:05:03AM +0000, Jingchang Lu wrote:
>> > > > > +     struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>> > > > > +     struct dma_slave_config *cfg = (void *)arg;
>> > > > > +     unsigned long flags;
>> > > > > +     LIST_HEAD(head);
>> > > > > +
>> > > > > +     switch (cmd) {
>> > > > > +     case DMA_TERMINATE_ALL:
>> > > > > +             spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>> > > > > +             fsl_edma_disable_request(fsl_chan);
>> > > > > +             fsl_chan->edesc = NULL;
>> > > > > +             vchan_get_all_descriptors(&fsl_chan->vchan, &head);
>> > > > > +             spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>> > > > > +             vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>> > > > > +             return 0;
> >> > > well what happens to the current ongoing transactions, i don't see
> >> those
> >> > > getting
> >> > > terminated?
> >> > The fsl_edma_disable_request(fsl_chan) would end the channel's ongoing
> >> transaction, then
> >> > the eDMA would not response to device dma request, and the
> >> vchan_dma_desc_free_list()
> >> > will release all associate memory. Thanks.
> >> Can you explain a bit more how terminate will happen, given taht you are
> >> using
> >> same thing for pause?
>> It works just like an interrupt controller on irq enable and disable. It has a register called
>> set/clear enable request register(SERQ/CERQ) to enable or disable the DMA request for a given
>> channel. It won't transfer data any more with the enable request register cleared. So for the
>> pause and terminate the pause is the same. And there is no other way to stop the channels.
>well then it is not pause! If you jave no way to stop the channel, you cant
>claim to support pause and resume!

>>Also, for terminate this will be problematic. Assuming you are doing transfers
>and terminate is invoked. Then you will disable irq. The transfers may get stuck
>and periphral clock may go away after transfer so current transaction never gets
>completed, how do we recovery from this?
The clear enable request would isolate the dma request from the eDMA engine, 
and the eDMA engine could not receive any dma request from the device any more,
so the transmission is stopped, all the channel parameters will not be changed any more, and the
eDMA engine will not do any transmission for that channel until the request is enabled
by set enable request. And the channel parameters could be changed when the enable request
cleared.
We have tested the eDMA drive with the SAI audio driver which uses the cyclic dma tranfer, and it
work well.
Thanks.

>Alstly, have you looked at edma driver already existing, any similarties in teh
>controller with that?
Yes, I have notice the TI's edma driver, but they are not the same. So we implement this driver.

Best Regards,
Jingchang
