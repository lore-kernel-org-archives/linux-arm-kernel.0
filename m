From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Nov 2015 16:14:57 +0000
Subject: [PATCH] arm64: kvm: report original PAR_EL1 upon panic
In-Reply-To: <1447682309-5875-1-git-send-email-mark.rutland@arm.com>
References: <1447682309-5875-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151124161457.7d2f9148@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015 13:58:29 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> If we call __kvm_hyp_panic while a guest context is active, we call
> __restore_sysregs before acquiring the system register values for the
> panic, in the process throwing away the PAR_EL1 value at the point of
> the panic.
> 
> This patch modifies __kvm_hyp_panic to stash the PAR_EL1 value prior to
> restoring host register values, enabling us to report the original
> values at the point of the panic.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp.S | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 11183ce..2a8a4aa 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -864,6 +864,10 @@ ENTRY(__kvm_flush_vm_context)
>  ENDPROC(__kvm_flush_vm_context)
>  
>  __kvm_hyp_panic:
> +	// Stash PAR_EL1 before corrupting it in __restore_sysregs
> +	mrs	x0, par_el1
> +	push	x0, xzr
> +
>  	// Guess the context by looking at VTTBR:
>  	// If zero, then we're already a host.
>  	// Otherwise restore a minimal host context before panicing.
> @@ -898,7 +902,7 @@ __kvm_hyp_panic:
>  	mrs	x3, esr_el2
>  	mrs	x4, far_el2
>  	mrs	x5, hpfar_el2
> -	mrs	x6, par_el1
> +	pop	x6, xzr		// active context PAR_EL1
>  	mrs	x7, tpidr_el2
>  
>  	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
