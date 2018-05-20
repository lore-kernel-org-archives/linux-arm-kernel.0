From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 06:20:22 +0800
Subject: [kvmarm:queue 9/29] arch/arm/kvm/../../../virt/kvm/arm/arm.c:783:3:
 error: implicit declaration of function 'kvm_arch_vcpu_ctxsync_fp'; did you
 mean 'kvm_arch_vcpu_put_fp'?
Message-ID: <201805210613.5kgi04jf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git queue
head:   f2d1aab22d57235b58db391d318727d3e5ef1e89
commit: 9d346205940be002dc43a3274f8c6c47beddd8cc [9/29] KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9d346205940be002dc43a3274f8c6c47beddd8cc
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:783:3: error: implicit declaration of function 'kvm_arch_vcpu_ctxsync_fp'; did you mean 'kvm_arch_vcpu_put_fp'? [-Werror=implicit-function-declaration]
      kvm_arch_vcpu_ctxsync_fp(vcpu);
      ^~~~~~~~~~~~~~~~~~~~~~~~
      kvm_arch_vcpu_put_fp
   cc1: some warnings being treated as errors

vim +783 arch/arm/kvm/../../../virt/kvm/arm/arm.c

   626	
   627	/**
   628	 * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
   629	 * @vcpu:	The VCPU pointer
   630	 * @run:	The kvm_run structure pointer used for userspace state exchange
   631	 *
   632	 * This function is called through the VCPU_RUN ioctl called from user space. It
   633	 * will execute VM code in a loop until the time slice for the process is used
   634	 * or some emulation is needed from user space in which case the function will
   635	 * return with return value 0 and with the kvm_run structure filled in with the
   636	 * required data for the requested emulation.
   637	 */
   638	int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
   639	{
   640		int ret;
   641	
   642		if (unlikely(!kvm_vcpu_initialized(vcpu)))
   643			return -ENOEXEC;
   644	
   645		ret = kvm_vcpu_first_run_init(vcpu);
   646		if (ret)
   647			return ret;
   648	
   649		if (run->exit_reason == KVM_EXIT_MMIO) {
   650			ret = kvm_handle_mmio_return(vcpu, vcpu->run);
   651			if (ret)
   652				return ret;
   653			if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
   654				return 0;
   655		}
   656	
   657		if (run->immediate_exit)
   658			return -EINTR;
   659	
   660		vcpu_load(vcpu);
   661	
   662		kvm_sigset_activate(vcpu);
   663	
   664		ret = 1;
   665		run->exit_reason = KVM_EXIT_UNKNOWN;
   666		while (ret > 0) {
   667			/*
   668			 * Check conditions before entering the guest
   669			 */
   670			cond_resched();
   671	
   672			update_vttbr(vcpu->kvm);
   673	
   674			check_vcpu_requests(vcpu);
   675	
   676			/*
   677			 * Preparing the interrupts to be injected also
   678			 * involves poking the GIC, which must be done in a
   679			 * non-preemptible context.
   680			 */
   681			preempt_disable();
   682	
   683			/* Flush FP/SIMD state that can't survive guest entry/exit */
   684			kvm_fpsimd_flush_cpu_state();
   685	
   686			kvm_pmu_flush_hwstate(vcpu);
   687	
   688			local_irq_disable();
   689	
   690			kvm_vgic_flush_hwstate(vcpu);
   691	
   692			/*
   693			 * Exit if we have a signal pending so that we can deliver the
   694			 * signal to user space.
   695			 */
   696			if (signal_pending(current)) {
   697				ret = -EINTR;
   698				run->exit_reason = KVM_EXIT_INTR;
   699			}
   700	
   701			/*
   702			 * If we're using a userspace irqchip, then check if we need
   703			 * to tell a userspace irqchip about timer or PMU level
   704			 * changes and if so, exit to userspace (the actual level
   705			 * state gets updated in kvm_timer_update_run and
   706			 * kvm_pmu_update_run below).
   707			 */
   708			if (static_branch_unlikely(&userspace_irqchip_in_use)) {
   709				if (kvm_timer_should_notify_user(vcpu) ||
   710				    kvm_pmu_should_notify_user(vcpu)) {
   711					ret = -EINTR;
   712					run->exit_reason = KVM_EXIT_INTR;
   713				}
   714			}
   715	
   716			/*
   717			 * Ensure we set mode to IN_GUEST_MODE after we disable
   718			 * interrupts and before the final VCPU requests check.
   719			 * See the comment in kvm_vcpu_exiting_guest_mode() and
   720			 * Documentation/virtual/kvm/vcpu-requests.rst
   721			 */
   722			smp_store_mb(vcpu->mode, IN_GUEST_MODE);
   723	
   724			if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
   725			    kvm_request_pending(vcpu)) {
   726				vcpu->mode = OUTSIDE_GUEST_MODE;
   727				isb(); /* Ensure work in x_flush_hwstate is committed */
   728				kvm_pmu_sync_hwstate(vcpu);
   729				if (static_branch_unlikely(&userspace_irqchip_in_use))
   730					kvm_timer_sync_hwstate(vcpu);
   731				kvm_vgic_sync_hwstate(vcpu);
   732				local_irq_enable();
   733				preempt_enable();
   734				continue;
   735			}
   736	
   737			kvm_arm_setup_debug(vcpu);
   738	
   739			/**************************************************************
   740			 * Enter the guest
   741			 */
   742			trace_kvm_entry(*vcpu_pc(vcpu));
   743			guest_enter_irqoff();
   744	
   745			if (has_vhe()) {
   746				kvm_arm_vhe_guest_enter();
   747				ret = kvm_vcpu_run_vhe(vcpu);
   748				kvm_arm_vhe_guest_exit();
   749			} else {
   750				ret = kvm_call_hyp(__kvm_vcpu_run_nvhe, vcpu);
   751			}
   752	
   753			vcpu->mode = OUTSIDE_GUEST_MODE;
   754			vcpu->stat.exits++;
   755			/*
   756			 * Back from guest
   757			 *************************************************************/
   758	
   759			kvm_arm_clear_debug(vcpu);
   760	
   761			/*
   762			 * We must sync the PMU state before the vgic state so
   763			 * that the vgic can properly sample the updated state of the
   764			 * interrupt line.
   765			 */
   766			kvm_pmu_sync_hwstate(vcpu);
   767	
   768			/*
   769			 * Sync the vgic state before syncing the timer state because
   770			 * the timer code needs to know if the virtual timer
   771			 * interrupts are active.
   772			 */
   773			kvm_vgic_sync_hwstate(vcpu);
   774	
   775			/*
   776			 * Sync the timer hardware state before enabling interrupts as
   777			 * we don't want vtimer interrupts to race with syncing the
   778			 * timer virtual interrupt state.
   779			 */
   780			if (static_branch_unlikely(&userspace_irqchip_in_use))
   781				kvm_timer_sync_hwstate(vcpu);
   782	
 > 783			kvm_arch_vcpu_ctxsync_fp(vcpu);
   784	
   785			/*
   786			 * We may have taken a host interrupt in HYP mode (ie
   787			 * while executing the guest). This interrupt is still
   788			 * pending, as we haven't serviced it yet!
   789			 *
   790			 * We're now back in SVC mode, with interrupts
   791			 * disabled.  Enabling the interrupts now will have
   792			 * the effect of taking the interrupt again, in SVC
   793			 * mode this time.
   794			 */
   795			local_irq_enable();
   796	
   797			/*
   798			 * We do local_irq_enable() before calling guest_exit() so
   799			 * that if a timer interrupt hits while running the guest we
   800			 * account that tick as being spent in the guest.  We enable
   801			 * preemption after calling guest_exit() so that if we get
   802			 * preempted we make sure ticks after that is not counted as
   803			 * guest time.
   804			 */
   805			guest_exit();
   806			trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
   807	
   808			/* Exit types that need handling before we can be preempted */
   809			handle_exit_early(vcpu, run, ret);
   810	
   811			preempt_enable();
   812	
   813			ret = handle_exit(vcpu, run, ret);
   814		}
   815	
   816		/* Tell userspace about in-kernel device output levels */
   817		if (unlikely(!irqchip_in_kernel(vcpu->kvm))) {
   818			kvm_timer_update_run(vcpu);
   819			kvm_pmu_update_run(vcpu);
   820		}
   821	
   822		kvm_sigset_deactivate(vcpu);
   823	
   824		vcpu_put(vcpu);
   825		return ret;
   826	}
   827	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19846 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/3cee3bbc/attachment-0001.gz>
