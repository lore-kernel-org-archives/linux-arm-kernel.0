From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Sep 2017 05:57:27 +0800
Subject: [nomadik:input-mouse-gpio-descriptors 4/5]
 drivers/input/mouse/gpio_mouse.c:133:27: sparse: incompatible types for
 operation (>=)
Message-ID: <201709190525.nwSPoUvO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git input-mouse-gpio-descriptors
head:   8cae7ca7b0d5e96aa4fdade85593c71eb11dafac
commit: 5ff460b1d8f4cc8fab019d63c7a6672ac61d67ba [4/5] input: mouse: Convert GPIO mouse to use descriptors
reproduce:
        # apt-get install sparse
        git checkout 5ff460b1d8f4cc8fab019d63c7a6672ac61d67ba
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +133 drivers/input/mouse/gpio_mouse.c

5f565502 Hans-Christian Egtvedt 2007-06-14   71  
5298cc4c Bill Pemberton         2012-11-23   72  static int gpio_mouse_probe(struct platform_device *pdev)
5f565502 Hans-Christian Egtvedt 2007-06-14   73  {
e97212fa Linus Walleij          2017-09-17   74  	struct device *dev = &pdev->dev;
990e6f7d Linus Walleij          2017-09-17   75  	struct gpio_mouse *gmouse;
5f565502 Hans-Christian Egtvedt 2007-06-14   76  	struct input_polled_dev *input_poll;
5f565502 Hans-Christian Egtvedt 2007-06-14   77  	struct input_dev *input;
5ff460b1 Linus Walleij          2017-09-17   78  	int ret;
5f565502 Hans-Christian Egtvedt 2007-06-14   79  
990e6f7d Linus Walleij          2017-09-17   80  	gmouse = devm_kzalloc(dev, sizeof(*gmouse), GFP_KERNEL);
990e6f7d Linus Walleij          2017-09-17   81  	if (!gmouse)
e97212fa Linus Walleij          2017-09-17   82  		return -ENOMEM;
5f565502 Hans-Christian Egtvedt 2007-06-14   83  
5ff460b1 Linus Walleij          2017-09-17   84  	/* Assign some default scanning time */
5ff460b1 Linus Walleij          2017-09-17   85  	ret = device_property_read_u32(dev, "scan-interval",
5ff460b1 Linus Walleij          2017-09-17   86  				       &gmouse->scan_ms);
5ff460b1 Linus Walleij          2017-09-17   87  	if (ret || (gmouse->scan_ms == 0)) {
5ff460b1 Linus Walleij          2017-09-17   88  		dev_err(dev, "invalid scan time, set to 50 ms\n");
5ff460b1 Linus Walleij          2017-09-17   89  		gmouse->scan_ms = 50;
5f565502 Hans-Christian Egtvedt 2007-06-14   90  	}
5f565502 Hans-Christian Egtvedt 2007-06-14   91  
5ff460b1 Linus Walleij          2017-09-17   92  	/*
5ff460b1 Linus Walleij          2017-09-17   93  	 * These are compulsory GPIOs so bail out if any of them are
5ff460b1 Linus Walleij          2017-09-17   94  	 * not found.
5ff460b1 Linus Walleij          2017-09-17   95  	 */
5ff460b1 Linus Walleij          2017-09-17   96  	gmouse->up = devm_gpiod_get(dev, "up", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17   97  	if (IS_ERR(gmouse->up))
5ff460b1 Linus Walleij          2017-09-17   98  		return PTR_ERR(gmouse->up);
5ff460b1 Linus Walleij          2017-09-17   99  	gmouse->down = devm_gpiod_get(dev, "down", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  100  	if (IS_ERR(gmouse->down))
5ff460b1 Linus Walleij          2017-09-17  101  		return PTR_ERR(gmouse->down);
5ff460b1 Linus Walleij          2017-09-17  102  	gmouse->left = devm_gpiod_get(dev, "left", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  103  	if (IS_ERR(gmouse->left))
5ff460b1 Linus Walleij          2017-09-17  104  		return PTR_ERR(gmouse->left);
5ff460b1 Linus Walleij          2017-09-17  105  	gmouse->right = devm_gpiod_get(dev, "right", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  106  	if (IS_ERR(gmouse->right))
5ff460b1 Linus Walleij          2017-09-17  107  		return PTR_ERR(gmouse->right);
5ff460b1 Linus Walleij          2017-09-17  108  
5ff460b1 Linus Walleij          2017-09-17  109  	gmouse->bleft = devm_gpiod_get(dev, "button-left", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  110  	gmouse->bmiddle = devm_gpiod_get(dev, "button-middle", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  111  	gmouse->bright = devm_gpiod_get(dev, "button-right", GPIOD_IN);
5ff460b1 Linus Walleij          2017-09-17  112  
5ff460b1 Linus Walleij          2017-09-17  113  	input_poll = devm_input_allocate_polled_device(dev);
5f565502 Hans-Christian Egtvedt 2007-06-14  114  	if (!input_poll) {
5ff460b1 Linus Walleij          2017-09-17  115  		dev_err(dev, "not enough memory for input device\n");
5ff460b1 Linus Walleij          2017-09-17  116  		return -ENOMEM;
5f565502 Hans-Christian Egtvedt 2007-06-14  117  	}
5f565502 Hans-Christian Egtvedt 2007-06-14  118  
5f565502 Hans-Christian Egtvedt 2007-06-14  119  	platform_set_drvdata(pdev, input_poll);
5f565502 Hans-Christian Egtvedt 2007-06-14  120  
5f565502 Hans-Christian Egtvedt 2007-06-14  121  	/* set input-polldev handlers */
990e6f7d Linus Walleij          2017-09-17  122  	input_poll->private = gmouse;
5f565502 Hans-Christian Egtvedt 2007-06-14  123  	input_poll->poll = gpio_mouse_scan;
990e6f7d Linus Walleij          2017-09-17  124  	input_poll->poll_interval = gmouse->scan_ms;
5f565502 Hans-Christian Egtvedt 2007-06-14  125  
5f565502 Hans-Christian Egtvedt 2007-06-14  126  	input = input_poll->input;
5f565502 Hans-Christian Egtvedt 2007-06-14  127  	input->name = pdev->name;
5f565502 Hans-Christian Egtvedt 2007-06-14  128  	input->id.bustype = BUS_HOST;
5f565502 Hans-Christian Egtvedt 2007-06-14  129  	input->dev.parent = &pdev->dev;
5f565502 Hans-Christian Egtvedt 2007-06-14  130  
5f565502 Hans-Christian Egtvedt 2007-06-14  131  	input_set_capability(input, EV_REL, REL_X);
5f565502 Hans-Christian Egtvedt 2007-06-14  132  	input_set_capability(input, EV_REL, REL_Y);
990e6f7d Linus Walleij          2017-09-17 @133  	if (gmouse->bleft >= 0)
5f565502 Hans-Christian Egtvedt 2007-06-14  134  		input_set_capability(input, EV_KEY, BTN_LEFT);
990e6f7d Linus Walleij          2017-09-17  135  	if (gmouse->bmiddle >= 0)
5f565502 Hans-Christian Egtvedt 2007-06-14  136  		input_set_capability(input, EV_KEY, BTN_MIDDLE);
990e6f7d Linus Walleij          2017-09-17  137  	if (gmouse->bright >= 0)
5f565502 Hans-Christian Egtvedt 2007-06-14  138  		input_set_capability(input, EV_KEY, BTN_RIGHT);
5f565502 Hans-Christian Egtvedt 2007-06-14  139  
5ff460b1 Linus Walleij          2017-09-17  140  	ret = input_register_polled_device(input_poll);
5ff460b1 Linus Walleij          2017-09-17  141  	if (ret) {
5ff460b1 Linus Walleij          2017-09-17  142  		dev_err(dev, "could not register input device\n");
5ff460b1 Linus Walleij          2017-09-17  143  		return ret;
5f565502 Hans-Christian Egtvedt 2007-06-14  144  	}
5f565502 Hans-Christian Egtvedt 2007-06-14  145  
5ff460b1 Linus Walleij          2017-09-17  146  	dev_dbg(dev, "%d ms scan time, buttons: %s%s%s\n",
990e6f7d Linus Walleij          2017-09-17  147  		gmouse->scan_ms,
5ff460b1 Linus Walleij          2017-09-17  148  		IS_ERR(gmouse->bleft) ? "" : "left ",
5ff460b1 Linus Walleij          2017-09-17  149  		IS_ERR(gmouse->bmiddle) ? "" : "middle ",
5ff460b1 Linus Walleij          2017-09-17  150  		IS_ERR(gmouse->bright) ? "" : "right");
5f565502 Hans-Christian Egtvedt 2007-06-14  151  
5f565502 Hans-Christian Egtvedt 2007-06-14  152  	return 0;
5f565502 Hans-Christian Egtvedt 2007-06-14  153  }
5f565502 Hans-Christian Egtvedt 2007-06-14  154  

:::::: The code at line 133 was first introduced by commit
:::::: 990e6f7d2d2a01ea73c71b5240e70697ecd88dd0 input: mouse: Rename GPIO mouse variables

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
