From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Aug 2016 21:00:54 +0800
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
Message-ID: <201608262046.PdVznvgd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on next-20160825]
[cannot apply to v4.8-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Anson-Huang/Add-SMP-support-for-i-MX7D/20160826-140342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/built-in.o: In function `imx_enable_cpu':
>> arch/arm/mach-imx/src.c:103: undefined reference to `imx_gpcv2_set_core1_pdn_pup_by_software'

vim +103 arch/arm/mach-imx/src.c

    97		u32 mask, val;
    98	
    99		cpu = cpu_logical_map(cpu);
   100		spin_lock(&scr_lock);
   101		if (cpu_is_imx7d()) {
   102			if (enable)
 > 103				imx_gpcv2_set_core1_pdn_pup_by_software(false);
   104			mask = 1 << (BP_SRC_A7RCR1_A7_CORE1_ENABLE + cpu - 1);
   105			val = readl_relaxed(src_base + SRC_A7RCR1);
   106			val = enable ? val | mask : val & ~mask;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29845 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160826/bb7e3530/attachment-0001.obj>
