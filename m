From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 4 Apr 2017 05:15:49 +0800
Subject: [kvmarm:master 1/3] arch/arm/kvm/mmu.c:302:14: error: 'S2_PUD_SIZE'
 undeclared
Message-ID: <201704040547.iQuSbIzK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git master
head:   1f1c45c6f66a586ca420ca02cbd93a35690394f9
commit: f9d9eb7f7a2c7e388861fe1cdb253f63e63555fe [1/3] kvm: arm/arm64: Fix locking for kvm_free_stage2_pgd
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f9d9eb7f7a2c7e388861fe1cdb253f63e63555fe
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/mmu.c: In function 'unmap_stage2_range':
>> arch/arm/kvm/mmu.c:302:14: error: 'S2_PUD_SIZE' undeclared (first use in this function)
      if (size > S2_PUD_SIZE)
                 ^~~~~~~~~~~
   arch/arm/kvm/mmu.c:302:14: note: each undeclared identifier is reported only once for each function it appears in

vim +/S2_PUD_SIZE +302 arch/arm/kvm/mmu.c

   296		pgd = kvm->arch.pgd + stage2_pgd_index(addr);
   297		do {
   298			/*
   299			 * If the range is too large, release the kvm->mmu_lock
   300			 * to prevent starvation and lockup detector warnings.
   301			 */
 > 302			if (size > S2_PUD_SIZE)
   303				cond_resched_lock(&kvm->mmu_lock);
   304			next = stage2_pgd_addr_end(addr, end);
   305			if (!stage2_pgd_none(*pgd))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19880 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/9aa271d1/attachment-0001.gz>
