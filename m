From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 27 Mar 2017 18:03:39 +0100
Subject: [PATCH v2 1/9] arm64: KVM: PMU: Refactor pmu_*_el0_disabled
In-Reply-To: <20170327160345.12402-2-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-2-marc.zyngier@arm.com>
Message-ID: <e1ad349e-a14c-328a-83ea-4f939c49beb5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/17 17:03, Marc Zyngier wrote:
> There is a lot of duplication in the pmu_*_el0_disabled helpers,
> and as we're going to modify them shortly, let's move all the
> common stuff in a single function.
>
> No functionnal change.

nit: s/functionnal/functional

>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0e26f8c2b56f..7e1d673304d5 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -460,35 +460,32 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  	vcpu_sys_reg(vcpu, PMCR_EL0) = val;
>  }
>
> -static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
> +static bool check_disabled(struct kvm_vcpu *vcpu, u64 flags)

minor nit: check_disabled sounds too generic for a helper which checks for
something specific to pmuserenr_el0 register in a file where we deal with
lot of system registers. check_pmu_access_disabled()  ?

Suzuki
