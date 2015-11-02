From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 02 Nov 2015 15:54:12 -0500
Subject: [PATCH v4 08/21] KVM: ARM64: Add reset and access
 handlers for PMXEVTYPER register
In-Reply-To: <1446186123-11548-9-git-send-email-zhaoshenglong@huawei.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>
 <1446186123-11548-9-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <5637CD74.2010609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 10/30/2015 02:21 AM, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMXEVTYPER is UNKNOWN, use reset_unknown or
> reset_unknown_cp15 for its reset handler. Add access handler which
> emulates writing and reading PMXEVTYPER register. When writing to
> PMXEVTYPER, call kvm_pmu_set_counter_event_type to create a perf_event
> for the selected event type.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index cb82b15..4e606ea 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -491,6 +491,17 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
>  
>  	if (p->is_write) {
>  		switch (r->reg) {
> +		case PMXEVTYPER_EL0: {
> +			val = vcpu_sys_reg(vcpu, PMSELR_EL0);
> +			kvm_pmu_set_counter_event_type(vcpu,
> +						       *vcpu_reg(vcpu, p->Rt),
> +						       val);
> +			vcpu_sys_reg(vcpu, PMXEVTYPER_EL0) =
> +							 *vcpu_reg(vcpu, p->Rt);

Why does PMXEVTYPER get set directly? It seems like it could have an accessor
that redirected to PMEVTYPER<n>.

> +			vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + val) =
> +							 *vcpu_reg(vcpu, p->Rt);

I tried to look around briefly but couldn't find counter number range checking
in the PMSELR handler or here. Should there be some here and in PMXEVCNTR?

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
