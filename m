From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 27 May 2010 20:50:47 +0530
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <1274973118-11874-1-git-send-email-will.deacon@arm.com>
References: <1274973118-11874-1-git-send-email-will.deacon@arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C57A6E03@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Will Deacon
> Sent: Thursday, May 27, 2010 8:42 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Russell King - ARM Linux; Will Deacon
> Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
> 
> The cpu_relax() macro is often used in the body of busy-wait loops to ensure
> that the variable being spun on is re-loaded for each iteration. On the
> ARM11MPCore processor [where loads are prioritised over stores], spinning in
> such a loop will prevent the write buffer from draining. If a write contained
> in the write buffer indirectly affects the variable being spun on, there is a
> potential for deadlock. This deadlock is experienced when executing the KGDB
> testsuite on an SMP ARM11MPCore configuration.
> 
> This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> forcing a flushing of the write buffer on SMP systems before the next load
> takes place. If the Kernel is not compiled for SMP support, this will expand
> to a barrier() as before.
>
I have missed this thread. Is this not applicable for ARMv7 MP Cores as well??
 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Russell - the discussion on this last month seemed to draw to a close.
> Can I submit this to the patch system please, or are there any outstanding
> issues?
> 
>  arch/arm/include/asm/processor.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 6a89567..7bed3da 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -91,7 +91,11 @@ extern void release_thread(struct task_struct *);
> 
>  unsigned long get_wchan(struct task_struct *p);
> 
> +#if __LINUX_ARM_ARCH__ == 6
> +#define cpu_relax()			smp_mb()
> +#else
>  #define cpu_relax()			barrier()
> +#endif
> 
>  /*
>   * Create a new kernel thread
> --
> 1.6.3.3

Regards,
Santosh
