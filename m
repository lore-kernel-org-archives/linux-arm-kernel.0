From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Oct 2013 12:22:29 -0500
Subject: [PATCH v3 2/4] mmc: omap_hsmmc: Enable SDIO IRQ.
In-Reply-To: <CALtMJECWCqBy4UCtuSZ7WtXaizjmgdaxW7pn5uL0ymuXPn=61A@mail.gmail.com>
References: <1380971830-21492-1-git-send-email-afenkart@gmail.com>
 <1380971830-21492-3-git-send-email-afenkart@gmail.com>
 <20131008161131.GD13128@radagast>
 <CALtMJECWCqBy4UCtuSZ7WtXaizjmgdaxW7pn5uL0ymuXPn=61A@mail.gmail.com>
Message-ID: <20131029172229.GA12193@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 29, 2013 at 04:06:58PM +0100, Andreas Fenkart wrote:
> >> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> >> index 94d6dc8..53beac4 100644
> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> @@ -130,6 +130,7 @@ static void apply_clk_hack(struct device *dev)
> >>  #define TC_EN                        (1 << 1)
> >>  #define BWR_EN                       (1 << 4)
> >>  #define BRR_EN                       (1 << 5)
> >> +#define CIRQ_EN                      (1 << 8)
> >>  #define ERR_EN                       (1 << 15)
> >>  #define CTO_EN                       (1 << 16)
> >>  #define CCRC_EN                      (1 << 17)
> >> @@ -210,6 +211,10 @@ struct omap_hsmmc_host {
> >>       int                     reqs_blocked;
> >>       int                     use_reg;
> >>       int                     req_in_progress;
> >> +     int                     flags;
> >> +#define HSMMC_RUNTIME_SUSPENDED      (1 << 0)        /* Runtime suspended */
> >> +#define HSMMC_SDIO_IRQ_ENABLED       (1 << 1)        /* SDIO irq enabled */
> >> +
> >>       struct omap_hsmmc_next  next_data;
> >>       struct  omap_mmc_platform_data  *pdata;
> >>  };
> >> @@ -490,27 +495,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
> >>  static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
> >>                                 struct mmc_command *cmd)
> >>  {
> >> -     unsigned int irq_mask;
> >> +     u32 irq_mask = INT_EN_MASK;
> >> +     unsigned long flags;
> >>
> >>       if (host->use_dma)
> >> -             irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
> >> -     else
> >> -             irq_mask = INT_EN_MASK;
> >> +             irq_mask &= ~(BRR_EN | BWR_EN);
> >
> > is this a bugfix ? should it be sent as a separate patch ?
> 
> maybe the u32, but otherwise it's just shorter... shall I drop it.

no, now I saw what you did ;-)

> >>
> >>       /* Disable timeout for erases */
> >>       if (cmd->opcode == MMC_ERASE)
> >>               irq_mask &= ~DTO_EN;
> >>
> >> +     spin_lock_irqsave(&host->irq_lock, flags);
> >
> > why do you need this new locking here ? register acesses are atomic,
> > right ? If you really do need the locking, should it be a separate patch
> > as well ?
> 
> because host->flags can be accessed from irq context as well

fair point :-)

> >>  static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
> >>  {
> >> -     OMAP_HSMMC_WRITE(host->base, ISE, 0);
> >> -     OMAP_HSMMC_WRITE(host->base, IE, 0);
> >> +     u32 irq_mask = 0;
> >> +     unsigned long flags;
> >> +
> >> +     spin_lock_irqsave(&host->irq_lock, flags);
> >> +     /* no transfer running, need to signal cirq if */
> >
> > if... ?
> >
> >> +     if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
> >> +             irq_mask |= CIRQ_EN;
> >> +     OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> >
> > the whole fiddling with STAT and ISE registers look very bogus to me
> > (even on current state before this patch). We shouldn't be clearing
> > pending IRQ events here, right ? We could miss IRQs due to that.
> 
> sdio_claim_host excludes multiple users and  typical users are using synchronous
> communication, issue a transfer, wait till it's done, then release the host.
> Hence when we come here, the content of ISE/STAT is a leftover from
> the previous transfer.
> Probably the intent here is to reset the registers in defined state,
> maybe it wasn't needed
> but it doesn't hurt either.
> 
> It's conservative... I don't like to change it, along the side of my
> sdio irq patches.
> If I did lots of such changes, surely I would create a regression.
> 
> On the other side If I was up to optimize the driver, then I would do this.

sure, that was an unrelated comment, just exposing some possible problem
with that approach :-)

> >> @@ -1067,8 +1085,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> >>       int status;
> >>
> >>       status = OMAP_HSMMC_READ(host->base, STAT);
> >> -     while (status & INT_EN_MASK && host->req_in_progress) {
> >> -             omap_hsmmc_do_irq(host, status);
> >> +     while (status & (INT_EN_MASK | CIRQ_EN)) {
> >
> > why don't enable CIRQ_EN in INT_EN_MASK directly ?
> 
> INT_EN_MASK is also used when bootstrapping the card in
> send_init_stream, but there
> you don't want to enable sdio irqs. So I would have to mask it there,
> so this is the smaller
> change.

true, fair enough.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/609ec52b/attachment-0001.sig>
