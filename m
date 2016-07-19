From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jul 2016 14:57:47 +0100
Subject: [PATCH v15 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <20160714162208.GA22235@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <20160714162208.GA22235@e104818-lin.cambridge.arm.com>
Message-ID: <20160719135747.GB21256@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 05:22:08PM +0100, Catalin Marinas wrote:
> On Fri, Jul 08, 2016 at 12:35:44PM -0400, David Long wrote:
> > David A. Long (3):
> >   arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
> >   arm64: Add more test functions to insn.c
> >   arm64: add conditional instruction simulation support
> > 
> > Pratyush Anand (2):
> >   arm64: Blacklist non-kprobe-able symbol
> >   arm64: Treat all entry code as non-kprobe-able
> > 
> > Sandeepa Prabhu (4):
> >   arm64: Kprobes with single stepping support
> >   arm64: kprobes instruction simulation support
> >   arm64: Add kernel return probes support (kretprobes)
> >   kprobes: Add arm64 case in kprobe example module
> > 
> > William Cohen (1):
> >   arm64: Add trampoline code for kretprobes
> 
> I applied these patches on top of the arm64 for-next/core branch an
> tried to run the resulting kernel in a guest (on a Juno platform using
> both kvmtool and qemu) with KPROBES_SANITY_TEST enabled. Unfortunately,
> the kernel fails to boot with lots of "Unexpected kernel single-step
> exception at EL1".

FYI, we managed to track down the issue to two bugs in the arm64 kernel
boot part, occasionally leaving the PSTATE.D bit set for kernel threads.
While not KVM specific, the pre-conditions were more likely when running
as a guest (receiving interrupts early on during boot, possibly because
of a slow-down in the booting process due to stage 2 page faulting
mechanism).

Will is going to post the fixes soon.

-- 
Catalin
