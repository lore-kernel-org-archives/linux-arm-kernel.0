From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 20 Jul 2013 23:04:05 +0100
Subject: [PATCH 3/4] arm64: KVM: let other tasks run when hitting WFE
In-Reply-To: <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130720220405.GC35165@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 02:53:54PM +0100, Marc Zyngier wrote:
> So far, when a guest executes WFE (like when waiting for a spinlock
> to become unlocked), we don't do a thing and let it run uninterrupted.
> 
> Another option is to trap a blocking WFE and offer the opportunity
> to the scheduler to switch to another task, potentially giving the
> vcpu holding the spinlock a chance to run sooner.
> 

I'm curious if we have any data supporting this to be a good idea?

My intuition here is that waiting for a spinlock really shouldn't be
something a guest is doing for a long time - we always try to avoid too
much contention on spinlocks, no?  The theory that it would unlock the
spinlock sooner is really only supported if the CPU resources are
grossly oversubscribed - are we optimizing for this case?

So, how many cycles do we anticipate a world-switch back and forward
between a VM and the host to be compared to the average number of spin
cycles for a spinlock?

Finally, for the case where a waiting vcpu is only going to spin for a
couple of cycles, aren't we adding significant overhead?  I would expect
this to be the most common case.


> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |  6 ++++--
>  arch/arm64/kvm/handle_exit.c     | 18 +++++++++++++-----
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index a5f28e2..ac1ea05 100644
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
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 9beaca03..b0098c2 100644
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
> +	if (kvm_vcpu_get_hsr(vcpu) & 1)
> +		cond_resched();
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
> 

-- 
Christoffer
