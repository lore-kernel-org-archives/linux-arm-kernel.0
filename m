From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Feb 2018 02:11:36 +0800
Subject: [PATCH v2 07/16] arm/arm64: KVM: Add PSCI version selection API
In-Reply-To: <20180129174559.1866-8-marc.zyngier@arm.com>
References: <20180129174559.1866-8-marc.zyngier@arm.com>
Message-ID: <201802010127.RqriruTy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I love your patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[cannot apply to kvmarm/next linus/master v4.15 next-20180126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marc-Zyngier/arm64-Add-SMCCC-v1-1-support-and-CVE-2017-5715-Spectre-variant-2-mitigation/20180131-234336
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Marc-Zyngier/arm64-Add-SMCCC-v1-1-support-and-CVE-2017-5715-Spectre-variant-2-mitigation/20180131-234336 HEAD 8c17f9fc363230480b44d05f728350e6fa448bd4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/psci.c: In function 'kvm_arm_get_fw_reg':
>> arch/arm64/kvm/../../../virt/kvm/arm/psci.c:443:9: error: too many arguments to function 'kvm_psci_version'
      val = kvm_psci_version(vcpu, vcpu->kvm);
            ^~~~~~~~~~~~~~~~
   arch/arm64/kvm/../../../virt/kvm/arm/psci.c:237:5: note: declared here
    int kvm_psci_version(struct kvm_vcpu *vcpu)
        ^~~~~~~~~~~~~~~~

vim +/kvm_psci_version +443 arch/arm64/kvm/../../../virt/kvm/arm/psci.c

   436	
   437	int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
   438	{
   439		if (reg->id == KVM_REG_ARM_PSCI_VERSION) {
   440			void __user *uaddr = (void __user *)(long)reg->addr;
   441			u64 val;
   442	
 > 443			val = kvm_psci_version(vcpu, vcpu->kvm);
   444			if (val == KVM_ARM_PSCI_0_1)
   445				return -EINVAL;
   446			if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
   447				return -EFAULT;
   448	
   449			return 0;
   450		}
   451	
   452		return -EINVAL;
   453	}
   454	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37478 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/15788a39/attachment-0001.gz>
