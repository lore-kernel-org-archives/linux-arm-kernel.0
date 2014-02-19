From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Feb 2014 16:12:54 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:52:09AM +0000, Sebastian Capella wrote:

[...]

> diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> new file mode 100644
> index 0000000..16f406f
> --- /dev/null
> +++ b/arch/arm/kernel/hibernate.c
> @@ -0,0 +1,106 @@
> +/*
> + * Hibernation support specific for ARM
> + *
> + * Derived from work on ARM hibernation support by:
> + *
> + * Ubuntu project, hibernation support for mach-dove
> + * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
> + * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> + *  https://lkml.org/lkml/2010/6/18/4
> + *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
> + *  https://patchwork.kernel.org/patch/96442/
> + *
> + * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/suspend.h>
> +#include <asm/tlbflush.h>
> +#include <asm/cacheflush.h>
> +#include <asm/system_misc.h>
> +#include <asm/idmap.h>
> +#include <asm/suspend.h>
> +
> +extern const void __nosave_begin, __nosave_end;
> +
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn =
> +			__pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> +	unsigned long nosave_end_pfn =
> +			PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> +
> +	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +}
> +
> +void notrace save_processor_state(void)
> +{
> +	WARN_ON(num_online_cpus() != 1);
> +	flush_thread();

Can you explain to me please why we need to call flush_thread() here ?
At this point in time syscore_suspend() was already called and CPU
peripheral state saved through CPU PM notifiers.

> +	local_fiq_disable();

To me it looks like we are using this hook to disable fiqs, since it is
not done in generic code.

> +}
> +
> +void notrace restore_processor_state(void)
> +{
> +	local_fiq_enable();
> +}
> +
> +/*
> + * Snapshot kernel memory and reset the system.
> + * After resume, the hibernation snapshot is written out.
> + */
> +static int notrace __swsusp_arch_save_image(unsigned long unused)
> +{
> +	int ret;
> +
> +	ret = swsusp_save();
> +	if (ret == 0)
> +		soft_restart(virt_to_phys(cpu_resume));

By the time the suspend finisher (ie this function) is run, the
processor state has been saved and I think that's all you have to do,
function can just return after calling swsusp_save(), unless I am missing
something.

I do not understand why a soft_restart is required here. On a side note,
finisher is called with irqs disabled so, since you added a function for
soft restart noirq, it should be used, if needed, but I have to understand
why in the first place.

> +	return ret;
> +}
> +
> +/*
> + * Save the current CPU state before suspend / poweroff.
> + */
> +int notrace swsusp_arch_suspend(void)
> +{
> +	return cpu_suspend(0, __swsusp_arch_save_image);

If the goal of soft_restart is to return 0 on success from this call,
you can still do that without requiring a soft_restart in the first
place. IIUC all you want to achieve is to save processor context
registers so that when you resume from image you will actually return
from here.

> +}
> +
> +/*
> + * The framework loads the hibernation image into a linked list anchored
> + * at restore_pblist, for swsusp_arch_resume() to copy back to the proper
> + * destinations.
> + *
> + * To make this work if resume is triggered from initramfs, the
> + * pagetables need to be switched to allow writes to kernel mem.

Can you elaborate a bit more on this please ?

> + */
> +static void notrace __swsusp_arch_restore_image(void *unused)
> +{
> +	struct pbe *pbe;
> +
> +	cpu_switch_mm(idmap_pgd, &init_mm);

Same here, thanks.

> +	for (pbe = restore_pblist; pbe; pbe = pbe->next)
> +		copy_page(pbe->orig_address, pbe->address);
> +
> +	soft_restart_noirq(virt_to_phys(cpu_resume));

This soft_restart is justified so that you resume from the context saved
when creating the image.

> +}
> +
> +static u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
> +
> +/*
> + * Resume from the hibernation image.
> + * Due to the kernel heap / data restore, stack contents change underneath
> + * and that would make function calls impossible; switch to a temporary
> + * stack within the nosave region to avoid that problem.
> + */
> +int __naked swsusp_arch_resume(void)
> +{
> +	extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);

Ok, a function with attribute __naked that still calls C functions, is
attr __naked really needed here ?

> +	cpu_init();	/* get a clean PSR */

cpu_init is called in the cpu_resume path, why is this call needed here ?

Thanks,
Lorenzo
