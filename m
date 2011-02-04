From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 23:43:31 +0000
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support for
	re-enabling l2x0
In-Reply-To: <AANLkTi=cTXmQFm_s5OL2pGyyaFv5UR_f9MV=S5Ajx0tu@mail.gmail.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-5-git-send-email-ccross@android.com>
	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
	<20110125154133.GB17280@n2100.arm.linux.org.uk>
	<1295979242.10109.308.camel@e102109-lin.cambridge.arm.com>
	<2f97ec8a084e590220e1548fc927b60e@mail.gmail.com>
	<-8932138696981683633@unknownmsgid>
	<AANLkTi=cTXmQFm_s5OL2pGyyaFv5UR_f9MV=S5Ajx0tu@mail.gmail.com>
Message-ID: <20110204234331.GF8732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 05:32:26PM -0600, Colin Cross wrote:
> On Tue, Jan 25, 2011 at 12:39 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Well if you set the priority fields in the notifier blocks correctly
> > then you can just return NOTIFY_STOP when you've saved/restored as much
> > as you want. This assumes of course that you can identify which power
> > mode you're entering/leaving and that each one is `deeper' than the previous.
> 
> I doubt its possible to create an order that will work for all
> architectures, and returning NOTIFY_STOP would require the decision on
> when to finish to be made by the notifier block instead of the
> platform code.
> 
> Tegra has three possible idle modes:
> 
> 1.  WFI - nothing reset
> 2.  CPU, TWD, L1, GIC lost, L2 needs to be disabled but not reset
> 3.  CPU, TWD, L1, GIC, and L2 lost

(2) and (3) don't sound like per-cpu modes but system modes.  If you're
having to disable L2, then your other CPU can't be active.

> CPU and L1 are already handled by the platform-specific suspend code.
> TWD is handled by the clockevents broadcast notifiers.  That leaves L2
> and GIC.

GIC can be handled in just the same way - upon a CPU idling and it
being decided that the CPU should enter low power mode, the idle states
are entered which does what's required with TWD, L1, VFP, Neon, etc.
We just need the GIC CPU interface included in there.

When both CPUs are idled, then the L2 comes into play, and then modes
(2) and (3) become possible and this is where you start doing the extra
stuff.

Note that you have to do it that way anyway, because you can't save
the state of the other CPU's GIC without doing an IPI call, which
could kick it out of its idle mode.
