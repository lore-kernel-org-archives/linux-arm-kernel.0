From: lkp@intel.com (kbuild test robot)
Date: Thu, 4 Aug 2016 02:15:31 +0800
Subject: [PATCH] KVM: arm64: ITS: move ITS registration into first VCPU run
In-Reply-To: <20160803145745.7556-1-andre.przywara@arm.com>
Message-ID: <201608040210.JpIdp2ZQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

[auto build test ERROR on kvmarm/next]
[also build test ERROR on next-20160803]
[cannot apply to v4.7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andre-Przywara/KVM-arm64-ITS-move-ITS-registration-into-first-VCPU-run/20160803-235253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c: In function 'vgic_register_its_iodevs':
>> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1508:17: error: 'struct kvm' has no member named 'devices_lock'
     mutex_lock(&kvm->devices_lock);
                    ^
   arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1534:19: error: 'struct kvm' has no member named 'devices_lock'
     mutex_unlock(&kvm->devices_lock);
                      ^

vim +1508 arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c

  1502	 */
  1503	int vgic_register_its_iodevs(struct kvm *kvm)
  1504	{
  1505		struct kvm_device *dev;
  1506		int ret = 0;
  1507	
> 1508		mutex_lock(&kvm->devices_lock);
  1509	
  1510		list_for_each_entry(dev, &kvm->devices, vm_node) {
  1511			if (dev->ops != &kvm_arm_vgic_its_ops)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28732 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160804/0be659ad/attachment-0001.obj>
