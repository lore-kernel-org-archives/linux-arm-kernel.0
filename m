From: xobs@kosagi.com (Sean Cross)
Date: Thu, 02 Apr 2015 12:13:34 +0800
Subject: [PATCH] ARM: fix broken hibernation
In-Reply-To: <E1YdKq4-00049v-Bj@rmk-PC.arm.linux.org.uk>
References: <E1YdKq4-00049v-Bj@rmk-PC.arm.linux.org.uk>
Message-ID: <551CC1EE.7000205@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2015 23:45, Russell King wrote:
> Normally, when a CPU wants to clear a cache line to zero in the external
> L2 cache, it would generate bus cycles to write each word as it would do
> with any other data access.
>
> However, a Cortex A9 connected to a L2C-310 has a specific feature where
> the CPU can detect this operation, and signal that it wants to zero an
> entire cache line.  This feature, known as Full Line of Zeros (FLZ),
> involves a non-standard AXI signalling mechanism which only the L2C-310
> can properly interpret.
>
> There are separate enable bits in both the L2C-310 and the Cortex A9 -
> the L2C-310 needs to be enabled and have the FLZ enable bit set in the
> auxiliary control register before the Cortex A9 has this feature
> enabled.
>
> Unfortunately, the suspend code was not respecting this - it's not
> obvious from the code:
>
> swsusp_arch_suspend()
>  cpu_suspend() /* saves the Cortex A9 auxiliary control register */
>   arch_save_image()
>   soft_restart() /* turns off FLZ in Cortex A9, and disables L2C */
>    cpu_resume() /* restores the Cortex A9 registers, inc auxcr */
>
> At this point, we end up with the L2C disabled, but the Cortex A9 with
> FLZ enabled - which means any memset() or zeroing of a full cache line
> will fail to take effect.
>
> A similar issue exists in the resume path, but it's slightly more
> complex:
>
> swsusp_arch_suspend()
>  cpu_suspend() /* saves the Cortex A9 auxiliary control register */
>   arch_save_image() /* image with A9 auxcr saved */
> ...
> swsusp_arch_resume()
>  call_with_stack()
>   arch_restore_image() /* restores image with A9 auxcr saved above */
>   soft_restart() /* turns off FLZ in Cortex A9, and disables L2C */
>    cpu_resume() /* restores the Cortex A9 registers, inc auxcr */
>
> Again, here we end up with the L2C disabled, but Cortex A9 FLZ enabled.
>
> There's no need to turn off the L2C in either of these two paths; there
> are benefits from not doing so - for example, the page copies will be
> faster with the L2C enabled.
>
> Hence, fix this by providing a variant of soft_restart() which can be
> used without turning the L2 cache controller off, and use it in both
> of these paths to keep the L2C enabled across the respective resume
> transitions.
This patch fixes hibernation on my i.MX6-based Novena, running v3.19. 
It has survived thirty hibernate/resume cycles so far.  Without the
patch it panics almost instantly after issuing the "hibernate" command.

Tested-by: Sean Cross <xobs@kosagi.com>
> Fixes: 8ef418c7178f ("ARM: l2c: trial at enabling some Cortex-A9 optimisations")
> Reported-by: xobs <-- please give me your preferred email for this!
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/hibernate.c |  5 +++--
>  arch/arm/kernel/process.c   | 10 ++++++++--
>  arch/arm/kernel/reboot.h    |  6 ++++++
>  3 files changed, 17 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/kernel/reboot.h
>
> diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> index c4cc50e58c13..cfb354ff2a60 100644
> --- a/arch/arm/kernel/hibernate.c
> +++ b/arch/arm/kernel/hibernate.c
> @@ -22,6 +22,7 @@
>  #include <asm/suspend.h>
>  #include <asm/memory.h>
>  #include <asm/sections.h>
> +#include "reboot.h"
>  
>  int pfn_is_nosave(unsigned long pfn)
>  {
> @@ -61,7 +62,7 @@ static int notrace arch_save_image(unsigned long unused)
>  
>  	ret = swsusp_save();
>  	if (ret == 0)
> -		soft_restart(virt_to_phys(cpu_resume));
> +		_soft_restart(virt_to_phys(cpu_resume), false);
>  	return ret;
>  }
>  
> @@ -86,7 +87,7 @@ static void notrace arch_restore_image(void *unused)
>  	for (pbe = restore_pblist; pbe; pbe = pbe->next)
>  		copy_page(pbe->orig_address, pbe->address);
>  
> -	soft_restart(virt_to_phys(cpu_resume));
> +	_soft_restart(virt_to_phys(cpu_resume), false);
>  }
>  
>  static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index c50fe212fd89..d14d38b860f8 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -42,6 +42,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/tls.h>
>  #include <asm/vdso.h>
> +#include "reboot.h"
>  
>  #ifdef CONFIG_CC_STACKPROTECTOR
>  #include <linux/stackprotector.h>
> @@ -96,7 +97,7 @@ static void __soft_restart(void *addr)
>  	BUG();
>  }
>  
> -void soft_restart(unsigned long addr)
> +void _soft_restart(unsigned long addr, bool disable_l2)
>  {
>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>  
> @@ -105,7 +106,7 @@ void soft_restart(unsigned long addr)
>  	local_fiq_disable();
>  
>  	/* Disable the L2 if we're the last man standing. */
> -	if (num_online_cpus() == 1)
> +	if (disable_l2)
>  		outer_disable();
>  
>  	/* Change to the new stack and continue with the reset. */
> @@ -115,6 +116,11 @@ void soft_restart(unsigned long addr)
>  	BUG();
>  }
>  
> +void soft_restart(unsigned long addr)
> +{
> +	_soft_restart(addr, num_online_cpus() == 1);
> +}
> +
>  /*
>   * Function pointers to optional machine specific functions
>   */
> diff --git a/arch/arm/kernel/reboot.h b/arch/arm/kernel/reboot.h
> new file mode 100644
> index 000000000000..c87f05816d6b
> --- /dev/null
> +++ b/arch/arm/kernel/reboot.h
> @@ -0,0 +1,6 @@
> +#ifndef REBOOT_H
> +#define REBOOT_H
> +
> +extern void _soft_restart(unsigned long addr, bool disable_l2);
> +
> +#endif
