From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 13 May 2016 06:51:05 -0700
Subject: [PATCH] ARM: hide finish_arch_post_lock_switch from modules
In-Reply-To: <1463146234-161304-1-git-send-email-arnd@arndb.de>
References: <1463146234-161304-1-git-send-email-arnd@arndb.de>
Message-ID: <5735DBC9.10204@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2016 06:30 AM, Arnd Bergmann wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The introduction of switch_mm_irqs_off() brought back an old bug
> regarding the use of preempt_enable_no_resched:
>
> As part of 62b94a08da1b ("sched/preempt: Take away
> preempt_enable_no_resched() from modules"), the definition of
> preempt_enable_no_resched() is only available in built-in code,
> not in loadable modules, so we can't generally use it from header
> files. However, the ARM version of finish_arch_post_lock_switch()
> calls preempt_enable_no_resched() and is defined as a static
> inline function in asm/mmu_context.h. This in turn means we cannot
> include asm/mmu_context.h from modules.
>
> With today's tip tree, asm/mmu_context.h gets included from
> linux/mmu_context.h, which is normally the exact pattern one would
> expect, but unfortunately, linux/mmu_context.h can be included from
> the vhost driver that is a loadable module, now causing this compile
> time error:
>
> In file included from ../include/linux/mmu_context.h:4:0,
>                   from ../drivers/vhost/vhost.c:18:
> ../arch/arm/include/asm/mmu_context.h: In function 'finish_arch_post_lock_switch':
> ../arch/arm/include/asm/mmu_context.h:88:3: error: implicit declaration of function 'preempt_enable_no_resched' [-Werror=implicit-function-declaration]
>     preempt_enable_no_resched();
>
> Andy already tried to fix the bug by including linux/preempt.h
> from asm/mmu_context.h, but that didn't help. I suggested reordering
> the header files, which wasn't popular, but Steve came up with this
> workaround instead:
>
> The finish_arch_post_lock_switch() definition is now also hidden
> inside of #ifdef MODULE, so we don't see anything referencing
> preempt_enable_no_resched() from a header file. I've built a
> few hundred randconfig kernels with this, and did not see any
> new problems.
>
> Fixes: f98db6013c55 ("sched/core: Add switch_mm_irqs_off() and use it in the scheduler")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/include/asm/mmu_context.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index ed73babc0dc9..3cc14dd8587c 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -67,6 +67,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
>   		cpu_switch_mm(mm->pgd, mm);
>   }
>
> +#ifndef MODULE
>   #define finish_arch_post_lock_switch \
>   	finish_arch_post_lock_switch
>   static inline void finish_arch_post_lock_switch(void)
> @@ -88,6 +89,7 @@ static inline void finish_arch_post_lock_switch(void)
>   		preempt_enable_no_resched();
>   	}
>   }
> +#endif /* !MODULE */
>
>   #endif	/* CONFIG_MMU */
>
>
