From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 5 Aug 2011 21:22:06 +0200
Subject: [linux-pm] [RFC/PATCH v2] PM / Runtime: allow _put_sync() from
	interrupts-disabled context
In-Reply-To: <87vcuczrey.fsf@ti.com>
References: <1311371188-28879-1-git-send-email-khilman@ti.com>
	<201107240102.09698.rjw@sisk.pl> <87vcuczrey.fsf@ti.com>
Message-ID: <201108052122.06949.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 05, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, July 22, 2011, Kevin Hilman wrote:
> >> Currently the use of pm_runtime_put_sync() is not safe from
> >> interrupts-disabled context because rpm_idle() will release the
> >> spinlock and enable interrupts for the idle callbacks.  This enables
> >> interrupts during a time where interrupts were expected to be
> >> disabled, and can have strange side effects on drivers that expected
> >> interrupts to be disabled.
> >> 
> >> This is not a bug since the documentation clearly states that only
> >> _put_sync_suspend() is safe in IRQ-safe mode.
> >> 
> >> However, pm_runtime_put_sync() could be made safe when in IRQ-safe
> >> mode by releasing the spinlock but not re-enabling interrupts, which
> >> is what this patch aims to do.
> >> 
> >> Problem was found when using some buggy drivers that set
> >> pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
> >> context.
> >> 
> >> The offending drivers have been fixed to use _put_sync_suspend(),
> >> But this patch is an RFC to see if it might make sense to allow
> >> using _put_sync() from interrupts-disabled context.
> >
> > OK, I'm going to take this for 3.2.
> 
> Rafael, 
> 
> Since you're planning to merge this, maybe we should consider merging
> this as a fix for v3.1, and possibly even for v3.0 stable.  That way,
> any current drivers using irq_safe and the normal _put_sync() will not
> have this problem.

I think I can push it for 3.1, but I don't think it's stable material.

Thanks,
Rafael
