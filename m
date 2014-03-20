From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 18:11:19 -0700
Subject: [PATCH v2 4/7] ARM: KVM: __kvm_vcpu_run function return result
 fix in BE case
In-Reply-To: <1392183693-21238-5-git-send-email-victor.kamensky@linaro.org>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-5-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320011119.GJ1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:41:30PM -0800, Victor Kamensky wrote:
> The __kvm_vcpu_run function returns a 64-bit result in two registers,
> which has to be adjusted for BE case.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kvm/interrupts.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index f0696bd..5d27f7f 100644
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
>  	bx	lr			@ return to IOCTL
>  
>  /********************************************************************
> -- 
> 1.8.1.4
> 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
