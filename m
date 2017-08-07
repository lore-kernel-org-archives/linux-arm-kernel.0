From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Aug 2017 12:35:28 +0100
Subject: [PATCH 5/5] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <CAKv+Gu_aVPiDtmQiq_3rUVpm23jBMpRGhh8uVw3evceEbO6cag@mail.gmail.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
 <1501777403-9782-6-git-send-email-Dave.Martin@arm.com>
 <20170807112343.inxrf3k7qxkgziaj@armageddon.cambridge.arm.com>
 <CAKv+Gu_aVPiDtmQiq_3rUVpm23jBMpRGhh8uVw3evceEbO6cag@mail.gmail.com>
Message-ID: <20170807113528.yklmm7lqoqxkyy3b@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 12:31:47PM +0100, Ard Biesheuvel wrote:
> On 7 August 2017 at 12:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Aug 03, 2017 at 05:23:23PM +0100, Dave P Martin wrote:
> >> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> >> index 96959b5..5a1a927 100644
> >> --- a/arch/arm64/include/asm/simd.h
> >> +++ b/arch/arm64/include/asm/simd.h
> >> @@ -9,15 +9,46 @@
> >>  #ifndef __ASM_SIMD_H
> >>  #define __ASM_SIMD_H
> >>
> >> +#include <linux/compiler.h>
> >> +#include <linux/percpu.h>
> >> +#include <linux/preempt.h>
> >>  #include <linux/types.h>
> >>
> >> +#ifdef CONFIG_KERNEL_MODE_NEON
> >> +
> >> +DECLARE_PER_CPU(bool, kernel_neon_busy);
> > [...]
> >> @@ -233,49 +254,69 @@ void fpsimd_flush_task_state(struct task_struct *t)
> >>
> >>  #ifdef CONFIG_KERNEL_MODE_NEON
> >>
> >> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
> >> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
> >> +DEFINE_PER_CPU(bool, kernel_neon_busy);
> >
> > This variable needs to be exported to modules (allmodconfig fails to
> > build with these patches). Any preference for GPL vs non-GPL export?
> 
> It should match whatever kernel_neon_begin|end use.

Ah, good point. I'll drop the _GPL part.

-- 
Catalin
