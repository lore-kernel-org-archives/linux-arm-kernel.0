From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 18:14:41 -0700
Subject: [PATCH v2 2/2] arm64: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1381253894-18114-3-git-send-email-marc.zyngier@arm.com>
References: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
 <1381253894-18114-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131016011441.GB24837@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:38:14PM +0100, Marc Zyngier wrote:
> On an (even slightly) oversubscribed system, spinlocks are quickly
> becoming a bottleneck, as some vcpus are spinning, waiting for a
> lock to be released, while the vcpu holding the lock may not be
> running at all.
> 
> The solution is to trap blocking WFEs and tell KVM that we're
> now spinning. This ensures that other vpus will get a scheduling
> boost, allowing the lock to be released more quickly. Also, using
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT slightly improves the performance
> when the VM is severely overcommited.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |  8 ++++++--
>  arch/arm64/kvm/Kconfig           |  1 +
>  arch/arm64/kvm/handle_exit.c     | 18 +++++++++++++-----
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index a5f28e2..c98ef47 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -63,6 +63,7 @@
>   * TAC:		Trap ACTLR
>   * TSC:		Trap SMC
>   * TSW:		Trap cache operations by set/way
> + * TWE:		Trap WFE
>   * TWI:		Trap WFI
>   * TIDCP:	Trap L2CTLR/L2ECTLR
>   * BSU_IS:	Upgrade barriers to the inner shareable domain
> @@ -72,8 +73,9 @@
>   * FMO:		Override CPSR.F and enable signaling with VF
>   * SWIO:	Turn set/way invalidates into set/way clean+invalidate
>   */
> -#define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
> -			 HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
> +#define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
> +			 HCR_BSU_IS | HCR_FB | HCR_TAC | \
> +			 HCR_AMO | HCR_IMO | HCR_FMO | \
>  			 HCR_SWIO | HCR_TIDCP | HCR_RW)
>  #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
>  
> @@ -242,4 +244,6 @@
>  
>  #define ESR_EL2_EC_xABT_xFSR_EXTABT	0x10
>  
> +#define ESR_EL2_EC_WFI_ISS_WFE	(1 << 0)
> +
>  #endif /* __ARM64_KVM_ARM_H__ */
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 21e9082..4480ab3 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -21,6 +21,7 @@ config KVM
>  	select MMU_NOTIFIER
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
> +	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_MMIO
>  	select KVM_ARM_HOST
>  	select KVM_ARM_VGIC
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 9beaca03..8da5606 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -47,21 +47,29 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  }
>  
>  /**
> - * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
> + * kvm_handle_wfx - handle a wait-for-interrupts or wait-for-event
> + *		    instruction executed by a guest
> + *
>   * @vcpu:	the vcpu pointer
>   *
> - * Simply call kvm_vcpu_block(), which will halt execution of
> + * WFE: Yield the CPU and come back to this vcpu when the scheduler
> + * decides to.
> + * WFI: Simply call kvm_vcpu_block(), which will halt execution of
>   * world-switches and schedule other host processes until there is an
>   * incoming IRQ or FIQ to the VM.
>   */
> -static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	kvm_vcpu_block(vcpu);
> +	if (kvm_vcpu_get_hsr(vcpu) & ESR_EL2_EC_WFI_ISS_WFE)
> +		kvm_vcpu_on_spin(vcpu);
> +	else
> +		kvm_vcpu_block(vcpu);
> +
>  	return 1;
>  }
>  
>  static exit_handle_fn arm_exit_handlers[] = {
> -	[ESR_EL2_EC_WFI]	= kvm_handle_wfi,
> +	[ESR_EL2_EC_WFI]	= kvm_handle_wfx,
>  	[ESR_EL2_EC_CP15_32]	= kvm_handle_cp15_32,
>  	[ESR_EL2_EC_CP15_64]	= kvm_handle_cp15_64,
>  	[ESR_EL2_EC_CP14_MR]	= kvm_handle_cp14_access,
> -- 
> 1.8.2.3
> 
ack
