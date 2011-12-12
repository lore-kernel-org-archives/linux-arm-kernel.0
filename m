From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 12 Dec 2011 10:25:40 +0900
Subject: [PATCH 2/2] DMA: PL330: Removes useless function
In-Reply-To: <CABb+yY2gyBXSW98EEF_t-RjCFwxLuOtaRBxTXBD_6Q5M0kR9aA@mail.gmail.com>
References: <Acy1grs8azr8gcXzQzOmZ6e1pLhc6Q==@samsung.com>
 <002a01ccb582$bbcdbba0$336932e0$%kim@samsung.com>
 <CABb+yY2gyBXSW98EEF_t-RjCFwxLuOtaRBxTXBD_6Q5M0kR9aA@mail.gmail.com>
Message-ID: <005c01ccb86c$f5ac4bb0$e104e310$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:

> Subject: Re: [PATCH 2/2] DMA: PL330: Removes useless function
>
> On Thu, Dec 8, 2011 at 1:53 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> > From: Boojin Kim <boojin.kim@samsung.com>
> >
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/dma/pl330.c |   47 -----------------------------------------
> ------
> >  1 files changed, 0 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 35f0904..b917477 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -1512,53 +1512,6 @@ static int pl330_chan_ctrl(void *ch_id, enum
> pl330_chan_op op)
> >        return ret;
> >  }
> >
> > -static int pl330_chan_status(void *ch_id, struct pl330_chanstatus
> *pstatus)
> > -{
> > -       struct pl330_thread *thrd = ch_id;
> > -       struct pl330_dmac *pl330;
> > -       struct pl330_info *pi;
> > -       void __iomem *regs;
> > -       int active;
> > -       u32 val;
> > -
> > -       if (!pstatus || !thrd || thrd->free)
> > -               return -EINVAL;
> > -
> > -       pl330 = thrd->dmac;
> > -       pi = pl330->pinfo;
> > -       regs = pi->base;
> > -
> > -       /* The client should remove the DMAC and add again */
> > -       if (pl330->state == DYING)
> > -               pstatus->dmac_halted = true;
> > -       else
> > -               pstatus->dmac_halted = false;
> > -
> > -       val = readl(regs + FSC);
> > -       if (val & (1 << thrd->id))
> > -               pstatus->faulting = true;
> > -       else
> > -               pstatus->faulting = false;
> > -
> > -       active = _thrd_active(thrd);
> > -
> > -       if (!active) {
> > -               /* Indicate that the thread is not running */
> > -               pstatus->top_req = NULL;
> > -               pstatus->wait_req = NULL;
> > -       } else {
> > -               active--;
> > -               pstatus->top_req = thrd->req[active].r;
> > -               pstatus->wait_req = !IS_FREE(&thrd->req[1 - active])
> > -                                       ? thrd->req[1 - active].r : NULL;
> > -       }
> > -
> > -       pstatus->src_addr = readl(regs + SA(thrd->id));
> > -       pstatus->dst_addr = readl(regs + DA(thrd->id));
> > -
> > -       return 0;
> > -}
> >
> NAK.
> Recently Samsung ASoC regressed to update DMA pointer only at period
> boundaries.
> I am sure other platforms would like to have low audio latencies and
> hence need this function.

ASoC doesn't use DMA HW pointer to get its position with the new pl330 driver 
on dmaengine. So, pl330_chan_status() isn't used anymore. It just brings a 
build warning.

Thanks you.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
