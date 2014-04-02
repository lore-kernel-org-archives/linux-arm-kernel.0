From: robherring2@gmail.com (Rob Herring)
Date: Wed, 2 Apr 2014 08:12:12 -0500
Subject: [PATCH v7 10/12] ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI
 v0.2
In-Reply-To: <1396435347-20056-11-git-send-email-anup.patel@linaro.org>
References: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
 <1396435347-20056-11-git-send-email-anup.patel@linaro.org>
Message-ID: <CAL_JsqJ6sJ6n4UVSx6x5C73_6yD1EHdvmp+36Vs5jrMB57v7_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 5:42 AM, Anup Patel <anup.patel@linaro.org> wrote:
> As-per PSCI v0.2, the source CPU provides physical address of
> "entry point" and "context id" for starting a target CPU. Also,
> if target CPU is already running then we should return ALREADY_ON.
>
> Current emulation of CPU_ON function does not consider physical
> address of "context id" and returns INVALID_PARAMETERS if target
> CPU is already running.
>
> This patch updates kvm_psci_vcpu_on() such that it works for both
> PSCI v0.1 and PSCI v0.2.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index d8335da..fdbd829 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c


> @@ -101,6 +109,8 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>                 kvm_vcpu_set_be(vcpu);
>
>         *vcpu_pc(vcpu) = target_pc;
> +       if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
> +               *vcpu_reg(vcpu, 0) = context_id;

This could be done unconditionally. The register value is undefined
for 0.1, so whatever was in r3/x3 meets that requirement.

Rob
