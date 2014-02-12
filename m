From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Feb 2014 10:27:16 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <CAKfTPtATfnjP7R4ABSu_GDEYkVe3W6N2HU-ZkrQmT=nF31U4GA@mail.gmail.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com>
 <20140210164647.GB13533@sirena.org.uk>
 <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
 <20140211103428.GC8693@mudshark.cambridge.arm.com>
 <CAKfTPtDjF2bZsoj+tgBH-ZXYXNbXQ2mBie0FVgUy2vb_jY12FQ@mail.gmail.com>
 <20140211140749.GE3748@arm.com>
 <CAKfTPtATfnjP7R4ABSu_GDEYkVe3W6N2HU-ZkrQmT=nF31U4GA@mail.gmail.com>
Message-ID: <20140212102716.GE29702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 08:04:54AM +0000, Vincent Guittot wrote:
> On 11 February 2014 15:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Feb 11, 2014 at 01:18:56PM +0000, Vincent Guittot wrote:
> >> On 11 February 2014 11:34, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Tue, Feb 11, 2014 at 08:15:19AM +0000, Vincent Guittot wrote:
> >> >> On 10 February 2014 17:46, Mark Brown <broonie@kernel.org> wrote:
> >> >> > On Mon, Feb 10, 2014 at 04:22:31PM +0000, Catalin Marinas wrote:
> >> >> >> On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:
> >> >> >
> >> >> >> > +           if (cpu != cpuid)
> >> >> >> > +                   cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
> >> >> >> > +   }
> >> >> >> > +   smp_wmb();
> >> >> >
> >> >> >> I now noticed there are a couple of smp_wmb() calls in this patch. What
> >> >> >> are they for?
> >> >> >
> >> >> > To be honest I mostly cargo culted them from the ARM implementation; I
> >> >> > did look a bit but didn't fully dig into it - it seemed they were
> >> >> > required to ensure that the updates for the new CPU are visible over all
> >> >> > CPUs.  Vincent?
> >> >>
> >> >> Yes that's it. we must ensure that updates are made visible to other CPUs
> >> >
> >> > In relation to what? The smp_* barriers ensure ordering of observability
> >> > between a number of independent accesses, so you must be ensuring
> >> > ordering against something else. Also, you need to guarantee ordering on the
> >> > read-side too -- how is this achieved? I can't see any smp_rmb calls from a
> >> > quick grep, so I assume you're making use of address dependencies?
> >>
> >> The boot sequence ensures the rmb
> >
> > As Will said, smp_*mb() do not ensure absolute visibility, only relative
> > to subsequent memory accesses on the same processor. So just placing a
> 
> It's my time to be a bit confused, if smp_*mb() do not ensure absolute
> visibility on other CPUs, how can we ensure that ?

smb_wmb()/smb_rmb() do not provide any waiting, they are not
synchronisation primitives. You have to use spinlocks or some other
polling (and of course, barriers for relative ordering of memory
reads/writes).

> > barrier at the end of a function does not mean much, it only shows half
> > of the problem it is trying to solve.
> >
> > How are the secondary CPUs using this information? AFAICT, secondaries
> > call smp_store_cpu_info() which also go through each CPU in
> > update_siblings_mask(). Is there any race here that smp_wmb() is trying
> > to solve?
> 
> The fields will be used to construct topology so we must ensure their
> visibility

I wonder whether you need spinlocks around the topology updating code.

-- 
Catalin
