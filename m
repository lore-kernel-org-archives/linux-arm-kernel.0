From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 8 Aug 2013 06:29:33 -0300
Subject: [PATCH 2/5] clocksource: armada-370-xp: Simplify TIMER_CTRL
 register access
In-Reply-To: <20130808072016.GB29815@lunn.ch>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375919556-24104-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130808072016.GB29815@lunn.ch>
Message-ID: <20130808092932.GB2295@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 09:20:16AM +0200, Andrew Lunn wrote:
> On Wed, Aug 07, 2013 at 08:52:33PM -0300, Ezequiel Garcia wrote:
> > This commit creates two functions to access the TIMER_CTRL register:
> > one for global one for the per-cpu. This makes the code much more
> > readable. In addition, since the TIMER_CTRL register is also used for
> > watchdog, this is preparation work for future thread-safe improvements.
> > 
> > Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/clocksource/time-armada-370-xp.c | 70 ++++++++++++++------------------
> >  1 file changed, 31 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> > index 5ee4329..a2351ac 100644
> > --- a/drivers/clocksource/time-armada-370-xp.c
> > +++ b/drivers/clocksource/time-armada-370-xp.c
> > @@ -71,6 +71,18 @@ static u32 ticks_per_jiffy;
> >  
> >  static struct clock_event_device __percpu **percpu_armada_370_xp_evt;
> >  
> > +void timer_ctrl_clrset(u32 clr, u32 set)
> > +{
> > +       writel((readl(timer_base + TIMER_CTRL_OFF) & ~clr) | set,
> > +               timer_base + TIMER_CTRL_OFF);
> > +}
> > +
> > +void local_timer_ctrl_clrset(u32 clr, u32 set)
> > +{
> > +       writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
> > +               local_base + TIMER_CTRL_OFF);
> > +}
> > +
> 
> Ezequiel
> 
> I guess the watchdog will only require one of these two functions
> above, and probably not the local_timer function. So maybe make it
> static? Also, do you get sparse warnings from timer_ctrl_clrset()
> since it is not static, but also not declared in a header file
> somewhere?
> 

Nice catch! Both should be static for now, we can export/declare
the proper one in the proper time.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
