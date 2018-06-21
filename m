From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 21 Jun 2018 13:46:12 +0000
Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
 invoked for each DMA operation
In-Reply-To: <CAN8YU5O35du2RpTV78sJMx+MpGdOKf2LCQu8FqO1og6FO-JBOQ@mail.gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-2-andrea.merello@gmail.com>
 <DM6PR02MB43615ED0221189B6B8D9017EC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
 <CAN8YU5O35du2RpTV78sJMx+MpGdOKf2LCQu8FqO1og6FO-JBOQ@mail.gmail.com>
Message-ID: <DM6PR02MB43610F17B71F96903B17F312C7760@DM6PR02MB4361.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrea Merello [mailto:andrea.merello at gmail.com]
> Sent: Wednesday, June 20, 2018 7:02 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
> invoked for each DMA operation
> 
> On Wed, Jun 20, 2018 at 2:36 PM, Radhey Shyam Pandey
> <radheys@xilinx.com> wrote:
> >> -----Original Message-----
> >> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> >> owner at vger.kernel.org] On Behalf Of Andrea Merello
> >> Sent: Wednesday, June 20, 2018 2:07 PM
> >> To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
> >> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> >> <appanad@xilinx.com>; dmaengine at vger.kernel.org
> >> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> >> Andrea Merello <andrea.merello@gmail.com>
> >> Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
> >> invoked for each DMA operation
> >>
> >> API specification says: "On completion of each DMA operation, the next in
> >> queue is started and a tasklet triggered. The tasklet will then call the
> >> client driver completion callback routine for notification, if set."
> >>
> >> Currently the driver keeps a "desc_pendingcount" counter of the total
> >> descriptor pending, and it uses as IRQ coalesce threshold, as result it
> >> only calls the CBs after ALL pending operations are completed, which is
> >> wrong.
> > I think IRQ coalescing enable/disable should be configurable.
> > Performance related usecases will need this support.
> 
> I didn't intend this (only) wrt performances; my concern was mostly
> wrt correctness. If my point of view is wrong then I'll drop this
> patch from the series.
> 
If coalescing is enabled driver will know DMA completion when
all packet counts are processed. So I think it's correct implementation.
Making interrupt coalescing configurable will address all usecases.

> (.. I might respin it again in future: I had a patch wrt an old driver
> version that allowed submitting new descriptors to the HW while the
> DMA is running, and in this case disabling coalesce is needed i.e. in
> order to submit a new empty buffer whenever the DMA finishes a
> transfer without waiting the DMA to stop).
> 
> BTW, is there any dmaengine API suitable for setting interrupt coalesce?
> 
> >>
> >> This patch uses disable IRQ coalesce and checks for the completion flag
> >> for the descriptors (which is further divided in segments).
> >>
> >> Possibly a better optimization could be using proper IRQ coalesce
> >> threshold to get an IRQ after all segments of the descriptors are done.
> >> But we don't do that yet..
> >>
> >> NOTE: for now we do this only for AXI DMA, other DMA flavors are
> >> untested/untouched.
> >> This is loosely based on
> >> commit 65df81a6dc74 ("xilinx_dma: IrqThreshold set incorrectly,
> unreliable.")
> >> in my linux-4.6-zynq tree
> > NOTE description doesn't help much.
> >
> >>
> >> From: Jeremy Trimble [original patch]
> >> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> >> ---
> >>  drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++------------
> >>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> >> index a516e7ffef21..cf12f7147f07 100644
> >> --- a/drivers/dma/xilinx/xilinx_dma.c
> >> +++ b/drivers/dma/xilinx/xilinx_dma.c
> >> @@ -164,6 +164,7 @@
> >>  #define XILINX_DMA_CR_COALESCE_SHIFT 16
> >>  #define XILINX_DMA_BD_SOP            BIT(27)
> >>  #define XILINX_DMA_BD_EOP            BIT(26)
> >> +#define XILINX_DMA_BD_CMPLT          BIT(31)
> >>  #define XILINX_DMA_COALESCE_MAX              255
> >>  #define XILINX_DMA_NUM_DESCS         255
> >>  #define XILINX_DMA_NUM_APP_WORDS     5
> >> @@ -1274,12 +1275,9 @@ static void xilinx_dma_start_transfer(struct
> >> xilinx_dma_chan *chan)
> >>
> >>       reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
> >>
> >> -     if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
> >> -             reg &= ~XILINX_DMA_CR_COALESCE_MAX;
> >> -             reg |= chan->desc_pendingcount <<
> >> -                               XILINX_DMA_CR_COALESCE_SHIFT;
> >> -             dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> >> -     }
> >> +     reg &= ~XILINX_DMA_CR_COALESCE_MAX;
> >> +     reg |= 1 << XILINX_DMA_CR_COALESCE_SHIFT;
> >> +     dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> >>
> >>       if (chan->has_sg && !chan->xdev->mcdma)
> >>               xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> >> @@ -1378,6 +1376,20 @@ static void
> xilinx_dma_complete_descriptor(struct
> >> xilinx_dma_chan *chan)
> >>               return;
> >>
> >>       list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> >> +             if (chan->xdev->dma_config->dmatype ==
> >> XDMA_TYPE_AXIDMA) {
> >> +                     /*
> >> +                      * Check whether the last segment in this descriptor
> >> +                      * has been completed.
> >> +                      */
> >> +                     const struct xilinx_axidma_tx_segment *const tail_seg
> >> =
> >> +                             list_last_entry(&desc->segments,
> >> +                                             struct
> >> xilinx_axidma_tx_segment,
> >> +                                             node);
> >> +
> >> +                     /* we've processed all the completed descriptors */
> >> +                     if (!(tail_seg->hw.status & XILINX_DMA_BD_CMPLT))
> >> +                             break;
> >> +             }
> >>               list_del(&desc->node);
> >>               if (!desc->cyclic)
> >>                       dma_cookie_complete(&desc->async_tx);
> >> @@ -1826,14 +1838,13 @@ static struct dma_async_tx_descriptor
> >> *xilinx_dma_prep_slave_sg(
> >>                                  struct xilinx_axidma_tx_segment, node);
> >>       desc->async_tx.phys = segment->phys;
> >>
> >> -     /* For the last DMA_MEM_TO_DEV transfer, set EOP */
> >> -     if (chan->direction == DMA_MEM_TO_DEV) {
> >> -             segment->hw.control |= XILINX_DMA_BD_SOP;
> >> -             segment = list_last_entry(&desc->segments,
> >> -                                       struct xilinx_axidma_tx_segment,
> >> -                                       node);
> >> -             segment->hw.control |= XILINX_DMA_BD_EOP;
> >> -     }
> >> +     /* For the first transfer, set SOP */
> >> +     segment->hw.control |= XILINX_DMA_BD_SOP;
> >> +     /* For the last transfer, set EOP */
> >> +     segment = list_last_entry(&desc->segments,
> >> +                               struct xilinx_axidma_tx_segment,
> >> +                               node);
> >> +     segment->hw.control |= XILINX_DMA_BD_EOP;
> >>
> >>       return &desc->async_tx;
> >>
> >> --
> >> 2.17.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> >> the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
