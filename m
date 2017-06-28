From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Jun 2017 16:22:22 +0100
Subject: [PATCH] arm64: fix missing __user in compat_vfp_{get,set}()
In-Reply-To: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
References: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170628152221.GN8543@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:58:16PM +0200, Luc Van Oostenryck wrote:
> compat_vfp_get() & compat_vfp_set() are two helpers reading
> or writting some values via {get,put}_user() which need a
> pointer annotated with '__user'.
> The buffers used by the two helpers are correctly '__user'
> annotated but need to be casted to a real type before being
> given to {get,put}_user().
> 
> The problem is that this cast lack a '__user' annotation.
> 
> Fix this by adding the missing '__user'.

Casting __user off is something that sparse certainly should be warning
about (and it was, by the looks of it).

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(There remains a sparse warning in compat_ptrace_write_user(), where we
pass implicitly cast __user onto a pointer, under set_fs(KERNEL_DS).
I'm not sure what the most correct fix is there.)

Cheers
---Dave

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/kernel/ptrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index c142459a8..c77f425c7 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -908,7 +908,7 @@ static int compat_vfp_get(struct task_struct *target,
>  	if (count && !ret) {
>  		fpscr = (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
>  			(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
> -		ret = put_user(fpscr, (compat_ulong_t *)ubuf);
> +		ret = put_user(fpscr, (compat_ulong_t __user *)ubuf);
>  	}
>  
>  	return ret;
> @@ -932,7 +932,7 @@ static int compat_vfp_set(struct task_struct *target,
>  				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
>  
>  	if (count && !ret) {
> -		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
> +		ret = get_user(fpscr, (compat_ulong_t __user *)ubuf);
>  		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
>  		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
>  	}
> -- 
> 2.13.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
