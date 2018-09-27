From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Sep 2018 12:42:18 +0800
Subject: [arm-platforms:irq/gicv3-kdump 12/13]
 drivers//irqchip/irq-gic-v3-its.c:1659:11: error: implicit declaration of
 function 'gic_reserve_range'; did you mean 'free_reserved_page'?
Message-ID: <201809271217.rRFpC7FY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gicv3-kdump
head:   8bc67dad68a8d35bd9186eb4782df953da664a66
commit: 8af4c6c076d0f4c8469f3aab34aa93d638306d2b [12/13] irqchip/gic-v3-its: Register LPI tables with EFI config table
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8af4c6c076d0f4c8469f3aab34aa93d638306d2b
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

Note: the arm-platforms/irq/gicv3-kdump HEAD 8bc67dad68a8d35bd9186eb4782df953da664a66 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/bug.h:37:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from include/linux/resource_ext.h:19,
                    from include/linux/acpi.h:26,
                    from drivers//irqchip/irq-gic-v3-its.c:18:
   drivers//irqchip/irq-gic-v3-its.c: In function 'its_setup_lpi_prop_table':
>> drivers//irqchip/irq-gic-v3-its.c:1659:11: error: implicit declaration of function 'gic_reserve_range'; did you mean 'free_reserved_page'? [-Werror=implicit-function-declaration]
      WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
              ^
   include/asm-generic/bug.h:122:25: note: in definition of macro 'WARN_ON'
     int __ret_warn_on = !!(condition);    \
                            ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +1659 drivers//irqchip/irq-gic-v3-its.c

  1631	
  1632	static int __init its_setup_lpi_prop_table(void)
  1633	{
  1634		if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
  1635			u64 val;
  1636	
  1637			val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
  1638			lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
  1639	
  1640			gic_rdists->prop_table_pa = val & GENMASK_ULL(51, 12);
  1641			gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
  1642							     LPI_PROPBASE_SZ,
  1643							     MEMREMAP_WB);
  1644			gic_reset_prop_table(gic_rdists->prop_table_va);
  1645		} else {
  1646			struct page *page;
  1647	
  1648			lpi_id_bits = min_t(u32,
  1649					    GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
  1650					    ITS_MAX_LPI_NRBITS);
  1651			page = its_allocate_prop_table(GFP_NOWAIT);
  1652			if (!page) {
  1653				pr_err("Failed to allocate PROPBASE\n");
  1654				return -ENOMEM;
  1655			}
  1656	
  1657			gic_rdists->prop_table_pa = page_to_phys(page);
  1658			gic_rdists->prop_table_va = page_address(page);
> 1659			WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
  1660						  LPI_PROPBASE_SZ));
  1661		}
  1662	
  1663		pr_info("GICv3: using LPI property table @%pa\n",
  1664			&gic_rdists->prop_table_pa);
  1665	
  1666		return its_lpi_init(lpi_id_bits);
  1667	}
  1668	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40352 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180927/5dc8de3c/attachment-0001.gz>
