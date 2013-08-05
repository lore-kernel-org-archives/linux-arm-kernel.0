From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 5 Aug 2013 21:15:51 +0530
Subject: [PATCH v2 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20991.23049.78707.457046@ipc1.ka-ro>
References: <1375682824-11443-1-git-send-email-b35083@freescale.com>
 <1375682824-11443-2-git-send-email-b35083@freescale.com>
 <20991.23049.78707.457046@ipc1.ka-ro>
Message-ID: <20130805154551.GP29095@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 09:53:45AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Jingchang Lu writes:
> > Add Freescale enhanced direct memory(eDMA) controller support.
> > The eDMA controller deploys DMAMUXs routing DMA request sources(slot)
> > to eDMA channels.
> > This module can be found on Vybrid and LS-1 SoCs.
> > 
> [...]
> > +static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
> > +		int sg_len)
> > +{
> > +	struct fsl_edma_desc *fsl_desc;
> > +	int size, i;
> > +
> > +	size = sizeof(struct fsl_edma_desc);
> > +	size += sizeof(struct fsl_edma_sw_tcd) * sg_len;
> > +	fsl_desc = kzalloc(size, GFP_KERNEL);
> > +	if (!fsl_desc)
> > +		return NULL;
> > +
> > +	fsl_desc->echan = fsl_chan;
> > +	fsl_desc->n_tcds = sg_len;
> > +	for (i = 0; i < sg_len; i++) {
> > +		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
> > +					GFP_ATOMIC, &fsl_desc->tcd[i].ptcd);
> >
> Why is this called with GFP_ATOMIC while fsl_desc above is being
> allocated with GFP_KERNEL?
Both need to be GFP_ATOMIC, better they need to be GFP_NOWAIT.

~Vinod
