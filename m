From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 26 May 2014 19:52:25 +0200
Subject: [PATCH v3 14/14] ARM64: KVM: fix big endian issue in
 access_vm_reg for 32bit guest
In-Reply-To: <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140526175225.GF31431@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:14:06AM -0700, Victor Kamensky wrote:
> Fix isssue with 32bit guests running on top of BE KVM host. Guest
> state is retored with double word read operations. Within the high

restored (spell check should catch this).

"Guest state is restored with double word read operations."  I don't
know what this sentence is supposed to tell me.

> and low word data is already byteswap. This code effectively swaps

"data is already byteswap" is not English.  data is already byteswapped?

> two words within 64bit value.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 060c3a9..4438b47 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -51,6 +51,16 @@ static u32 cache_levels;
>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>  #define CSSELR_MAX 12
>  
> +/* Word access indexes for 64bit vm accessor */
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define CP15_REG_MSW_INDEX 0
> +#define CP15_REG_LSW_INDEX 1
> +#else
> +#define CP15_REG_MSW_INDEX 1
> +#define CP15_REG_LSW_INDEX 0
> +#endif
> +
> +
>  /* Which cache CCSIDR represents depends on CSSELR value. */
>  static u32 get_ccsidr(u32 csselr)
>  {
> @@ -137,9 +147,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
>  	if (!p->is_aarch32) {
>  		vcpu_sys_reg(vcpu, r->reg) = val;
>  	} else {
> -		vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
> +		vcpu_cp15(vcpu, r->reg + CP15_REG_LSW_INDEX) = val & 0xffffffffUL;
>  		if (!p->is_32bit)
> -			vcpu_cp15(vcpu, r->reg + 1) = val >> 32;
> +			vcpu_cp15(vcpu, r->reg + CP15_REG_MSW_INDEX) = val >> 32;
>  	}
>  	return true;
>  }
> -- 
> 1.8.1.4
> 
I really don't like this. If anything I feel like it should be
abstracted inside vcpu_cp15, but wouldn't it be cleaner to do something
along the lines of:

u64 *regstore = (u64 *)vcpu->arch.ctxt.cp15[r->reg];
if (p->is_32bit)
	val &= 0xffffffffUL;
*regstore = val;

But I think the thing that bothers me in general with all these patches
is that they deal specially with a lot of situations where the data
structure was designed specifically to make the code easy to read, and
now it just becomes a really complicated mess.  Have you carefully
considered other options, redesigning the data structure layout etc.?

-Christoffer
