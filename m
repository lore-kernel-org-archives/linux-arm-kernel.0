From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 17:05:07 +0200
Subject: [PATCH v4 14/14] ARM64: KVM: fix big endian issue in
 access_vm_reg for 32bit guest
In-Reply-To: <1402590613-3341-15-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
 <1402590613-3341-15-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140614150507.GI14023@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 09:30:13AM -0700, Victor Kamensky wrote:
> Fix issue with 32bit guests running on top of BE KVM host.
> Indexes of high and low words of 64bit cp15 register are
> swapped in case of big endian code, since 64bit cp15 state is
> restored or saved with double word write or read instruction.
> 
> Define helper macros to access high low words of 64bit cp15
> register.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_host.h | 8 ++++++++
>  arch/arm64/kvm/sys_regs.c         | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0a1d697..e9d2e11 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -140,6 +140,14 @@ struct kvm_vcpu_arch {
>  #define vcpu_sys_reg(v,r)	((v)->arch.ctxt.sys_regs[(r)])
>  #define vcpu_cp15(v,r)		((v)->arch.ctxt.cp15[(r)])
>  
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define vcpu_cp15_64_high(v,r) ((v)->arch.ctxt.cp15[((r) + 0)])
> +#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.cp15[((r) + 1)])
> +#else
> +#define vcpu_cp15_64_high(v,r) ((v)->arch.ctxt.cp15[((r) + 1)])
> +#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.cp15[((r) + 0)])
> +#endif
> +
>  struct kvm_vm_stat {
>  	u32 remote_tlb_flush;
>  };
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 8e65e31..71aa9b0 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -137,9 +137,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
>  	if (!p->is_aarch32) {
>  		vcpu_sys_reg(vcpu, r->reg) = val;
>  	} else {
> -		vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
> +		vcpu_cp15_64_low(vcpu, r->reg) = val & 0xffffffffUL;
>  		if (!p->is_32bit)
> -			vcpu_cp15(vcpu, r->reg + 1) = val >> 32;
> +			vcpu_cp15_64_high(vcpu, r->reg) = val >> 32;
>  	}
>  	return true;
>  }
> -- 
> 1.8.1.4
> 

I thought there was a consensus here about handling 64-bit accesses
through the 64-bit values with the vcpu_sys_reg() interface?  Did you
give up on this for a particular reason?

-Christoffer
