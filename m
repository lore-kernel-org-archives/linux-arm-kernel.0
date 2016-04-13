From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Apr 2016 18:01:02 +0100
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=Xe5r3qveX356gUZWmt29Bw0XUrg5KHEbaRdJm=tDYLkw@mail.gmail.com>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
 <20160331142908.GG26532@leverpostej>
 <CAG_fn=V+e=+-svWOCUirOy4SvBNgJR5JWCFDU3uE3aKwz9ihvw@mail.gmail.com>
 <20160331160052.GA26393@leverpostej>
 <CAG_fn=Vgvuaoz_jUNcyxvFdu4LpyO55AWmTzGvCVhOYoaX9y7Q@mail.gmail.com>
 <20160331171434.GC26393@leverpostej>
 <CAG_fn=UGRMM-dJYNO3RF5zcC5p=x-+5yvk+KqU5aRbAH9p+pHw@mail.gmail.com>
 <CACT4Y+Y_zb0LmcXys6HF=Y_5Y+vaJmwyL_kps2p6je7p2dQPVg@mail.gmail.com>
 <CAG_fn=Xe5r3qveX356gUZWmt29Bw0XUrg5KHEbaRdJm=tDYLkw@mail.gmail.com>
Message-ID: <20160413170102.GA1411@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 01:17:00PM +0200, Alexander Potapenko wrote:
> On Mon, Apr 4, 2016 at 7:30 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > I did not look at all boot crashes and hangs. The low level arch code
> > like interrupts and early bootstrap is not interesting in this
> > setting, so I just bisected down to file level and excluded it. I
> > looked at one crash, though. It was related to setup of permanent
> > per-cpu storage, the kcov callback was emitted into a critical
> > sequence of instructions that switches per-cpu storage from bootstrap
> > to the real one, and access to 'current' faulted in that callback. In
> > general, for the boot issue it's better to exclude files lazily as we
> > discover new issues.
> >
> > Besides the boot issues, other files are excluded for two reasons:
> > 1. non-deterministic coverage (like interrupts and mutex slow paths).
> > 2. excessive coverage, for example memcpy-like loop will produce O(N)
> > coverage since kcov is trace-based. I guess that delay.c falls into
> > this category.
> >
> > We don't need 100% deterministic coverage. I agree that it's not
> > feasible. User-space part of syzkaller (kcov-based fuzzer) tries to
> > work around it with some heuristics. But I've tried to to eliminate
> > some frequent and common sources of non-determinism. I've repeatedly
> > collected coverage from a simple program containing
> > mmap-open-read-close, and eliminated all frequent, large spikes of
> > coverage one by one.
> >
> > Re delay.c: on x86 it is not inlined, and some parts are written in C
> > so disable of instrumentation worked. Is it inlined on arm64? I see at
> > least the following in the c file:
> >
> > void __delay(unsigned long cycles)
> > {
> >         cycles_t start = get_cycles();
> >
> >         while ((get_cycles() - start) < cycles)
> >                 cpu_relax();
> > }
> 
> Mark,
> 
> Looks like we haven't reached the consensus on this topic yet.
> Do you have anything to comment on what Dmitry said?

I'm still concerned that we only seem to have a coarse understanding of
the issues, but I guess that cannot be helped.

I'd like to make sure that if there's anything we must inhibit the
coverage of for arm64, we have a good, documented (comment or commit
message) understanding of why. That allows us to re-evaluate the
situation as code changes.

Given we don't have much fine-grained knowledge of that sort from x86,
it looks like we have to figure that out from scratch.

As for deterministic coverage, I guess we have to see what happens and
make judgements on a case-by-case basis.

> I also wonder if we can, say, land the change to arch/arm64/Kconfig
> separately from makefile changes that improve the precision or fix
> certain build configurations.

I assume that 'precision' here means 'determinism'.

I mostly agree with that, though I would like to see the feature working
from the point it's merged. i.e. any known boot/runtime failures should
be solved now, and as above, we should somehow document why each change
is necessary.

Changes relating to determinism are a bit different, and should be
evaluated separately/subsequently. We may want to annotate those
differently, as there may be cases where non-deterministic coverage data
is useful (e.g. for something other than syzkaller).

Thanks,
Mark.
