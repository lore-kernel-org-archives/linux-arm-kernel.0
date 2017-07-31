From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 1 Aug 2017 06:59:29 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 44/69]
 drivers//irqchip/irq-gic-v4.c:104:13: error: implicit declaration of
 function 'task_pid_nr'
Message-ID: <201708010624.AIIgvIMH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bc92ecf019337ebc32b96a58145face5ae67d876
commit: aa416de26eb97c13d6810285671a2600a669c294 [44/69] irqchip/gic-v4: Enable low-level GICv4 operations
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout aa416de26eb97c13d6810285671a2600a669c294
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers//irqchip/irq-gic-v4.c: In function 'its_alloc_vcpu_irqs':
>> drivers//irqchip/irq-gic-v4.c:104:13: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
                task_pid_nr(current));
                ^~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/task_pid_nr +104 drivers//irqchip/irq-gic-v4.c

4e06995e Marc Zyngier 2016-12-20   98  
4e06995e Marc Zyngier 2016-12-20   99  int its_alloc_vcpu_irqs(struct its_vm *vm)
4e06995e Marc Zyngier 2016-12-20  100  {
4e06995e Marc Zyngier 2016-12-20  101  	int vpe_base_irq, i;
4e06995e Marc Zyngier 2016-12-20  102  
4e06995e Marc Zyngier 2016-12-20  103  	vm->fwnode = irq_domain_alloc_named_id_fwnode("GICv4-vpe",
4e06995e Marc Zyngier 2016-12-20 @104  						      task_pid_nr(current));
4e06995e Marc Zyngier 2016-12-20  105  	if (!vm->fwnode)
4e06995e Marc Zyngier 2016-12-20  106  		goto err;
4e06995e Marc Zyngier 2016-12-20  107  
4e06995e Marc Zyngier 2016-12-20  108  	vm->domain = irq_domain_create_hierarchy(gic_domain, 0, vm->nr_vpes,
4e06995e Marc Zyngier 2016-12-20  109  						 vm->fwnode, vpe_domain_ops,
4e06995e Marc Zyngier 2016-12-20  110  						 vm);
4e06995e Marc Zyngier 2016-12-20  111  	if (!vm->domain)
4e06995e Marc Zyngier 2016-12-20  112  		goto err;
4e06995e Marc Zyngier 2016-12-20  113  
4e06995e Marc Zyngier 2016-12-20  114  	for (i = 0; i < vm->nr_vpes; i++) {
4e06995e Marc Zyngier 2016-12-20  115  		vm->vpes[i]->its_vm = vm;
4e06995e Marc Zyngier 2016-12-20  116  		vm->vpes[i]->idai = true;
4e06995e Marc Zyngier 2016-12-20  117  	}
4e06995e Marc Zyngier 2016-12-20  118  
4e06995e Marc Zyngier 2016-12-20  119  	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
4e06995e Marc Zyngier 2016-12-20  120  					       NUMA_NO_NODE, vm,
4e06995e Marc Zyngier 2016-12-20  121  					       false, NULL);
4e06995e Marc Zyngier 2016-12-20  122  	if (vpe_base_irq <= 0)
4e06995e Marc Zyngier 2016-12-20  123  		goto err;
4e06995e Marc Zyngier 2016-12-20  124  
4e06995e Marc Zyngier 2016-12-20  125  	for (i = 0; i < vm->nr_vpes; i++)
4e06995e Marc Zyngier 2016-12-20  126  		vm->vpes[i]->irq = vpe_base_irq + i;
4e06995e Marc Zyngier 2016-12-20  127  
4e06995e Marc Zyngier 2016-12-20  128  	return 0;
4e06995e Marc Zyngier 2016-12-20  129  
4e06995e Marc Zyngier 2016-12-20  130  err:
4e06995e Marc Zyngier 2016-12-20  131  	if (vm->domain)
4e06995e Marc Zyngier 2016-12-20  132  		irq_domain_remove(vm->domain);
4e06995e Marc Zyngier 2016-12-20  133  	if (vm->fwnode)
4e06995e Marc Zyngier 2016-12-20  134  		irq_domain_free_fwnode(vm->fwnode);
4e06995e Marc Zyngier 2016-12-20  135  
4e06995e Marc Zyngier 2016-12-20  136  	return -ENOMEM;
4e06995e Marc Zyngier 2016-12-20  137  }
4e06995e Marc Zyngier 2016-12-20  138  

:::::: The code at line 104 was first introduced by commit
:::::: 4e06995e100a3c6a23ca8180f0d0e0959f7a8659 irqchip/gic-v4: Add per-VM VPE domain creation

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41850 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170801/d3af9596/attachment-0001.gz>
