From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 5 May 2010 17:31:37 +0530
Subject: [PATCH v8 1/2] sDMA: descriptor autoloading feature
In-Reply-To: <k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
	<k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D1806@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of Venkatraman S
> Sent: Wednesday, May 05, 2010 5:20 PM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
> 
> [Long sections have been trimmed to the context of the discussion]
> On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *sghead,
> >> + ? ? ? ? ? ? dma_addr_t phyaddr, int nelem)
> >> +{
> >> + ? ? struct omap_dma_sglist_node *sgcurr, *sgprev;
> >> + ? ? dma_addr_t elem_paddr = phyaddr;
> >> +
> >> + ? ? for (sgprev = sghead;
> >> + ? ? ? ? ? ? sgprev < sghead + nelem;
> >> + ? ? ? ? ? ? sgprev++) {
> >> +
> >> + ? ? ? ? ? ? sgcurr = sgprev + 1;
> >> + ? ? ? ? ? ? sgprev->next = sgcurr;
> >> + ? ? ? ? ? ? elem_paddr += (int)sizeof(*sgcurr);
> >> + ? ? ? ? ? ? sgprev->next_desc_add_ptr = elem_paddr;
> >> +
> >> + ? ? ? ? ? ? switch (sgcurr->desc_type) {
> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 1);
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> +
> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> >> + ? ? ? ? ? ? /* intentional no break */
> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 2);
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> +
> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> >> + ? ? ? ? ? ? ? ? ? ? /* intentional no break */
> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 3);
> >> + ? ? ? ? ? ? ? ? ? ? break;
> >> +
> >> + ? ? ? ? ? ? default:
> >> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> >> +
> >> + ? ? ? ? ? ? }
> > Are we supporting all the descriptor types. I think only type2a is
> > supported. In that case please add FIXME, or WARN message here.
> 
> From DMA perspective, all are supported - no restrictions. Only I have
> not figured
> out how to use type 2b and type 3b descriptors. It's not the fault of
> DMA driver or
> specification :-) It's actually upto the client to select the right type.
OK. Then the question which I wanted to ask.
For TX, 2b should have been better choice than 2a isn't it? 
> 
> >> +
> >> + ? ? lcfg->sghead = sgparams;
> >> + ? ? lcfg->num_elem = nelem;
> >> + ? ? lcfg->sgheadphy = padd;
> >> + ? ? lcfg->pausenode = -1;
> >> +
> >> +
> >> + ? ? if (NULL == chparams)
> > Minute point really. Better readability "ch_params"
> OK
> 
> >> + ? ? dma_write(l, CDP(lch));
> >> + ? ? dma_write((lcfg->sgheadphy), CNDP(lch));
> >> + ? ? /**
> >> + ? ? ?* Barrier needed as writes to the
> >> + ? ? ?* descriptor memory needs to be flushed
> >> + ? ? ?* before it's used by DMA controller
> >> + ? ? ?*/
> > Little bit of re-wording if you can.
> > Also you don't wanted the double **
> > ? ? ? ?/*
> > ? ? ? ? * Memory barrier is needed because data may still be
> > ? ? ? ? * in the write buffer. The barrier drains write buffers and
> > ? ? ? ? * ensures that DMA sees correct descriptors
> > ? ? ? ? */
> OK
> 
> >> + ? ? wmb();
> >> + ? ? omap_start_dma(lch);
> >> +
> >> + ? ? /* Maintain the pause state in descriptor */
> >> + ? ? omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
> >> + ? ? omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
> >> +
> >> + ? ? /**
> >> + ? ? ?* Barrier needed as writes to the
> >> + ? ? ?* descriptor memory needs to be flushed
> >> + ? ? ?* before it's used by DMA controller
> >> + ? ? ?*/
> > Description change if possible
> OK
> 
> >> + ? ? wmb();
> >> +
> >> + ? ? /* Errata i557 - pausebit should be cleared in no standby mode */
> > This should have been
> 
> I couldn't understand this comment.
This should have been a separate patch since it's an errata.
> 
> >> + ? ? sys_cf = dma_read(OCP_SYSCONFIG);
> >> + ? ? l = sys_cf;
> >> + ? ? /* Middle mode reg set no Standby */
> >> + ? ? l &= ~(BIT(12) | BIT(13));
> >> + ? ? dma_write(l, OCP_SYSCONFIG);
