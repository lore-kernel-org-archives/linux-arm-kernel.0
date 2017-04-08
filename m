From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 9 Apr 2017 01:44:22 +0800
Subject: [arm-platforms:kvm-arm64/tlb-abort 22/22] arch/arm/kvm/mmu.c:1433:3:
 error: implicit declaration of function 'kvm_inject_tlbabort'
Message-ID: <201704090118.OWnHHb1I%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/tlb-abort
head:   cb344ffd75d27204ef0e82e8d6a280b4edd19ac0
commit: cb344ffd75d27204ef0e82e8d6a280b4edd19ac0 [22/22] WIP
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cb344ffd75d27204ef0e82e8d6a280b4edd19ac0
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/kvm/arm.c:45:0:
   arch/arm/include/asm/kvm_emulate.h: In function 'kvm_vcpu_abt_tlbabort':
>> arch/arm/include/asm/kvm_emulate.h:211:38: warning: passing argument 1 of 'kvm_vcpu_trap_get_fault_type' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return kvm_vcpu_trap_get_fault_type(vcpu) == FSC_TLB_ABORT;
                                         ^~~~
   arch/arm/include/asm/kvm_emulate.h:204:18: note: expected 'struct kvm_vcpu *' but argument is of type 'const struct kvm_vcpu *'
    static inline u8 kvm_vcpu_trap_get_fault_type(struct kvm_vcpu *vcpu)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/arm/kvm/mmu.c:30:0:
   arch/arm/include/asm/kvm_emulate.h: In function 'kvm_vcpu_abt_tlbabort':
>> arch/arm/include/asm/kvm_emulate.h:211:38: warning: passing argument 1 of 'kvm_vcpu_trap_get_fault_type' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return kvm_vcpu_trap_get_fault_type(vcpu) == FSC_TLB_ABORT;
                                         ^~~~
   arch/arm/include/asm/kvm_emulate.h:204:18: note: expected 'struct kvm_vcpu *' but argument is of type 'const struct kvm_vcpu *'
    static inline u8 kvm_vcpu_trap_get_fault_type(struct kvm_vcpu *vcpu)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/kvm/mmu.c: In function 'kvm_handle_guest_abort':
>> arch/arm/kvm/mmu.c:1433:3: error: implicit declaration of function 'kvm_inject_tlbabort' [-Werror=implicit-function-declaration]
      kvm_inject_tlbabort(vcpu);
      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/arm/kvm/hyp/switch.c: In function '__populate_fault_info':
>> arch/arm/kvm/hyp/switch.c:146:14: error: implicit declaration of function 'kvm_vcpu_abt_tlbabort' [-Werror=implicit-function-declaration]
     } else if (!kvm_vcpu_abt_tlbabort(vcpu)){
                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/kvm_inject_tlbabort +1433 arch/arm/kvm/mmu.c

  1427		bool is_iabt, write_fault, writable;
  1428		gfn_t gfn;
  1429		int ret, idx;
  1430	
  1431		/* Check for TLB Conflict Abort */
  1432		if (kvm_vcpu_abt_tlbabort(vcpu)) {
> 1433			kvm_inject_tlbabort(vcpu);
  1434			return 1;
  1435		}
  1436	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19880 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170409/b42de759/attachment-0001.gz>
