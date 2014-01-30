From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 30 Jan 2014 16:19:34 +0000
Subject: [RFC] ARM Generic Timer + Interaction with WFI on Cortex-A15
In-Reply-To: <52947FFA.90504@gmail.com>
References: <528DBD0C.6040203@gmail.com>
 <20131121120025.GC31695@e102568-lin.cambridge.arm.com>
 <529442BB.1000006@gmail.com>
 <20131126101041.GA12304@e102568-lin.cambridge.arm.com>
 <52947FFA.90504@gmail.com>
Message-ID: <20140130161934.GC8389@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

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

I though about this and I think the only clean way to implement this
would be to add a power domain property to the arch timers. The problem
I am having is that this should not break existing platforms, so
basically we need to understand what the power-domain property would
mean on a system like yours with no power management. We might add
an always-on power domain and attach the arch timer to that, it seems
lots of churn for not much to me.

Adding a property like "state-retained" is not nice either because this
would solve the problem for arch timer but that does not represent a
generic solution.

Thoughts appreciated.

Thanks,
Lorenzo
