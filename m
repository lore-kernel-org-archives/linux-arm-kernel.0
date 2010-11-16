From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Nov 2010 10:12:57 -0000
Subject: [PATCH 5/5] ARM: perf: separate PMU backends into multiple files
In-Reply-To: <AANLkTik6gEvTXh75_FouQegm_WxdSm8FmW2HB85jdW+T@mail.gmail.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>	<1289842263-21241-6-git-send-email-will.deacon@arm.com>
	<AANLkTik6gEvTXh75_FouQegm_WxdSm8FmW2HB85jdW+T@mail.gmail.com>
Message-ID: <006101cb8576$d7f6c520$87e44f60$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Will,
> 
> The checkpatch script returns some warnings and errors, cf. dump here below.

[...]

Cheers, I'll fix these for v2.
 
> Other than that I have a few remarks inlined.

[...]

> > -const struct arm_pmu *__init xscale2pmu_init(void)
> > -{
> > -       return &xscale2pmu;
> > -}
> > +/* Include the PMU-specific implementations. */
> > +#include "perf_event_xscale.c"
> > +#include "perf_event_v6.c"
> > +#include "perf_event_v7.c"
> >
> >  static int __init
> >  init_hw_perf_events(void)
> 
> It is better to use Kconfig/Makefile to conditionally compile files
> instead of using #include for C files.

As a general rule, I agree with you. In fact, I spent a large part of
Sunday afternoon trying to factor out these architectures so that the
`drivers' can be compiled individually and then interact with the main
perf code via an internal API. Whilst I eventually achieved this, the
code was *horrible* and massively over-engineered. The PMU backends
require access to a lot of internal types and structures which you
suddenly need to stick into a header file. The result is that perf_event.h
becomes full of ARM internal information and you end up with an elaborate
combination of forward declarations, #ifdefs and type information floating
about as a result of cleaning up the code!

At this point, I took a look at what x86 does and they use the #include
trick above. Whilst it's not code I would immediately think of writing, the
result is a much cleaner main file in my opinion. In fact, you could probably
drop the first 4 patches of this series and it would still work, but they
exist because of the initial approach I took and I still believe that making
the architecture files as self-contained as possible is a good thing.

For what it's worth, the perf_event_*.c files do contain internal compile-time
guards so they expand to a minimal (empty) init function if you're not compiling
for the relevant architecture.

Will
