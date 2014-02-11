From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 11 Feb 2014 15:46:04 +0100
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140211140749.GE3748@arm.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com> <20140210164647.GB13533@sirena.org.uk>
 <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
 <20140211103428.GC8693@mudshark.cambridge.arm.com>
 <CAKfTPtDjF2bZsoj+tgBH-ZXYXNbXQ2mBie0FVgUy2vb_jY12FQ@mail.gmail.com>
 <20140211140749.GE3748@arm.com>
Message-ID: <CAKfTPtDrLX6ZSV9cZckGztorrYRc-PNknaJch3nry=PzonZJHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2014 15:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Feb 11, 2014 at 01:18:56PM +0000, Vincent Guittot wrote:
>> On 11 February 2014 11:34, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Feb 11, 2014 at 08:15:19AM +0000, Vincent Guittot wrote:
>> >> On 10 February 2014 17:46, Mark Brown <broonie@kernel.org> wrote:
>> >> > On Mon, Feb 10, 2014 at 04:22:31PM +0000, Catalin Marinas wrote:
>> >> >> On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:
>> >> >
>> >> >> > +           if (cpu != cpuid)
>> >> >> > +                   cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
>> >> >> > +   }
>> >> >> > +   smp_wmb();
>> >> >
>> >> >> I now noticed there are a couple of smp_wmb() calls in this patch. What
>> >> >> are they for?
>> >> >
>> >> > To be honest I mostly cargo culted them from the ARM implementation; I
>> >> > did look a bit but didn't fully dig into it - it seemed they were
>> >> > required to ensure that the updates for the new CPU are visible over all
>> >> > CPUs.  Vincent?
>> >>
>> >> Yes that's it. we must ensure that updates are made visible to other CPUs
>> >
>> > In relation to what? The smp_* barriers ensure ordering of observability
>> > between a number of independent accesses, so you must be ensuring
>> > ordering against something else. Also, you need to guarantee ordering on the
>> > read-side too -- how is this achieved? I can't see any smp_rmb calls from a
>> > quick grep, so I assume you're making use of address dependencies?
>>
>> The boot sequence ensures the rmb
>
> As Will said, smp_*mb() do not ensure absolute visibility, only relative
> to subsequent memory accesses on the same processor. So just placing a
> barrier at the end of a function does not mean much, it only shows half
> of the problem it is trying to solve.

OK, that's probably the shortcut that has been made, we want to drain
the write buffer to make modification available to other cpus and I
though smp_wmb and the associated mb(ishst) was there for that
purpose.

Vincent

>
> How are the secondary CPUs using this information? AFAICT, secondaries
> call smp_store_cpu_info() which also go through each CPU in
> update_siblings_mask(). Is there any race here that smp_wmb() is trying
> to solve?
>
> I guess for secondaries you could move the barrier just before
> set_cpu_online(), this way it is clear that we want any previous writes
> to become visible when this CPU is marked online. For the primary, any
> memory writes should become visible before the CPU is started. One
> synchronisation point is the pen release, depending on the smp_ops. I
> think that's already covered by code like arch/arm/mach-*/platsmp.c.
>
> So my proposal is to remove the smp_wmb() from topology.c and add it
> where it is relevant as described above. If we have some race in
> topology.c (like for example we may later decide to start more
> secondaries at the same time), it needs to be solved using spinlocks.
>
> --
> Catalin
