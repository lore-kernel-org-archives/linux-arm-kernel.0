From: james.morse@arm.com (James Morse)
Date: Mon, 12 Mar 2018 18:27:00 +0000
Subject: [PATCH v5 19/23] arm64: KVM: Allow far branches from vector slots
 to the main vectors
In-Reply-To: <20180301155538.26860-20-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-20-marc.zyngier@arm.com>
Message-ID: <5AA6C674.90607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 01/03/18 15:55, Marc Zyngier wrote:
> So far, the branch from the vector slots to the main vectors can at
> most be 4GB from the main vectors (the reach of ADRP), and this
> distance is known at compile time. If we were to remap the slots
> to an unrelated VA, things would break badly.
> 
> A way to achieve VA independence would be to load the absolute
> address of the vectors (__kvm_hyp_vector), either using a constant
> pool or a series of movs, followed by an indirect branch.
> 
> This patches implements the latter solution, using another instance
> of a patching callback.

> diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
> index e000cb390618..e8d997788ad0 100644
> --- a/arch/arm64/kernel/bpi.S
> +++ b/arch/arm64/kernel/bpi.S
> @@ -19,6 +19,9 @@
>  #include <linux/linkage.h>
>  #include <linux/arm-smccc.h>
>  
> +#include <asm/alternative.h>
> +#include <asm/kvm_mmu.h>
> +
>  .macro hyp_ventry offset
>  	.align 7
>  	.rept 29
> @@ -64,9 +67,15 @@ ENTRY(__bp_harden_hyp_vecs_start)
>  	.endr
>  
>  __kvm_enter_vectors:
> +alternative_cb	kvm_patch_vector_branch
> +	movz	x1, #0
> +	movk	x1, #0, lsl #16
> +	movk	x1, #0, lsl #32
> +	movk	x1, #0, lsl #48
> +alternative_cb_end
>  
> -	adr_l	x1, __kvm_hyp_vector
>  	add	x0, x1, x0
> +	kern_hyp_va x0

Can't you patch the kern_hyp_va address into the movk block directly?
Obviously you can't call kern_hyp_va, but you could generate the layout and have
some slow __kern_hyp_va() to generate the value. This would avoid generating a
value, to then throw half of it away and patch something else in.

Does this code run for VHE systems too? (it not, is the x<<48 movk needed?)


Thanks,

James


>  	br	x0
>  ENTRY(__bp_harden_hyp_vecs_end)

>  
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index a73e47804972..7ef3d920c8d4 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -152,3 +152,30 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
>  		updptr[i] = cpu_to_le32(insn);
>  	}
>  }
> +
> +void kvm_patch_vector_branch(struct alt_instr *alt,
> +			     __le32 *origptr, __le32 *updptr, int nr_inst)
> +{
> +	enum aarch64_insn_movewide_type type;
> +	u64 addr;
> +	u32 oinsn, rd;
> +	int s;
> +
> +	BUG_ON(nr_inst != 4);
> +
> +	addr = (uintptr_t)kvm_ksym_ref(__kvm_hyp_vector);
> +	oinsn = le32_to_cpu(origptr[0]);
> +	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, oinsn);
> +
> +	type = AARCH64_INSN_MOVEWIDE_ZERO;
> +	for (s = 0; nr_inst--; s += 16) {
> +		u32 insn = aarch64_insn_gen_movewide(rd,
> +						     (u16)(addr >> s),
> +						     s,
> +						     AARCH64_INSN_VARIANT_64BIT,
> +						     type);
> +		*updptr++ = cpu_to_le32(insn);
> +		type = AARCH64_INSN_MOVEWIDE_KEEP;
> +	}
> +
> +}
> 
