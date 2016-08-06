From: lkp@intel.com (kbuild test robot)
Date: Sat, 6 Aug 2016 15:22:57 +0800
Subject: [PATCH 3/4] KVM: arm/arm64: Check for broadcast TLBI support
In-Reply-To: <1470302117-32296-4-git-send-email-mbrugger@suse.com>
Message-ID: <201608061524.SBmsYVTp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.7]
[cannot apply to next-20160805]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthias-Brugger/arm64-insn-Do-not-disable-irqs-during-patching/20160804-172016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/arm.c: In function 'kvm_arch_init':
>> arch/arm/kvm/arm.c:1378:6: error: implicit declaration of function 'cpus_have_cap' [-Werror=implicit-function-declaration]
     if (cpus_have_cap(ARM64_HAS_NO_BCAST_TLBI)) {
         ^
>> arch/arm/kvm/arm.c:1378:20: error: 'ARM64_HAS_NO_BCAST_TLBI' undeclared (first use in this function)
     if (cpus_have_cap(ARM64_HAS_NO_BCAST_TLBI)) {
                       ^
   arch/arm/kvm/arm.c:1378:20: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/cpus_have_cap +1378 arch/arm/kvm/arm.c

  1372	 */
  1373	int kvm_arch_init(void *opaque)
  1374	{
  1375		int err;
  1376		int ret, cpu;
  1377	
> 1378		if (cpus_have_cap(ARM64_HAS_NO_BCAST_TLBI)) {
  1379			kvm_err("Missing broadcast TLBI support.\n");
  1380			return -ENODEV;
  1381		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19020 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160806/3b2a684d/attachment-0001.obj>
