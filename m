From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 5 Oct 2016 21:12:54 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
Message-ID: <20161005201254.GA26721@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 02:25:22PM +0200, Fredrik Markstr?m wrote:
> On Tue, Oct 4, 2016 at 7:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Oct 04, 2016 at 05:35:33PM +0200, Fredrik Markstrom wrote:
> The way I was trying to defend the breakage was by reasoning that that if it
> was an ABI we broke it both with a4780ad and with 6a1c531, and since we don't
> break ABI:s, it can't be one.

Prior to commit 6a1c531, other programs and/or cpuidle could have corrupted
TPIDRURW to arbitrary values at any point in time, so it couldn't have been
relied upon.

Arguably, someone could have (ab)used TPIDRURW between commits 6a1c531 and
a4780ad to detect context switches, but in practice they don't appear to have,
and we know of an established user relying on the current behaviour.

For better or worse, the current behaviour is ABI.

> > I was under the impression that other mechanisms were being considered
> > for fast userspace access to per-cpu data structures, e.g. restartable
> > sequences. What is the state of those? Why is this better?
> >
> > If getcpu() specifically is necessary, is there no other way to
> > implement it?
> 
> If you are referring to the user space stuff can probably be implemented
> other ways, it's just convenient since the interface is there and it will
> speed up stuff like lttng without modifications (well, except glibc). It's
> also already implemented as a vDSO on other major architectures (like x86,
> x86_64, ppc32 and ppc64).
> 
> If you are referring to the implementation of the vdso call, there are other
> possibilities, but I haven't found any that doesn't introduce overhead in
> context switching.
>
> But if TPIDRURW is definitely a no go, I can work on a patch that does this
> with a thread notifier and the vdso data page. Would that be a viable option?

As pointed out, that won't work for SMP, but perhaps we can come up with
something that does.

> > > +notrace int __vdso_getcpu(unsigned int *cpup, unsigned int *nodep,
> > > +                       struct getcpu_cache *tcache)
> > > +{
> > > +     unsigned long node_and_cpu;
> > > +
> > > +     asm("mrc p15, 0, %0, c13, c0, 2\n" : "=r"(node_and_cpu));
> > > +
> > > +     if (nodep)
> > > +             *nodep = cpu_to_node(node_and_cpu >> 16);
> > > +     if (cpup)
> > > +             *cpup  = node_and_cpu & 0xffffUL;
> >
> > Given this is directly user-accessible, this format is a de-facto ABI,
> > even if it's not documented as such. Is this definitely the format you
> > want long-term?
> 
> Yes, this (the interface) is indeed the important part and therefore I tried
> not to invent anything on my own.  This is the interface used by ppc32,
> ppc64, x86, x86_64. It's also this is how the getcpu(2) system call is
> documented.

I was referring to the value in TPIDRURW specifically. If an application
started reading that directly (rather than going through the vDSO), we wouldn't
be able to change the register value in future.

That's all moot, given we can't repurpose TPIDRURW.

Thanks,
Mark.
