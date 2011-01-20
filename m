From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jan 2011 09:42:24 -0000
Subject: [PATCH] ARM: oprofile: Always allow backtraces
In-Reply-To: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
Message-ID: <000101cbb886$582f1480$088d3d80$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ari,

> Always allow backtrace when using oprofile on ARM, even if a PMU
> isn't present.
> 
> Restores functionality originally introduced in
> 1b7b56982fdcd9d85effd76f3928cf5d6eb26155 by Richard Purdie.

Well spotted, I'd forgotten we still want this for timer mode.
Comments inline.
 
> diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> index 8aa9744..a23e5ae 100644
> --- a/arch/arm/oprofile/common.c
> +++ b/arch/arm/oprofile/common.c
> @@ -46,6 +46,7 @@ char *op_name_from_perf_id(void)
>  		return NULL;
>  	}
>  }
> +#endif
> 
>  static int report_trace(struct stackframe *frame, void *d)
>  {
> @@ -109,6 +110,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
>  		tail = user_backtrace(tail);
>  }
> 
> +#ifdef CONFIG_HW_PERF_EVENTS

Can you reorder the backtrace stuff so that we don't need the extra
#endif/#ifdef please?

>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
>  	ops->backtrace		= arm_backtrace;
> @@ -124,6 +126,8 @@ void __exit oprofile_arch_exit(void)
>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
>  	pr_info("oprofile: hardware counters not available\n");
> +	ops->backtrace		= arm_backtrace;
> +
>  	return -ENODEV;
>  }
>  void __exit oprofile_arch_exit(void) {}

One thing worth mentioning is that the backtrace code relies on a
sensible frame pointer, which you might not have in ARM code and you
certainly won't have for Thumb-2 code.

Will
