From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 17:09:07 +0100
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130502160906.GI20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:26PM +0100, Marc Zyngier wrote:
>  static inline bool kvm_vcpu_reg_is_pc(const struct kvm_vcpu *vcpu, int reg)
>  {
> -	return false;
> +	return (vcpu_mode_is_32bit(vcpu)) && reg == 15;
>  }

On AArch64, would ESR_EL2 have SRT == 15 when the source/destination
register is PC? The mapping between AArch32 and AArch64 registers
suggests R13_hyp. Maybe 15 is correct but it's not clear to me from the
spec.

BTW, on arch/arm it looks like this is used when you get a data abort
with PC as the destination register and you inject a prefetch abort in
this case. Why isn't this a normal data abort? Once you get the
information, you load it into PC but first you need to sort out the data
abort (unless I don't understand how the kvm_inject_pabt works).

-- 
Catalin
