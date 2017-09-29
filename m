From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Sep 2017 01:27:23 +0800
Subject: [PATCH v2 03/10] pinctrl: axp209: use drv_data of
 pinctrl_pin_desc to store pin reg
In-Reply-To: <7993a30fbc2e50a2d228fa0c8fad643c4034b101.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <201709300118.XqpYF5ya%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-pinmuxing-support-for-pins-in-AXP209-and-AXP813-PMICs/20170929-162846
base:    
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers//pinctrl/pinctrl-axp209.c: In function 'axp20x_gpio_get_direction':
>> drivers//pinctrl/pinctrl-axp209.c:136:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     int reg = (int)gpio->desc->pins[offset].pin.drv_data;
               ^
   drivers//pinctrl/pinctrl-axp209.c: In function 'axp20x_gpio_set':
   drivers//pinctrl/pinctrl-axp209.c:171:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     int reg = (int)gpio->desc->pins[offset].pin.drv_data;
               ^
   drivers//pinctrl/pinctrl-axp209.c: In function 'axp20x_pmx_set':
   drivers//pinctrl/pinctrl-axp209.c:183:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     int reg = (int)gpio->desc->pins[offset].pin.drv_data;
               ^

vim +136 drivers//pinctrl/pinctrl-axp209.c

   132	
   133	static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
   134	{
   135		struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 > 136		int reg = (int)gpio->desc->pins[offset].pin.drv_data;
   137		unsigned int val;
   138		int ret;
   139	
   140		ret = regmap_read(gpio->regmap, reg, &val);
   141		if (ret)
   142			return ret;
   143	
   144		/*
   145		 * This shouldn't really happen if the pin is in use already,
   146		 * or if it's not in use yet, it doesn't matter since we're
   147		 * going to change the value soon anyway. Default to output.
   148		 */
   149		if ((val & AXP20X_GPIO_FUNCTIONS) > 2)
   150			return 0;
   151	
   152		/*
   153		 * The GPIO directions are the three lowest values.
   154		 * 2 is input, 0 and 1 are output
   155		 */
   156		return val & 2;
   157	}
   158	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57613 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170930/e25f335d/attachment-0001.gz>
