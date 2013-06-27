From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 11:35:58 +0200
Subject: [PATCH 2/8] clocksource: sun4i: Add clocksource and sched clock
 drivers
In-Reply-To: <20130627060234.GD4824@tarshish>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130627060234.GD4824@tarshish>
Message-ID: <20130627093558.GB8437@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Thu, Jun 27, 2013 at 09:02:34AM +0300, Baruch Siach wrote:
> Hi Maxime,
> 
> On Wed, Jun 26, 2013 at 11:16:55PM +0200, Maxime Ripard wrote:
> > The A10 and the A13 has a 64 bits free running counter that we can use
> > as a clocksource and a sched clock, that were both not used yet on these
> > platforms.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clocksource/sun4i_timer.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> > index bdf34d9..1d2eaa0 100644
> > --- a/drivers/clocksource/sun4i_timer.c
> > +++ b/drivers/clocksource/sun4i_timer.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  
> > +#include <asm/sched_clock.h>
> 
> In the tip.git tree (and -next) this header is moved to <linux/sched_clock.h> 
> in  38ff87f77a (sched_clock: Make ARM's sched_clock generic for all 
> architectures).

Ah, good to know. Thanks!

> > +
> >  #define TIMER_IRQ_EN_REG	0x00
> >  #define TIMER_IRQ_EN(val)		BIT(val)
> >  #define TIMER_IRQ_ST_REG	0x04
> > @@ -34,6 +36,11 @@
> >  #define TIMER_CNTVAL_REG(val)	(0x10 * val + 0x18)
> >  
> >  #define TIMER_SCAL		16
> > +#define TIMER_CNT64_CTL_REG	0xa0
> > +#define TIMER_CNT64_CTL_CLR		BIT(0)
> > +#define TIMER_CNT64_CTL_RL		BIT(1)
> > +#define TIMER_CNT64_LOW_REG	0xa4
> > +#define TIMER_CNT64_HIGH_REG	0xa8
> >  
> >  static void __iomem *timer_base;
> >  
> > @@ -96,6 +103,20 @@ static struct irqaction sun4i_timer_irq = {
> >  	.dev_id = &sun4i_clockevent,
> >  };
> >  
> > +static u32 sun4i_timer_sched_read(void)
> 
> You commit message mentions "64 bits free running counter", but this one only 
> returns 32 bit.

Yeah, the callback setup by setup_sched_clock is supposed to be
returning a u32, and clocksource_mmio_init only accepts up to 32 bits as
well, so I'm only using the lower 32bits of this 64 bits counter.

I'll amend the commit log to state this.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/0a28a285/attachment.sig>
