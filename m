From: osp@andrep.de (Andre Przywara)
Date: Thu, 20 Feb 2014 23:35:43 +0100
Subject: [PATCH] arm/arm64: KVM: detect CPU reset on CPU_PM_EXIT
In-Reply-To: <1392910014-15495-1-git-send-email-marc.zyngier@arm.com>
References: <1392910014-15495-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140220233543.1836e2d5@slackpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Feb 2014 15:26:54 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> Commit 1fcf7ce0c602 (arm: kvm: implement CPU PM notifier) added
> support for CPU power-management, using a cpu_nofigier to re-init
> KVM on a CPU that entered CPU idle.
> 
> The code assumed that a CPU entering idle would actually be powered
> off, loosing its state entierely, and would then need to be
> reinitialized. It turns out that this is not always the case, and
> some HW performs CPU PM without actually killing the core. In this
> case, we try to reinitialize KVM while it still live. It ends up
> badly, as reported by Andre Przywara (using a Calxeda Midway):
> 
> [    3.663897] Kernel panic - not syncing: unexpected prefetch abort
> in Hyp mode at: 0x685760 [    3.663897] unexpected data abort in Hyp
> mode at: 0xc067d150 [    3.663897] unexpected HVC/SVC trap in Hyp
> mode at: 0xc0901dd0
> 
> The trick here is to detect if we've been through a full re-init or
> not by looking at HVBAR (VBAR_EL2 on arm64). This involves
> implementing the backend for __hyp_get_vectors in the main KVM HYP
> code (rather small), and checking the return value against the
> default one when the CPU notifier is called on CPU_PM_EXIT.
> 
> Reported-by: Andre Przywara <osp@andrep.de>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <rob.herring@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Andre Przywara <osp@andrep.de>

(there seems to be a typo in the second line of the commit message)

Marc,

thanks a lot for this quick and perfectly working patch! I still
believe it is actually the firmware that needs to be fixed, but this is
rather unlikely in this special case ...

Regards,
Andre.

> ---
>  arch/arm/kvm/arm.c        | 3 ++-
>  arch/arm/kvm/interrupts.S | 7 ++++++-
>  arch/arm64/kvm/hyp.S      | 9 +++++++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 1d8248e..bd18bb8 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -878,7 +878,8 @@ static int hyp_init_cpu_pm_notifier(struct
> notifier_block *self, unsigned long cmd,
>  				    void *v)
>  {
> -	if (cmd == CPU_PM_EXIT) {
> +	if (cmd == CPU_PM_EXIT &&
> +	    __hyp_get_vectors() == hyp_default_vectors) {
>  		cpu_init_hyp_mode(NULL);
>  		return NOTIFY_OK;
>  	}
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index ddc1553..9b0ff68 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -363,6 +363,11 @@ hyp_hvc:
>  host_switch_to_hyp:
>  	pop	{r0, r1, r2}
>  
> +	/* Check for __hyp_get_vectors */
> +	cmp	r0, #-1
> +	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
> +	beq	1f
> +
>  	push	{lr}
>  	mrs	lr, SPSR
>  	push	{lr}
> @@ -378,7 +383,7 @@ THUMB(	orr	lr, #1)
>  	pop	{lr}
>  	msr	SPSR_csxf, lr
>  	pop	{lr}
> -	eret
> +1:	eret
>  
>  guest_trap:
>  	load_vcpu			@ Load VCPU pointer to r0
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 3b47c36..f1cbabe 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -737,7 +737,12 @@
> el1_sync:					// Guest trapped
> into EL2 pop	x2, x3 pop	x0, x1
>  
> -	push	lr, xzr
> +	/* Check for __hyp_get_vectors */
> +	cbnz	x0, 1f
> +	mrs	x0, vbar_el2
> +	b	2f
> +
> +1:	push	lr, xzr
>  
>  	/*
>  	 * Compute the function address in EL2, and shuffle the
> parameters. @@ -750,7 +755,7 @@
> el1_sync:					// Guest trapped
> into EL2 blr	lr 
>  	pop	lr, xzr
> -	eret
> +2:	eret
>  
>  el1_trap:
>  	/*
