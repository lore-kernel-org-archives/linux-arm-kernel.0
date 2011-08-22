From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 22 Aug 2011 21:03:13 +0900
Subject: [PATCH v6 04/15] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <CABb+yY2CjmoDEmvC3S0ua3=B++jKz5g2JXGTwhNcAw5MQ06M9A@mail.gmail.com>
References: <1313744097-27289-1-git-send-email-boojin.kim@samsung.com>
	<1313744097-27289-5-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2CjmoDEmvC3S0ua3=B++jKz5g2JXGTwhNcAw5MQ06M9A@mail.gmail.com>
Message-ID: <002c01cc60c3$77d18210$67748630$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:

>
> > @@ -324,6 +362,9 @@ static void pl330_free_chan_resources(struct
> dma_chan *chan)
> >        pl330_release_channel(pch->pl330_chid);
> >        pch->pl330_chid = NULL;
> >
> > +       if (pch->cyclic)
> > +               list_splice_tail_init(&pch->work_list, &pch->dmac-
> >desc_pool);
> 'cyclic' member is 'enum cyclic_mode', please observe the rule and
> compare
> it only against the enum values.
I will address your comment.

>
>
> > +static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
> > +               struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
> > +               size_t period_len, enum dma_data_direction direction)
> > +{
> > +       struct dma_pl330_desc *desc;
> > +       struct dma_pl330_chan *pch = to_pchan(chan);
> > +       dma_addr_t dst;
> > +       dma_addr_t src;
> > +
> > +       desc = pl330_get_desc(pch);
> > +       if (!desc) {
> > +               dev_err(pch->dmac->pif.dev, "%s:%d Unable to fetch
> desc\n",
> > +                       __func__, __LINE__);
> > +               return NULL;
> > +       }
> > +
> > +       switch (direction) {
> > +       case DMA_TO_DEVICE:
> > +               desc->rqcfg.src_inc = 1;
> > +               desc->rqcfg.dst_inc = 0;
> > +               src = dma_addr;
> > +               dst = pch->fifo_addr;
> > +               break;
> > +       case DMA_FROM_DEVICE:
> > +               desc->rqcfg.src_inc = 0;
> > +               desc->rqcfg.dst_inc = 1;
> > +               src = pch->fifo_addr;
> > +               dst = dma_addr;
> > +               break;
> > +       default:
> > +               dev_err(pch->dmac->pif.dev, "%s:%d Invalid dma
> direction\n",
> > +               __func__, __LINE__);
> > +               return NULL;
> > +       }
> > +
> > +       desc->rqcfg.brst_size = pch->burst_sz;
> > +       desc->rqcfg.brst_len = 1;
> > +
> > +       if (!pch->cyclic)
> > +               pch->cyclic = CYCLIC_PREP;
> The need for check here seems suspicious.
> Is it really needed? If not, please remove it.
It's required because Cyclic operation is passed from CYCLIC_PREP to 
CYCLIC_TRIGGER.

Thanks
Boojin
