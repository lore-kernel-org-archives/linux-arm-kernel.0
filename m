From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 19:12:46 +0100
Subject: [PATCH] arm: exynos: Modify pm code to check for cortex A9
 rather than the SoC
In-Reply-To: <53A9B27F.4080606@samsung.com>
References: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
 <20140624161114.GW32514@n2100.arm.linux.org.uk>
 <53A9A568.6060108@samsung.com>
 <20140624163030.GY32514@n2100.arm.linux.org.uk>
 <53A9B27F.4080606@samsung.com>
Message-ID: <20140624181246.GA32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 07:16:47PM +0200, Tomasz Figa wrote:
> I tend to disagree. The chance of a new Cortex A9 based SoC with
> different implementor code showing up is so close to zero that I don't
> see increasing of code complexity by adding yet another check justified.

That's your opinion which I strongly disagree with.

> > If people still whine about this, I will force a change to make it
> > harder to do the wrong thing - I will get rid of the _part_number
> > interface replacing it with one which always returns the implementor
> > as well as the part number so both have to be checked.
> 
> That might be actually a better option. Something like
> 
> 	if (read_cpuid_impl_and_part() == ARM_CPU(impl, part))
> 
> or even
> 
> 	if (ARM_CPU_IS(impl, part))
> 
> would keep the checks simple, while still checking both values.

Indeed, but... Cortex is an ARM Ltd trademark, so I really doubt that
we'll see a Cortex processor implemented by another party other than
ARM.  So, there's no need for ARM_CPU(impl, part).

> > We never call firmware operations from assembly code.  However, in exynos'
> > case, it's not running in non-secure mode because it's happily reading
> > and writing these registers with no issue.
> 
> Current version of code, yes. However it handles only Exynos-based
> boards running in secure mode. For those running in non-secure mode,
> mainline does not support sleep yet.
> 
> I already have patches to change this, which I was planning to post
> after eliminating last issue. The change set includes making this
> save/restore being executed only in secure mode.

As Will has already pointed out, writing to the diagnostic register
becomes a no-op in non-secure mode - it doesn't fault.  So moving
the saving and restoring of this register into generic code, where
other platforms already require it, makes total sense.

Of course, when you have to deal with it in non-secure mode, that's
something that you have to deal with, but in secure mode, platform
code should not have to worry about this level of detail.

> In ideal world (which I would be glad to be living in)...
> 
> We both know that we can't fully rely on firmware. Firmware bugs are
> common and in many cases we can't do anything about it, because it
> already comes with the device and in many cases it is undesirable to
> change it or it can't be done at all.

Yes, I'm aware of the crap situation there.  That doesn't stop us
talking about these aspects though and setting what we expect in the
future - and changing the code to a better structure.

> > We get there from kernel/cpu_pm.c, when the notifier chain is called.
> > The notifier chain is called while taking a read lock on
> > cpu_pm_notifier_lock.
> 
> Your point. Thanks for explaining this. However this will be still
> running with just one CPU online.
> 
> > 
> > If this is about the last CPU going down, then why the notifier?  Why
> > not put the code in exynos_suspend_enter() ?  Why add this needless
> > complexity?
> > 
> 
> This code is used by both system-wide suspend/resume and cpuidle paths.
> Daniel has moved this code to CPU PM notifier as a part of his Exynos
> cpuidle consolidation series to avoid code duplication, as this is the
> common point of both paths.
> 
> To clarify, on suspend/resume path, the notifier is being called from
> syscore_ops registered in kernel/cpu_pm.c, while on cpuidle path, this
> is invoked from exynos_enter_core0_aftr() in
> drivers/cpuidle/cpuidle-exynos.c, which calls cpu_pm_enter().

... which then goes on to call cpu_suspend().  So moving this stuff
into the CPU level makes total sense rather than having every platform
running in secure mode duplicating this functionality.  Thanks for
pointing that out and adding further justification to my assertion.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
