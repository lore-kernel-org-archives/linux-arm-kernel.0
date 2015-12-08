From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 8 Dec 2015 17:36:18 +0800
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <201512081150.hIfZ22cp%fengguang.wu@intel.com>
References: <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
 <201512081150.hIfZ22cp%fengguang.wu@intel.com>
Message-ID: <20151208093617.GD16881@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 11:16:31AM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on v4.4-rc4 next-20151207]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Chen/USB-add-generic-onboard-USB-HUB-driver/20151208-094428
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: tile-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/usb/misc/generic_onboard_hub.c: In function 'usb_hub_generic_probe':
> >> drivers/usb/misc/generic_onboard_hub.c:76:3: error: implicit declaration of function 'devm_gpiod_get_optional'
> >> drivers/usb/misc/generic_onboard_hub.c:77:16: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
>    drivers/usb/misc/generic_onboard_hub.c:77:16: note: each undeclared identifier is reported only once for each function it appears in
> >> drivers/usb/misc/generic_onboard_hub.c:77:33: error: 'GPIOD_OUT_LOW' undeclared (first use in this function)
> >> drivers/usb/misc/generic_onboard_hub.c:95:5: error: implicit declaration of function 'gpio_to_desc'
> >> drivers/usb/misc/generic_onboard_hub.c:95:17: warning: assignment makes pointer from integer without a cast [enabled by default]
> >> drivers/usb/misc/generic_onboard_hub.c:114:3: error: implicit declaration of function 'gpiod_set_value'
>    cc1: some warnings being treated as errors
> 
> vim +/devm_gpiod_get_optional +76 drivers/usb/misc/generic_onboard_hub.c
> 
>     70			if (of_find_property(node, "hub-reset-active-high", NULL))
>     71				reset_pol = 1;
>     72	
>     73			of_property_read_u32(node, "hub-reset-duration-us",
>     74				&duration_us);
>     75	
>   > 76			gpiod_reset = devm_gpiod_get_optional(dev, "hub-reset",
>   > 77				reset_pol ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
>     78			ret = PTR_ERR_OR_ZERO(gpiod_reset);
>     79			if (ret) {
>     80				dev_err(dev, "Failed to get reset gpio, err = %d\n",
>     81					ret);
>     82				return ret;
>     83			}
>     84		} else if (pdata) {
>     85			hub_data->clk = pdata->ext_clk;
>     86			duration_us = pdata->gpio_reset_duration_us;
>     87			reset_pol = pdata->gpio_reset_polarity;
>     88	
>     89			if (gpio_is_valid(pdata->gpio_reset)) {
>     90				ret = devm_gpio_request_one(
>     91					dev, pdata->gpio_reset, reset_pol
>     92					? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
>     93					dev_name(dev));
>     94				if (!ret)
>   > 95					gpiod_reset = gpio_to_desc(pdata->gpio_reset);
>     96			}
>     97		}
>     98	
>     99		if (!IS_ERR(hub_data->clk)) {
>    100			ret = clk_prepare_enable(hub_data->clk);
>    101			if (ret) {
>    102				dev_err(dev,
>    103					"Can't enable external clock: %d\n",
>    104					ret);
>    105				return ret;
>    106			}
>    107		}
>    108	
>    109		if (gpiod_reset) {
>    110			/* Sanity check */
>    111			if (duration_us > 1000000)
>    112				duration_us = 50;
>    113			usleep_range(duration_us, duration_us + 100);
>  > 114			gpiod_set_value(gpiod_reset, reset_pol ? 0 : 1);
>    115		}
>    116	
>    117		dev_set_drvdata(dev, hub_data);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

I will add <linux/gpio/consumer.h> at header file list.


-- 

Best Regards,
Peter Chen
