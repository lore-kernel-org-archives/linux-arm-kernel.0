From: lkp@intel.com (kbuild test robot)
Date: Fri, 8 Jun 2018 11:20:47 +0800
Subject: [PATCH v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <1528401833-29963-3-git-send-email-gengdongjiu@huawei.com>
References: <1528401833-29963-3-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201806081136.UoSCbcD1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.17]
[cannot apply to next-20180607]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/support-exception-state-migration-and-set-VSESR_EL2-by-user-space/20180608-063827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/guest.c: In function 'kvm_arm_vcpu_get_events':
>> arch/arm64/kvm/guest.c:295:26: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to dereference it? [-Wsizeof-pointer-memaccess]
     memset(events, 0, sizeof(events));
                             ^

vim +295 arch/arm64/kvm/guest.c

   291	
   292	int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
   293				struct kvm_vcpu_events *events)
   294	{
 > 295		memset(events, 0, sizeof(events));
   296	
   297		events->exception.serror_pending = !!(vcpu->arch.hcr_el2 & HCR_VSE);
   298		events->exception.serror_has_esr =
   299						cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
   300	
   301		if (events->exception.serror_pending &&
   302			events->exception.serror_has_esr)
   303			events->exception.serror_esr = vcpu_get_vsesr(vcpu);
   304		else
   305			events->exception.serror_esr = 0;
   306	
   307		return 0;
   308	}
   309	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37498 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180608/69ebaa7b/attachment-0001.gz>
