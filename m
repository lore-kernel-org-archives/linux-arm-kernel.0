From: lkp@intel.com (kbuild test robot)
Date: Wed, 15 Jun 2016 08:00:51 +0800
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201606150738.QuuJosnS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on gpio/for-next]
[also build test ERROR on v4.7-rc3 next-20160614]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/gpio-omap-make-gpio-numbering-deterministical-by-using-of-aliases/20160614-180703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: arm-omap1_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
>> drivers/gpio/gpio-omap.c:1067:44: error: 'struct gpio_chip' has no member named 'of_node'
     gpio_alias_id = of_alias_get_id(bank->chip.of_node, "gpio");
                                               ^

vim +1067 drivers/gpio/gpio-omap.c

  1061		/*
  1062		 * Traditionally the base is given out in first-come-first-serve order.
  1063		 * This might shuffle the numbering of gpios if the probe order changes.
  1064		 * So make the base deterministical if the device tree specifies alias
  1065		 * ids.
  1066		 */
> 1067		gpio_alias_id = of_alias_get_id(bank->chip.of_node, "gpio");
  1068		if (gpio_alias_id >= 0)
  1069			bank->chip.base = bank->width * gpio_alias_id;
  1070	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19463 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/a9a6708f/attachment-0001.obj>
