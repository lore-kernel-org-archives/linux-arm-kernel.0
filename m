From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Jul 2018 05:59:31 +0800
Subject: [PATCH 1/5] mfd: rk808: Add RK817 and RK809 support
In-Reply-To: <1532315945-1094-2-git-send-email-tony.xie@rock-chips.com>
References: <1532315945-1094-2-git-send-email-tony.xie@rock-chips.com>
Message-ID: <201807240507.gtlOvDOH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.18-rc6 next-20180723]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Xie/mfd-rk808-Add-RK817-and-RK809-support/20180724-040547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers//mfd/rk808.c: In function 'rk808_probe':
>> drivers//mfd/rk808.c:715:16: warning: 'pm_pwroff_fn' may be used uninitialized in this function [-Wmaybe-uninitialized]
      pm_power_off = pm_pwroff_fn;
      ~~~~~~~~~~~~~^~~~~~~~~~~~~~

vim +/pm_pwroff_fn +715 drivers//mfd/rk808.c

2eedcbfc0 Wadim Egorov    2016-08-29  581  
f69a7cf74 Chris Zhong     2014-09-03  582  static int rk808_probe(struct i2c_client *client,
f69a7cf74 Chris Zhong     2014-09-03  583  		       const struct i2c_device_id *id)
f69a7cf74 Chris Zhong     2014-09-03  584  {
f69a7cf74 Chris Zhong     2014-09-03  585  	struct device_node *np = client->dev.of_node;
f69a7cf74 Chris Zhong     2014-09-03  586  	struct rk808 *rk808;
2eedcbfc0 Wadim Egorov    2016-08-29  587  	const struct rk808_reg_data *pre_init_reg;
2eedcbfc0 Wadim Egorov    2016-08-29  588  	const struct mfd_cell *cells;
b2e2c8509 Jianhong Chen   2016-10-17  589  	void (*pm_pwroff_fn)(void);
2eedcbfc0 Wadim Egorov    2016-08-29  590  	int nr_pre_init_regs;
2eedcbfc0 Wadim Egorov    2016-08-29  591  	int nr_cells;
9d6105e19 Elaine Zhang    2017-08-21  592  	int pm_off = 0, msb, lsb;
1e99c2e53 Tony Xie        2018-07-23  593  	unsigned char pmic_id_msb = RK808_ID_MSB, pmic_id_lsb = RK808_ID_LSB;
f69a7cf74 Chris Zhong     2014-09-03  594  	int ret;
f69a7cf74 Chris Zhong     2014-09-03  595  	int i;
f69a7cf74 Chris Zhong     2014-09-03  596  
f69a7cf74 Chris Zhong     2014-09-03  597  	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
f69a7cf74 Chris Zhong     2014-09-03  598  	if (!rk808)
f69a7cf74 Chris Zhong     2014-09-03  599  		return -ENOMEM;
f69a7cf74 Chris Zhong     2014-09-03  600  
1e99c2e53 Tony Xie        2018-07-23  601  	if (of_device_is_compatible(np, "rockchip,rk817") ||
1e99c2e53 Tony Xie        2018-07-23  602  	    of_device_is_compatible(np, "rockchip,rk809")) {
1e99c2e53 Tony Xie        2018-07-23  603  		pmic_id_msb = RK817_ID_MSB;
1e99c2e53 Tony Xie        2018-07-23  604  		pmic_id_lsb = RK817_ID_LSB;
1e99c2e53 Tony Xie        2018-07-23  605  	}
9d6105e19 Elaine Zhang    2017-08-21  606  	/* Read chip variant */
1e99c2e53 Tony Xie        2018-07-23  607  	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
9d6105e19 Elaine Zhang    2017-08-21  608  	if (msb < 0) {
9d6105e19 Elaine Zhang    2017-08-21  609  		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
2eedcbfc0 Wadim Egorov    2016-08-29  610  			RK808_ID_MSB);
9d6105e19 Elaine Zhang    2017-08-21  611  		return msb;
2eedcbfc0 Wadim Egorov    2016-08-29  612  	}
2eedcbfc0 Wadim Egorov    2016-08-29  613  
1e99c2e53 Tony Xie        2018-07-23  614  	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
9d6105e19 Elaine Zhang    2017-08-21  615  	if (lsb < 0) {
9d6105e19 Elaine Zhang    2017-08-21  616  		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
9d6105e19 Elaine Zhang    2017-08-21  617  			RK808_ID_LSB);
9d6105e19 Elaine Zhang    2017-08-21  618  		return lsb;
9d6105e19 Elaine Zhang    2017-08-21  619  	}
9d6105e19 Elaine Zhang    2017-08-21  620  
9d6105e19 Elaine Zhang    2017-08-21  621  	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
9d6105e19 Elaine Zhang    2017-08-21  622  	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
2eedcbfc0 Wadim Egorov    2016-08-29  623  
2eedcbfc0 Wadim Egorov    2016-08-29  624  	switch (rk808->variant) {
990f05f6a Elaine Zhang    2017-08-21  625  	case RK805_ID:
990f05f6a Elaine Zhang    2017-08-21  626  		rk808->regmap_cfg = &rk805_regmap_config;
990f05f6a Elaine Zhang    2017-08-21  627  		rk808->regmap_irq_chip = &rk805_irq_chip;
990f05f6a Elaine Zhang    2017-08-21  628  		pre_init_reg = rk805_pre_init_reg;
990f05f6a Elaine Zhang    2017-08-21  629  		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
990f05f6a Elaine Zhang    2017-08-21  630  		cells = rk805s;
990f05f6a Elaine Zhang    2017-08-21  631  		nr_cells = ARRAY_SIZE(rk805s);
990f05f6a Elaine Zhang    2017-08-21  632  		pm_pwroff_fn = rk805_device_shutdown;
990f05f6a Elaine Zhang    2017-08-21  633  		break;
2eedcbfc0 Wadim Egorov    2016-08-29  634  	case RK808_ID:
2eedcbfc0 Wadim Egorov    2016-08-29  635  		rk808->regmap_cfg = &rk808_regmap_config;
2eedcbfc0 Wadim Egorov    2016-08-29  636  		rk808->regmap_irq_chip = &rk808_irq_chip;
2eedcbfc0 Wadim Egorov    2016-08-29  637  		pre_init_reg = rk808_pre_init_reg;
2eedcbfc0 Wadim Egorov    2016-08-29  638  		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
2eedcbfc0 Wadim Egorov    2016-08-29  639  		cells = rk808s;
2eedcbfc0 Wadim Egorov    2016-08-29  640  		nr_cells = ARRAY_SIZE(rk808s);
b2e2c8509 Jianhong Chen   2016-10-17  641  		pm_pwroff_fn = rk808_device_shutdown;
2eedcbfc0 Wadim Egorov    2016-08-29  642  		break;
2eedcbfc0 Wadim Egorov    2016-08-29  643  	case RK818_ID:
2eedcbfc0 Wadim Egorov    2016-08-29  644  		rk808->regmap_cfg = &rk818_regmap_config;
2eedcbfc0 Wadim Egorov    2016-08-29  645  		rk808->regmap_irq_chip = &rk818_irq_chip;
2eedcbfc0 Wadim Egorov    2016-08-29  646  		pre_init_reg = rk818_pre_init_reg;
2eedcbfc0 Wadim Egorov    2016-08-29  647  		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
2eedcbfc0 Wadim Egorov    2016-08-29  648  		cells = rk818s;
2eedcbfc0 Wadim Egorov    2016-08-29  649  		nr_cells = ARRAY_SIZE(rk818s);
b2e2c8509 Jianhong Chen   2016-10-17  650  		pm_pwroff_fn = rk818_device_shutdown;
2eedcbfc0 Wadim Egorov    2016-08-29  651  		break;
1e99c2e53 Tony Xie        2018-07-23  652  	case RK809_ID:
1e99c2e53 Tony Xie        2018-07-23  653  	case RK817_ID:
1e99c2e53 Tony Xie        2018-07-23  654  		rk808->regmap_cfg = &rk817_regmap_config;
1e99c2e53 Tony Xie        2018-07-23  655  		rk808->regmap_irq_chip = &rk817_irq_chip;
1e99c2e53 Tony Xie        2018-07-23  656  		pre_init_reg = rk817_pre_init_reg;
1e99c2e53 Tony Xie        2018-07-23  657  		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
1e99c2e53 Tony Xie        2018-07-23  658  		cells = rk817s;
1e99c2e53 Tony Xie        2018-07-23  659  		nr_cells = ARRAY_SIZE(rk817s);
1e99c2e53 Tony Xie        2018-07-23  660  		pm_power_off_prepare = rk8xx_device_shutdown_prepare;
1e99c2e53 Tony Xie        2018-07-23  661  		break;
2eedcbfc0 Wadim Egorov    2016-08-29  662  	default:
2eedcbfc0 Wadim Egorov    2016-08-29  663  		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
2eedcbfc0 Wadim Egorov    2016-08-29  664  			rk808->variant);
2eedcbfc0 Wadim Egorov    2016-08-29  665  		return -EINVAL;
2eedcbfc0 Wadim Egorov    2016-08-29  666  	}
2eedcbfc0 Wadim Egorov    2016-08-29  667  
2eedcbfc0 Wadim Egorov    2016-08-29  668  	rk808->i2c = client;
2eedcbfc0 Wadim Egorov    2016-08-29  669  	i2c_set_clientdata(client, rk808);
2eedcbfc0 Wadim Egorov    2016-08-29  670  
2eedcbfc0 Wadim Egorov    2016-08-29  671  	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
f69a7cf74 Chris Zhong     2014-09-03  672  	if (IS_ERR(rk808->regmap)) {
f69a7cf74 Chris Zhong     2014-09-03  673  		dev_err(&client->dev, "regmap initialization failed\n");
f69a7cf74 Chris Zhong     2014-09-03  674  		return PTR_ERR(rk808->regmap);
f69a7cf74 Chris Zhong     2014-09-03  675  	}
f69a7cf74 Chris Zhong     2014-09-03  676  
2eedcbfc0 Wadim Egorov    2016-08-29  677  	if (!client->irq) {
2eedcbfc0 Wadim Egorov    2016-08-29  678  		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
2eedcbfc0 Wadim Egorov    2016-08-29  679  		return -EINVAL;
f69a7cf74 Chris Zhong     2014-09-03  680  	}
f69a7cf74 Chris Zhong     2014-09-03  681  
f69a7cf74 Chris Zhong     2014-09-03  682  	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
f69a7cf74 Chris Zhong     2014-09-03  683  				  IRQF_ONESHOT, -1,
2eedcbfc0 Wadim Egorov    2016-08-29  684  				  rk808->regmap_irq_chip, &rk808->irq_data);
f69a7cf74 Chris Zhong     2014-09-03  685  	if (ret) {
f69a7cf74 Chris Zhong     2014-09-03  686  		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
f69a7cf74 Chris Zhong     2014-09-03  687  		return ret;
f69a7cf74 Chris Zhong     2014-09-03  688  	}
f69a7cf74 Chris Zhong     2014-09-03  689  
2eedcbfc0 Wadim Egorov    2016-08-29  690  	for (i = 0; i < nr_pre_init_regs; i++) {
2eedcbfc0 Wadim Egorov    2016-08-29  691  		ret = regmap_update_bits(rk808->regmap,
2eedcbfc0 Wadim Egorov    2016-08-29  692  					pre_init_reg[i].addr,
2eedcbfc0 Wadim Egorov    2016-08-29  693  					pre_init_reg[i].mask,
2eedcbfc0 Wadim Egorov    2016-08-29  694  					pre_init_reg[i].value);
2eedcbfc0 Wadim Egorov    2016-08-29  695  		if (ret) {
2eedcbfc0 Wadim Egorov    2016-08-29  696  			dev_err(&client->dev,
2eedcbfc0 Wadim Egorov    2016-08-29  697  				"0x%x write err\n",
2eedcbfc0 Wadim Egorov    2016-08-29  698  				pre_init_reg[i].addr);
2eedcbfc0 Wadim Egorov    2016-08-29  699  			return ret;
2eedcbfc0 Wadim Egorov    2016-08-29  700  		}
2eedcbfc0 Wadim Egorov    2016-08-29  701  	}
f69a7cf74 Chris Zhong     2014-09-03  702  
2eedcbfc0 Wadim Egorov    2016-08-29  703  	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
2eedcbfc0 Wadim Egorov    2016-08-29  704  			      cells, nr_cells, NULL, 0,
d5623161a Laxman Dewangan 2016-04-08  705  			      regmap_irq_get_domain(rk808->irq_data));
f69a7cf74 Chris Zhong     2014-09-03  706  	if (ret) {
f69a7cf74 Chris Zhong     2014-09-03  707  		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
f69a7cf74 Chris Zhong     2014-09-03  708  		goto err_irq;
f69a7cf74 Chris Zhong     2014-09-03  709  	}
f69a7cf74 Chris Zhong     2014-09-03  710  
f69a7cf74 Chris Zhong     2014-09-03  711  	pm_off = of_property_read_bool(np,
f69a7cf74 Chris Zhong     2014-09-03  712  				"rockchip,system-power-controller");
f69a7cf74 Chris Zhong     2014-09-03  713  	if (pm_off && !pm_power_off) {
f69a7cf74 Chris Zhong     2014-09-03  714  		rk808_i2c_client = client;
b2e2c8509 Jianhong Chen   2016-10-17 @715  		pm_power_off = pm_pwroff_fn;
f69a7cf74 Chris Zhong     2014-09-03  716  	}
f69a7cf74 Chris Zhong     2014-09-03  717  
f69a7cf74 Chris Zhong     2014-09-03  718  	return 0;
f69a7cf74 Chris Zhong     2014-09-03  719  
f69a7cf74 Chris Zhong     2014-09-03  720  err_irq:
f69a7cf74 Chris Zhong     2014-09-03  721  	regmap_del_irq_chip(client->irq, rk808->irq_data);
f69a7cf74 Chris Zhong     2014-09-03  722  	return ret;
f69a7cf74 Chris Zhong     2014-09-03  723  }
f69a7cf74 Chris Zhong     2014-09-03  724  

:::::: The code at line 715 was first introduced by commit
:::::: b2e2c85091710159b305735d557f4ef4695f5dff mfd: rk808: RK818 uses DEV_OFF to power off supplies

:::::: TO: Jianhong Chen <chenjh@rock-chips.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54212 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/3d22d6cb/attachment-0001.gz>
