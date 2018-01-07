From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 8 Jan 2018 03:03:33 +0800
Subject: [arm-platforms:kvm-arm64/haslr 17/22]
 arch/arm/kvm/../../../virt/kvm/arm/mmu.c:754:33: error: 'VA_BITS'
 undeclared; did you mean 'NMI_BITS'?
Message-ID: <201801080332.8CfUIMf2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/haslr
head:   b6f07d796000cff9e69657e2369c1adbad6a72a2
commit: 326f33852915935d41ade2e8f55fbed2cdfaabe3 [17/22] KVM: arm/arm64: Move HYP IO VAs to the "idmap" range
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 326f33852915935d41ade2e8f55fbed2cdfaabe3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/mman.h:5,
                    from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:19:
   arch/arm/kvm/../../../virt/kvm/arm/mmu.c: In function 'create_hyp_io_mappings':
>> arch/arm/kvm/../../../virt/kvm/arm/mmu.c:754:33: error: 'VA_BITS' undeclared (first use in this function); did you mean 'NMI_BITS'?
     if ((base ^ io_map_base) & BIT(VA_BITS - 1)) {
                                    ^
   include/linux/bitops.h:7:28: note: in definition of macro 'BIT'
    #define BIT(nr)   (1UL << (nr))
                               ^~
   arch/arm/kvm/../../../virt/kvm/arm/mmu.c:754:33: note: each undeclared identifier is reported only once for each function it appears in
     if ((base ^ io_map_base) & BIT(VA_BITS - 1)) {
                                    ^
   include/linux/bitops.h:7:28: note: in definition of macro 'BIT'
    #define BIT(nr)   (1UL << (nr))
                               ^~

vim +754 arch/arm/kvm/../../../virt/kvm/arm/mmu.c

   717	
   718	/**
   719	 * create_hyp_io_mappings - Map IO into both kernel and HYP
   720	 * @phys_addr:	The physical start address which gets mapped
   721	 * @size:	Size of the region being mapped
   722	 * @kaddr:	Kernel VA for this mapping
   723	 * @haddr:	HYP VA for this mapping
   724	 *
   725	 * The resulting HYP VA is completely unrelated to the kernel VA.
   726	 */
   727	int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
   728				   void __iomem **kaddr,
   729				   void __iomem **haddr)
   730	{
   731		pgd_t *pgd = hyp_pgd;
   732		unsigned long base;
   733		int ret;
   734	
   735		*kaddr = ioremap(phys_addr, size);
   736		if (!*kaddr)
   737			return -ENOMEM;
   738	
   739		if (is_kernel_in_hyp_mode()) {
   740			*haddr = *kaddr;
   741			return 0;
   742		}
   743	
   744		mutex_lock(&io_map_lock);
   745	
   746		base = io_map_base - size;
   747		base &= ~(size - 1);
   748	
   749		/*
   750		 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
   751		 * allocating the new area, as it would indicate we've
   752		 * overflowed the idmap/IO address range.
   753		 */
 > 754		if ((base ^ io_map_base) & BIT(VA_BITS - 1)) {
   755			ret = -ENOMEM;
   756			goto out;
   757		}
   758	
   759		if (__kvm_cpu_uses_extended_idmap())
   760			pgd = boot_hyp_pgd;
   761	
   762		ret = __create_hyp_mappings(pgd, base, base + size,
   763					     __phys_to_pfn(phys_addr), PAGE_HYP_DEVICE);
   764	
   765		if (!ret) {
   766			*haddr = (void __iomem *)base;
   767			io_map_base = base;
   768		}
   769	
   770	out:
   771		mutex_unlock(&io_map_lock);
   772	
   773		if (ret) {
   774			iounmap(*kaddr);
   775			*kaddr = NULL;
   776		}
   777	
   778		return ret;
   779	}
   780	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20369 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/25c1278e/attachment-0001.gz>
