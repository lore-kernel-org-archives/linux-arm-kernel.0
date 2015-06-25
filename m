From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Jun 2015 09:49:34 +0200
Subject: [PATCH v6 10/12] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <87mvzoxpg6.fsf@linaro.org>
References: <1434716630-18260-1-git-send-email-alex.bennee@linaro.org>
 <1434716630-18260-11-git-send-email-alex.bennee@linaro.org>
 <20150624202216.GE22785@cbox> <87mvzoxpg6.fsf@linaro.org>
Message-ID: <20150625074934.GB28244@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 07:38:33AM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Fri, Jun 19, 2015 at 01:23:48PM +0100, Alex Benn?e wrote:
> >> This adds support for userspace to control the HW debug registers for
> >> guest debug. In the debug ioctl we copy the IMPDEF defined number of
> >
> > s/defined//
> >
> >> registers into a new register set called host_debug_state. There is now
> >> a new vcpu parameter called debug_ptr which selects which register set
> >> is to copied into the real registers when world switch occurs.
> >
> > But this patch doesn't seem to add the debug_ptr field?
> 
> Oops, yes the comment belongs to the previous patch.
> 
> >
> > s/to//
> >
> >> 
> >> I've moved some helper functions into the hw_breakpoint.h header for
> >> re-use.
> >> 
> >> As with single step we need to tweak the guest registers to enable the
> >> exceptions so we need to save and restore those bits.
> >> 
> >> Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
> >> userspace to query the number of hardware break and watch points
> >> available on the host hardware.
> >> 
> >> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> >> 
> >> ---
> >> v2
> >>    - switched to C setup
> >>    - replace host debug registers directly into context
> >>    - minor tweak to api docs
> >>    - setup right register for debug
> >>    - add FAR_EL2 to debug exit structure
> >>    - add support for trapping debug register access
> >> v3
> >>    - remove stray trace statement
> >>    - fix spacing around operators (various)
> >>    - clean-up usage of trap_debug
> >>    - introduce debug_ptr, replace excessive memcpy stuff
> >>    - don't use memcpy in ioctl, just assign
> >>    - update cap ioctl documentation
> >>    - reword a number comments
> >>    - rename host_debug_state->external_debug_state
> >> v4
> >>    - use the new u32/u64 split debug_ptr approach
> >>    - fix some wording/comments
> >> v5
> >>    - don't set MDSCR_EL1.KDE (not needed)
> >> v6
> >>    - update wording given change in commentary
> >>    - KVM_GUESTDBG_USE_HW_BP->KVM_GUESTDBG_USE_HW
> >> ---
> >>  Documentation/virtual/kvm/api.txt      |  7 ++++++-
> >>  arch/arm/kvm/arm.c                     |  7 +++++++
> >>  arch/arm64/include/asm/hw_breakpoint.h | 12 +++++++++++
> >>  arch/arm64/include/asm/kvm_host.h      |  6 +++++-
> >>  arch/arm64/kernel/hw_breakpoint.c      | 12 -----------
> >>  arch/arm64/kvm/debug.c                 | 37 +++++++++++++++++++++++++++++-----
> >>  arch/arm64/kvm/handle_exit.c           |  6 ++++++
> >>  arch/arm64/kvm/reset.c                 | 12 +++++++++++
> >>  include/uapi/linux/kvm.h               |  2 ++
> >>  9 files changed, 82 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> >> index 33c8143..ada57df 100644
> >> --- a/Documentation/virtual/kvm/api.txt
> >> +++ b/Documentation/virtual/kvm/api.txt
> >> @@ -2668,7 +2668,7 @@ The top 16 bits of the control field are architecture specific control
> >>  flags which can include the following:
> >>  
> >>    - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86, arm64]
> >> -  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
> >> +  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390, arm64]
> >>    - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
> >>    - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
> >>    - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
> >> @@ -2683,6 +2683,11 @@ updated to the correct (supplied) values.
> >>  The second part of the structure is architecture specific and
> >>  typically contains a set of debug registers.
> >>  
> >> +For arm64 the number of debug registers is implementation defined and
> >> +can be determined by querying the KVM_CAP_GUEST_DEBUG_HW_BPS and
> >> +KVM_CAP_GUEST_DEBUG_HW_WPS capabilities which return a positive number
> >> +indicating the number of supported registers.
> >> +
> >>  When debug events exit the main run loop with the reason
> >>  KVM_EXIT_DEBUG with the kvm_debug_exit_arch part of the kvm_run
> >>  structure containing architecture specific debug information.
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index 0d17c7b..60c4045 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -307,6 +307,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> >>  
> >>  #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE |    \
> >>  			    KVM_GUESTDBG_USE_SW_BP | \
> >> +			    KVM_GUESTDBG_USE_HW | \
> >>  			    KVM_GUESTDBG_SINGLESTEP)
> >>  
> >>  /**
> >> @@ -327,6 +328,12 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >>  
> >>  	if (dbg->control & KVM_GUESTDBG_ENABLE) {
> >>  		vcpu->guest_debug = dbg->control;
> >> +
> >> +		/* Hardware assisted Break and Watch points */
> >> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW) {
> >> +			vcpu->arch.external_debug_state = dbg->arch;
> >> +		}
> >> +
> >>  	} else {
> >>  		/* If not enabled clear all flags */
> >>  		vcpu->guest_debug = 0;
> >> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> >> index 52b484b..c450552 100644
> >> --- a/arch/arm64/include/asm/hw_breakpoint.h
> >> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> >> @@ -130,6 +130,18 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
> >>  }
> >>  #endif
> >>  
> >> +/* Determine number of BRP registers available. */
> >> +static inline int get_num_brps(void)
> >> +{
> >> +	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
> >> +}
> >> +
> >> +/* Determine number of WRP registers available. */
> >> +static inline int get_num_wrps(void)
> >> +{
> >> +	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
> >> +}
> >> +
> >>  extern struct pmu perf_ops_bp;
> >>  
> >>  #endif	/* __KERNEL__ */
> >> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >> index 9697daf..0a3ee7b 100644
> >> --- a/arch/arm64/include/asm/kvm_host.h
> >> +++ b/arch/arm64/include/asm/kvm_host.h
> >> @@ -116,13 +116,17 @@ struct kvm_vcpu_arch {
> >>  	 * debugging the guest from the host and to maintain separate host and
> >>  	 * guest state during world switches. vcpu_debug_state are the debug
> >>  	 * registers of the vcpu as the guest sees them.  host_debug_state are
> >> -	 * the host registers which are saved and restored during world switches.
> >> +	 * the host registers which are saved and restored during
> >> +	 * world switches. external_debug_state contains the debug
> >> +	 * values we want to debugging the guest. This is set via the
> >
> > nit: s/debugging/debug/
> >
> >> +	 * KVM_SET_GUEST_DEBUG ioctl.
> >>  	 *
> >>  	 * debug_ptr points to the set of debug registers that should be loaded
> >>  	 * onto the hardware when running the guest.
> >>  	 */
> >>  	struct kvm_guest_debug_arch *debug_ptr;
> >>  	struct kvm_guest_debug_arch vcpu_debug_state;
> >> +	struct kvm_guest_debug_arch external_debug_state;
> >>  
> >>  	/* Pointer to host CPU context */
> >>  	kvm_cpu_context_t *host_cpu_context;
> >> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> >> index e7d934d..3a41bbf 100644
> >> --- a/arch/arm64/kernel/hw_breakpoint.c
> >> +++ b/arch/arm64/kernel/hw_breakpoint.c
> >> @@ -49,18 +49,6 @@ static DEFINE_PER_CPU(int, stepping_kernel_bp);
> >>  static int core_num_brps;
> >>  static int core_num_wrps;
> >>  
> >> -/* Determine number of BRP registers available. */
> >> -static int get_num_brps(void)
> >> -{
> >> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
> >> -}
> >> -
> >> -/* Determine number of WRP registers available. */
> >> -static int get_num_wrps(void)
> >> -{
> >> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
> >> -}
> >> -
> >>  int hw_breakpoint_slots(int type)
> >>  {
> >>  	/*
> >> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> >> index d439eb8..b287bbc 100644
> >> --- a/arch/arm64/kvm/debug.c
> >> +++ b/arch/arm64/kvm/debug.c
> >> @@ -96,10 +96,6 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
> >>  				MDCR_EL2_TDRA |
> >>  				MDCR_EL2_TDOSA);
> >>  
> >> -	/* Trap on access to debug registers? */
> >> -	if (trap_debug)
> >> -		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
> >> -
> >>  	/* Is Guest debugging in effect? */
> >>  	if (vcpu->guest_debug) {
> >>  		/* Route all software debug exceptions to EL2 */
> >> @@ -134,11 +130,42 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
> >>  		} else {
> >>  			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
> >>  		}
> >> +
> >> +		/*
> >> +		 * HW Breakpoints and watchpoints
> >> +		 *
> >> +		 * We simply switch the debug_ptr to point to our new
> >> +		 * external_debug_state which has been populated by the
> >> +		 * debug ioctl. The existing KVM_ARM64_DEBUG_DIRTY
> >> +		 * mechanism ensures the registers are updated on the
> >> +		 * world switch.
> >> +		 */
> >> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW) {
> >> +			/* Enable breakpoints/watchpoints */
> >> +			vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_MDE;
> >> +
> >> +			vcpu->arch.debug_ptr = &vcpu->arch.external_debug_state;
> >> +			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
> >> +			trap_debug = true;
> >> +		}
> >>  	}
> >> +
> >> +	/* Trap debug register access */
> >> +	if (trap_debug)
> >> +		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
> >>  }
> >>  
> >>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
> >>  {
> >> -	if (vcpu->guest_debug)
> >> +	if (vcpu->guest_debug) {
> >>  		restore_guest_debug_regs(vcpu);
> >> +
> >> +		/*
> >> +		 * If we were using HW debug we need to restore the
> >> +		 * debug_ptr to the guest debug state.
> >> +		 */
> >> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW)
> >> +			vcpu->arch.debug_ptr = &vcpu->arch.vcpu_debug_state;
> >
> > I still think this would be more cleanly done in the setup_debug
> > function, but ok:
> 
> I don't follow, setup_debug is called before we enter KVM. It's pretty
> light when no debugging is being done so this ensure we leave state how
> we would like it when we stop debugging.
> 
> I can move it to an else leg in setup if you really want.
> 
I just feel like whenever you enter the guest you setup the state you
want for your guest and then when reading the code you never have to
worry about "did I set the pointer back correctly last time it exited",
but thinking about your response, I guess that's an extra store on each
world-switch, so theoretically that may be a bit more overhead (on top
of the hundreds other stores and spinlocks we take and stuff).

If you prefer, leave it like this, but consider adding a
BUG_ON(!guest_debugging && debug_ptr != &vcpu->arch.vcpu_debug_state) in
the setup function...

I'm probably being paranoid.

-Christoffer
