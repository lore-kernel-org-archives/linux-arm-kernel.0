From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Feb 2011 16:33:47 -0000
Subject: [PATCHv2 1/2] ARM: perf_event: allow platform-specific interrupt
	handler
In-Reply-To: <AANLkTi=wQ9ku+zbu6sx5Mm+ux4Ot6K2h9a_WK=XEB_iG@mail.gmail.com>
References: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
	<-6723806473392693428@unknownmsgid>
	<AANLkTi=wQ9ku+zbu6sx5Mm+ux4Ot6K2h9a_WK=XEB_iG@mail.gmail.com>
Message-ID: <001901cbcec0$7392bbf0$5ab833d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

> > You'll be able to target the PMU IRQ to both CPUs and avoid the need for
> > ping-ponging the affinity. This is a bit weird though as usually you'd have
> > a PPI for a percpu interrupt so this might be better off staying inside
> > platform code and leaving the GIC code alone. I also think this approach
> > is more invasive from the perf point of view.
> >
> > Unless this approach gives markedly better profiling results than your
> > proposal, I think we should go with what you've got.
> 
> I gave this a try, along with the modifications to enable IRQ_PER_CPU
> and have the pmu code use the appropriate flags and set the affinity.
> Didn't work though; it always ends up triggering the spurious IRQ check.

Hmm, that doesn't sound right. Did you have any synchronisation to ensure
that the CPU without the overflow didn't return IRQ_NONE until the handling
CPU had returned IRQ_HANDLED?

Will
