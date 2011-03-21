From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2011 18:22:04 -0000
Subject: [PATCH 2/2] ARM: perf: add required isbs() to ARMv7 backend
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>	<1300289898-2720-2-git-send-email-will.deacon@arm.com>
	<AANLkTinQJ_1Ym8jVHjRP80XzC0PKzR+o9-Fdk56WzEF8@mail.gmail.com>
Message-ID: <002301cbe7f4$e1750450$a45f0cf0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> > On Wed, Mar 16, 2011 at 4:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > The ARMv7 architecture does not guarantee that effects from co-processor
> > > writes are immediately visible to following instructions.
> > >
> > > This patch adds two isbs to the ARMv7 perf code:
> > >
> > > (1) Immediately after selecting an event register, so that the PMU state
> > > ? ?following this instruction is consistent with the new event.
> > Ok
> >
> > >
> > > (2) Immediately before writing to the PMCR, so that any previous writes
> > > ? ?to the PMU have taken effect before (typically) enabling the
> > > ? ?counters.
> > Should the isb come _after_ the cp15 instruction so that the current
> > access is actually performed?
> 
> No. We want to ensure that the _other_ PMU registers are up-to-date before
> playing with the control register, otherwise we could end up in a horrible
> situation where we enable all the counters, but the writes to the counters
> themselves haven't yet made it.
> 
> The write to the control register will take effect before the next
> exception return, which is fine for what we want.

I'd like to submit this to the patch system if you're happy with it.
Are you OK with the barrier coming before the write to the PMCR?

Cheers,

Will
