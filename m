From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 22:21:01 +0800
Subject: [PATCH 2/6] regulator: core: introduce function to lock
 regulators and its supplies
In-Reply-To: <1443621946-8712-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201509302240.9Pm4jp0Q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: x86_64-randconfig-i0-201539 (attached as .config)
reproduce:
  git checkout 70f6f03239f72ac3a34fad792af5200c613f4dbc
  # save the attached .config to linux build tree
  make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/regulator/core.c: In function 'regulator_lock_supply':
>> drivers/regulator/core.c:141:6: warning: unused variable 'i' [-Wunused-variable]
     int i = 0;
         ^
   drivers/regulator/core.c: At top level:
   drivers/regulator/core.c:138:13: warning: 'regulator_lock_supply' defined but not used [-Wunused-function]
    static void regulator_lock_supply(struct regulator_dev *rdev)
                ^
   drivers/regulator/core.c:158:13: warning: 'regulator_unlock_supply' defined but not used [-Wunused-function]
    static void regulator_unlock_supply(struct regulator_dev *rdev)
                ^

vim +/i +141 drivers/regulator/core.c

   125		else
   126			return "";
   127	}
   128	
   129	static bool have_full_constraints(void)
   130	{
   131		return has_full_constraints || of_have_populated_dt();
   132	}
   133	
   134	/**
   135	 * regulator_lock_supply - lock a regulator and its supplies
   136	 * @rdev:         regulator source
   137	 */
   138	static void regulator_lock_supply(struct regulator_dev *rdev)
   139	{
   140		struct regulator *supply;
 > 141		int i = 0;
   142	
   143		while (1) {
   144			mutex_lock_nested(&rdev->mutex, i++);
   145			supply = rdev->supply;
   146	
   147			if (!rdev->supply)
   148				return;
   149	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25033 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/39223bfc/attachment-0001.obj>
