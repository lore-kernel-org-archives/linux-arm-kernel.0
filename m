From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 29 Oct 2016 00:45:31 +0800
Subject: [arm-platforms:kvm-arm64/fixes-4.9 2/3]
 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio.c:483: undefined reference
 to `__aeabi_uldivmod'
Message-ID: <201610290027.gd3IPY1z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/fixes-4.9
head:   3f3ed5826900f2f078417f8cf855c5977c3b28ea
commit: 465c188f7bc881c095448e8c2b16688b02ac5c3c [2/3] KVM: arm/arm64: vgic: Prevent access to invalid SPIs
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 465c188f7bc881c095448e8c2b16688b02ac5c3c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/built-in.o: In function `check_region':
>> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio.c:483: undefined reference to `__aeabi_uldivmod'

vim +483 arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio.c

   467		case 4:
   468			if (!((region->access_flags & VGIC_ACCESS_32bit) && !(addr & 3)))
   469				return false;
   470			break;
   471		case 8:
   472			if (!((region->access_flags & VGIC_ACCESS_64bit) && !(addr & 7)))
   473				return false;
   474			break;
   475		default:
   476			return false;
   477		}
   478	
   479		if (!region->bits_per_irq)
   480			return true;
   481	
   482		/* Do we access a non-allocated IRQ? */
 > 483		return VGIC_ADDR_TO_INTID(addr, region->bits_per_irq) < nr_irqs;
   484	}
   485	
   486	static int dispatch_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
   487				      gpa_t addr, int len, void *val)
   488	{
   489		struct vgic_io_device *iodev = kvm_to_vgic_iodev(dev);
   490		const struct vgic_register_region *region;
   491		unsigned long data = 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19528 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161029/e5e15c7f/attachment-0001.gz>
