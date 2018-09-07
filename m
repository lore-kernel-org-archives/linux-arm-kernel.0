From: lkp@intel.com (kbuild test robot)
Date: Fri, 7 Sep 2018 12:57:49 +0800
Subject: [PATCH 05/13] nvmem: change the signature of nvmem_unregister()
In-Reply-To: <20180905095738.26406-6-brgl@bgdev.pl>
References: <20180905095738.26406-6-brgl@bgdev.pl>
Message-ID: <201809071229.wdsqKzQM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180907-112400
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   drivers//nvmem/mxs-ocotp.c: In function 'mxs_ocotp_remove':
>> drivers//nvmem/mxs-ocotp.c:202:9: error: void value not ignored as it ought to be
     return nvmem_unregister(otp->nvmem);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers//nvmem/mxs-ocotp.c:203:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +202 drivers//nvmem/mxs-ocotp.c

c01e9a11 Stefan Wahren 2015-09-30  195  
c01e9a11 Stefan Wahren 2015-09-30  196  static int mxs_ocotp_remove(struct platform_device *pdev)
c01e9a11 Stefan Wahren 2015-09-30  197  {
c01e9a11 Stefan Wahren 2015-09-30  198  	struct mxs_ocotp *otp = platform_get_drvdata(pdev);
c01e9a11 Stefan Wahren 2015-09-30  199  
c01e9a11 Stefan Wahren 2015-09-30  200  	clk_unprepare(otp->clk);
c01e9a11 Stefan Wahren 2015-09-30  201  
c01e9a11 Stefan Wahren 2015-09-30 @202  	return nvmem_unregister(otp->nvmem);
c01e9a11 Stefan Wahren 2015-09-30 @203  }
c01e9a11 Stefan Wahren 2015-09-30  204  

:::::: The code at line 202 was first introduced by commit
:::::: c01e9a11ab6f3096a54574c3224d8732a374f135 nvmem: add driver for ocotp in i.MX23 and i.MX28

:::::: TO: Stefan Wahren <stefan.wahren@i2se.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54957 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/68865a99/attachment-0001.gz>
