From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Dec 2015 13:28:09 +0000
Subject: [PATCH v5 04/21] KVM: ARM64: Add reset and access handlers for
 PMCR_EL0 register
In-Reply-To: <1449123091-20252-5-git-send-email-zhaoshenglong@huawei.com>
References: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
 <1449123091-20252-5-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <56658969.5040506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/15 06:11, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add reset handler which gets host value of PMCR_EL0 and make writable
> bits architecturally UNKNOWN except PMCR.E to zero. Add a common access
> handler for PMU registers which emulates writing and reading register
> and add emulation for PMCR.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 87a64e8..e020fe0 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -33,6 +33,7 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_host.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/pmu.h>
>  
>  #include <trace/events/kvm.h>
>  
> @@ -446,6 +447,58 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
>  }
>  
> +static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	u64 pmcr, val;
> +
> +	asm volatile("mrs %0, pmcr_el0\n" : "=r" (pmcr));
> +	/* Writable bits of PMCR_EL0 (ARMV8_PMCR_MASK) is reset to UNKNOWN
> +	 * except PMCR.E resetting to zero.
> +	 */
> +	val = ((pmcr & ~ARMV8_PMCR_MASK) | (ARMV8_PMCR_MASK & 0xdecafbad))
> +	      & (~ARMV8_PMCR_E);
> +	vcpu_sys_reg(vcpu, r->reg) = val;
> +}
> +
> +/* PMU registers accessor. */
> +static bool access_pmu_regs(struct kvm_vcpu *vcpu,
> +			    const struct sys_reg_params *p,

You may have noticed that this now generates a warning on 4.4-rc4, as
you cannot have a const struct sys_reg_params anymore (we've changed a
number of things there to solve another bug).

> +			    const struct sys_reg_desc *r)
> +{
> +	u64 val;
> +
> +	if (p->is_write) {
> +		switch (r->reg) {
> +		case PMCR_EL0: {
> +			/* Only update writeable bits of PMCR */
> +			val = vcpu_sys_reg(vcpu, r->reg);
> +			val &= ~ARMV8_PMCR_MASK;
> +			val |= *vcpu_reg(vcpu, p->Rt) & ARMV8_PMCR_MASK;

vcpu_reg and ->Rt are now gone. To ease the transition, I've pushed a
patch on top of this series to my kvm-arm64/pmu-v5 branch. Feel free to
use it as a reference.

	M.
-- 
Jazz is not dead. It just smells funny...
