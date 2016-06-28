From: lkp@intel.com (kbuild test robot)
Date: Tue, 28 Jun 2016 14:33:03 +0800
Subject: [PATCH v3 03/10] input: tps65218-pwrbutton: Add
 platform_device_id table
In-Reply-To: <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
Message-ID: <201606281452.QoZeqpzz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc5 next-20160627]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/mfd-tps65218-Clean-ups/20160628-141354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/input/misc/tps65218-pwrbutton.c:22:0:
>> include/linux/module.h:223:1: error: expected ',' or ';' before 'extern'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
    ^
>> drivers/input/misc/tps65218-pwrbutton.c:120:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
    ^

vim +/MODULE_DEVICE_TABLE +120 drivers/input/misc/tps65218-pwrbutton.c

    16	
    17	#include <linux/init.h>
    18	#include <linux/input.h>
    19	#include <linux/interrupt.h>
    20	#include <linux/kernel.h>
    21	#include <linux/mfd/tps65218.h>
  > 22	#include <linux/module.h>
    23	#include <linux/of.h>
    24	#include <linux/platform_device.h>
    25	#include <linux/regmap.h>
    26	#include <linux/slab.h>
    27	
    28	struct tps65218_pwrbutton {
    29		struct device *dev;
    30		struct tps65218 *tps;
    31		struct input_dev *idev;
    32	};
    33	
    34	static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
    35	{
    36		struct tps65218_pwrbutton *pwr = _pwr;
    37		unsigned int reg;
    38		int error;
    39	
    40		error = regmap_read(pwr->tps->regmap, TPS65218_REG_STATUS, &reg);
    41		if (error) {
    42			dev_err(pwr->dev, "can't read register: %d\n", error);
    43			goto out;
    44		}
    45	
    46		if (reg & TPS65218_STATUS_PB_STATE) {
    47			input_report_key(pwr->idev, KEY_POWER, 1);
    48			pm_wakeup_event(pwr->dev, 0);
    49		} else {
    50			input_report_key(pwr->idev, KEY_POWER, 0);
    51		}
    52	
    53		input_sync(pwr->idev);
    54	
    55	out:
    56		return IRQ_HANDLED;
    57	}
    58	
    59	static int tps65218_pwron_probe(struct platform_device *pdev)
    60	{
    61		struct tps65218 *tps = dev_get_drvdata(pdev->dev.parent);
    62		struct device *dev = &pdev->dev;
    63		struct tps65218_pwrbutton *pwr;
    64		struct input_dev *idev;
    65		int error;
    66		int irq;
    67	
    68		pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
    69		if (!pwr)
    70			return -ENOMEM;
    71	
    72		idev = devm_input_allocate_device(dev);
    73		if (!idev)
    74			return -ENOMEM;
    75	
    76		idev->name = "tps65218_pwrbutton";
    77		idev->phys = "tps65218_pwrbutton/input0";
    78		idev->dev.parent = dev;
    79		idev->id.bustype = BUS_I2C;
    80	
    81		input_set_capability(idev, EV_KEY, KEY_POWER);
    82	
    83		pwr->tps = tps;
    84		pwr->dev = dev;
    85		pwr->idev = idev;
    86		platform_set_drvdata(pdev, pwr);
    87		device_init_wakeup(dev, true);
    88	
    89		irq = platform_get_irq(pdev, 0);
    90		error = devm_request_threaded_irq(dev, irq, NULL, tps65218_pwr_irq,
    91						  IRQF_TRIGGER_RISING |
    92							IRQF_TRIGGER_FALLING |
    93							IRQF_ONESHOT,
    94						  "tps65218-pwrbutton", pwr);
    95		if (error) {
    96			dev_err(dev, "failed to request IRQ #%d: %d\n",
    97				irq, error);
    98			return error;
    99		}
   100	
   101		error= input_register_device(idev);
   102		if (error) {
   103			dev_err(dev, "Can't register power button: %d\n", error);
   104			return error;
   105		}
   106	
   107		return 0;
   108	}
   109	
   110	static const struct of_device_id of_tps65218_pwr_match[] = {
   111		{ .compatible = "ti,tps65218-pwrbutton" },
   112		{ },
   113	};
   114	MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
   115	
   116	static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
   117		{ "tps65218-pwrbutton", },
   118		{ /* sentinel */ }
   119	}
 > 120	MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
   121	
   122	static struct platform_driver tps65218_pwron_driver = {
   123		.probe	= tps65218_pwron_probe,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46347 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/589d1fe4/attachment-0001.obj>
