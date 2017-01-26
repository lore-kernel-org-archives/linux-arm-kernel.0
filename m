From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Jan 2017 09:28:35 +0800
Subject: [PATCH v5 4/4] clk: samsung: exynos-audss: Use runtime PM
In-Reply-To: <1485345194-3196-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201701260921.yaPXh2GJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on next-20170125]
[cannot apply to v4.10-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marek-Szyprowski/Add-runtime-PM-support-for-clocks-on-Exynos-SoC-example/20170125-202948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:25:0,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/of_device.h:4,
                    from drivers/clk/samsung/clk-exynos-audss.c:17:
>> drivers/clk/samsung/clk-exynos-audss.c:285:21: error: 'exynos_audss_clk_suspend' undeclared here (not in a function)
     SET_RUNTIME_PM_OPS(exynos_audss_clk_suspend, exynos_audss_clk_resume,
                        ^
   include/linux/pm.h:359:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^~~~~~~~~~
>> drivers/clk/samsung/clk-exynos-audss.c:285:47: error: 'exynos_audss_clk_resume' undeclared here (not in a function)
     SET_RUNTIME_PM_OPS(exynos_audss_clk_suspend, exynos_audss_clk_resume,
                                                  ^
   include/linux/pm.h:360:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^~~~~~~~~

vim +/exynos_audss_clk_suspend +285 drivers/clk/samsung/clk-exynos-audss.c

   279			clk_disable_unprepare(epll);
   280	
   281		return 0;
   282	}
   283	
   284	static const struct dev_pm_ops exynos_audss_clk_pm_ops = {
 > 285		SET_RUNTIME_PM_OPS(exynos_audss_clk_suspend, exynos_audss_clk_resume,
   286				   NULL)
   287		SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
   288					     pm_runtime_force_resume)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43119 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/4393aa81/attachment-0001.gz>
