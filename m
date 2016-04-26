From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Apr 2016 17:26:04 +0100
Subject: [PATCH v8 05/13] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1461604250-12789-6-git-send-email-james.morse@arm.com>
References: <1461604250-12789-1-git-send-email-james.morse@arm.com>
 <1461604250-12789-6-git-send-email-james.morse@arm.com>
Message-ID: <571F969C.80200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 25/04/16 18:10, James Morse wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> The current kvm implementation on arm64 does cpu-specific initialization
> at system boot, and has no way to gracefully shutdown a core in terms of
> kvm. This prevents kexec from rebooting the system at EL2.
> 
> This patch adds a cpu tear-down function and also puts an existing cpu-init
> code into a separate function, kvm_arch_hardware_disable() and
> kvm_arch_hardware_enable() respectively.
> We don't need the arm64 specific cpu hotplug hook any more.
> 
> Since this patch modifies common code between arm and arm64, one stub
> definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
> compilation errors.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> [Rebase, added separate VHE init/exit path, changed resets use of
>  kvm_call_hyp() to the __version, en/disabled hardware in init_subsystems(),
>  added icache maintenance to __kvm_hyp_reset() and removed lr restore, removed
>  guest-enter after teardown handling]
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> CC: Marc Zyngier <marc.zyngier@arm.com>
> ---
> N.B. this patch conflicts with 06a71a24bae5 ("arm64: KVM: unregister notifiers
> in hyp mode teardown path") in v4.6-rc4. See the cover letter for details.
> 
> Changes since v7:
>  * Moved the kvm-torn-down guest entry handling into handle_exit(),
>  * Added an exception type for hyp-stub to return to any kvm_call_hyp() caller
> 
>  arch/arm/include/asm/kvm_host.h   |  10 +++-
>  arch/arm/include/asm/kvm_mmu.h    |   1 +
>  arch/arm/kvm/arm.c                | 119 +++++++++++++++++++++++---------------
>  arch/arm/kvm/mmu.c                |   5 ++
>  arch/arm64/include/asm/kvm_asm.h  |   3 +
>  arch/arm64/include/asm/kvm_host.h |  13 ++++-
>  arch/arm64/include/asm/kvm_mmu.h  |   1 +
>  arch/arm64/kernel/hyp-stub.S      |   5 +-
>  arch/arm64/kvm/handle_exit.c      |   7 +++
>  arch/arm64/kvm/hyp-init.S         |  38 ++++++++++++
>  arch/arm64/kvm/reset.c            |  14 +++++
>  11 files changed, 164 insertions(+), 52 deletions(-)

If you moved these hunks:

> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index eb7490d232a0..a88da136f332 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -22,6 +22,8 @@
>  
>  #define ARM_EXCEPTION_IRQ	  0
>  #define ARM_EXCEPTION_TRAP	  1
> +/* The hyp-stub will return this for any kvm_call_hyp() call */
> +#define ARM_EXCEPTION_HYP_GONE	  2
>  
>  #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
>  #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 894fb40fb378..8727f4490772 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -23,6 +23,7 @@
>  
>  #include <asm/assembler.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
>  #include <asm/ptrace.h>
>  #include <asm/virt.h>
>  
> @@ -70,8 +71,8 @@ el1_sync:
>  	msr	vbar_el2, x1
>  	b	9f
>  
> -	/* Unrecognised call type */
> -2:	mov     x0, xzr
> +	/* Someone called kvm_call_hyp() against the hyp-stub... */
> +2:	mov     x0, #ARM_EXCEPTION_HYP_GONE
>  
>  9:	eret
>  ENDPROC(el1_sync)
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index eba89e42f0ed..3246c4aba5b1 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -186,6 +186,13 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		exit_handler = kvm_get_exit_handler(vcpu);
>  
>  		return exit_handler(vcpu, run);
> +	case ARM_EXCEPTION_HYP_GONE:
> +		/*
> +		 * EL2 has been reset to the hyp-stub. This happens when a guest
> +		 * is pre-empted by kvm_reboot()'s shutdown call.
> +		 */
> +		run->exit_reason = KVM_EXIT_FAIL_ENTRY;
> +		return 0;
>  	default:
>  		kvm_pr_unimpl("Unsupported exception type: %d",
>  			      exception_index);

to a separate patch (just before this one), I'd be quite happy.

So for this patch and the future one:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
