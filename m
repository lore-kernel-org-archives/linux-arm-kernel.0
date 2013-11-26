From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 26 Nov 2013 12:28:01 +0000
Subject: [RFC] ARM Generic Timer + Interaction with WFI on Cortex-A15
In-Reply-To: <52947FFA.90504@gmail.com>
References: <528DBD0C.6040203@gmail.com>
 <20131121120025.GC31695@e102568-lin.cambridge.arm.com>
 <529442BB.1000006@gmail.com>
 <20131126101041.GA12304@e102568-lin.cambridge.arm.com>
 <52947FFA.90504@gmail.com>
Message-ID: <20131126122801.GB12304@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Mark in CC to make him aware of this thread]

On Tue, Nov 26, 2013 at 11:03:22AM +0000, Marc C wrote:
> Hi Lorenzo,
> 
> > So what's the problem then ? Just avoid adding CPUIDLE_FLAG_TIMER_STOP
> > to the C-state flags and you are all set, or I am missing something
> > here ?
> 
> The C3STOP flag prevents the kernel from using the timer as a
> high-resolution clock source. There are some patches that remove the
> C3STOP flag [1] in order for the timer to function for use with hrtimer.
> I think something similar could be manageable as a DT property on the
> armv7-timer binding.
> 
> > Yes I do object. Timer binding is global in the DT and do not want to
> > override the flag for all local timers when, as I mentioned, A15
> > behaviour is just an exception. If you really need that, please write
> > an idle driver that does not enter broadcast mode on C-state entry
> > (see above).
> 
> So what you're saying is that you'll outright disapprove of any patch
> that would otherwise help ensure the kernel would run on any/all
> variations of armv7-timer? I would imagine that we'd want things to be
> more inclusive, and since there are quite a few SoCs with the timer that
> behave in this manner.
> 
> I'm not trying to be a thorn in your side. I just want to make sure
> everyone that has an implementation similar to ours is covered, too.

Ok, I think I got it now. The platform in question has just local timers
(no global timer), and they are not shut down on idle entry, actually
the platform has no PM capability at all (apart from wfi).

Given that arch timers are C3STOP, kernel does not enter hr mode.

Problem is more complex than I thought and deserves some time to sort it
out properly, I am also working on C-states binding for ARM, I will take
this into account.

> I appreciate your feedback.

Sorry for misunderstanding the problem at first.

Thanks,
Lorenzo

> Thanks,
> Marc
> 
> [1] https://lkml.org/lkml/2013/6/16/245
> 
> [1] https://lkml.org/lkml/2013/6/16/245
> On 11/26/13, 2:10 AM, Lorenzo Pieralisi wrote:
> > Hi Marc,
> > 
> > On Tue, Nov 26, 2013 at 06:42:03AM +0000, Marc C wrote:
> >> Hello Lorenzo,
> >>
> >>> It is an A15 oddity and we should not care, given that this behaviour
> >>> is platform specific and likely to fail in most common A15
> >>> implementations.
> >>
> >> I'm supporting a platform where this "oddity" is actually a relied-upon
> >> feature. Our ARMv7-compliant MPCore implements the ARM Generic Timer per
> >> spec. Our implementation isn't a constituent of a big.LITTLE
> >> arrangement, and we'll never completely power-off all cores (we just use
> >> WFI).
> > 
> > So what's the problem then ? Just avoid adding CPUIDLE_FLAG_TIMER_STOP
> > to the C-state flags and you are all set, or I am missing something here ?
> > 
> >> According to the documentation that currently exists, it seems that the
> >> behavior of the ARM Generic Timer on cores like the A15 is really just
> >> an attribute of that specific implementation. As you've alluded to,
> >> there may be other implementations that are also usable when the CPUs
> >> enter WFI. That said, do you object to having an optional boolean
> >> property in the arch_timer DT binding [1] which allows users to override
> >> the C3STOP flag? The default behavior would be as is currently
> >> implemented, and for the odd machines we can add the new property to the DT.
> > 
> > Yes I do object. Timer binding is global in the DT and do not want to
> > override the flag for all local timers when, as I mentioned, A15 behaviour is
> > just an exception. If you really need that, please write an idle driver that
> > does not enter broadcast mode on C-state entry (see above).
> > 
> > Thanks,
> > Lorenzo
> > 
> 
