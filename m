From: gleb@redhat.com (Gleb Natapov)
Date: Mon, 7 Oct 2013 19:53:53 +0300
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1BCAA4EA-CD0A-4E2A-9D22-5B9BD98F2ECD@suse.de>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
 <52F72A87-9CC3-4B38-ACDA-F5EA66FA7375@suse.de>
 <5252DE5E.6060700@arm.com>
 <1BCAA4EA-CD0A-4E2A-9D22-5B9BD98F2ECD@suse.de>
Message-ID: <20131007165352.GC9127@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 06:30:04PM +0200, Alexander Graf wrote:
> 
> On 07.10.2013, at 18:16, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > On 07/10/13 17:04, Alexander Graf wrote:
> >> 
> >> On 07.10.2013, at 17:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> 
> >>> On an (even slightly) oversubscribed system, spinlocks are quickly 
> >>> becoming a bottleneck, as some vcpus are spinning, waiting for a 
> >>> lock to be released, while the vcpu holding the lock may not be 
> >>> running at all.
> >>> 
> >>> This creates contention, and the observed slowdown is 40x for 
> >>> hackbench. No, this isn't a typo.
> >>> 
> >>> The solution is to trap blocking WFEs and tell KVM that we're now
> >>> spinning. This ensures that other vpus will get a scheduling boost,
> >>> allowing the lock to be released more quickly.
> >>> 
> >>>> From a performance point of view: hackbench 1 process 1000
> >>> 
> >>> 2xA15 host (baseline):	1.843s
> >>> 
> >>> 2xA15 guest w/o patch:	2.083s 4xA15 guest w/o patch:	80.212s
> >>> 
> >>> 2xA15 guest w/ patch:	2.072s 4xA15 guest w/ patch:	3.202s
> >> 
> >> I'm confused. You got from 2.083s when not exiting on spin locks to
> >> 2.072 when exiting on _every_ spin lock that didn't immediately
> >> succeed. I would've expected to second number to be worse rather than
> >> better. I assume it's within jitter, I'm still puzzled why you don't
> >> see any significant drop in performance.
> > 
> > The key is in the ARM ARM:
> > 
> > B1.14.9: "When HCR.TWE is set to 1, and the processor is in a Non-secure
> > mode other than Hyp mode, execution of a WFE instruction generates a Hyp
> > Trap exception if, ignoring the value of the HCR.TWE bit, conditions
> > permit the processor to suspend execution."
> > 
> > So, on a non-overcommitted system, you rarely hit a blocking spinlock,
> > hence not trapping. Otherwise, performance would go down the drain very
> > quickly.
> 
> Well, it's the same as pause/loop exiting on x86, but there we have special hardware features to only ever exit after n number of turnarounds. I wonder why we have those when we could just as easily exit on every blocking path.
> 
It will hurt performance if vcpu that holds the lock is running.
Ideally you want to exit to hypervisor only if lock holder is preempted,
but there is no way to know it, so you spin for a short time and if lock
is not released it means that lock holder is preempted (spinlock should
not be held for a long time after all), so you exit.

--
			Gleb.
