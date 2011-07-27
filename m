From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 27 Jul 2011 11:22:07 +0200
Subject: [linux-pm] [RFC/PATCH v2] PM / Runtime: allow _put_sync() from
	interrupts-disabled context
In-Reply-To: <87r55cpnwo.fsf@ti.com>
References: <1311371188-28879-1-git-send-email-khilman@ti.com>
	<201107240102.09698.rjw@sisk.pl> <87r55cpnwo.fsf@ti.com>
Message-ID: <201107271122.07701.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 27, 2011, Kevin Hilman wrote:
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
> >
> 
> OK, great.  Thanks.
> 
> Might want to just drop the last paragraph from the changelog since it
> doesn't really belong in the permanant history.

OK

Thanks,
Rafael
