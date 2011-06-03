From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Fri, 03 Jun 2011 10:11:39 +0100
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <20110603085735.GH10532@n2100.arm.linux.org.uk>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
	<20110603085735.GH10532@n2100.arm.linux.org.uk>
Message-ID: <1307092299.31098.51.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-06-03 at 09:57 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 01, 2011 at 03:03:26PM +0100, Marc Zyngier wrote:
> > Currently, the boot CPU has its local timer enabled long after
> > the delay loop has been calibrated. This makes it impossible to
> > boot a system that only uses local timers, like the A15.
> > 
> > Use late_time_init hook to initialize the boot CPU local timer.
> > Since shmobile is already using this hook, add an ARM specific
> > arm_late_time_init hook that platforms can use instead.
> 
> Why do we need to initialize the per-cpu timer in late_time_init() ?
> Is there a reason it doesn't work at time_init(), and if not can it
> be fixed to work there?

It's an ugly mess: TWD needs to be calibrated, and this requires that
jiffies are progressing. For that, you need another timer to be already
registered (fine, we have that on all TWD platforms). But time_init() is
run with interrupts disabled, and you'd hang calibrating TWD.

This can be solved by merging Colin's scalable TWD, and make sure all
platforms provide a "smp_twd" clock. Then we can get rid of the
calibration, and time_init() becomes the natural spot for
percpu_timer_setup().

	M.
-- 
Reality is an implementation detail.
