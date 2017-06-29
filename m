From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 29 Jun 2017 11:52:44 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 60/66]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:111: undefined reference
 to `its_schedule_vpe'
Message-ID: <201706291138.1oevMSto%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bcbe1ce47109136fda5a06bdc6c87fc5209defdc
commit: 7309b9b89579a2f0433b76cd395fd31fc079031e [60/66] KVM: arm/arm64: GICv4: Hook vPE scheduling into vgic flush/sync
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7309b9b89579a2f0433b76cd395fd31fc079031e
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `vgic_v4_teardown':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:87: undefined reference to `its_free_vcpu_irqs'
   arch/arm/kvm/built-in.o: In function `vgic_v4_init':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:50: undefined reference to `its_alloc_vcpu_irqs'
   arch/arm/kvm/built-in.o: In function `vgic_v4_schedule':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:111: undefined reference to `its_schedule_vpe'
   arch/arm/kvm/built-in.o: In function `kvm_vgic_v4_set_forwarding':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:168: undefined reference to `its_map_vlpi'
   arch/arm/kvm/built-in.o: In function `kvm_vgic_v4_unset_forwarding':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:205: undefined reference to `its_unmap_vlpi'
   arch/arm/kvm/built-in.o: In function `its_free_ite':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:629: undefined reference to `its_unmap_vlpi'
   arch/arm/kvm/built-in.o: In function `update_lpi_config':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:299: undefined reference to `its_prop_update_vlpi'
   arch/arm/kvm/built-in.o: In function `vgic_its_cmd_handle_movi':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:714: undefined reference to `its_get_vlpi'
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:720: undefined reference to `its_map_vlpi'
   arch/arm/kvm/built-in.o: In function `vgic_its_cmd_handle_movall':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1186: undefined reference to `its_get_vlpi'
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1188: undefined reference to `its_map_vlpi'
   arch/arm/kvm/built-in.o: In function `vgic_its_cmd_handle_invall':
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1138: undefined reference to `its_invall_vpe'

vim +111 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c

    81	
    82		for (i = 0; i < its_vm->nr_vpes; i++) {
    83			vcpu = kvm_get_vcpu(kvm, i);
    84			free_irq(its_vm->vpes[i]->irq, vcpu);
    85		}
    86	
  > 87		its_free_vcpu_irqs(its_vm);
    88		kfree(its_vm->vpes);
    89	}
    90	
    91	int vgic_v4_schedule(struct kvm_vcpu *vcpu, bool on)
    92	{
    93		if (!(kvm_vgic_global_state.has_gicv4 && vgic_has_its(vcpu->kvm)))
    94			return 0;
    95	
    96		/*
    97		 * Before making the VPE resident, make sure the redistributor
    98		 * expects us here.
    99		 */
   100		if (on) {
   101			int irq = vcpu->arch.vgic_cpu.vgic_v3.its_vpe.irq;
   102			int err;
   103	
   104			err = irq_set_affinity(irq, cpumask_of(smp_processor_id()));
   105			if (err) {
   106				kvm_err("failed irq_set_affinity IRQ%d (%d)\n", irq, err);
   107				return err;
   108			}
   109		}
   110	
 > 111		return its_schedule_vpe(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe, on);
   112	}
   113	
   114	static struct vgic_its *vgic_get_its(struct kvm *kvm,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/f21fdab4/attachment-0001.gz>
