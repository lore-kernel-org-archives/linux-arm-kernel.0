From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 19:02:28 +0200
Subject: [linux-sunxi] [PATCH 2/8] clocksource: sun4i: Add clocksource
 and sched clock drivers
In-Reply-To: <20130627131729.5fff8468@i7>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130627131729.5fff8468@i7>
Message-ID: <20130627170228.GC4319@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Siarhei,

On Thu, Jun 27, 2013 at 01:17:29PM +0300, Siarhei Siamashka wrote:
> On Wed, 26 Jun 2013 23:16:55 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
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
> > +{
> > +	u32 reg = readl(timer_base + TIMER_CNT64_CTL_REG);
> 
> If we can be absolutely sure that nothing else may ever change
> the TIMER_CNT64_CTL_REG, then its default value can be probably
> cached instead of doing expensive read from the hardware register
> each time?

Since it's a free-running counter, its value will always change, so the
caching will bring no additions at all, right?

> The gettimeofday() abusers will feel a bit less pain. ARM does not
> currently enjoy the VDSO optimized gettimeofday, so the software
> which has been only tested on x86 may get a nasty surprise (an order
> of magnitude higher gettimeofday overhead).
> 
> > +	writel(reg | TIMER_CNT64_CTL_RL, timer_base + TIMER_CNT64_CTL_REG);
> > +	while (readl(timer_base + TIMER_CNT64_CTL_REG) & TIMER_CNT64_CTL_REG);
> 
> Some may think that this particular loop looks like a performance
> bottleneck, but it is very rarely run for more than one iteration.
> In fact, most of the time it just happens to be a single HW register
> read.

Thanks for your insight on this.

It does make me more eager to merge the simpler approach first, and then
try to take some shortcuts if needed and safe enough.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/046606b3/attachment.sig>
