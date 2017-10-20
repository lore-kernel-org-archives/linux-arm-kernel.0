From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 21 Oct 2017 07:08:39 +0800
Subject: [arm-platforms:kvm-arm64/icache 3/10]
 arch/arm/include/asm/kvm_mmu.h:203:30: error: macro "__write_sysreg"
 requires 5 arguments, but only 2 given
Message-ID: <201710210736.FeEmkQR3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/icache
head:   d478d2fed087051f5b827ccb46e60bff529fb41f
commit: 483374ed3bf4a6f6f8a2bb21696c6e85b853e8a4 [3/10] arm: KVM: Add optimized PIPT icache flushing
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 483374ed3bf4a6f6f8a2bb21696c6e85b853e8a4
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/kvm_hyp.h:24:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/aarch32.c:26:
   arch/arm/include/asm/kvm_mmu.h: In function '__invalidate_icache_guest_page':
>> arch/arm/include/asm/kvm_mmu.h:203:30: error: macro "__write_sysreg" requires 5 arguments, but only 2 given
       write_sysreg(addr, ICIMVAU);
                                 ^
   In file included from arch/arm/include/asm/kvm_hyp.h:23:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/aarch32.c:26:
>> arch/arm/include/asm/cp15.h:65:31: error: '__write_sysreg' undeclared (first use in this function)
    #define write_sysreg(v, ...)  __write_sysreg(v, __VA_ARGS__)
                                  ^
>> arch/arm/include/asm/kvm_mmu.h:203:4: note: in expansion of macro 'write_sysreg'
       write_sysreg(addr, ICIMVAU);
       ^~~~~~~~~~~~
   arch/arm/include/asm/cp15.h:65:31: note: each undeclared identifier is reported only once for each function it appears in
    #define write_sysreg(v, ...)  __write_sysreg(v, __VA_ARGS__)
                                  ^
>> arch/arm/include/asm/kvm_mmu.h:203:4: note: in expansion of macro 'write_sysreg'
       write_sysreg(addr, ICIMVAU);
       ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/kvm_hyp.h:24:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/aarch32.c:26:
   arch/arm/include/asm/kvm_mmu.h:218:27: error: macro "__write_sysreg" requires 5 arguments, but only 2 given
      write_sysreg(0, BPIALLIS);
                              ^

vim +/__write_sysreg +203 arch/arm/include/asm/kvm_mmu.h

   157	
   158	static inline void __invalidate_icache_guest_page(struct kvm_vcpu *vcpu,
   159							  kvm_pfn_t pfn,
   160							  unsigned long size)
   161	{
   162		u32 iclsz;
   163	
   164		/*
   165		 * If we are going to insert an instruction page and the icache is
   166		 * either VIPT or PIPT, there is a potential problem where the host
   167		 * (or another VM) may have used the same page as this guest, and we
   168		 * read incorrect data from the icache.  If we're using a PIPT cache,
   169		 * we can invalidate just that page, but if we are using a VIPT cache
   170		 * we need to invalidate the entire icache - damn shame - as written
   171		 * in the ARM ARM (DDI 0406C.b - Page B3-1393).
   172		 *
   173		 * VIVT caches are tagged using both the ASID and the VMID and doesn't
   174		 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
   175		 */
   176	
   177		VM_BUG_ON(size & ~PAGE_MASK);
   178	
   179		if (icache_is_vivt_asid_tagged())
   180			return;
   181	
   182		if (!icache_is_pipt()) {
   183			/* any kind of VIPT cache */
   184			__flush_icache_all();
   185			return;
   186		}
   187	
   188		/*
   189		 * CTR IminLine contains Log2 of the number of words in the
   190		 * cache line, so we can get the number of words as
   191		 * 2 << (IminLine - 1).  To get the number of bytes, we
   192		 * multiply by 4 (the number of bytes in a 32-bit word), and
   193		 * get 4 << (IminLine).
   194		 */
   195		iclsz = 4 << (read_cpuid(CPUID_CACHETYPE) & 0xf);
   196	
   197		while (size) {
   198			void *va = kmap_atomic_pfn(pfn);
   199			void *end = va + PAGE_SIZE;
   200			void *addr = va;
   201	
   202			do {
 > 203				write_sysreg(addr, ICIMVAU);
   204				addr += iclsz;
   205			} while (addr < end);
   206	
   207			dsb(ishst);
   208			isb();
   209	
   210			size -= PAGE_SIZE;
   211			pfn++;
   212	
   213			kunmap_atomic(va);
   214		}
   215	
   216		/* Check if we need to invalidate the BTB */
   217		if ((read_cpuid_ext(CPUID_EXT_MMFR1) >> 28) != 4) {
   218			write_sysreg(0, BPIALLIS);
   219			dsb(ishst);
   220			isb();
   221		}
   222	}
   223	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20323 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171021/ee0c7100/attachment-0001.gz>
