From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 03:46:45 +0800
Subject: [arm-platforms:irq/gicv3-kdump 17/17]
 drivers/irqchip/irq-gic-v3-its.c:1640:2: error: implicit declaration of
 function 'for_each_reserved_mem_region'; did you mean
 'efi_reserve_mem_region'?
Message-ID: <201807180342.gMa0tm35%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gicv3-kdump
head:   99c53b140fe1cb3e4ca20a7bed540d2ded20625b
commit: 99c53b140fe1cb3e4ca20a7bed540d2ded20625b [17/17] irqchip/gic-v3-its: Allow a kexec kernel to use EFI-reserved RD tables
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 99c53b140fe1cb3e4ca20a7bed540d2ded20625b
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'gic_check_reserved_range':
>> drivers/irqchip/irq-gic-v3-its.c:1640:2: error: implicit declaration of function 'for_each_reserved_mem_region'; did you mean 'efi_reserve_mem_region'? [-Werror=implicit-function-declaration]
     for_each_reserved_mem_region(i, &start, &end) {
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
     efi_reserve_mem_region
>> drivers/irqchip/irq-gic-v3-its.c:1640:48: error: expected ';' before '{' token
     for_each_reserved_mem_region(i, &start, &end) {
                                                   ^
   cc1: some warnings being treated as errors

vim +1640 drivers/irqchip/irq-gic-v3-its.c

  1632	
  1633	static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
  1634	{
  1635		phys_addr_t start, end, addr_end;
  1636		u64 i;
  1637	
  1638		addr_end = addr + size - 1;
  1639	
> 1640		for_each_reserved_mem_region(i, &start, &end) {
  1641			if (addr >= start && addr_end <= end)
  1642				return true;
  1643		}
  1644	
  1645		/* Not found, not a good sign... */
  1646		pr_warn("GICv3: Expected reserved range [%pa:%pa], not found\n",
  1647			&addr, &addr_end);
  1648		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
  1649		return false;
  1650	}
  1651	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6672 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/d93b090b/attachment.gz>
