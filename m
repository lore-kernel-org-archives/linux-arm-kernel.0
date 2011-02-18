From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Feb 2011 11:34:18 -0000
Subject: [PATCHv2 1/2] ARM: perf_event: allow platform-specific interrupt
	handler
In-Reply-To: <AANLkTi=ph8U3qGFgfhc15SNuYcj6oSUq8VPyJ+h_8b5O@mail.gmail.com>
References: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
	<-6723806473392693428@unknownmsgid>
	<AANLkTi=wQ9ku+zbu6sx5Mm+ux4Ot6K2h9a_WK=XEB_iG@mail.gmail.com>
	<-3663809140750500272@unknownmsgid>
	<AANLkTi=ph8U3qGFgfhc15SNuYcj6oSUq8VPyJ+h_8b5O@mail.gmail.com>
Message-ID: <001e01cbcf5f$c7ab5bd0$57021370$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Feb 17, 2011 at 22:03, Will Deacon <will.deacon@arm.com> wrote:
> >> I gave this a try, along with the modifications to enable IRQ_PER_CPU
> >> and have the pmu code use the appropriate flags and set the affinity.
> >> Didn't work though; it always ends up triggering the spurious IRQ check.
> >
> > Hmm, that doesn't sound right. Did you have any synchronisation to ensure
> > that the CPU without the overflow didn't return IRQ_NONE until the handling
> > CPU had returned IRQ_HANDLED?
> 
> No.  What kind of synchronization do you mean?

Well my guess is that the CPU returning IRQ_NONE is perpetually taking the
same interrupt until the other CPU has poked the PMU to stop it asserting
the line (otherwise I can't see how the spurious check would trip). You could
have a lock in the driver to synchronise between the two CPUs so that if you
don't have an overflow, you wait for the other CPU to clear the interrupt before
returning.

This has quickly started to become horrible but I was just curious as to whether
it provides better results than the affinity-setting approach (which is certainly
less invasive).

Cheers,

Will
