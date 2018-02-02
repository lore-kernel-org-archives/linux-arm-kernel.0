From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Feb 2018 18:01:57 +0000
Subject: [PATCH 2/2] arm64: entry: Apply BP hardening for suspicious
 interrupts from EL0
In-Reply-To: <1517592700-26497-3-git-send-email-will.deacon@arm.com>
References: <1517592700-26497-1-git-send-email-will.deacon@arm.com>
 <1517592700-26497-3-git-send-email-will.deacon@arm.com>
Message-ID: <6a3df8ca-dca1-c1e6-ae1d-1fe25fd0c9f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/18 17:31, Will Deacon wrote:
> It is possible to take an IRQ from EL0 following a branch to a kernel
> address in such a way that the IRQ is prioritised over the instruction
> abort. Whilst an attacker would need to get the starts to align here,

Nit: I'm guessing that should probably be "stars", but given the context 
of a theoretical race between a BP training sequence and an 
IRQ-generating sequence, there's a little doubt left ;)

Robin.

> it might be sufficient with enough calibration so perform BP hardening
> in the rare case that we see a kernel address in the ELR when handling
> an IRQ from EL0.
> 
> Reported-by: Dan Hettena <dhettena@nvidia.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/kernel/entry.S | 5 +++++
>   arch/arm64/mm/fault.c     | 6 ++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 394b149825b6..9bba6990e9b5 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -827,6 +827,11 @@ el0_irq_naked:
>   #endif
>   
>   	ct_user_exit
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	tbz	x22, #55, 1f
> +	bl	do_el0_irq_bp_hardening
> +1:
> +#endif
>   	irq_handler
>   
>   #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 445aa4475c67..3d2bcbfdb90b 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -708,6 +708,12 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
>   	arm64_notify_die("", regs, &info, esr);
>   }
>   
> +asmlinkage void __exception do_el0_irq_bp_hardening(void)
> +{
> +	/* PC has already been checked in entry.S */
> +	arm64_apply_bp_hardening();
> +}
> +
>   asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
>   						   unsigned int esr,
>   						   struct pt_regs *regs)
> 
