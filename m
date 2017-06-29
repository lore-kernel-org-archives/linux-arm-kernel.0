From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 29 Jun 2017 10:13:12 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 50/66]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:115: undefined reference
 to `its_map_vlpi'
Message-ID: <201706291001.jj1xvxdc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bcbe1ce47109136fda5a06bdc6c87fc5209defdc
commit: 72adc31604df8cf73af0e6981b87ac9f249257d4 [50/66] KVM: arm/arm64: GICv4: Wire mapping/unmapping of VLPIs in VFIO irq bypass
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 72adc31604df8cf73af0e6981b87ac9f249257d4
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `vgic_v4_init':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:42: undefined reference to `its_alloc_vcpu_irqs'
   arch/arm/kvm/built-in.o: In function `vgic_v4_teardown':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:57: undefined reference to `its_free_vcpu_irqs'
   arch/arm/kvm/built-in.o: In function `kvm_vgic_v4_set_forwarding':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:115: undefined reference to `its_map_vlpi'
   arch/arm/kvm/built-in.o: In function `kvm_vgic_v4_unset_forwarding':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:150: undefined reference to `its_unmap_vlpi'

vim +115 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c

    36	
    37		dist->its_vm.nr_vpes = nr_vcpus;
    38	
    39		kvm_for_each_vcpu(i, vcpu, kvm)
    40			dist->its_vm.vpes[i] = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
    41	
  > 42		ret = its_alloc_vcpu_irqs(&dist->its_vm);
    43		if (ret < 0) {
    44			kvm_err("VPE IRQ allocation failure\n");
    45			dist->its_vm.nr_vpes = 0;
    46			kfree(dist->its_vm.vpes);
    47			return ret;
    48		}
    49	
    50		return ret;
    51	}
    52	
    53	void vgic_v4_teardown(struct kvm *kvm)
    54	{
    55		struct its_vm *its_vm = &kvm->arch.vgic.its_vm;
    56	
    57		its_free_vcpu_irqs(its_vm);
    58		kfree(its_vm->vpes);
    59	}
    60	
    61	static struct vgic_its *vgic_get_its(struct kvm *kvm,
    62					     struct kvm_kernel_irq_routing_entry *irq_entry)
    63	{
    64		struct kvm_msi msi  = (struct kvm_msi) {
    65			.address_lo	= irq_entry->msi.address_lo,
    66			.address_hi	= irq_entry->msi.address_hi,
    67			.data		= irq_entry->msi.data,
    68			.flags		= irq_entry->msi.flags,
    69			.devid		= irq_entry->msi.devid,
    70		};
    71	
    72		/*
    73		 * Get a reference on the LPI. If NULL, this is not a valid
    74		 * translation for any of our vITSs.
    75		 */
    76		return vgic_msi_to_its(kvm, &msi);
    77	}
    78	
    79	int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
    80				       struct kvm_kernel_irq_routing_entry *irq_entry)
    81	{
    82		struct vgic_its *its;
    83		struct vgic_irq *irq;
    84		struct its_vlpi_map map;
    85		int ret;
    86	
    87		/*
    88		 * Get the LPI. If NULL, this is not a valid translation for
    89		 * any of our vITSs.
    90		 */
    91		its = vgic_get_its(kvm, irq_entry);
    92		if (!its)
    93			return 0;
    94	
    95		mutex_lock(&its->its_lock);
    96	
    97		ret = vgic_its_resolve_lpi(kvm, its, irq_entry->msi.devid,
    98					   irq_entry->msi.data, &irq);
    99		if (ret)
   100			goto out;
   101	
   102		/*
   103		 * Emit the mapping request. If it fails, the ITS probably
   104		 * isn't v4 compatible, so let's silently bail out. Holding
   105		 * the ITS lock should ensure that nothing can modify the
   106		 * target vcpu.
   107		 */
   108		map = (struct its_vlpi_map) {
   109			.vm		= &kvm->arch.vgic.its_vm,
   110			.vintid		= irq->intid,
   111			.db_enabled	= true,
   112			.vpe_idx	= irq->target_vcpu->vcpu_id,
   113		};
   114	
 > 115		if (its_map_vlpi(virq, &map))
   116			goto out;
   117	
   118		irq->hw		= true;
   119		irq->host_irq	= virq;
   120	
   121	out:
   122		mutex_unlock(&its->its_lock);
   123		return 0;
   124	}
   125	
   126	int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int virq,
   127					 struct kvm_kernel_irq_routing_entry *irq_entry)
   128	{
   129		struct vgic_its *its;
   130		struct vgic_irq *irq;
   131		int ret;
   132	
   133		/*
   134		 * Get the LPI. If NULL, this is not a valid translation for
   135		 * any of our vITSs.
   136		 */
   137		its = vgic_get_its(kvm, irq_entry);
   138		if (!its)
   139			return 0;
   140	
   141		mutex_lock(&its->its_lock);
   142	
   143		ret = vgic_its_resolve_lpi(kvm, its, irq_entry->msi.devid,
   144					   irq_entry->msi.data, &irq);
   145		if (ret)
   146			goto out;
   147	
   148		WARN_ON(!(irq->hw && irq->host_irq == virq));
   149		irq->hw = false;
 > 150		ret = its_unmap_vlpi(virq);
   151	
   152	out:
   153		mutex_unlock(&its->its_lock);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/87c779b4/attachment-0001.gz>
