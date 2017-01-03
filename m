From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Jan 2017 19:20:57 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-wip 26/39]
 drivers/irqchip/irq-gic-v3-its.c:2053:3: error: implicit declaration of
 function 'writeq_relaxed'
Message-ID: <201701031954.tzozHjZJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-wip
head:   ff003d7a3416337cc037320bfd175aaee79f05ae
commit: 0c2bc9e2fd28b4be9bc1f4e7442e0926714994d3 [26/39] irqchip/gic-v3-its: Add VPE scheduling
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0c2bc9e2fd28b4be9bc1f4e7442e0926714994d3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/irqchip/irq-gic-v3-its.c:18:
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_vpe_set_vcpu_affinity':
>> include/linux/bitops.h:22:27: warning: right shift count is negative [-Wshift-count-negative]
     (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                              ^
>> drivers/irqchip/irq-gic-v3-its.c:2049:4: note: in expansion of macro 'GENMASK'
       GENMASK(51, 12);
       ^~~~~~~
>> drivers/irqchip/irq-gic-v3-its.c:2053:3: error: implicit declaration of function 'writeq_relaxed' [-Werror=implicit-function-declaration]
      writeq_relaxed(val, gic_data_rdist_vlpi_base() + GICR_VPROPBASER);
      ^~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/irqchip/irq-gic-v3-its.c:18:
>> include/linux/bitops.h:22:27: warning: right shift count is negative [-Wshift-count-negative]
     (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                              ^
   drivers/irqchip/irq-gic-v3-its.c:2055:54: note: in expansion of macro 'GENMASK'
      val  = virt_to_phys(page_address(vpe->vpt_page)) & GENMASK(51, 16);
                                                         ^~~~~~~
>> drivers/irqchip/irq-gic-v3-its.c:2069:9: error: implicit declaration of function 'readq_relaxed' [-Werror=implicit-function-declaration]
      val = readq_relaxed(gic_data_rdist_vlpi_base() + GICR_VPENDBASER);
            ^~~~~~~~~~~~~
   In file included from drivers/irqchip/irq-gic-v3-its.c:38:0:
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_probe_one':
   include/linux/irqchip/arm-gic-v3.h:308:32: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define GITS_TYPER_VMOVP  (1UL << 37)
                                   ^
   drivers/irqchip/irq-gic-v3-its.c:2416:30: note: in expansion of macro 'GITS_TYPER_VMOVP'
     if (its->is_v4 && !(typer & GITS_TYPER_VMOVP)) {
                                 ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/writeq_relaxed +2053 drivers/irqchip/irq-gic-v3-its.c

  2043	
  2044		switch (info->cmd_type) {
  2045		case SCHEDULE_VPE:
  2046		{
  2047			/* Schedule the VPE */
  2048			val  = virt_to_phys(page_address(vpe->its_vm->vprop_page)) &
> 2049				GENMASK(51, 12);
  2050			val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
  2051			val |= GICR_VPROPBASER_RaWb;
  2052			val |= GICR_VPROPBASER_InnerShareable;
> 2053			writeq_relaxed(val, gic_data_rdist_vlpi_base() + GICR_VPROPBASER);
  2054	
  2055			val  = virt_to_phys(page_address(vpe->vpt_page)) & GENMASK(51, 16);
  2056			val |= GICR_VPENDBASER_WaWb;
  2057			val |= GICR_VPENDBASER_NonShareable;
  2058			val |= GICR_PENDBASER_PendingLast;
  2059			val |= vpe->idai ? GICR_PENDBASER_IDAI : 0;
  2060			val |= GICR_PENDBASER_Valid;
  2061			writeq_relaxed(val, gic_data_rdist_vlpi_base() + GICR_VPENDBASER);
  2062	
  2063			return 0;
  2064		}
  2065	
  2066		case DESCHEDULE_VPE:
  2067		{
  2068			/* We're being scheduled out */
> 2069			val = readq_relaxed(gic_data_rdist_vlpi_base() + GICR_VPENDBASER);
  2070			val &= ~GICR_PENDBASER_Valid;
  2071			writeq_relaxed(val, gic_data_rdist_vlpi_base() + GICR_VPENDBASER);
  2072	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39862 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/e7d8f8c7/attachment-0001.gz>
