From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Oct 2017 20:37:15 +0800
Subject: [arm-platforms:irq/irqchip-4.15 18/19]
 drivers//irqchip/irq-gic-v3-its.c:2782:3: warning: 'return' with no value,
 in function returning non-void
Message-ID: <201710182012.4BZyPBLb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.15
head:   0beae24927562ef40a444409d2a9a0d162a18ae7
commit: 698f0a9a6892cdce91cdf64389c0707452c0561c [18/19] irqchip/gic-v3-its: Limit scope of VPE mapping to be per ITS
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 698f0a9a6892cdce91cdf64389c0707452c0561c
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers//irqchip/irq-gic-v3-its.c: In function 'its_vpe_irq_domain_activate':
>> drivers//irqchip/irq-gic-v3-its.c:2782:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
      return;
      ^~~~~~
   drivers//irqchip/irq-gic-v3-its.c:2774:12: note: declared here
    static int its_vpe_irq_domain_activate(struct irq_domain *domain,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//irqchip/irq-gic-v3-its.c: At top level:
   drivers//irqchip/irq-gic-v3-its.c:2982:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
      .init = its_enable_quirk_hip07_161600802,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//irqchip/irq-gic-v3-its.c:2982:11: note: (near initialization for 'its_quirks[4].init')
   cc1: some warnings being treated as errors

vim +/return +2782 drivers//irqchip/irq-gic-v3-its.c

  2773	
  2774	static int its_vpe_irq_domain_activate(struct irq_domain *domain,
  2775					       struct irq_data *d, bool early)
  2776	{
  2777		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
  2778		struct its_node *its;
  2779	
  2780		/* If we use the list map, we issue VMAPP on demand... */
  2781		if (its_list_map)
> 2782			return;
  2783	
  2784		/* Map the VPE to the first possible CPU */
  2785		vpe->col_idx = cpumask_first(cpu_online_mask);
  2786	
  2787		list_for_each_entry(its, &its_nodes, entry) {
  2788			if (!its->is_v4)
  2789				continue;
  2790	
  2791			its_send_vmapp(its, vpe, true);
  2792			its_send_vinvall(its, vpe);
  2793		}
  2794	
  2795		return 0;
  2796	}
  2797	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/518179ea/attachment-0001.gz>
