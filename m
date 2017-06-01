From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Jun 2017 21:14:55 +0800
Subject: [PATCH] misc: atmel-ssc: Handle return value of
 clk_prepare_enable and clk_prepare
In-Reply-To: <cb2b3be8181a11c9d102bd2e7d4088e87f939e4d.1496302242.git.arvind.yadav.cs@gmail.com>
Message-ID: <201706012119.HeZzaVuo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind,

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.12-rc3 next-20170601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arvind-Yadav/misc-atmel-ssc-Handle-return-value-of-clk_prepare_enable-and-clk_prepare/20170601-191011
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/misc/atmel-ssc.c: In function 'ssc_request':
>> drivers/misc/atmel-ssc.c:67:3: warning: return makes pointer from integer without a cast
      return ret;
      ^

vim +67 drivers/misc/atmel-ssc.c

    51			spin_unlock(&user_lock);
    52			pr_err("ssc: ssc%d platform device is missing\n", ssc_num);
    53			return ERR_PTR(-ENODEV);
    54		}
    55	
    56		if (ssc->user) {
    57			spin_unlock(&user_lock);
    58			dev_dbg(&ssc->pdev->dev, "module busy\n");
    59			return ERR_PTR(-EBUSY);
    60		}
    61		ssc->user++;
    62		spin_unlock(&user_lock);
    63	
    64		ret = clk_prepare(ssc->clk);
    65		if (ret) {
    66			pr_err("Failed to prepare clock\n");
  > 67			return ret;
    68		}
    69	
    70		return ssc;
    71	}
    72	EXPORT_SYMBOL(ssc_request);
    73	
    74	void ssc_free(struct ssc_device *ssc)
    75	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50138 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/e788021c/attachment-0001.gz>
