From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 11:01:48 +0100
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <87d3xgd20n.fsf@deeprootsystems.com>
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	<87d3xgd20n.fsf@deeprootsystems.com>
Message-ID: <20100501100148.GE12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 03:11:20PM -0700, Kevin Hilman wrote:
> Colin Cross <ccross@android.com> writes:
> 
> > An alternative to this patch would be to add a config option to use
> > sched_clock() to provide the counter instead of the cycle loop.  The
> > same loops_per_jiffy calibration could be done to  determine the
> > sched_clock frequency.  Any machine with an available constant tick
> > rate counter, which is likely to be used for sched_clock() already,
> > can enable CONFIG_UDELAY_USES_SCHED_CLOCK.
> 
> Or even better, why not have an option to use the clocksource which is
> most likely using the constant tick timer as well.

We may be running into the same problem which we did with the printk
clock - that is using a machine provided sched_clock() or clocksource
requires MMIO accesses, which can only be done after the IO mappings
have been initialized.

Let's hope no one ever uses udelay() before the necessary IO mappings
are present.
