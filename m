From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 17 Oct 2018 20:02:43 +0100
Subject: [PATCH] KVM: arm64: Safety check PSTATE when entering guest and
 handle IL
In-Reply-To: <20181017182116.22603-1-christoffer.dall@arm.com>
References: <20181017182116.22603-1-christoffer.dall@arm.com>
Message-ID: <CAFEAcA-b8O4tjViHGfQpJt6C=i4A2tV7vcOFPiE+i4QMFKFZKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2018 at 19:21, Christoffer Dall <christoffer.dall@arm.com> wrote:
> This commit adds a paranoid check when entering the guest to make sure
> we don't attempt running guest code in an equally or more privilged mode
> than the hypervisor.  We also catch other accidental programming of the
> SPSR_EL2 which results in an illegal exception return and report this
> safely back to the user.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---

> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 9ce223944983..d7ac15412c97 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -152,8 +152,25 @@ static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  static void __hyp_text
>  __sysreg_restore_el2_return_state(struct kvm_cpu_context *ctxt)
>  {
> +       u64 pstate = ctxt->gp_regs.regs.pstate;
> +       u64 mode = pstate & PSR_AA32_MODE_MASK;
> +
> +       /*
> +        * Safety check to ensure we're setting the CPU up to enter the guest
> +        * in a less privileged mode.
> +        *
> +        * If we are attempting a return to EL2 or higher in AArch64 state,
> +        * program SPSR_EL2 with M=EL2h and the IL bit set which ensures that
> +        * we'll take an illegal exception return exception immediately after

This should read "illegal exception state exception", I think
(for the 64-bit case we don't do an illegal exception return,
we do a legal exception return that sets PSTATE.IL to 1.)

> +        * the ERET to the guest.  Attempts to return to AArch32 Hyp will
> +        * result in an illegal exception return because EL2's execution state
> +        * is determined by SCR_EL3.RW.
> +        */
> +       if (!(mode & PSR_MODE32_BIT) && mode >= PSR_MODE_EL2t)
> +               pstate = PSR_MODE_EL2h | PSR_IL_BIT;

thanks
-- PMM
