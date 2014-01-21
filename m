From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 07:53:21 -0300
Subject: [PATCH v2 02/15] clocksource: orion: Use atomic access for
 shared registers
In-Reply-To: <52DE4491.2000505@linaro.org>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE4491.2000505@linaro.org>
Message-ID: <20140121105320.GA4356@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Tue, Jan 21, 2014 at 10:57:37AM +0100, Daniel Lezcano wrote:
> On 01/21/2014 10:12 AM, Ezequiel Garcia wrote:
> > Replace the driver-specific thread-safe shared register API
> > by the recently introduced atomic_io_clear_set().
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> in the future, put me in Cc when modifying files in clocksource that 
> will make my life easier to track the changes.
> 

Ouch, sorry about that.

[..]
> >   /*
> >    * Free-running clocksource handling.
> > @@ -68,7 +54,8 @@ static int orion_clkevt_next_event(unsigned long delta,
> >   {
> >   	/* setup and enable one-shot timer */
> >   	writel(delta, timer_base + TIMER1_VAL);
> > -	orion_timer_ctrl_clrset(TIMER1_RELOAD_EN, TIMER1_EN);
> > +	atomic_io_modify(timer_base + TIMER_CTRL,
> > +		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
> 
> I am not convinced this change is worth.
> 
> Could you elaborate the race the spinlock should prevent ?
> 

Sure. Take a look to the patchset that adds the atomic I/O (sorry again for
not Ccing you on that one):

  http://www.spinics.net/lists/arm-kernel/msg292775.html

The TIMER_CTRL register provides clocksource and watchdog control, so we
need a safe way to access the register, since we're sharing it on two
completely unrelated drivers.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
