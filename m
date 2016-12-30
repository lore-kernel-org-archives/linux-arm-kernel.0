From: lkp@intel.com (kbuild test robot)
Date: Fri, 30 Dec 2016 10:44:23 +0800
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161229224335.13531-2-cov@codeaurora.org>
Message-ID: <201612301000.Aevrg8rZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

[auto build test ERROR on next-20161224]
[also build test ERROR on v4.10-rc1]
[cannot apply to arm64/for-next/core v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christopher-Covington/arm64-Define-Falkor-v1-CPU/20161230-081412
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/context.c: In function 'flush_context':
>> arch/arm64/mm/context.c:93:13: error: 'CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID' undeclared (first use in this function)
      __set_bit(CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID, asid_map);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/mm/context.c:93:13: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm64/mm/context.c: In function 'asids_init':
   arch/arm64/mm/context.c:255:13: error: 'CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID' undeclared (first use in this function)
      __set_bit(CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID, asid_map);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID +93 arch/arm64/mm/context.c

    87		/* Update the list of reserved ASIDs and the ASID bitmap. */
    88		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
    89	
    90		/* Reserve ASID for Falkor erratum 1003 */
    91		if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_1003) &&
    92		    cpus_have_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
  > 93			__set_bit(CONFIG_QCOM_FALKOR_E1003_RESERVED_ASID, asid_map);
    94	
    95		/*
    96		 * Ensure the generation bump is observed before we xchg the

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6340 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161230/abb6797a/attachment.gz>
