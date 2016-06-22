From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 23 Jun 2016 02:09:23 +0800
Subject: [stericsson:sensors 5/5] drivers/iio/magnetometer/ak8974.c:770:2:
 warning: this 'if' clause does not guard...
Message-ID: <201606230221.82DKFRCW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git sensors
head:   95dfbeefd550c325a8c1768e0747791a67b88d47
commit: 95dfbeefd550c325a8c1768e0747791a67b88d47 [5/5] iio: magn: add a driver for AK8974
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        git checkout 95dfbeefd550c325a8c1768e0747791a67b88d47
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/iio/magnetometer/ak8974.c: In function 'ak8974_runtime_resume':
>> drivers/iio/magnetometer/ak8974.c:770:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (ret)
     ^~
   drivers/iio/magnetometer/ak8974.c:772:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
      ^~~~~~~~~~~~~~~~~~~~~~

vim +/if +770 drivers/iio/magnetometer/ak8974.c

   754	{
   755		struct i2c_client *i2c = to_i2c_client(dev);
   756		struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
   757		struct ak8974 *ak8974 = iio_priv(indio_dev);
   758		int ret;
   759	
   760		ret = regulator_bulk_enable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
   761		if (ret)
   762			return ret;
   763		msleep(AK8974_POWERON_DELAY);
   764		ret = ak8974_set_power(ak8974, AK8974_PWR_ON);
   765		if (ret) {
   766			regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
   767			return ret;
   768		}
   769		ret = ak8974_configure(ak8974);
 > 770		if (ret)
   771			ak8974_set_power(ak8974, AK8974_PWR_OFF);
   772			regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
   773			return ret;
   774	
   775		return 0;
   776	}
   777	#endif /* CONFIG_PM */
   778	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54808 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/d4f6e1cb/attachment-0001.obj>
