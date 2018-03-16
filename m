From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Mar 2018 07:42:36 +0800
Subject: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
In-Reply-To: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
Message-ID: <201803170712.tkABPRQe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-JAILLET/net-ethernet-arc-Fix-a-potential-memory-leak-if-an-optional-regulator-is-deferred/20180317-042849
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/arc/emac_rockchip.c: In function 'emac_rockchip_probe':
>> drivers/net/ethernet/arc/emac_rockchip.c:173:4: error: 'ret' undeclared (first use in this function); did you mean 'net'?
       ret = -EPROBE_DEFER;
       ^~~
       net
   drivers/net/ethernet/arc/emac_rockchip.c:173:4: note: each undeclared identifier is reported only once for each function it appears in

vim +173 drivers/net/ethernet/arc/emac_rockchip.c

   102	
   103	static int emac_rockchip_probe(struct platform_device *pdev)
   104	{
   105		struct device *dev = &pdev->dev;
   106		struct net_device *ndev;
   107		struct rockchip_priv_data *priv;
   108		const struct of_device_id *match;
   109		u32 data;
   110		int err, interface;
   111	
   112		if (!pdev->dev.of_node)
   113			return -ENODEV;
   114	
   115		ndev = alloc_etherdev(sizeof(struct rockchip_priv_data));
   116		if (!ndev)
   117			return -ENOMEM;
   118		platform_set_drvdata(pdev, ndev);
   119		SET_NETDEV_DEV(ndev, dev);
   120	
   121		priv = netdev_priv(ndev);
   122		priv->emac.drv_name = DRV_NAME;
   123		priv->emac.drv_version = DRV_VERSION;
   124		priv->emac.set_mac_speed = emac_rockchip_set_mac_speed;
   125	
   126		interface = of_get_phy_mode(dev->of_node);
   127	
   128		/* RK3036/RK3066/RK3188 SoCs only support RMII */
   129		if (interface != PHY_INTERFACE_MODE_RMII) {
   130			dev_err(dev, "unsupported phy interface mode %d\n", interface);
   131			err = -ENOTSUPP;
   132			goto out_netdev;
   133		}
   134	
   135		priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
   136							    "rockchip,grf");
   137		if (IS_ERR(priv->grf)) {
   138			dev_err(dev, "failed to retrieve global register file (%ld)\n",
   139				PTR_ERR(priv->grf));
   140			err = PTR_ERR(priv->grf);
   141			goto out_netdev;
   142		}
   143	
   144		match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
   145		priv->soc_data = match->data;
   146	
   147		priv->emac.clk = devm_clk_get(dev, "hclk");
   148		if (IS_ERR(priv->emac.clk)) {
   149			dev_err(dev, "failed to retrieve host clock (%ld)\n",
   150				PTR_ERR(priv->emac.clk));
   151			err = PTR_ERR(priv->emac.clk);
   152			goto out_netdev;
   153		}
   154	
   155		priv->refclk = devm_clk_get(dev, "macref");
   156		if (IS_ERR(priv->refclk)) {
   157			dev_err(dev, "failed to retrieve reference clock (%ld)\n",
   158				PTR_ERR(priv->refclk));
   159			err = PTR_ERR(priv->refclk);
   160			goto out_netdev;
   161		}
   162	
   163		err = clk_prepare_enable(priv->refclk);
   164		if (err) {
   165			dev_err(dev, "failed to enable reference clock (%d)\n", err);
   166			goto out_netdev;
   167		}
   168	
   169		/* Optional regulator for PHY */
   170		priv->regulator = devm_regulator_get_optional(dev, "phy");
   171		if (IS_ERR(priv->regulator)) {
   172			if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
 > 173				ret = -EPROBE_DEFER;
   174				goto out_clk_disable;
   175			}
   176			dev_err(dev, "no regulator found\n");
   177			priv->regulator = NULL;
   178		}
   179	
   180		if (priv->regulator) {
   181			err = regulator_enable(priv->regulator);
   182			if (err) {
   183				dev_err(dev, "failed to enable phy-supply (%d)\n", err);
   184				goto out_clk_disable;
   185			}
   186		}
   187	
   188		/* Set speed 100M */
   189		data = (1 << (priv->soc_data->grf_speed_offset + 16)) |
   190		       (1 << priv->soc_data->grf_speed_offset);
   191		/* Set RMII mode */
   192		data |= (1 << (priv->soc_data->grf_mode_offset + 16)) |
   193			(0 << priv->soc_data->grf_mode_offset);
   194	
   195		err = regmap_write(priv->grf, priv->soc_data->grf_offset, data);
   196		if (err) {
   197			dev_err(dev, "unable to apply initial settings to grf (%d)\n",
   198				err);
   199			goto out_regulator_disable;
   200		}
   201	
   202		/* RMII interface needs always a rate of 50MHz */
   203		err = clk_set_rate(priv->refclk, 50000000);
   204		if (err) {
   205			dev_err(dev,
   206				"failed to change reference clock rate (%d)\n", err);
   207			goto out_regulator_disable;
   208		}
   209	
   210		if (priv->soc_data->need_div_macclk) {
   211			priv->macclk = devm_clk_get(dev, "macclk");
   212			if (IS_ERR(priv->macclk)) {
   213				dev_err(dev, "failed to retrieve mac clock (%ld)\n",
   214					PTR_ERR(priv->macclk));
   215				err = PTR_ERR(priv->macclk);
   216				goto out_regulator_disable;
   217			}
   218	
   219			err = clk_prepare_enable(priv->macclk);
   220			if (err) {
   221				dev_err(dev, "failed to enable mac clock (%d)\n", err);
   222				goto out_regulator_disable;
   223			}
   224	
   225			/* RMII TX/RX needs always a rate of 25MHz */
   226			err = clk_set_rate(priv->macclk, 25000000);
   227			if (err) {
   228				dev_err(dev,
   229					"failed to change mac clock rate (%d)\n", err);
   230				goto out_clk_disable_macclk;
   231			}
   232		}
   233	
   234		err = arc_emac_probe(ndev, interface);
   235		if (err) {
   236			dev_err(dev, "failed to probe arc emac (%d)\n", err);
   237			goto out_clk_disable_macclk;
   238		}
   239	
   240		return 0;
   241	
   242	out_clk_disable_macclk:
   243		if (priv->soc_data->need_div_macclk)
   244			clk_disable_unprepare(priv->macclk);
   245	out_regulator_disable:
   246		if (priv->regulator)
   247			regulator_disable(priv->regulator);
   248	out_clk_disable:
   249		clk_disable_unprepare(priv->refclk);
   250	out_netdev:
   251		free_netdev(ndev);
   252		return err;
   253	}
   254	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63084 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/dad09dbd/attachment-0001.gz>
