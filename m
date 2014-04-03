From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 02 Apr 2014 18:04:29 -0700
Subject: [PATCH] arm: ftrace: work with CONFIG_DEBUG_SET_MODULE_RONX
In-Reply-To: <1396476619-15386-1-git-send-email-rabin@rab.in>
References: <1396476619-15386-1-git-send-email-rabin@rab.in>
Message-ID: <533CB39D.2030509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2014 3:10 PM, Rabin Vincent wrote:
> Make ftrace work with CONFIG_DEBUG_SET_MODULE_RONX by making module text
> writable around the place where ftrace does its work, like it is done on
> x86 in the patch which introduced CONFIG_DEBUG_SET_MODULE_RONX,
> 84e1c6bb38eb ("x86: Add RO/NX protection for loadable kernel modules").
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/ftrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 34e5664..70ce654 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/ftrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/module.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/opcodes.h>
> @@ -63,6 +64,18 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
>  }
>  #endif
>  
> +int ftrace_arch_code_modify_prepare(void)
> +{
> +	set_all_modules_text_rw();
> +	return 0;
> +}
> +
> +int ftrace_arch_code_modify_post_process(void)
> +{
> +	set_all_modules_text_ro();
> +	return 0;
> +}
> +
>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
>  {
>  	return arm_gen_branch_link(pc, addr);
> 

I think Mitch tested this on our internal targets. I'll let him reply with his Tested-by

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
