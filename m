From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Sep 2018 05:53:20 +0800
Subject: [arm-platforms:kvm-arm64/nv-wip 67/116]
 arch/arm/kvm/../../../virt/kvm/arm/arm.c:565:14: error: 'struct
 kvm_vcpu_arch' has no member named 'vttbr_el2'; did you mean 'vttbr_vel2'?
Message-ID: <201809190517.6NBPGpBt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip
head:   b7b336b71aac5dbb02b53a82e7032524ba292713
commit: f22e6b9e66c013327421bc726c0b1df4c0f98e01 [67/116] KVM: arm/arm64: Support mmu for the virtual EL2 execution
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f22e6b9e66c013327421bc726c0b1df4c0f98e01
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'update_vttbr':
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:565:14: error: 'struct kvm_vcpu_arch' has no member named 'vttbr_el2'; did you mean 'vttbr_vel2'?
      vcpu->arch.vttbr_el2 = new_vttbr;
                 ^~~~~~~~~
                 vttbr_vel2
--
   In file included from arch/arm/include/asm/kvm_hyp.h:23:0,
                    from arch/arm/kvm/hyp/switch.c:20:
   arch/arm/kvm/hyp/switch.c: In function '__activate_vm':
>> arch/arm/kvm/hyp/switch.c:81:18: error: 'struct kvm_s2_mmu' has no member named 'vttbr'
     write_sysreg(mmu->vttbr, VTTBR);
                     ^
   arch/arm/include/asm/cp15.h:65:73: note: in definition of macro '__write_sysreg'
    #define __write_sysreg(v, r, w, c, t) asm volatile(w " " c : : "r" ((t)(v)))
                                                                            ^
>> arch/arm/kvm/hyp/switch.c:81:2: note: in expansion of macro 'write_sysreg'
     write_sysreg(mmu->vttbr, VTTBR);
     ^~~~~~~~~~~~

vim +565 arch/arm/kvm/../../../virt/kvm/arm/arm.c

   502	
   503	/**
   504	 * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
   505	 * @kvm: The guest that we are about to run
   506	 * @vmid: The stage-2 VMID information struct
   507	 *
   508	 * Called from kvm_arch_vcpu_ioctl_run before entering the guest to ensure the
   509	 * VM has a valid VMID, otherwise assigns a new one and flushes corresponding
   510	 * caches and TLBs.
   511	 */
   512	static void update_vttbr(struct kvm *kvm, struct kvm_s2_vmid *vmid)
   513	{
   514		struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
   515		struct kvm_vcpu *vcpu;
   516		bool new_gen;
   517		u64 new_vttbr;
   518		int i = 0;
   519	
   520		read_lock(&kvm_vmid_lock);
   521		new_gen = need_new_vmid_gen(vmid);
   522		read_unlock(&kvm_vmid_lock);
   523	
   524		if (!new_gen)
   525			return;
   526	
   527		write_lock(&kvm_vmid_lock);
   528	
   529		/*
   530		 * We need to re-check the vmid_gen here to ensure that if another vcpu
   531		 * already allocated a valid vmid for this vm, then this vcpu should
   532		 * use the same vmid.
   533		 */
   534		if (!need_new_vmid_gen(vmid)) {
   535			write_unlock(&kvm_vmid_lock);
   536			return;
   537		}
   538	
   539		/* First user of a new VMID generation? */
   540		if (unlikely(kvm_next_vmid == 0)) {
   541			atomic64_inc(&kvm_vmid_gen);
   542			kvm_next_vmid = 1;
   543	
   544			/*
   545			 * On SMP we know no other CPUs can use this CPU's or each
   546			 * other's VMID after force_vm_exit returns since the
   547			 * kvm_vmid_lock blocks them from reentry to the guest.
   548			 */
   549			force_vm_exit(cpu_all_mask);
   550			/*
   551			 * Now broadcast TLB + ICACHE invalidation over the inner
   552			 * shareable domain to make sure all data structures are
   553			 * clean.
   554			 */
   555			kvm_call_hyp(__kvm_flush_vm_context);
   556		}
   557	
   558		vmid->vmid_gen = atomic64_read(&kvm_vmid_gen);
   559		vmid->vmid = kvm_next_vmid;
   560		kvm_next_vmid++;
   561		kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
   562	
   563		new_vttbr = kvm_get_vttbr(&mmu->vmid, mmu);
   564		kvm_for_each_vcpu(i, vcpu, kvm) {
 > 565			vcpu->arch.vttbr_el2 = new_vttbr;
   566		}
   567	
   568		write_unlock(&kvm_vmid_lock);
   569	}
   570	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/98f25d16/attachment-0001.gz>
