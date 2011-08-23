From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 24 Aug 2011 08:28:59 +0900
Subject: [PATCH v6 04/15] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <CABb+yY1N0d3t6WP=0Lu02znAcd_sTv5idSei3BWcn7PJJm7yAQ@mail.gmail.com>
References: <1313744097-27289-1-git-send-email-boojin.kim@samsung.com>
	<1313744097-27289-5-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2CjmoDEmvC3S0ua3=B++jKz5g2JXGTwhNcAw5MQ06M9A@mail.gmail.com>
	<002c01cc60c3$77d18210$67748630$%kim@samsung.com>
	<CABb+yY0oQwBTc1zmow+ng+TEJTzRsjB-i1xZdLVwtT+RR6J5RQ@mail.gmail.com>
	<001001cc6163$74cc62b0$5e652810$%kim@samsung.com>
	<CABb+yY1N0d3t6WP=0Lu02znAcd_sTv5idSei3BWcn7PJJm7yAQ@mail.gmail.com>
Message-ID: <000201cc61ec$7028f410$507adc30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> On Tue, Aug 23, 2011 at 12:38 PM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
> > Jassi Brar [mailto:jassisinghbrar at gmail.com]
> >> Sent: Tuesday, August 23, 2011 2:42 PM
> >> To: Boojin Kim
> >> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-
> >> soc at vger.kernel.org; Vinod Koul; Kukjin Kim; Dan Williams; Mark
> Brown;
> >> Grant Likely; Russell King
> >> Subject: Re: [PATCH v6 04/15] DMA: PL330: Add DMA_CYCLIC capability
> >>
> >> On Mon, Aug 22, 2011 at 5:33 PM, Boojin Kim
> <boojin.kim@samsung.com>
> >> wrote:
> >> >>
> >> >> > +static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
> >> >> > +               struct dma_chan *chan, dma_addr_t dma_addr,
> size_t
> >> len,
> >> >> > +               size_t period_len, enum dma_data_direction
> >> direction)
> >> >> > +{
> >> >> > +       struct dma_pl330_desc *desc;
> >> >> > +       struct dma_pl330_chan *pch = to_pchan(chan);
> >> >> > +       dma_addr_t dst;
> >> >> > +       dma_addr_t src;
> >> >> > +
> >> >> > +       desc = pl330_get_desc(pch);
> >> >> > +       if (!desc) {
> >> >> > +               dev_err(pch->dmac->pif.dev, "%s:%d Unable to
> fetch
> >> >> desc\n",
> >> >> > +                       __func__, __LINE__);
> >> >> > +               return NULL;
> >> >> > +       }
> >> >> > +
> >> >> > +       switch (direction) {
> >> >> > +       case DMA_TO_DEVICE:
> >> >> > +               desc->rqcfg.src_inc = 1;
> >> >> > +               desc->rqcfg.dst_inc = 0;
> >> >> > +               src = dma_addr;
> >> >> > +               dst = pch->fifo_addr;
> >> >> > +               break;
> >> >> > +       case DMA_FROM_DEVICE:
> >> >> > +               desc->rqcfg.src_inc = 0;
> >> >> > +               desc->rqcfg.dst_inc = 1;
> >> >> > +               src = pch->fifo_addr;
> >> >> > +               dst = dma_addr;
> >> >> > +               break;
> >> >> > +       default:
> >> >> > +               dev_err(pch->dmac->pif.dev, "%s:%d Invalid dma
> >> >> direction\n",
> >> >> > +               __func__, __LINE__);
> >> >> > +               return NULL;
> >> >> > +       }
> >> >> > +
> >> >> > +       desc->rqcfg.brst_size = pch->burst_sz;
> >> >> > +       desc->rqcfg.brst_len = 1;
> >> >> > +
> >> >> > +       if (!pch->cyclic)
> >> >> > +               pch->cyclic = CYCLIC_PREP;
> >> >> The need for check here seems suspicious.
> >> >> Is it really needed? If not, please remove it.
> >> > It's required because Cyclic operation is passed from CYCLIC_PREP
> to
> >> > CYCLIC_TRIGGER.
> >> I don't see why you need to differentiate between PREP and TRIGGER
> in
> >> cyclic mode. I think, you should simply have 'bool cyclic' instead
> of
> >> enum.
> > On cyclic mode, Pl330_tasklet() operation is changed according to
> the value of
> > 'cyclic'.
> > In case of CYCLIC_PREP, Pl330_tasklet()operation is same with normal
> > operation.
> By 'normal' you mean non-cyclic, right?  That doesn't seem correct to
> do.
> Once the desc has been marked cyclic by device_prep_dma_cyclic(), you
> shouldn't treat it like a non-cyclic anymore.
>
>
> > The sequence is following.
> > device_prep_dma_cyclic() -> set CYCLIC_PREP -> device_issue_pending()
> ->
> > Pl330_tasklet() with CYCLIC_PREP -> set CYCLIC_TRIGGER -> PL330 IRQ
> ->
> > Pl330_tasklet() with CYCLIC_TRIGGER.
> "device_issue_pending() ->Pl330_tasklet() with CYCLIC_PREP" is no
> different
> from "device_issue_pending() ->Pl330_tasklet() with CYCLIC_TRIGGER"
> because the list of 'done' xfers would be null yet.
Okay, You're right. CYCLIC_PREP is a redundancy status.
I will address your comment.

Thanks
Boojin Kim
