From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 May 2014 16:02:48 +0100
Subject: [PATCH v3 04/14] ARM: KVM: __kvm_vcpu_run function return result
 fix in BE case
In-Reply-To: <1399997646-4716-5-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-5-git-send-email-victor.kamensky@linaro.org>
Message-ID: <5384A918.2000508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/14 17:13, Victor Kamensky wrote:
> The __kvm_vcpu_run function returns a 64-bit result in two registers,
> which has to be adjusted for BE case.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/interrupts.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 24d4e65..7dfe9e4 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -199,8 +199,13 @@ after_vfp_restore:
>  
>  	restore_host_regs
>  	clrex				@ Clear exclusive monitor
> +#ifndef __ARMEB__
>  	mov	r0, r1			@ Return the return code
>  	mov	r1, #0			@ Clear upper bits in return value
> +#else
> +	@ r1 already has return code
> +	mov	r0, #0			@ Clear upper bits in return value
> +#endif /* __ARMEB__ */

Why using __ARMEB__ while the rest of the series is using
CONFIG_CPU_ENDIAN_BE8?

>  	bx	lr			@ return to IOCTL
>  
>  /********************************************************************
> 

Aside from the above nit:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
