From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jan 2015 11:21:00 +0000
Subject: [PATCHv7 1/2] arm64: use fixmap for text patching
In-Reply-To: <1421276394-20402-2-git-send-email-lauraa@codeaurora.org>
References: <1421276394-20402-1-git-send-email-lauraa@codeaurora.org>
 <1421276394-20402-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20150115112100.GA16217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:59:53PM +0000, Laura Abbott wrote:
> When kernel text is marked as read only, it cannot be modified directly.
> Use a fixmap to modify the text instead in a similar manner to
> x86 and arm.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v7: Dropped early code path. Now using fixmap unconditionally for all patching.
> ---
>  arch/arm64/include/asm/fixmap.h |  1 +
>  arch/arm64/kernel/insn.c        | 45 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 9ef6eca..defa0ff9 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -49,6 +49,7 @@ enum fixed_addresses {
>  
>  	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
>  	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +	FIX_TEXT_POKE0,
>  	__end_of_fixed_addresses
>  };
>  
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 7e9327a..df630f2 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -19,12 +19,15 @@
>  #include <linux/bitops.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
> +#include <linux/mm.h>
>  #include <linux/smp.h>
> +#include <linux/spinlock.h>
>  #include <linux/stop_machine.h>

We also need <linux/types.h> for uintptr_t below (or we could just use
unsigned long). Currently we seem to be getting that via a transitive
include, but it's best not to rely on that.

>  #include <linux/uaccess.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/fixmap.h>
>  #include <asm/insn.h>
>  
>  #define AARCH64_INSN_SF_BIT	BIT(31)
> @@ -72,6 +75,29 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
>  	}
>  }
>  
> +static DEFINE_SPINLOCK(patch_lock);
> +
> +static void __kprobes *patch_map(void *addr, int fixmap)
> +{
> +	unsigned long uintaddr = (uintptr_t) addr;
> +	bool module = !core_kernel_text(uintaddr);
> +	struct page *page;
> +
> +	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
> +		page = vmalloc_to_page(addr);
> +	else
> +		page = virt_to_page(addr);
> +

It looks like vmalloc_to_page may return NULL if a mapping isn't active
for the provided address. If that happens page_to_phys would generate a
bogus physical address, and that could lead to SErrors or other pain.

I think we should have a BUG_ON(!page) here to catch that happening
early (along with an include for <linux/bug.h> at the top).

> +
> +	set_fixmap(fixmap, page_to_phys(page));
> +
> +	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> +}

Other than the above, this looks good to me. I've messed around with
static keys with this applied and didn't spot anything unexpected. So
with the above changes (I've tested with and without):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
