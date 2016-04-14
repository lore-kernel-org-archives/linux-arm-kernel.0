From: lkp@intel.com (kbuild test robot)
Date: Thu, 14 Apr 2016 22:29:13 +0800
Subject: [PATCH] i2c: designware-platdrv: implement bus recovery
In-Reply-To: <1460642696-1858-1-git-send-email-jszhang@marvell.com>
Message-ID: <201604142235.VwuWAH5B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.6-rc3 next-20160414]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/i2c-designware-platdrv-implement-bus-recovery/20160414-221615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-designware-platdrv.c: In function 'i2c_dw_plat_prepare_recovery':
>> drivers/i2c/busses/i2c-designware-platdrv.c:156:2: error: implicit declaration of function 'pinctrl_select_state' [-Werror=implicit-function-declaration]
     pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
     ^
   drivers/i2c/busses/i2c-designware-platdrv.c: In function 'i2c_dw_plat_init_recovery_info':
>> drivers/i2c/busses/i2c-designware-platdrv.c:171:2: error: implicit declaration of function 'pinctrl_lookup_state' [-Werror=implicit-function-declaration]
     dev->pinctrl_pins_default = pinctrl_lookup_state(dev->pinctrl,
     ^
>> drivers/i2c/busses/i2c-designware-platdrv.c:172:4: error: 'PINCTRL_STATE_DEFAULT' undeclared (first use in this function)
       PINCTRL_STATE_DEFAULT);
       ^
   drivers/i2c/busses/i2c-designware-platdrv.c:172:4: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/i2c/busses/i2c-designware-platdrv.c:173:25: warning: assignment makes pointer from integer without a cast
     dev->pinctrl_pins_gpio = pinctrl_lookup_state(dev->pinctrl,
                            ^
   drivers/i2c/busses/i2c-designware-platdrv.c: In function 'dw_i2c_plat_probe':
>> drivers/i2c/busses/i2c-designware-platdrv.c:212:2: error: implicit declaration of function 'devm_pinctrl_get' [-Werror=implicit-function-declaration]
     dev->pinctrl = devm_pinctrl_get(&pdev->dev);
     ^
   drivers/i2c/busses/i2c-designware-platdrv.c:212:15: warning: assignment makes pointer from integer without a cast
     dev->pinctrl = devm_pinctrl_get(&pdev->dev);
                  ^
   cc1: some warnings being treated as errors

vim +/pinctrl_select_state +156 drivers/i2c/busses/i2c-designware-platdrv.c

   150	}
   151	
   152	static void i2c_dw_plat_prepare_recovery(struct i2c_adapter *adap)
   153	{
   154		struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
   155	
 > 156		pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
   157	}
   158	
   159	static void i2c_dw_plat_unprepare_recovery(struct i2c_adapter *adap)
   160	{
   161		struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
   162	
   163		pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
   164	}
   165	
   166	static void i2c_dw_plat_init_recovery_info(struct dw_i2c_dev *dev,
   167						   struct platform_device *pdev)
   168	{
   169		struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
   170	
 > 171		dev->pinctrl_pins_default = pinctrl_lookup_state(dev->pinctrl,
 > 172				PINCTRL_STATE_DEFAULT);
 > 173		dev->pinctrl_pins_gpio = pinctrl_lookup_state(dev->pinctrl,
   174				"gpio");
   175		rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
   176		rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
   177	
   178		if (!gpio_is_valid(rinfo->sda_gpio) ||
   179		    !gpio_is_valid(rinfo->scl_gpio) ||
   180		    IS_ERR(dev->pinctrl_pins_default) ||
   181		    IS_ERR(dev->pinctrl_pins_gpio)) {
   182			dev_dbg(&pdev->dev, "recovery information incomplete\n");
   183			return;
   184		}
   185	
   186		dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
   187			rinfo->sda_gpio, rinfo->scl_gpio);
   188	
   189		rinfo->prepare_recovery = i2c_dw_plat_prepare_recovery;
   190		rinfo->unprepare_recovery = i2c_dw_plat_unprepare_recovery;
   191		rinfo->recover_bus = i2c_generic_gpio_recovery;
   192		dev->adapter.bus_recovery_info = rinfo;
   193	}
   194	
   195	static int dw_i2c_plat_probe(struct platform_device *pdev)
   196	{
   197		struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
   198		struct dw_i2c_dev *dev;
   199		struct i2c_adapter *adap;
   200		struct resource *mem;
   201		int irq, r;
   202		u32 clk_freq, ht = 0;
   203	
   204		irq = platform_get_irq(pdev, 0);
   205		if (irq < 0)
   206			return irq;
   207	
   208		dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
   209		if (!dev)
   210			return -ENOMEM;
   211	
 > 212		dev->pinctrl = devm_pinctrl_get(&pdev->dev);
   213		if (IS_ERR(dev->pinctrl))
   214			return PTR_ERR(dev->pinctrl);
   215	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44878 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/c75c29a7/attachment-0001.obj>
