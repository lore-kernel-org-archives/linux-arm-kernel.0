From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Mar 2018 08:38:04 +0000
Subject: [PATCH 3/7] Disable instrumentation for some code
In-Reply-To: <20180318125342.4278-4-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
 <20180318125342.4278-4-liuwenliang@huawei.com>
Message-ID: <5ec51db8-196e-fd3d-8cce-2bdaccc52424@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/18 12:53, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Disable instrumentation for arch/arm/boot/compressed/*
> and arch/arm/vdso/* because those code won't linkd with
> kernel image.
> 
> Disable kasan check in the function unwind_pop_register
> because it doesn't matter that kasan checks failed when
> unwind_pop_register read stack memory of task.
> 
> Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> ---
>  arch/arm/boot/compressed/Makefile | 1 +
>  arch/arm/kernel/unwind.c          | 3 ++-
>  arch/arm/vdso/Makefile            | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..966103e 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
>  endif
>  
>  GCOV_PROFILE		:= n
> +KASAN_SANITIZE		:= n
>  
>  #
>  # Architecture dependencies
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 0bee233..2e55c7d 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -249,7 +249,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
>  		if (*vsp >= (unsigned long *)ctrl->sp_high)
>  			return -URC_FAILURE;
>  
> -	ctrl->vrs[reg] = *(*vsp)++;
> +	ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
> +	(*vsp)++;
>  	return URC_OK;
>  }
>  
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index bb411821..87abbb7 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -30,6 +30,8 @@ CFLAGS_vgettimeofday.o = -O2
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>  
> +KASAN_SANITIZE := n
> +
>  # Force dependency
>  $(obj)/vdso.o : $(obj)/vdso.so
>  
> 

You need to extend this at least to arch/arm/kvm/hyp/Makefile, as the
KASAN shadow region won't be mapped in HYP. See commit a6cdf1c08cbfe for
more details (all the arm64 comments in this patch apply to 32bit as well).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
