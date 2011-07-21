From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 21 Jul 2011 13:13:54 +0900
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
Message-ID: <000101cc475c$9b5bcdb0$d2136910$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> Sent: Thursday, July 21, 2011 4:18 AM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org;
> Vinod Koul; Dan Williams; Kukjin Kim
> Subject: Re: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
>
> On Wed, Jul 20, 2011 at 4:16 PM, Boojin Kim <boojin.kim@samsung.com> wrote:
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/dma/pl330.c |   53 
> > +++++++++++++++++++++++++++++++++++++----------
> ---
> >  1 files changed, 39 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 586ab39..880f010 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -256,25 +256,50 @@ static int pl330_alloc_chan_resources(struct 
> > dma_chan
> *chan)
> >  static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> unsigned long arg)
> >  {
> >        struct dma_pl330_chan *pch = to_pchan(chan);
> > -       struct dma_pl330_desc *desc;
> > +       struct dma_pl330_desc *desc, *_dt;
> >        unsigned long flags;
> > +       struct dma_pl330_dmac *pdmac = pch->dmac;
> > +       struct dma_slave_config *slave_config;
> > +       struct dma_pl330_peri *peri;
> > +       LIST_HEAD(list);
> >
> > -       /* Only supports DMA_TERMINATE_ALL */
> > -       if (cmd != DMA_TERMINATE_ALL)
> > -               return -ENXIO;
> > -
> > -       spin_lock_irqsave(&pch->lock, flags);
> > -
> > -       /* FLUSH the PL330 Channel thread */
> > -       pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> > +       switch (cmd) {
> > +       case DMA_TERMINATE_ALL:
> > +               spin_lock_irqsave(&pch->lock, flags);
> >
> > -       /* Mark all desc done */
> > -       list_for_each_entry(desc, &pch->work_list, node)
> > -               desc->status = DONE;
> > +               /* FLUSH the PL330 Channel thread */
> > +               pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
> >
> > -       spin_unlock_irqrestore(&pch->lock, flags);
> > +               /* Mark all desc done */
> > +               list_for_each_entry_safe(desc, _dt, &pch->work_list , 
> > node)
> {
> > +                       desc->status = DONE;
> > +                       pch->completed = desc->txd.cookie;
> > +                       list_move_tail(&desc->node, &list);
> > +               }
> >
> > -       pl330_tasklet((unsigned long) pch);
> > +               list_splice_tail_init(&list, &pdmac->desc_pool);
> > +               spin_unlock_irqrestore(&pch->lock, flags);
> > +               break;
> > +       case DMA_SLAVE_CONFIG:
> Please protect this section too using spin_lock.
Why is spin_lock need here?
This code just sets configuration data into own channel structure.

>
>
> > +               if (slave_config->direction == DMA_TO_DEVICE) {
> > +                       if (slave_config->dst_addr)
> > +                               peri->fifo_addr = slave_config->dst_addr;
> > +                       if (slave_config->dst_addr_width)
> > +                               peri->burst_sz = __ffs(slave_config-
> >dst_addr_width);
> > +               } else if (slave_config->direction == DMA_FROM_DEVICE) {
> > +                       if (slave_config->src_addr)
> > +                               peri->fifo_addr = slave_config->src_addr;
> > +                       if (slave_config->src_addr_width)
> > +                               peri->burst_sz = __ffs(slave_config-
> >src_addr_width);
> > +               }
> PL330 has fixed channels to peripherals.
> So FIFO addresses(burst_sz too?) should already be set via platform data.
> Client drivers shouldn't bother.

First, DMA machine code should know the FIFO address of all client drivers to 
set via platform data.
In this case, Problem is that the definition of FIFO address is almost 
declared to the header file of client driver.
For example, sound\soc\samsung\regs-i2s-v2.h only has the definition of fifo 
address as following.

#define S3C2412_IISTXD			(0x10)
#define S3C2412_IISRXD			(0x14)

These definitions should be referred to DMA machine code to set fifo address 
through platform data.
I think it's not good method.
And, SLAVE_CONFIG command exist to pass slave configuration data from client 
driver to DMA driver.
So, I think that it's proper to pass fifo address through SLAVE_CONFIG 
command.

Second, 'burst_sz' isn't fixed value. Namely, Client driver changes 'burst_sz' 
according to its usecase.
For example, I2S driver sets 'burst_sz' to 4 in case of stereo 
playback/recording. But in case of mono playback/recording, It changes 
'burst_sz' to 2.
So, Client driver should use SLAVE_CONFIG command to set 'burst_sz' because 
it's not fixed value.

>
> <will review remaining patches soon, gotta go now>
