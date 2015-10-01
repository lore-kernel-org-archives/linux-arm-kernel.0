From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 1 Oct 2015 22:15:20 +0300
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
Message-ID: <20151001191520.GA25295@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 11:19:19AM +0100, Catalin Marinas wrote:
> On Wed, Sep 30, 2015 at 01:13:57AM +0300, Yury Norov wrote:
> > V5 reincarnation for ILP32.
> > 
> > This is mostly the same code as Andrew suggested in v3:
> > 	https://lkml.org/lkml/2014/9/3/704.
> > 
> > V4 series and discussion:
> > 	https://lkml.org/lkml/2015/4/13/691
> > 
> > Discussion on v3 and v4 raised questions and some disagreement in community,
> > and therefore patches are not accepted till now. In this v5 I tried to avoid any
> > changes that are not about obvious fixes, so all interface and implementation
> > questions are still here.
> 
> This thing comes roughly every 5-6 months, so I don't think it's worth
> reviewing it again and forgetting about it until sometime next year. We
> also had discussions on the v4 and IIRC we agreed that the ABI should be
> closer to AArch32/compat in terms of __kernel_size_t, time_t but with
> the canonical set of system calls from the asm-generic/unistd.h.
> 
> > In v5:
> >  - rebased on top of 4.3.0-rc3;
> >  - build fixed if ILP32 enabled without AARCH32;
> >  - PATCH v4 22/24 (use compat for stack_t) dropped because it confuses
> >    debug tools like gdb and strace;
> >  - PATCH v4 20/24 (use compat-syscalls for msgsnd and msgrcv for ILP32)
> >    dropped as breaking tests;
> >  - PATCH v5 22/23 (msgrcv, msgsnd handlers) introduced for proper 
> >    handling of msgrcv, msgsnd;
> >  - other minor fixes.
> 
> So apart from rebasing, there are no ABI changes. I don't think it's
> worth re-discussing the points raised during v4.
> 
> > Questions under discussion:
> >  - What for ILP32 on ARM64?
> > 	See https://lkml.org/lkml/2015/4/13/814
> > 	and http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> > 	Briefly,
> > 	 - for compatibility;
> > 	 - for performance;
> > 	 - for memory saving.
> 
> Does anyone actually need this ABI? And by "need" I don't mean a
> tick-box on product fliers but actually someone going to use it on real
> systems in the field. Because I'm not keen on maintaining an ABI in the
> kernel just as a PR exercise. I have yet to see conclusive benchmarks
> that ILP32 is a real win vs LP64 but happy to be proven wrong.
> 

Adding Prasun Capoor <Prasun.Kapoor@caviumnetworks.com>

I'm not familar with details. I know that ARM32 compatibility is the main
concern now. I think, in long run compatibility doesn't mean much.
The performance does instead. Bamvor Jian Zhang reports 10%
performance gain, and I think noone will miss the chance to became 10%
faster, if speed is a real concern, just after rebuilding the application.

> That said, I'm fine with agreeing on an ABI and see whether it takes off
> before any merging decisions.
> 
> >  - ABI questions: time_t and so on;
> > 	I think we are out of choice now. Patches to GCC and Glibc are
> > 	upstreamed more than a year ago, and there already might be a code compiled
> > 	against existing ABI. At the end, there is no major disagreement, and final
> > 	word is after ABI users. And I found no objections from that side.
> 
> CORRECTION: patches for gcc have been upstreamed, that's the ELF and PCS
> AArch64 ILP32 ABI. The syscall ABI which goes in glibc hasn't been
> merged because we did not reach an agreement on the kernel ABI (it would
> be rather silly to push something into mainline glibc that's not
> officially supported by Linux).
> 
> I really don't care if there is compiled code out there using out of
> tree patches for glibc and the kernel.

You right, they are out of tree. Sorry.

> 
> >  - Implementation questions: use ILP32 separated table or not, and others;
> > 	Code proposed by Andrew works just fine for more than a year,
> > 	and it even shows slightly better performance comparing to LP64:
> > 	http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> > 	So I see no reason to change something except obvious bugs, if found.
> 
> As I said, with patches twice a year, I don't remember the past
> discussions. So normally you should start with v4 and address the
> comments there. But you seem to have refreshed v3.
> 
> Anyway, if by table you mean the syscall table, I think on v4 we agreed
> on a separate ILP32 syscall table using the generic syscall numbering
> but with some compat syscall pointers where applicable.
> 

We already have separated ILP32 syscall table, see patch 19 in this
patchset. This is in fact the option e), suggested by Arnd as best
option for him. https://lkml.org/lkml/2015/4/17/237

Regarding time_t, it, of course, doesn't takes much time to make it
32-bit, but I think 64 bit is better because of Y2038. X32 and mips
n32 has time_t 64-bit (and ppc, not sure), and that's OK for them.
That's OK for BSD as well. The objection may come from users of ABI,
complaining portability problems, but I found no such complains in
public discussions.

Nevertheless, as I told, I do not see any problem to rework time_t.
But some arguments supporting this decision are appreciated.

The downside of 32 bit time_t is that we still face Y2038 problem,
but that's the other story fixing it.

__kernel_long_t is the same. Now it's 64 bits length. Compatibility
may suffer, but, again, there're no complains, and in long run it
looks better.

That's what Andrew says, and I'm gonna to agree:
> There are only a few places where long should be 32bit rather than 64bit.
> The non-time_t field of timespec is the only one I can think of. The rest
> are valid and good idea to stay as 64bit. Including the limits.

BR,
Yury

> -- 
> Catalin
