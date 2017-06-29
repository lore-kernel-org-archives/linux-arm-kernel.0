From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 29 Jun 2017 08:36:37 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 48/66]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:42: undefined reference to
 `its_alloc_vcpu_irqs'
Message-ID: <201706290833.fBX24j3Z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bcbe1ce47109136fda5a06bdc6c87fc5209defdc
commit: d5387af9c16fb39e9030e2dd9b012fda07845914 [48/66] KVM: arm/arm64: GICv4: Add init and teardown of the vPE irq domain
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d5387af9c16fb39e9030e2dd9b012fda07845914
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `vgic_v4_init':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:42: undefined reference to `its_alloc_vcpu_irqs'
   arch/arm/kvm/built-in.o: In function `vgic_v4_teardown':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c:57: undefined reference to `its_free_vcpu_irqs'

vim +42 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v4.c

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
  > 57		its_free_vcpu_irqs(its_vm);
    58		kfree(its_vm->vpes);
    59	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/170b9011/attachment-0001.gz>
