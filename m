From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Jun 2017 01:24:49 +0800
Subject: [PATCH v2 2/4] spi: rockchip: add support for "cs-gpios" dts
 property
In-Reply-To: <1497331543-8565-2-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <201706140136.LWVD2FnX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.12-rc5 next-20170613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jeffy-Chen/spi-rockchip-fix-error-handling-when-probe/20170613-172725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: x86_64-randconfig-s5-06132355 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/spi/spi-rockchip.c: In function 'rockchip_spi_setup_cs_gpios':
>> drivers/spi/spi-rockchip.c:678:13: error: implicit declaration of function 'devm_gpiod_get_index_optional' [-Werror=implicit-function-declaration]
      cs_gpio = devm_gpiod_get_index_optional(dev, "cs",
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-rockchip.c:679:11: error: 'GPIOD_ASIS' undeclared (first use in this function)
           i, GPIOD_ASIS);
              ^~~~~~~~~~
   drivers/spi/spi-rockchip.c:679:11: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/devm_gpiod_get_index_optional +678 drivers/spi/spi-rockchip.c

   672		if (!np)
   673			return 0;
   674	
   675		nb = of_gpio_named_count(np, "cs-gpios");
   676		for (i = 0; i < nb; i++) {
   677			/* We support both GPIO CS and HW CS */
 > 678			cs_gpio = devm_gpiod_get_index_optional(dev, "cs",
 > 679								i, GPIOD_ASIS);
   680			if (IS_ERR(cs_gpio))
   681				return PTR_ERR(cs_gpio);
   682		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21781 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/12e03c32/attachment-0001.gz>
