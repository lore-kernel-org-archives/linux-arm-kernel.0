From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 May 2018 07:52:12 +0800
Subject: [PATCH 3/3] sh: add the sh_ prefix to early platform symbols
In-Reply-To: <20180430163556.2560-4-brgl@bgdev.pl>
References: <20180430163556.2560-4-brgl@bgdev.pl>
Message-ID: <201805010735.DbWU1fzw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180430]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/sh-make-early_platform-code-SuperH-specific/20180501-025442
config: powerpc64-allmodconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc64 

All errors (new ones prefixed by >>):

   drivers/clocksource/sh_cmt.c: In function 'sh_cmt_probe':
>> drivers/clocksource/sh_cmt.c:1046:7: error: implicit declaration of function 'is_sh_early_platform_device'; did you mean 'to_platform_device'? [-Werror=implicit-function-declaration]
     if (!is_sh_early_platform_device(pdev)) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
          to_platform_device
   drivers/clocksource/sh_cmt.c: At top level:
   drivers/clocksource/sh_cmt.c:1103:24: error: expected declaration specifiers or '...' before string constant
    sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
                           ^~~~~~~~~~~~
   drivers/clocksource/sh_cmt.c:1103:38: error: expected declaration specifiers or '...' before '&' token
    sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
                                         ^
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/sh-sci.c: In function 'sci_probe':
>> drivers/tty/serial/sh-sci.c:3196:6: error: implicit declaration of function 'is_sh_early_platform_device'; did you mean 'to_platform_device'? [-Werror=implicit-function-declaration]
     if (is_sh_early_platform_device(dev))
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         to_platform_device
   cc1: some warnings being treated as errors

vim +1046 drivers/clocksource/sh_cmt.c

  1040	
  1041	static int sh_cmt_probe(struct platform_device *pdev)
  1042	{
  1043		struct sh_cmt_device *cmt = platform_get_drvdata(pdev);
  1044		int ret;
  1045	
> 1046		if (!is_sh_early_platform_device(pdev)) {
  1047			pm_runtime_set_active(&pdev->dev);
  1048			pm_runtime_enable(&pdev->dev);
  1049		}
  1050	
  1051		if (cmt) {
  1052			dev_info(&pdev->dev, "kept as earlytimer\n");
  1053			goto out;
  1054		}
  1055	
  1056		cmt = kzalloc(sizeof(*cmt), GFP_KERNEL);
  1057		if (cmt == NULL)
  1058			return -ENOMEM;
  1059	
  1060		ret = sh_cmt_setup(cmt, pdev);
  1061		if (ret) {
  1062			kfree(cmt);
  1063			pm_runtime_idle(&pdev->dev);
  1064			return ret;
  1065		}
  1066		if (is_sh_early_platform_device(pdev))
  1067			return 0;
  1068	
  1069	 out:
  1070		if (cmt->has_clockevent || cmt->has_clocksource)
  1071			pm_runtime_irq_safe(&pdev->dev);
  1072		else
  1073			pm_runtime_idle(&pdev->dev);
  1074	
  1075		return 0;
  1076	}
  1077	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56210 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/d9a49b1e/attachment-0001.gz>
