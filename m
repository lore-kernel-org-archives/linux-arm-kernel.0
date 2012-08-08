From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 23:47:22 -0700
Subject: [PATCH] ARM: OMAP2+: Fix dmtimer set source clock failure
In-Reply-To: <87boim36mj.fsf@ti.com>
References: <1342210323-2129-1-git-send-email-jon-hunter@ti.com>
 <87boim36mj.fsf@ti.com>
Message-ID: <20120808064722.GB11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120807 11:21]:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
> > Calling the dmtimer function omap_dm_timer_set_source() fails if following a
> > call to pm_runtime_put() to disable the timer. For example the following
> > sequence would fail to set the parent clock ...
> >
> > 	omap_dm_timer_stop(gptimer);
> > 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
> >
> > The following error message would be seen ...
> >
> > omap_dm_timer_set_source: failed to set timer_32k_ck as parent
> >
> > The problem is that, by design, pm_runtime_put() simply decrements the usage
> > count and returns before the timer has actually been disabled. Therefore,
> > setting the parent clock failed because the timer was still active when the
> > trying to set the parent clock. Setting a parent clock will fail if the clock
> > you are setting the parent of has a non-zero usage count. To ensure that this
> > does not fail use pm_runtime_put_sync() when disabling the timer.
> >
> > Note that this will not be seen on OMAP1 devices, because these devices do
> > not use the clock framework for dmtimers.
> >
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks applying into fixes with Cc stable.

Tony
