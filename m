From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 1 Aug 2017 15:25:07 +0200
Subject: [PATCH v2 15/16] KVM: arm64: Save ESR_EL2 on guest SError
In-Reply-To: <20170728141019.9084-16-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
 <20170728141019.9084-16-james.morse@arm.com>
Message-ID: <CAMJs5B88=tWvJm=ub8tdVJTkxzm0vXGVY4_3CnxcP4F2Gv-AkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 03:10:18PM +0100, James Morse wrote:
> When we exit a guest due to an SError the vcpu fault info isn't updated
> with the ESR. Today this is only done for traps.
>
> The v8.2 RAS Extensions define ISS values for SError. Update the vcpu's
> fault_info with the ESR on SError so that handle_exit() can determine
> if this was a RAS SError and decode its severity.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm64/kvm/hyp/switch.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 945e79c641c4..c6f17c7675ad 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -226,13 +226,20 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
>   return true;
>  }
>
> +static void __hyp_text __populate_fault_info_esr(struct kvm_vcpu *vcpu)
> +{
> + vcpu->arch.fault.esr_el2 = read_sysreg_el2(esr);
> +}
> +
>  static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>  {
> - u64 esr = read_sysreg_el2(esr);
> - u8 ec = ESR_ELx_EC(esr);
> + u8 ec;
> + u64 esr;
>   u64 hpfar, far;
>
> - vcpu->arch.fault.esr_el2 = esr;
> + __populate_fault_info_esr(vcpu);
> + esr = vcpu->arch.fault.esr_el2;
> + ec = ESR_ELx_EC(esr);
>
>   if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
>   return true;
> @@ -321,6 +328,8 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>   */
>   if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
>   goto again;
> + else if (ARM_EXCEPTION_CODE(exit_code) == ARM_EXCEPTION_EL1_SERROR)
> + __populate_fault_info_esr(vcpu);
>
>   if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
>      exit_code == ARM_EXCEPTION_TRAP) {
> --
> 2.13.2
>
