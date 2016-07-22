From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Jul 2016 22:30:53 +0800
Subject: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
In-Reply-To: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
Message-ID: <201607222230.DZObarhu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.7-rc7 next-20160722]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/PM-OPP-optimize-dev_pm_opp_set_rate-a-bit/20160722-205339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':
>> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_max' may be used uninitialized in this function [-Wmaybe-uninitialized]
      _set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> drivers/base/power/opp/core.c:666:3: warning: 'ou_volt' may be used uninitialized in this function [-Wmaybe-uninitialized]

vim +/ou_volt_max +666 drivers/base/power/opp/core.c

6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  650  	if (freq < old_freq) {
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  651  		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  652  				       u_volt_max);
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  653  		if (ret)
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  654  			goto restore_freq;
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  655  	}
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  656  
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  657  	return 0;
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  658  
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  659  restore_freq:
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  660  	if (clk_set_rate(clk, old_freq))
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  661  		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  662  			__func__, old_freq);
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  663  restore_voltage:
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  664  	/* This shouldn't harm even if the voltages weren't updated earlier */
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  665  	if (!IS_ERR(old_opp))
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09 @666  		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  667  
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  668  	return ret;
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  669  }
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  670  EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
6a0712f6 drivers/base/power/opp/core.c Viresh Kumar 2016-02-09  671  
2c2709dc drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  672  /* OPP-dev Helpers */
2c2709dc drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  673  static void _kfree_opp_dev_rcu(struct rcu_head *head)
06441658 drivers/base/power/opp.c      Viresh Kumar 2015-07-29  674  {

:::::: The code at line 666 was first introduced by commit
:::::: 6a0712f6f199e737aa5913d28ec4bd3a25de9660 PM / OPP: Add dev_pm_opp_set_rate()

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54839 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/0211a3ca/attachment-0001.obj>
