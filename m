From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 7 Dec 2017 01:44:04 +0800
Subject: [arm-platforms:kvm-arm64/haslr 10/20]
 arch/arm64/include/asm/kvm_mmu.h:104:27: error: macro "ALTERNATIVE_CB"
 requires 3 arguments, but only 1 given
Message-ID: <201712070158.kdh6efdr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/haslr
head:   983da603415991b6e7e7cd9b53cfa922bf052393
commit: e7f8236b93aede2dfe4c043ea6b8b149e17c30f8 [10/20] arm64: KVM: Dynamically patch the kernel/hyp VA mask
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e7f8236b93aede2dfe4c043ea6b8b149e17c30f8
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/haslr HEAD 983da603415991b6e7e7cd9b53cfa922bf052393 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/haslr.c:22:0:
   arch/arm64/include/asm/kvm_mmu.h: In function '__kern_hyp_va':
>> arch/arm64/include/asm/kvm_mmu.h:104:27: error: macro "ALTERNATIVE_CB" requires 3 arguments, but only 1 given
            kvm_update_va_mask)
                              ^
>> arch/arm64/include/asm/kvm_mmu.h:103:15: error: expected string literal before 'ALTERNATIVE_CB'
     asm volatile(ALTERNATIVE_CB("and %0, %0, #1\n"
                  ^~~~~~~~~~~~~~

vim +/ALTERNATIVE_CB +104 arch/arm64/include/asm/kvm_mmu.h

   100	
   101	static inline unsigned long __kern_hyp_va(unsigned long v)
   102	{
 > 103		asm volatile(ALTERNATIVE_CB("and %0, %0, #1\n"
 > 104					    kvm_update_va_mask)
   105			     : "+r" (v));
   106		return v;
   107	}
   108	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37460 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/e5e2c2f1/attachment-0001.gz>
