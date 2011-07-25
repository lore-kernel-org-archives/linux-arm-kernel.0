From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 19:18:20 +0530
Subject: [PATCH V4 03/14] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <002401cc4ac9$97737570$c65a6050$%kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-4-git-send-email-boojin.kim@samsung.com>
	<1311589617.27357.3.camel@vkoul-mobl4>
	<002401cc4ac9$97737570$c65a6050$%kim@samsung.com>
Message-ID: <1311601700.8206.7.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-25 at 21:51 +0900, Boojin Kim wrote:
> Vinod Koul Wrote:
> > Sent: Monday, July 25, 2011 7:27 PM
> > To: Boojin Kim
> > Cc: vinod.koul at intel.com; linux-arm-kernel at lists.infradead.org; linux-
> > samsung-soc at vger.kernel.org; Kukjin Kim; Jassi Brar; Grant Likely;
> > Mark Brown; Dan Williams
> > Subject: Re: [PATCH V4 03/14] DMA: PL330: Support DMA_SLAVE_CONFIG
> > command
> >
> > On Mon, 2011-07-25 at 10:28 +0900, Boojin Kim wrote:
> > > This patch adds support DMA_SLAVE_CONFIG command.
> > >
> > > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > > ---
> > >  drivers/dma/pl330.c |   53 +++++++++++++++++++++++++++++++++++++----
> > ---------
> > >  1 files changed, 39 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > > index 586ab39..880f010 100644
> > > --- a/drivers/dma/pl330.c
> > > +++ b/drivers/dma/pl330.c
> > > @@ -256,25 +256,50 @@ static int pl330_alloc_chan_resources(struct
> > dma_chan *chan)
> > >  static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd
> > cmd, unsigned long arg)
> > >  {
> > >  	struct dma_pl330_chan *pch = to_pchan(chan);
> > > -	struct dma_pl330_desc *desc;
> > > +	struct dma_pl330_desc *desc, *_dt;
> > >  	unsigned long flags;
> > > +	struct dma_pl330_dmac *pdmac = pch->dmac;
> > > +	struct dma_slave_config *slave_config;
> > > +	struct dma_pl330_peri *peri;
> > > +	LIST_HEAD(list);
> > >
> > > -	/* Only supports DMA_TERMINATE_ALL */
> > > -	if (cmd != DMA_TERMINATE_ALL)
> > > -		return -ENXIO;
> > > -
> > > -	spin_lock_irqsave(&pch->lock, flags);
> > > -
> > > -	/* FLUSH the PL330 Channel thread */
> > > -	pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> > > +	switch (cmd) {
> > > +	case DMA_TERMINATE_ALL:
> > > +		spin_lock_irqsave(&pch->lock, flags);
> > >
> > > -	/* Mark all desc done */
> > > -	list_for_each_entry(desc, &pch->work_list, node)
> > > -		desc->status = DONE;
> > > +		/* FLUSH the PL330 Channel thread */
> > > +		pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> > >
> > > -	spin_unlock_irqrestore(&pch->lock, flags);
> > > +		/* Mark all desc done */
> > > +		list_for_each_entry_safe(desc, _dt, &pch->work_list , node)
> > {
> > > +			desc->status = DONE;
> > > +			pch->completed = desc->txd.cookie;
> > > +			list_move_tail(&desc->node, &list);
> > > +		}
> > >
> > > -	pl330_tasklet((unsigned long) pch);
> > > +		list_splice_tail_init(&list, &pdmac->desc_pool);
> > > +		spin_unlock_irqrestore(&pch->lock, flags);
> > > +		break;
> > > +	case DMA_SLAVE_CONFIG:
> > > +		slave_config = (struct dma_slave_config *)arg;
> > > +		peri = pch->chan.private;
> > > +
> > > +		if (slave_config->direction == DMA_TO_DEVICE) {
> > > +			if (slave_config->dst_addr)
> > > +				peri->fifo_addr = slave_config->dst_addr;
> > > +			if (slave_config->dst_addr_width)
> > > +				peri->burst_sz = __ffs(slave_config-
> > >dst_addr_width);
> > This doesn't sound right, why can't you use xxx_maxburst field instead?
> Can you explain the problem in more detail?
> Do you mean that 'xxx_maxburst' takes place of 'xxx_addr_width' or __ffs() 
> isn't proper here?
> 
> Additionally, I will modify this code to consider '_maxburst' field.
__ffs is okay and sensible.
I meant you should use proper fields for passing info, which in this
case would be dst_maxburst for specifying destination burst sizes
-- 
~Vinod Koul
Intel Corp.
