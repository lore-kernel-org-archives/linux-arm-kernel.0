From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jun 2016 11:28:23 +0100
Subject: [PATCH 2/2] arm64: hibernate: Don't hibernate on systems with
 stuck CPUs
In-Reply-To: <1466156097-20028-3-git-send-email-james.morse@arm.com>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
 <1466156097-20028-3-git-send-email-james.morse@arm.com>
Message-ID: <20160617102823.GB14524@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 10:34:57AM +0100, James Morse wrote:
> Hibernate relies on cpu hotplug to prevent secondary cores executing
> the kernel text while it is being restored.
> 
> Add a call to cpus_are_stuck_in_kernel() to determine if there are
> CPUs not counted by 'num_online_cpus()', and prevent hibernate in this
> case.
> 
> Fixes: 82869ac57b5 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/hibernate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index f8df75d740f4..21ab5df9fa76 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -33,6 +33,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/sections.h>
> +#include <asm/smp.h>
>  #include <asm/suspend.h>
>  #include <asm/virt.h>
>  
> @@ -236,6 +237,11 @@ int swsusp_arch_suspend(void)
>  	unsigned long flags;
>  	struct sleep_stack_data state;
>  
> +	if (cpus_are_stuck_in_kernel()) {
> +		pr_err("Can't hibernate: no mechanism to offline secondary CPUs.\n");
> +		return -EBUSY;
> +	}
> +
>  	local_dbg_save(flags);
>  
>  	if (__cpu_suspend_enter(&state)) {
> -- 
> 2.8.0.rc3
> 
