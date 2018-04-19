From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Apr 2018 02:59:07 +0800
Subject: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
In-Reply-To: <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <201804200133.omtxKqzI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc1 next-20180419]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/PECI-device-driver-introduction/20180411-180018
config: x86_64-randconfig-s0-04192349 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers//peci/peci-core.c: In function 'peci_device_match':
>> drivers//peci/peci-core.c:739:6: error: implicit declaration of function 'peci_of_match_device' [-Werror=implicit-function-declaration]
     if (peci_of_match_device(drv->of_match_table, client))
         ^~~~~~~~~~~~~~~~~~~~
   At top level:
   drivers//peci/peci-core.c:840:28: warning: 'peci_new_device' defined but not used [-Wunused-function]
    static struct peci_client *peci_new_device(struct peci_adapter *adapter,
                               ^~~~~~~~~~~~~~~
   drivers//peci/peci-core.c:135:29: warning: 'peci_verify_adapter' defined but not used [-Wunused-function]
    static struct peci_adapter *peci_verify_adapter(struct device *dev)
                                ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/peci_of_match_device +739 drivers//peci/peci-core.c

   732	
   733	static int peci_device_match(struct device *dev, struct device_driver *drv)
   734	{
   735		struct peci_client *client = peci_verify_client(dev);
   736		struct peci_driver *driver;
   737	
   738		/* Attempt an OF style match */
 > 739		if (peci_of_match_device(drv->of_match_table, client))
   740			return 1;
   741	
   742		driver = to_peci_driver(drv);
   743	
   744		if (peci_match_id(driver->id_table, client))
   745			return 1;
   746	
   747		return 0;
   748	}
   749	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26598 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/f3bade5a/attachment-0001.gz>
