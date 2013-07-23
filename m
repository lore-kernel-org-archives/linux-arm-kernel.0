From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Jul 2013 17:04:59 +0100
Subject: [PATCH 3/4] arm64: KVM: let other tasks run when hitting WFE
In-Reply-To: <20130723104113.GE3748@MacBook-Pro.local>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
 <CAC4Lta17bmNjBck6LzziBeU0Xc36F1Jms2tQPv6+GaXvik6Wyg@mail.gmail.com>
 <CAMJs5B8Sg1MPHPsRV75mmagnYxkhzA0MKWVkwW2y0WdDVWTSxQ@mail.gmail.com>
 <20130723104113.GE3748@MacBook-Pro.local>
Message-ID: <20130723160459.GN30942@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 11:41:14AM +0100, Catalin Marinas wrote:
> On Mon, Jul 22, 2013 at 01:51:52PM +0100, Christoffer Dall wrote:
> > On 22 July 2013 10:53, Raghavendra KT <raghavendra.kt.linux@gmail.com> wrote:
> > > On Fri, Jul 19, 2013 at 7:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > >> So far, when a guest executes WFE (like when waiting for a spinlock
> > >> to become unlocked), we don't do a thing and let it run uninterrupted.
> > >>
> > >> Another option is to trap a blocking WFE and offer the opportunity
> > >> to the scheduler to switch to another task, potentially giving the
> > >> vcpu holding the spinlock a chance to run sooner.
> > >>
> > >
> > > Idea looks to be correct from my experiments on x86. It does bring some
> > > percentage of benefits in overcommitted guests. Infact,
> > >
> > > https://lkml.org/lkml/2013/7/22/41 tries to do the same thing for x86.
> > > (this results in using ple handler heuristics in vcpu_block pach).
> > 
> > What about the adverse effect in the non-overcommitted case?
> 
> Could we not detect overcommitment and only set the TWE bit in this case
> (per VCPU scheduled to run)?
> 
> The advantage of a properly para-virtualised lock is that you can target
> which VCPU to wake up. I don't think we can do this currently (without
> assumptions about the underlying OS and how the compiler allocates
> registers in the ticket spinlocks).
> 
> There have been suggestions to use WFE in user-space for a more power
> efficient busy loop (usually in user-only locking, I think some
> PostreSQL does that) together with an automatic even stream for waking
> up the WFE (Sudeep posted some patches recently for enabling 100us event
> stream). If such feature gets used, we have a new meaning for WFE and we
> may not want to trap it all the time.
> 
> Question for Will - do we have a PMU counter for WFE? (don't ask why ;))

Step away from the CPU! There's nothing architected for counting wfe
instructions so, although a CPU might expose such an event, software can't
rely on it.

Will
