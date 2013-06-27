From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 11:31:25 +0200
Subject: [PATCH 2/8] clocksource: sun4i: Add clocksource and sched clock
 drivers
In-Reply-To: <51CB5CC7.7000308@linaro.org>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <51CB5CC7.7000308@linaro.org>
Message-ID: <20130627093125.GA8437@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Jun 26, 2013 at 11:27:35PM +0200, Daniel Lezcano wrote:
> On 06/26/2013 11:16 PM, Maxime Ripard wrote:
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
> > +	writel(reg | TIMER_CNT64_CTL_RL, timer_base + TIMER_CNT64_CTL_REG);
> > +	while (readl(timer_base + TIMER_CNT64_CTL_REG) & TIMER_CNT64_CTL_REG);
> 
> Isn't a cpu_relax missing here ?

Right.

The AND is wrong as well, it should be TIMER_CNT64_CTL_RL, not the reg
offset.

> >  
> > +	writel(TIMER_CNT64_CTL_CLR, timer_base + TIMER_CNT64_CTL_REG);
> > +	setup_sched_clock(sun4i_timer_sched_read, 32, clk_get_rate(clk));
> > +	clocksource_mmio_init(timer_base + TIMER_CNT64_LOW_REG, node->name,
> > +			      clk_get_rate(clk), 300, 32,
> > +			      sun4i_timer_clksrc_read);
> > +
> >  	writel(rate / (TIMER_SCAL * HZ),
> 
> DIV_ROUND_CLOSEST(rate, (TIMER_SCAL * HZ)), ?

It's actually fixed in a later patch, but yes.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/b138f901/attachment.sig>
