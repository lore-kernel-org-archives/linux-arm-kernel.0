From: lkp@intel.com (kbuild test robot)
Date: Fri, 25 Nov 2016 18:52:31 +0800
Subject: [PATCH 01/10] power: supply: axp20x_usb_power: use of_device_id
 data field instead of device_is_compatible
In-Reply-To: <20161125090921.23138-2-quentin.schulz@free-electrons.com>
Message-ID: <201611251850.lfMksMrN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.9-rc6 next-20161124]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-VBUS-max-current-and-min-voltage-limits-AXP20X-and-AXP22X-PMICs/20161125-172224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-randconfig-s5-11251757 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/power/supply/axp20x_usb_power.c: In function 'axp20x_usb_power_probe':
>> drivers/power/supply/axp20x_usb_power.c:233:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     power->axp20x_id = (int)of_id->data;
                        ^

vim +233 drivers/power/supply/axp20x_usb_power.c

   217		if (!of_device_is_available(pdev->dev.of_node))
   218			return -ENODEV;
   219	
   220		of_id = of_match_device(axp20x_usb_power_match, &pdev->dev);
   221		if (!of_id)
   222			return -ENODEV;
   223	
   224		if (!axp20x) {
   225			dev_err(&pdev->dev, "Parent drvdata not set\n");
   226			return -EINVAL;
   227		}
   228	
   229		power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
   230		if (!power)
   231			return -ENOMEM;
   232	
 > 233		power->axp20x_id = (int)of_id->data;
   234	
   235		power->np = pdev->dev.of_node;
   236		power->regmap = axp20x->regmap;
   237	
   238		if (power->axp20x_id == AXP202_ID) {
   239			/* Enable vbus valid checking */
   240			ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
   241						 AXP20X_VBUS_MON_VBUS_VALID,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23302 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/f7be7673/attachment-0001.gz>
