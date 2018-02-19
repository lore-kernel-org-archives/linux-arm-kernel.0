From: julien.grall@arm.com (Julien Grall)
Date: Mon, 19 Feb 2018 18:12:29 +0000
Subject: [PATCH v4 24/40] KVM: arm64: Rewrite system register accessors to
 read/write functions
In-Reply-To: <20180215210332.8648-25-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-25-christoffer.dall@linaro.org>
Message-ID: <f1b3498d-754e-f8cf-0dd8-1c43a7b507e9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 15/02/18 21:03, Christoffer Dall wrote:
> From: Christoffer Dall <cdall@cs.columbia.edu>
> 
> Currently we access the system registers array via the vcpu_sys_reg()
> macro.  However, we are about to change the behavior to some times
> modify the register file directly, so let's change this to two
> primitives:
> 
>   * Accessor macros vcpu_write_sys_reg() and vcpu_read_sys_reg()
>   * Direct array access macro __vcpu_sys_reg()
> 
> The first primitive should be used in places where the code needs to
> access the currently loaded VCPU's state as observed by the guest.  For
> example, when trapping on cache related registers, a write to a system
> register should go directly to the VCPU version of the register.
> 
> The second primitive can be used in places where the VCPU is known to

"second primitive" is a bit confusing here. I count 3 primitives above: 
(vcpu_write_sys_reg(), vcpu_read_sys_reg() and __vcpu_sys_reg(). From 
the description, I would say to refer to the latter (i.e third one).

> never be running (for example userspace access) or for registers which
> are never context switched (for example all the PMU system registers).
> 
> This rewrites all users of vcpu_sys_regs to one of the two primitives
> above.
> 
> No functional change.
> 
> Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>

[...]

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index f2a6f39aec87..68398bf7882f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -287,7 +287,18 @@ struct kvm_vcpu_arch {
>   };
>   
>   #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
> -#define vcpu_sys_reg(v,r)	((v)->arch.ctxt.sys_regs[(r)])
> +
> +/*
> + * Only use __vcpu_sys_reg if you know you want the memory backed version of a
> + * register, and not the one most recently accessed by a runnning VCPU.  For

NIT: s/runnning/running/

> + * example, for userpace access or for system registers that are never context

NIT: s/userpace/userspace/

> + * switched, but only emulated.
> + */
> +#define __vcpu_sys_reg(v,r)	((v)->arch.ctxt.sys_regs[(r)])
> +
> +#define vcpu_read_sys_reg(v,r)	__vcpu_sys_reg(v,r)
> +#define vcpu_write_sys_reg(v,r,n)	do { __vcpu_sys_reg(v,r) = n; } while (0)
> +
>   /*
>    * CP14 and CP15 live in the same array, as they are backed by the
>    * same system registers.

[...]

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index b48af790615e..a05d2c01c786 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c

[...]

> @@ -817,10 +818,10 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>   			return false;
>   		}
>   
> -		vcpu_sys_reg(vcpu, PMUSERENR_EL0) = p->regval
> -						    & ARMV8_PMU_USERENR_MASK;
> -	} else {
> -		p->regval = vcpu_sys_reg(vcpu, PMUSERENR_EL0)
> +		__vcpu_sys_reg(vcpu, PMUSERENR_EL0) =
> +			       p->regval & ARMV8_PMU_USERENR_MASK;
> +	} else  {

NIT: There is a double space between else and {.

> +		p->regval = __vcpu_sys_reg(vcpu, PMUSERENR_EL0)
>   			    & ARMV8_PMU_USERENR_MASK;
>   	}
>   

Cheers,

-- 
Julien Grall
