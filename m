From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 26 Jun 2017 03:32:55 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 24/45]
 arch/arm/include/asm/arch_gicv3.h:308:12: error: 'GICR_PENDBASER_Valid'
 undeclared
Message-ID: <201706260342.V7b7OYma%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   6930e5891d9ee6507e03e79a72d419e48c3f89cc
commit: 342a8047aea9902a6d67d5d00ea97fb4ea16c8f8 [24/45] irqchip/gic-v3-its: Add VPENDBASER/VPROPBASER accessors
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 342a8047aea9902a6d67d5d00ea97fb4ea16c8f8
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-platforms/kvm-arm64/gicv4-kvm HEAD 6930e5891d9ee6507e03e79a72d419e48c3f89cc builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from include/linux/irqchip/arm-gic-v3.h:489:0,
                    from drivers//pci/host/pcie-iproc.c:24:
   arch/arm/include/asm/arch_gicv3.h: In function 'gits_write_vpendbaser':
>> arch/arm/include/asm/arch_gicv3.h:308:12: error: 'GICR_PENDBASER_Valid' undeclared (first use in this function)
     if (tmp & GICR_PENDBASER_Valid) {
               ^~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:308:12: note: each undeclared identifier is reported only once for each function it appears in

vim +/GICR_PENDBASER_Valid +308 arch/arm/include/asm/arch_gicv3.h

   302	 */
   303	static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
   304	{
   305		u32 tmp;
   306	
   307		tmp = readl_relaxed(addr + 4);
 > 308		if (tmp & GICR_PENDBASER_Valid) {
   309			tmp &= ~GICR_PENDBASER_Valid;
   310			writel_relaxed(tmp, addr + 4);
   311		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41289 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/3877cc9a/attachment-0001.gz>
