From: lkp@intel.com (kbuild test robot)
Date: Fri, 31 Aug 2018 04:37:58 +0800
Subject: [rfc] leds: add TI LMU backlight driver
In-Reply-To: <20180829212032.GB15786@amd>
References: <20180829212032.GB15786@amd>
Message-ID: <201808310341.F8E7Fiqo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

I love your patch! Yet something to improve:

[auto build test ERROR on j.anaszewski-leds/for-next]
[also build test ERROR on v4.19-rc1 next-20180830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Machek/leds-add-TI-LMU-backlight-driver/20180830-220414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/leds/ti-lmu-backlight-core.c: In function 'ti_lmu_bl_init':
>> drivers/leds/ti-lmu-backlight-core.c:412:19: error: 'struct ti_lmu' has no member named 'backlight_initialized'
     if (lmu_bank->lmu->backlight_initialized)
                      ^~
   drivers/leds/ti-lmu-backlight-core.c:414:15: error: 'struct ti_lmu' has no member named 'backlight_initialized'
     lmu_bank->lmu->backlight_initialized = true;
                  ^~
   drivers/leds/ti-lmu-backlight-core.c: In function 'ti_lmu_bl_probe':
>> drivers/leds/ti-lmu-backlight-core.c:496:43: error: 'struct ti_lmu' has no member named 'id'
     lmu_bank->cfg = &lmu_bl_cfg[lmu_bank->lmu->id];
                                              ^~

vim +412 drivers/leds/ti-lmu-backlight-core.c

   403	
   404	static int ti_lmu_bl_init(struct ti_lmu_bank *lmu_bank)
   405	{
   406		struct regmap *regmap = lmu_bank->lmu->regmap;
   407		const struct lmu_bl_reg_data *regdata =
   408			lmu_bank->cfg->reginfo->init;
   409		int num_init = lmu_bank->cfg->reginfo->num_init;
   410		int i, ret;
   411	
 > 412		if (lmu_bank->lmu->backlight_initialized)
   413			return 0;
   414		lmu_bank->lmu->backlight_initialized = true;
   415	
   416		for (i = 0; regdata && i < num_init; i++) {
   417			ret = regmap_update_bits(regmap, regdata->reg, regdata->mask,
   418						 regdata->val);
   419			if (ret)
   420				return ret;
   421	
   422			regdata++;
   423		}
   424	
   425		return 0;
   426	}
   427	
   428	static int ti_lmu_bl_reload(struct ti_lmu_bank *lmu_bank)
   429	{
   430		int err;
   431	
   432		ti_lmu_bl_init(lmu_bank);
   433	
   434		err = ti_lmu_bl_configure(lmu_bank);
   435		if (err)
   436			return err;
   437	
   438		printk("lmu: set_brightness %d\n", lmu_bank->default_brightness);		
   439		return ti_lmu_bl_set_brightness(lmu_bank, lmu_bank->current_brightness);
   440	}
   441	
   442	static int ti_lmu_bl_monitor_notifier(struct notifier_block *nb,
   443						     unsigned long action, void *unused)
   444	{
   445		struct ti_lmu_bank *lmu_bank = container_of(nb, struct ti_lmu_bank, nb);
   446	
   447		if (action == LMU_EVENT_MONITOR_DONE) {
   448			if (ti_lmu_bl_reload(lmu_bank))
   449				return NOTIFY_STOP;
   450		}
   451	
   452		return NOTIFY_OK;
   453	}
   454	
   455	static int ti_lmu_bl_probe(struct platform_device *pdev)
   456	{
   457		struct ti_lmu_bank *lmu_bank;
   458		int err;
   459	
   460		printk("lmu: bl probe\n");
   461		err = setup_of_node(pdev);
   462		if (err)
   463			return err;
   464	
   465		printk("lmu: bank\n");	
   466		lmu_bank = devm_kzalloc(&pdev->dev, sizeof(*lmu_bank), GFP_KERNEL);
   467		if (!lmu_bank)
   468			return -ENOMEM;
   469		lmu_bank->dev = &pdev->dev;
   470		dev_set_drvdata(&pdev->dev, lmu_bank);
   471	
   472		err = device_property_read_string(&pdev->dev, "label",
   473						  &lmu_bank->label);
   474		if (err)
   475			return err;
   476	
   477		if (!strcmp(lmu_bank->label, "keyboard")) {
   478			lmu_bank->label = "kbd_backlight";
   479		} else
   480			lmu_bank->default_brightness = 255;
   481	
   482		lmu_bank->leds = ti_lmu_parse_led_sources(&pdev->dev);
   483		if (lmu_bank->leds < 0)
   484			return lmu_bank->leds;
   485		else if (lmu_bank->leds == 0)
   486			return -EINVAL;
   487	
   488		device_property_read_u32(&pdev->dev, "default-brightness-level",
   489					 &lmu_bank->default_brightness);
   490		device_property_read_u32(&pdev->dev, "ti,ramp-up-ms",
   491					 &lmu_bank->ramp_up_msec);
   492		device_property_read_u32(&pdev->dev, "ti,ramp-down-ms",
   493					 &lmu_bank->ramp_down_msec);
   494		
   495		lmu_bank->lmu = dev_get_drvdata(pdev->dev.parent);
 > 496		lmu_bank->cfg = &lmu_bl_cfg[lmu_bank->lmu->id];
   497		lmu_bank->bank_id = pdev->id;
   498	
   499		ti_lmu_bl_init(lmu_bank);
   500	
   501		err = ti_lmu_bl_configure(lmu_bank);
   502		if (err)
   503			return err;
   504	
   505		err = ti_lmu_bl_add_device(lmu_bank);
   506		if (err)
   507			return err;
   508	
   509		printk("lmu: brightness\n");		
   510		err = ti_lmu_bl_set_brightness(lmu_bank,
   511						      lmu_bank->default_brightness);
   512		if (err)
   513			return err;
   514	
   515		/*
   516		 * Notifier callback is required because backlight device needs
   517		 * reconfiguration after fault detection procedure is done by
   518		 * ti-lmu-fault-monitor driver.
   519		 */
   520		if (lmu_bank->cfg->fault_monitor_used) {
   521			lmu_bank->nb.notifier_call = ti_lmu_bl_monitor_notifier;
   522			err = blocking_notifier_chain_register(&lmu_bank->lmu->notifier,
   523							       &lmu_bank->nb);
   524			if (err)
   525				return err;
   526		}
   527	
   528		return 0;
   529	}
   530	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65148 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/0dfdcd01/attachment-0001.gz>
