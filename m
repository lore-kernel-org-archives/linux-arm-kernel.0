From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Jun 2017 09:03:39 +0800
Subject: [PATCH v2] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <1498306822-2924-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201706260805.7Bmp3Y1k%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

[auto build test ERROR on kvm/linux-next]
[also build test ERROR on v4.12-rc6 next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/arm64-kvm-route-synchronous-external-abort-exceptions-to-el2/20170626-051545
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/../../../virt/kvm/arm/arm.c:45:0:
   arch/arm64/include/asm/kvm_emulate.h: In function 'vcpu_reset_hcr':
>> arch/arm64/include/asm/kvm_emulate.h:50:26: error: 'ARM64_HAS_RAS_EXTN' undeclared (first use in this function)
     if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN)) {
                             ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/kvm_emulate.h:50:26: note: each undeclared identifier is reported only once for each function it appears in

vim +/ARM64_HAS_RAS_EXTN +50 arch/arm64/include/asm/kvm_emulate.h

    44	
    45	static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
    46	{
    47		vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
    48		if (is_kernel_in_hyp_mode())
    49			vcpu->arch.hcr_el2 |= HCR_E2H;
  > 50		if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN)) {
    51			/* route synchronous external abort exceptions to EL2 */
    52			vcpu->arch.hcr_el2 |= HCR_TEA;
    53			/* trap error record accesses */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35202 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/e963afb9/attachment-0001.gz>
