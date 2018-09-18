From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Sep 2018 06:56:58 +0800
Subject: [arm-platforms:kvm-arm64/nv-wip 108/116]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v2-nested.c:228:11: error:
 'KVM_VGIC_V2_HYP_SIZE' undeclared; did you mean 'KVM_VGIC_V2_CPU_SIZE'?
Message-ID: <201809190657.U9zRwSkJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip
head:   b7b336b71aac5dbb02b53a82e7032524ba292713
commit: a528c9e903228ced99ab50ff8589a5bb8826f6e5 [108/116] KVM: arm/arm64: register GICH iodev for the guest hypervisor
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a528c9e903228ced99ab50ff8589a5bb8826f6e5
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v2-nested.c: In function 'vgic_register_gich_iodev':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v2-nested.c:228:11: error: 'KVM_VGIC_V2_HYP_SIZE' undeclared (first use in this function); did you mean 'KVM_VGIC_V2_CPU_SIZE'?
              KVM_VGIC_V2_HYP_SIZE, &io_device->dev);
              ^~~~~~~~~~~~~~~~~~~~
              KVM_VGIC_V2_CPU_SIZE
   arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v2-nested.c:228:11: note: each undeclared identifier is reported only once for each function it appears in

vim +228 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-v2-nested.c

   208	
   209	int vgic_register_gich_iodev(struct kvm *kvm, struct vgic_dist *dist)
   210	{
   211		struct vgic_io_device *io_device = &kvm->arch.vgic.hyp_iodev;
   212		int ret = 0;
   213	
   214		if (!nested_virt_in_use(kvm->vcpus[0]))
   215			return 0;
   216	
   217		io_device->regions = vgic_v2_gich_registers;
   218		io_device->nr_regions = ARRAY_SIZE(vgic_v2_gich_registers);
   219		kvm_iodevice_init(&io_device->dev, &kvm_io_gic_ops);
   220	
   221		io_device->base_addr = kvm->arch.vgic.vgic_hyp_base;
   222		io_device->iodev_type = IODEV_GICH;
   223		io_device->redist_vcpu = NULL;
   224	
   225		mutex_lock(&kvm->slots_lock);
   226		ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS,
   227					      io_device->base_addr,
 > 228					      KVM_VGIC_V2_HYP_SIZE, &io_device->dev);
   229		mutex_unlock(&kvm->slots_lock);
   230	
   231		return ret;
   232	}
   233	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/2586e03d/attachment-0001.gz>
