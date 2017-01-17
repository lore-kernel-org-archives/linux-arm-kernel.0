From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 17 Jan 2017 20:07:25 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-wip 30/40]
 drivers/irqchip/irq-gic-v3-its.c:997:3: error: implicit declaration of
 function 'writeq_relaxed'
Message-ID: <201701172023.fsGJ81qG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-wip
head:   fed7acd3fb70199b1c28fa230ee4f92ed674dd12
commit: 650b00e0e6193450bc6f4734cfa630f85606aa3f [30/40] irqchip/gic-v3-its: Add VPE interrupt masking
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 650b00e0e6193450bc6f4734cfa630f85606aa3f
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'lpi_update_config':
>> drivers/irqchip/irq-gic-v3-its.c:997:3: error: implicit declaration of function 'writeq_relaxed' [-Werror=implicit-function-declaration]
      writeq_relaxed(d->hwirq, rdbase + GICR_INVLPIR);
      ^~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/irqchip/irq-gic-v3-its.c:18:
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_vpe_set_vcpu_affinity':
   include/linux/bitops.h:22:27: warning: right shift count is negative [-Wshift-count-negative]
     (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                              ^
   drivers/irqchip/irq-gic-v3-its.c:2171:54: note: in expansion of macro 'GENMASK'
      val  = virt_to_phys(page_address(vpe->vpt_page)) & GENMASK(51, 16);
                                                         ^~~~~~~
   cc1: some warnings being treated as errors

vim +/writeq_relaxed +997 drivers/irqchip/irq-gic-v3-its.c

   991			its_send_inv(its_dev, its_get_event_id(d));
   992		} else {
   993			struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
   994			void __iomem *rdbase;
   995	
   996			rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 > 997			writeq_relaxed(d->hwirq, rdbase + GICR_INVLPIR);
   998		}
   999	}
  1000	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39892 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/cc7230c7/attachment-0001.gz>
