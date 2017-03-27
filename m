From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Mar 2017 23:04:59 +0800
Subject: [PATCH v4 13/22] KVM: arm64: ITS:
 KVM_DEV_ARM_VGIC_GRP_ITS_TABLES group
In-Reply-To: <1490607072-21610-14-git-send-email-eric.auger@redhat.com>
Message-ID: <201703272354.OaYhCMvV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on kvmarm/next]
[also build test ERROR on v4.11-rc4 next-20170327]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/vITS-save-restore/20170327-195443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c: In function 'vgic_its_has_attr':
>> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1766:33: error: 'its' undeclared (first use in this function)
      return vgic_its_table_restore(its);
                                    ^~~
   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1766:33: note: each undeclared identifier is reported only once for each function it appears in

vim +/its +1766 arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c

  1750			case KVM_DEV_ARM_VGIC_CTRL_INIT:
  1751				return 0;
  1752			}
  1753			break;
  1754		case KVM_DEV_ARM_VGIC_GRP_ITS_REGS: {
  1755			u64 __user *uaddr = (u64 __user *)(long)attr->addr;
  1756			u64 reg;
  1757	
  1758			if (get_user(reg, uaddr))
  1759				return -EFAULT;
  1760	
  1761			return vgic_its_attr_regs_access(dev, attr, &reg, true);
  1762		}
  1763		case KVM_DEV_ARM_VGIC_GRP_ITS_TABLES:
  1764			if (attr->attr)
  1765				return -EINVAL;
> 1766			return vgic_its_table_restore(its);
  1767		}
  1768		return -ENXIO;
  1769	}
  1770	
  1771	static int vgic_its_set_attr(struct kvm_device *dev,
  1772				     struct kvm_device_attr *attr)
  1773	{
  1774		struct vgic_its *its = dev->private;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33916 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/bc1b0096/attachment-0001.gz>
