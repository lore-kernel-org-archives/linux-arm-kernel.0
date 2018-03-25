From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Mar 2018 09:41:58 +0800
Subject: [PATCH v2 08/11] firmware: arm_sdei: Add ACPI GHES registration
 helper
In-Reply-To: <20180322181445.23298-9-james.morse@arm.com>
References: <20180322181445.23298-9-james.morse@arm.com>
Message-ID: <201803250913.XCBc2k7m%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

I love your patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.16-rc6]
[cannot apply to arm64/for-next/core next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/James-Morse/APEI-in_nmi-rework-and-arm64-SDEI-wire-up/20180325-064638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers//firmware/arm_sdei.c: In function 'sdei_register_ghes':
>> drivers//firmware/arm_sdei.c:921:26: error: 'FIX_APEI_GHES_SDEI_CRITICAL' undeclared (first use in this function)
      ghes->nmi_fixmap_idx = FIX_APEI_GHES_SDEI_CRITICAL;
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//firmware/arm_sdei.c:921:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers//firmware/arm_sdei.c:924:26: error: 'FIX_APEI_GHES_SDEI_NORMAL' undeclared (first use in this function); did you mean 'FIX_APEI_GHES_SDEI_CRITICAL'?
      ghes->nmi_fixmap_idx = FIX_APEI_GHES_SDEI_NORMAL;
                             ^~~~~~~~~~~~~~~~~~~~~~~~~
                             FIX_APEI_GHES_SDEI_CRITICAL

vim +/FIX_APEI_GHES_SDEI_CRITICAL +921 drivers//firmware/arm_sdei.c

   895	
   896	int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *cb)
   897	{
   898		int err;
   899		u32 event_num;
   900		u64 result;
   901	
   902		if (acpi_disabled)
   903			return -EOPNOTSUPP;
   904	
   905		event_num = ghes->generic->notify.vector;
   906		if (event_num == 0) {
   907			/*
   908			 * Event 0 is reserved by the specification for
   909			 * SDEI_EVENT_SIGNAL.
   910			 */
   911			return -EINVAL;
   912		}
   913	
   914		err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
   915					      &result);
   916		if (err)
   917			return err;
   918	
   919		if (result == SDEI_EVENT_PRIORITY_CRITICAL) {
   920			ghes->nmi_fixmap_lock = &sdei_ghes_fixmap_lock_critical;
 > 921			ghes->nmi_fixmap_idx = FIX_APEI_GHES_SDEI_CRITICAL;
   922		} else {
   923			ghes->nmi_fixmap_lock = &sdei_ghes_fixmap_lock_normal;
 > 924			ghes->nmi_fixmap_idx = FIX_APEI_GHES_SDEI_NORMAL;
   925		}
   926	
   927		err = sdei_event_register(event_num, cb, ghes);
   928		if (!err)
   929			err = sdei_event_enable(event_num);
   930	
   931		return err;
   932	}
   933	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59091 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180325/6faf7e54/attachment-0001.gz>
