From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 13:29:33 +0100
Subject: [PATCH v4 4/8] arm: use fixmap for text patching when text is RO
In-Reply-To: <1407949593-16121-5-git-send-email-keescook@chromium.org>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-5-git-send-email-keescook@chromium.org>
Message-ID: <20140819122933.GI23128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 13, 2014 at 06:06:29PM +0100, Kees Cook wrote:
> From: Rabin Vincent <rabin@rab.in>
> 
> Use fixmaps for text patching when the kernel text is read-only,
> inspired by x86.  This makes jump labels and kprobes work with the
> currently available CONFIG_DEBUG_SET_MODULE_RONX and the upcoming
> CONFIG_DEBUG_RODATA options.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> [kees: fixed up for merge with "arm: use generic fixmap.h"]
> [kees: added parse acquire/release annotations to pass C=1 builds]
> Signed-off-by: Kees Cook <keescook@chromium.org>

[...]

> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> index 07314af47733..a1dce690446a 100644
> --- a/arch/arm/kernel/patch.c
> +++ b/arch/arm/kernel/patch.c
> @@ -1,8 +1,11 @@
>  #include <linux/kernel.h>
> +#include <linux/spinlock.h>
>  #include <linux/kprobes.h>
> +#include <linux/mm.h>
>  #include <linux/stop_machine.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/fixmap.h>
>  #include <asm/smp_plat.h>
>  #include <asm/opcodes.h>
>  
> @@ -13,21 +16,77 @@ struct patch {
>  	unsigned int insn;
>  };
>  
> -void __kprobes __patch_text(void *addr, unsigned int insn)
> +static DEFINE_SPINLOCK(patch_lock);
> +
> +static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
> +	__acquires(&patch_lock)
> +{
> +	unsigned int uintaddr = (uintptr_t) addr;
> +	bool module = !core_kernel_text(uintaddr);
> +	struct page *page;
> +
> +	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
> +		page = vmalloc_to_page(addr);
> +	else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
> +		page = virt_to_page(addr);
> +	else
> +		return addr;
> +
> +	if (flags)
> +		spin_lock_irqsave(&patch_lock, *flags);
> +	else
> +		__acquire(&patch_lock);

I don't understand the locking here. Why is it conditional, why do we need
to disable interrupts, and are you just racing against yourself?

> +	set_fixmap(fixmap, page_to_phys(page));

set_fixmap does TLB invalidation, right? I think that means it can block on
11MPCore and A15 w/ the TLBI erratum, so it's not safe to call this with
interrupts disabled anyway.

Will
