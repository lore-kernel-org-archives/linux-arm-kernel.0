From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Sep 2015 11:19:19 +0100
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 01:13:57AM +0300, Yury Norov wrote:
> V5 reincarnation for ILP32.
> 
> This is mostly the same code as Andrew suggested in v3:
> 	https://lkml.org/lkml/2014/9/3/704.
> 
> V4 series and discussion:
> 	https://lkml.org/lkml/2015/4/13/691
> 
> Discussion on v3 and v4 raised questions and some disagreement in community,
> and therefore patches are not accepted till now. In this v5 I tried to avoid any
> changes that are not about obvious fixes, so all interface and implementation
> questions are still here.

This thing comes roughly every 5-6 months, so I don't think it's worth
reviewing it again and forgetting about it until sometime next year. We
also had discussions on the v4 and IIRC we agreed that the ABI should be
closer to AArch32/compat in terms of __kernel_size_t, time_t but with
the canonical set of system calls from the asm-generic/unistd.h.

> In v5:
>  - rebased on top of 4.3.0-rc3;
>  - build fixed if ILP32 enabled without AARCH32;
>  - PATCH v4 22/24 (use compat for stack_t) dropped because it confuses
>    debug tools like gdb and strace;
>  - PATCH v4 20/24 (use compat-syscalls for msgsnd and msgrcv for ILP32)
>    dropped as breaking tests;
>  - PATCH v5 22/23 (msgrcv, msgsnd handlers) introduced for proper 
>    handling of msgrcv, msgsnd;
>  - other minor fixes.

So apart from rebasing, there are no ABI changes. I don't think it's
worth re-discussing the points raised during v4.

> Questions under discussion:
>  - What for ILP32 on ARM64?
> 	See https://lkml.org/lkml/2015/4/13/814
> 	and http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> 	Briefly,
> 	 - for compatibility;
> 	 - for performance;
> 	 - for memory saving.

Does anyone actually need this ABI? And by "need" I don't mean a
tick-box on product fliers but actually someone going to use it on real
systems in the field. Because I'm not keen on maintaining an ABI in the
kernel just as a PR exercise. I have yet to see conclusive benchmarks
that ILP32 is a real win vs LP64 but happy to be proven wrong.

That said, I'm fine with agreeing on an ABI and see whether it takes off
before any merging decisions.

>  - ABI questions: time_t and so on;
> 	I think we are out of choice now. Patches to GCC and Glibc are
> 	upstreamed more than a year ago, and there already might be a code compiled
> 	against existing ABI. At the end, there is no major disagreement, and final
> 	word is after ABI users. And I found no objections from that side.

CORRECTION: patches for gcc have been upstreamed, that's the ELF and PCS
AArch64 ILP32 ABI. The syscall ABI which goes in glibc hasn't been
merged because we did not reach an agreement on the kernel ABI (it would
be rather silly to push something into mainline glibc that's not
officially supported by Linux).

I really don't care if there is compiled code out there using out of
tree patches for glibc and the kernel.

>  - Implementation questions: use ILP32 separated table or not, and others;
> 	Code proposed by Andrew works just fine for more than a year,
> 	and it even shows slightly better performance comparing to LP64:
> 	http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> 	So I see no reason to change something except obvious bugs, if found.

As I said, with patches twice a year, I don't remember the past
discussions. So normally you should start with v4 and address the
comments there. But you seem to have refreshed v3.

Anyway, if by table you mean the syscall table, I think on v4 we agreed
on a separate ILP32 syscall table using the generic syscall numbering
but with some compat syscall pointers where applicable.

-- 
Catalin
