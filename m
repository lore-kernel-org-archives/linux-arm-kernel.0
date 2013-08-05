From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 5 Aug 2013 09:44:55 +0000
Subject: [PATCH v2 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20991.23049.78707.457046@ipc1.ka-ro>
References: <1375682824-11443-1-git-send-email-b35083@freescale.com>
 <1375682824-11443-2-git-send-email-b35083@freescale.com>
 <20991.23049.78707.457046@ipc1.ka-ro>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851FC086@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: Monday, August 05, 2013 3:54 PM
> To: Lu Jingchang-B35083
> Cc: vinod.koul at intel.com; Li Xiaochun-B41219; Wang Huan-B18965; linux-
> kernel at vger.kernel.org; djbw at fb.com; shawn.guo at linaro.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/3] dma: Add Freescale eDMA engine driver support

> [...]
> > +	fsl_desc->n_tcds = sg_len;
> > +	for (i = 0; i < sg_len; i++) {
> > +		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
> > +					GFP_ATOMIC, &fsl_desc->tcd[i].ptcd);
> >
> Why is this called with GFP_ATOMIC while fsl_desc above is being
> allocated with GFP_KERNEL?
[Lu Jingchang-B35083] 
 I will make these consistently. Thanks.
> 
> > +	for (ch = 0; ch < 32; ch++)
> > +		if (intr & (0x1 << ch))
> > +			break;
> > +
> What, if IRQs for multiple channels are pending at the same time?
> You could handle them all in one go without extra calls of the IRQ
> handler.
[Lu Jingchang-B35083] 
Yes, It will be more efficiently to handle all the irqs once. Thanks.
> 
> > +	writeb(EDMA_CINT_CINT(ch), base_addr + EDMA_CINT);
> > +
> > +	fsl_chan = &fsl_edma->chans[ch];
> > +
> > +	if (!fsl_chan->edesc->iscyclic) {
> > +		list_del(&fsl_chan->edesc->vdesc.node);
> >
> Ain't there any protection needed for the list operation?
[Lu Jingchang-B35083] 
Protection is needed indeed, I will fix this, thanks.
> 
> > +		clk_prepare_enable(fsl_edmamux->clk);
> >
> What, if this fails?
[Lu Jingchang-B35083] 
I will add code to check the return value. Thanks.
> 





Best Regards,
Jingchang
