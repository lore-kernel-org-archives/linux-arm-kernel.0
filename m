From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 May 2015 14:04:49 +0100
Subject: [PATCH 1/6] ARM: kvm: psci: fix handling of unimplemented
 functions
In-Reply-To: <1432901799-18359-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1432901799-18359-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1432901799-18359-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <556863F1.10902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/05/15 13:16, Lorenzo Pieralisi wrote:
> According to the PSCI specification and the SMC/HVC calling
> convention, PSCI function_ids that are not implemented must
> return NOT_SUPPORTED as return value.
>
> Current KVM implementation takes an unhandled PSCI function_id
> as an error and injects an undefined instruction into the guest
> if PSCI implementation is called with a function_id that is not
> handled by the resident PSCI version (ie it is not implemented),
> which is not the behaviour expected by a guest when calling a
> PSCI function_id that is not implemented.
>
> This patch fixes this issue by returning NOT_SUPPORTED whenever
> the kvm PSCI call is executed for a function_id that is not
> implemented by the PSCI kvm layer.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Anup Patel <anup.patel@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kvm/psci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 7e9398c..ec5943b 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -273,7 +273,8 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>   		ret = 0;
>   		break;
>   	default:
> -		return -EINVAL;
> +		val = PSCI_RET_NOT_SUPPORTED;
> +		break;

IMO we can remove all the other optional non-implemented PSCI functions
(e.g. KVM_PSCI_FN_MIGRATE, KVM_PSCI_FN_CPU_SUSPEND, ..etc) returning
PSCI_RET_NOT_SUPPORTED here as they will be then automatically covered
by default case.

Otherwise looks good to me:
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
