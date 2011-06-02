From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 02 Jun 2011 17:56:55 +0100
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <20110602163152.GH32751@game.jcrosoft.org>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
	<20110602163152.GH32751@game.jcrosoft.org>
Message-ID: <1307033815.31098.31.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-02 at 18:31 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> On 15:03 Wed 01 Jun     , Marc Zyngier wrote:
> > Currently, the boot CPU has its local timer enabled long after
> > the delay loop has been calibrated. This makes it impossible to
> > boot a system that only uses local timers, like the A15.
> > 
> > Use late_time_init hook to initialize the boot CPU local timer.
> > Since shmobile is already using this hook, add an ARM specific
> > arm_late_time_init hook that platforms can use instead.
> > 
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> I propose to switch to early platform devce and earlytimer
> 
> this will avoid the arm_late_time_init hook
> 
> and will make it cross arch

I believe this is orthogonal. shmobile (the only ARM user of
late_time_init) is already doing some early_platform stuff for its
timers.

What I'm trying to achieve here is to make sure the timer on CPU0 is
actually up, running and registered as a clock_event_device before we
hit the delay loop.

Or maybe I've misunderstood what you're pointing me to?

Cheers,

	M.
-- 
Reality is an implementation detail.
