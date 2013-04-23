From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 16:00:39 -0700
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423230039.GI20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:26PM +0100, Marc Zyngier wrote:
> Allow access to the 32bit register file through the usual API.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  17 +++-
>  arch/arm64/kvm/Makefile              |   2 +-
>  arch/arm64/kvm/regmap.c              | 168 +++++++++++++++++++++++++++++++++++
>  3 files changed, 184 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/kvm/regmap.c
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 2dcfa74..37a6567 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -28,6 +28,9 @@
>  #include <asm/kvm_mmio.h>
>  #include <asm/ptrace.h>
>  
> +unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num);
> +unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu);
> +
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>  void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>  void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
> @@ -49,7 +52,7 @@ static inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
>  
>  static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
>  {
> -	return false;	/* 32bit? Bahhh... */
> +	return !!(*vcpu_cpsr(vcpu) & PSR_MODE32_BIT);

nit: you don't need the '!!': it's a bool

>  }
>  
>  static inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
> @@ -64,28 +67,38 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
>  
>  static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
>  {
> +	*vcpu_cpsr(vcpu) |= COMPAT_PSR_T_BIT;
>  }
>  
>  static inline unsigned long *vcpu_reg(const struct kvm_vcpu *vcpu, u8 reg_num)
>  {
> +	if (vcpu_mode_is_32bit(vcpu))
> +		return vcpu_reg32(vcpu, reg_num);
> +
>  	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.regs[reg_num];
>  }
>  
>  /* Get vcpu SPSR for current mode */
>  static inline unsigned long *vcpu_spsr(const struct kvm_vcpu *vcpu)
>  {
> +	if (vcpu_mode_is_32bit(vcpu))
> +		return vcpu_spsr32(vcpu);
> +
>  	return (unsigned long *)&vcpu_gp_regs(vcpu)->spsr[KVM_SPSR_EL1];
>  }
>  
>  static inline bool kvm_vcpu_reg_is_pc(const struct kvm_vcpu *vcpu, int reg)
>  {
> -	return false;
> +	return (vcpu_mode_is_32bit(vcpu)) && reg == 15;
>  }
>  
>  static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
>  {
>  	u32 mode = *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
>  
> +	if (vcpu_mode_is_32bit(vcpu))
> +		return mode > COMPAT_PSR_MODE_USR;
> +
>  	return mode != PSR_MODE_EL0t;
>  }
>  
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index be9eb3833..1668448 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../arch/arm/kvm/, arm.o mmu.o mmio.o psci.o perf.o)
>  
> -kvm-$(CONFIG_KVM_ARM_HOST) += inject_fault.o
> +kvm-$(CONFIG_KVM_ARM_HOST) += inject_fault.o regmap.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
>  
> diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
> new file mode 100644
> index 0000000..bbc6ae3
> --- /dev/null
> +++ b/arch/arm64/kvm/regmap.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright (C) 2012,2013 - ARM Ltd
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * Derived from arch/arm/kvm/emulate.c:
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/ptrace.h>
> +
> +#define VCPU_NR_MODES 6
> +#define REG_OFFSET(_reg) \
> +	(offsetof(struct user_pt_regs, _reg) / sizeof(unsigned long))
> +
> +#define USR_REG_OFFSET(R) REG_OFFSET(compat_usr(R))
> +
> +static const unsigned long vcpu_reg_offsets[VCPU_NR_MODES][16] = {
> +	/* USR Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +		USR_REG_OFFSET(12), USR_REG_OFFSET(13),	USR_REG_OFFSET(14),
> +		REG_OFFSET(pc)
> +	},
> +
> +	/* FIQ Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7),
> +		REG_OFFSET(compat_r8_fiq),  /* r8 */
> +		REG_OFFSET(compat_r9_fiq),  /* r9 */
> +		REG_OFFSET(compat_r10_fiq), /* r10 */
> +		REG_OFFSET(compat_r11_fiq), /* r11 */
> +		REG_OFFSET(compat_r12_fiq), /* r12 */
> +		REG_OFFSET(compat_sp_fiq),  /* r13 */
> +		REG_OFFSET(compat_lr_fiq),  /* r14 */
> +		REG_OFFSET(pc)
> +	},
> +
> +	/* IRQ Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +		USR_REG_OFFSET(12),
> +		REG_OFFSET(compat_sp_irq), /* r13 */
> +		REG_OFFSET(compat_lr_irq), /* r14 */
> +		REG_OFFSET(pc)
> +	},
> +
> +	/* SVC Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +		USR_REG_OFFSET(12),
> +		REG_OFFSET(compat_sp_svc), /* r13 */
> +		REG_OFFSET(compat_lr_svc), /* r14 */
> +		REG_OFFSET(pc)
> +	},
> +
> +	/* ABT Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +		USR_REG_OFFSET(12),
> +		REG_OFFSET(compat_sp_abt), /* r13 */
> +		REG_OFFSET(compat_lr_abt), /* r14 */
> +		REG_OFFSET(pc)
> +	},
> +
> +	/* UND Registers */
> +	{
> +		USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +		USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +		USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +		USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +		USR_REG_OFFSET(12),
> +		REG_OFFSET(compat_sp_und), /* r13 */
> +		REG_OFFSET(compat_lr_und), /* r14 */
> +		REG_OFFSET(pc)
> +	},
> +};
> +
> +/*
> + * Return a pointer to the register number valid in the current mode of
> + * the virtual CPU.
> + */
> +unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num)
> +{
> +	unsigned long *reg_array = (unsigned long *)&vcpu->arch.ctxt.gp_regs.regs;
> +	unsigned long mode = *vcpu_cpsr(vcpu) & COMPAT_PSR_MODE_MASK;
> +
> +	switch (mode) {
> +	case COMPAT_PSR_MODE_USR ... COMPAT_PSR_MODE_SVC:
> +		mode &= ~PSR_MODE32_BIT; /* 0 ... 3 */
> +		break;
> +
> +	case COMPAT_PSR_MODE_ABT:
> +		mode = 4;
> +		break;
> +
> +	case COMPAT_PSR_MODE_UND:
> +		mode = 5;
> +		break;
> +
> +	case COMPAT_PSR_MODE_SYS:
> +		mode = 0;	/* SYS maps to USR */
> +		break;
> +
> +	default:
> +		BUG();
> +	}
> +
> +	return reg_array + vcpu_reg_offsets[mode][reg_num];
> +}
> +
> +/*
> + * Return the SPSR for the current mode of the virtual CPU.
> + */
> +unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu)
> +{
> +	unsigned long mode = *vcpu_cpsr(vcpu) & COMPAT_PSR_MODE_MASK;
> +	switch (mode) {
> +	case COMPAT_PSR_MODE_SVC:
> +		mode = KVM_SPSR_SVC;
> +		break;
> +	case COMPAT_PSR_MODE_ABT:
> +		mode = KVM_SPSR_ABT;
> +		break;
> +	case COMPAT_PSR_MODE_UND:
> +		mode = KVM_SPSR_UND;
> +		break;
> +	case COMPAT_PSR_MODE_IRQ:
> +		mode = KVM_SPSR_IRQ;
> +		break;
> +	case COMPAT_PSR_MODE_FIQ:
> +		mode = KVM_SPSR_FIQ;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return (unsigned long *)&vcpu_gp_regs(vcpu)->spsr[mode];
> +}
> -- 
> 1.8.1.4
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
