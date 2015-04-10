From: drjones@redhat.com (Andrew Jones)
Date: Fri, 10 Apr 2015 14:25:21 +0200
Subject: [PATCH v2 08/10] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <1427814488-28467-9-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-9-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150410122520.GA3227@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 04:08:06PM +0100, Alex Benn?e wrote:
> This adds support for userspace to control the HW debug registers for
> guest debug. We'll only copy the $ARCH defined number across as that is
> all that hyp.S will use anyway. I've moved some helper functions into
> the hw_breakpoint.h header for re-use.
> 
> As with single step we need to tweak the guest registers to enable the
> exceptions so we need to save and restore those bits.
> 
> Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
> userspace to query the number of hardware break and watch points
> available on the host hardware.
> 
> As QEMU tests for watchpoints based on the address and not the PC we
> also need to export the value of far_el2 to userspace.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
> ---
> v2
>    - switched to C setup
>    - replace host debug registers directly into context
>    - minor tweak to api docs
>    - setup right register for debug
>    - add FAR_EL2 to debug exit structure
>    - add support fro trapping debug register access
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 17d4f9c..ac34093 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2627,7 +2627,7 @@ The top 16 bits of the control field are architecture specific control
>  flags which can include the following:
>  
>    - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86, arm64]
> -  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
> +  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390, arm64]
>    - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
>    - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
>    - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
> @@ -2642,6 +2642,10 @@ updated to the correct (supplied) values.
>  The second part of the structure is architecture specific and
>  typically contains a set of debug registers.
>  
> +For arm64 the number of debug registers is implementation defined and
> +can be determined by querying the KVM_CAP_GUEST_DEBUG_HW_BPS and
> +KVM_CAP_GUEST_DEBUG_HW_WPS capabilities.
> +
>  When debug events exit the main run loop with the reason
>  KVM_EXIT_DEBUG with the kvm_debug_exit_arch part of the kvm_run
>  structure containing architecture specific debug information.
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index c1ed8cb..a286026 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -306,6 +306,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  #define KVM_GUESTDBG_VALID (KVM_GUESTDBG_ENABLE |    \
>  			    KVM_GUESTDBG_USE_SW_BP | \
> +			    KVM_GUESTDBG_USE_HW_BP | \
>  			    KVM_GUESTDBG_SINGLESTEP)
>  
>  /**
> @@ -328,6 +329,26 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>  			return -EINVAL;
>  
>  		vcpu->guest_debug = dbg->control;
> +
> +		/* Hardware assisted Break and Watch points */
> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> +			int nb = get_num_brps();
> +			int nw = get_num_wrps();
> +
> +			/* Copy across up to IMPDEF debug registers to our
> +			 * shadow copy in the vcpu structure. The debug code
> +			 * will then set them up before we re-enter the guest.
> +			 */

Is it necessary to limit the number copied here by anything other than
what the struct supports? Userspace gave us a struct kvm_guest_debug_arch,
so let's save the whole thing. How about just

vcpu->arch.guest_debug_regs = *dbg;

> +			memcpy(vcpu->arch.guest_debug_regs.dbg_bcr,
> +				dbg->arch.dbg_bcr, sizeof(__u64)*nb);
> +			memcpy(vcpu->arch.guest_debug_regs.dbg_bvr,
> +				dbg->arch.dbg_bvr, sizeof(__u64)*nb);
> +			memcpy(vcpu->arch.guest_debug_regs.dbg_wcr,
> +				dbg->arch.dbg_wcr, sizeof(__u64)*nw);
> +			memcpy(vcpu->arch.guest_debug_regs.dbg_wvr,
> +				dbg->arch.dbg_wvr, sizeof(__u64)*nw);
> +		}
> +
>  	} else {
>  		/* If not enabled clear all flags */
>  		vcpu->guest_debug = 0;
> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> index 52b484b..c450552 100644
> --- a/arch/arm64/include/asm/hw_breakpoint.h
> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> @@ -130,6 +130,18 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
>  }
>  #endif
>  
> +/* Determine number of BRP registers available. */
> +static inline int get_num_brps(void)
> +{
> +	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
> +}
> +
> +/* Determine number of WRP registers available. */
> +static inline int get_num_wrps(void)
> +{
> +	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
> +}
> +
>  extern struct pmu perf_ops_bp;
>  
>  #endif	/* __KERNEL__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 6a33647..2c359c9 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -106,8 +106,9 @@ struct kvm_vcpu_arch {
>  	/* Exception Information */
>  	struct kvm_vcpu_fault_info fault;
>  
> -	/* Debug state */
> +	/* Guest debug state */
>  	u64 debug_flags;
> +	struct kvm_guest_debug_arch guest_debug_regs;
>  
>  	/* Pointer to host CPU context */
>  	kvm_cpu_context_t *host_cpu_context;
> @@ -126,6 +127,7 @@ struct kvm_vcpu_arch {
>  		u32	pstate_ss_bit;
>  		u32	mdscr_el1_bits;
>  
> +		struct kvm_guest_debug_arch debug_regs;
>  	} debug_saved_regs;
>  
>  	/* Don't run the guest */
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 6ee70a0..73f21e4 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -118,6 +118,7 @@ struct kvm_guest_debug_arch {
>  struct kvm_debug_exit_arch {
>  	__u64 pc;
>  	__u32 hsr;
> +	__u64 far;	/* used for watchpoints */
>  };
>  
>  struct kvm_sync_regs {
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 98bbe06..923be44 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -49,18 +49,6 @@ static DEFINE_PER_CPU(int, stepping_kernel_bp);
>  static int core_num_brps;
>  static int core_num_wrps;
>  
> -/* Determine number of BRP registers available. */
> -static int get_num_brps(void)
> -{
> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
> -}
> -
> -/* Determine number of WRP registers available. */
> -static int get_num_wrps(void)
> -{
> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
> -}
> -
>  int hw_breakpoint_slots(int type)
>  {
>  	/*
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index b32362c..3b368f3 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -50,14 +50,19 @@
>  
>  void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
>  {
> +	bool trap_debug = false;
> +
>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM | MDCR_EL2_TPMCR);
>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TDRA | MDCR_EL2_TDOSA);
>  
> -	/* Trap debug register access? */
> +	trace_kvm_arch_setup_debug_reg32("MDCR_EL2", vcpu->arch.mdcr_el2);

This is 2 patches too early. You don't introduce this tracepoint until
later.

> +
> +	/*
> +	 * If we are not treating debug registers are dirty we need
                                                  ^^ as
> +	 * to trap if the guest starts accessing them.
> +	 */
>  	if (!vcpu->arch.debug_flags & KVM_ARM64_DEBUG_DIRTY)
> -		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
> -	else
> -		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDA;
> +		trap_debug = true;

How about just

bool trap_debug = !(vcpu->arch.debug_flags & KVM_ARM64_DEBUG_DIRTY);

at the top instead?

>  
>  	/* Is Guest debugging in effect? */
>  	if (vcpu->guest_debug) {
> @@ -84,10 +89,69 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
>  			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
>  		}
>  
> +		/*
> +		 * HW Break/Watch points
> +		 */
> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> +			int nb = get_num_brps();
> +			int nw = get_num_wrps();
> +			struct kvm_guest_debug_arch *saved, *host;
> +
> +			vcpu_sys_reg(vcpu, MDSCR_EL1) |=
> +				(DBG_MDSCR_KDE|DBG_MDSCR_MDE);
> +
> +			/*
> +			 * First we need to make a copy of the guest
> +			 * debug registers before we wipe them out
> +			 * with the ones we want to use.
> +			 */
> +			saved = &vcpu_debug_saved_reg(vcpu, debug_regs);
> +			host = &vcpu->arch.guest_debug_regs;

Again, I don't think we need to be so precise with our copy. We can
always copy extra without problems. It's just what we use that matters.
And how about a couple helpers?

debug_regs_save_to(struct kvm_vcpu *vcpu, struct kvm_guest_debug_arch *dst)
{
  memcpy(dst->dbg_bcr, &vcpu_sys_reg(vcpu, DBGBCR0_EL1), sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(dst->dbg_bvr, &vcpu_sys_reg(vcpu, DBGBVR0_EL1), sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(dst->dbg_wcr, &vcpu_sys_reg(vcpu, DBGWCR0_EL1), sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(dst->dbg_wvr, &vcpu_sys_reg(vcpu, DBGWVR0_EL1), sizeof(u64)*KVM_ARM_NDBG_REGS);
}
debug_regs_restore_from(struct kvm_vcpu *vcpu, struct kvm_guest_debug_arch *src)
{
  memcpy(&vcpu_sys_reg(vcpu, DBGBCR0_EL1), src->dbg_bcr, sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(&vcpu_sys_reg(vcpu, DBGBVR0_EL1), src->dbg_bvr, sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(&vcpu_sys_reg(vcpu, DBGWCR0_EL1), src->dbg_wcr, sizeof(u64)*KVM_ARM_NDBG_REGS);
  memcpy(&vcpu_sys_reg(vcpu, DBGWVR0_EL1), src->dbg_wvr, sizeof(u64)*KVM_ARM_NDBG_REGS);
}

> +
> +			/* Save guest values */
> +			memcpy(&saved->dbg_bcr,
> +			       &vcpu_sys_reg(vcpu, DBGBCR0_EL1),
> +			       sizeof(__u64)*nb);
> +			memcpy(&saved->dbg_bvr,
> +			       &vcpu_sys_reg(vcpu, DBGBVR0_EL1),
> +			       sizeof(__u64)*nb);
> +			memcpy(&saved->dbg_wcr,
> +			       &vcpu_sys_reg(vcpu, DBGWCR0_EL1),
> +			       sizeof(__u64)*nw);
> +			memcpy(&saved->dbg_wvr,
> +			       &vcpu_sys_reg(vcpu, DBGWVR0_EL1),
> +			       sizeof(__u64)*nw);
> +
> +			/* Copy in host values */
> +			memcpy(&vcpu_sys_reg(vcpu, DBGBCR0_EL1),
> +			       &host->dbg_bcr,
> +			       sizeof(__u64)*nb);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGBVR0_EL1),
> +			       &host->dbg_bvr,
> +			       sizeof(__u64)*nb);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGWCR0_EL1),
> +			       &host->dbg_wcr,
> +			       sizeof(__u64)*nw);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGWVR0_EL1),
> +			       &host->dbg_wvr,
> +			       sizeof(__u64)*nw);
> +
> +			/* Make sure hyp.S copies them in/out */
> +			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
> +			/* Also track guest changes */
> +			trap_debug = true;
> +		}
> +
>  	} else {
>  		/* Debug operations can go straight to the guest */
>  		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
>  	}
> +
> +	/* Trap debug register access? */
> +	if (trap_debug)
> +		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
> +	else
> +		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDA;
>  }
>  
>  void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
> @@ -100,5 +164,31 @@ void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
>  		vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~MDSCR_EL1_DEBUG_BITS;
>  		vcpu_sys_reg(vcpu, MDSCR_EL1) |=
>  			vcpu_debug_saved_reg(vcpu, mdscr_el1_bits);
> +
> +		/*
> +		 * If we were using HW debug we need to restore the
> +		 * values the guest had set them up with
> +		 */
> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> +			struct kvm_guest_debug_arch *regs;
> +			int nb = get_num_brps();
> +			int nw = get_num_wrps();
> +
> +			regs = &vcpu_debug_saved_reg(vcpu, debug_regs);
debug_regs_restore_from(vcpu, regs);
> +
> +			/* Restore the saved debug register values */
> +			memcpy(&vcpu_sys_reg(vcpu, DBGBCR0_EL1),
> +			       &regs->dbg_bcr,
> +			       sizeof(__u64)*nb);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGBVR0_EL1),
> +			       &regs->dbg_bvr,
> +			       sizeof(__u64)*nb);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGWCR0_EL1),
> +			       &regs->dbg_wcr,
> +			       sizeof(__u64)*nw);
> +			memcpy(&vcpu_sys_reg(vcpu, DBGWVR0_EL1),
> +			       &regs->dbg_wvr,
> +			       sizeof(__u64)*nw);
> +		}
>  	}
>  }
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 16accae..460a1aa 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -101,7 +101,11 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	run->debug.arch.hsr = hsr;
>  
>  	switch (hsr >> ESR_ELx_EC_SHIFT) {
> +	case ESR_ELx_EC_WATCHPT_LOW:
> +		run->debug.arch.far = vcpu->arch.fault.far_el2;
> +		/* fall through */
>  	case ESR_ELx_EC_SOFTSTP_LOW:
> +	case ESR_ELx_EC_BREAKPT_LOW:
>  	case ESR_ELx_EC_BKPT32:
>  	case ESR_ELx_EC_BRK64:
>  		run->debug.arch.pc = *vcpu_pc(vcpu);
> @@ -129,6 +133,8 @@ static exit_handle_fn arm_exit_handlers[] = {
>  	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
>  	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
>  	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
> +	[ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
> +	[ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
>  	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
>  	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
>  };
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 0b43265..c2732c7 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -64,6 +64,12 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_ARM_EL1_32BIT:
>  		r = cpu_has_32bit_el1();
>  		break;
> +	case KVM_CAP_GUEST_DEBUG_HW_BPS:
> +		r = get_num_brps();
> +		break;
> +	case KVM_CAP_GUEST_DEBUG_HW_WPS:
> +		r  = get_num_wrps();
> +		break;
>  	default:
>  		r = 0;
>  	}
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c370b40..be9b188 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -196,16 +196,49 @@ static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
>   * - If the dirty bit is set, save guest registers, restore host
>   *   registers and clear the dirty bit. This ensure that the host can
>   *   now use the debug registers.
> + *
> + * We also use this mechanism to set-up the debug registers for guest
setup
> + * debugging. If this is the case we want to ensure the guest sees
> + * the right versions of the registers - even if they are not going to
> + * be effective while guest debug is using HW debug.
> + *
no need for this blank comment line
>   */
> +
>  static bool trap_debug_regs(struct kvm_vcpu *vcpu,
>  			    const struct sys_reg_params *p,
>  			    const struct sys_reg_desc *r)
>  {
> -	if (p->is_write) {
> -		vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
> -		vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
> +	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> +		struct kvm_guest_debug_arch *saved;
> +		__u64 *val;
> +
> +		saved = &vcpu_debug_saved_reg(vcpu, debug_regs);

Here we don't bother enforcing num_brps/wrps, which is fine by me.

> +
> +		if (r->reg >= DBGBCR0_EL1 && r->reg <= DBGBCR15_EL1)
> +			val = &saved->dbg_bcr[r->reg - DBGBCR0_EL1];
> +		else if (r->reg >= DBGBVR0_EL1 && r->reg <= DBGBVR15_EL1)
> +			val = &saved->dbg_bvr[r->reg - DBGBVR0_EL1];
> +		else if (r->reg >= DBGWCR0_EL1 && r->reg <= DBGWCR15_EL1)
> +			val = &saved->dbg_wcr[r->reg - DBGWCR0_EL1];
> +		else if (r->reg >= DBGWVR0_EL1 && r->reg <= DBGWVR15_EL1)
> +			val = &saved->dbg_wvr[r->reg - DBGWVR0_EL1];
> +		else {
> +			kvm_err("Bad register index %d\n", r->reg);
> +			return false;
> +		}
> +
> +		if (p->is_write)
> +			*val = *vcpu_reg(vcpu, p->Rt);
> +		else
> +			*vcpu_reg(vcpu, p->Rt) = *val;
> +
>  	} else {
> -		*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
> +		if (p->is_write) {
> +			vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
> +			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
> +		} else {
> +			*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
> +		}
>  	}
>  
>  	return true;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index ce2db14..0e48c0d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -771,6 +771,8 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_PPC_ENABLE_HCALL 104
>  #define KVM_CAP_CHECK_EXTENSION_VM 105
>  #define KVM_CAP_S390_USER_SIGP 106
> +#define KVM_CAP_GUEST_DEBUG_HW_BPS 107
> +#define KVM_CAP_GUEST_DEBUG_HW_WPS 108
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 2.3.4
> 
