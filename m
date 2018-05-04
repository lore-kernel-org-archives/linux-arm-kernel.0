From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 May 2018 01:51:25 +0800
Subject: [PATCH 2/4] phy: rockchip-typec: support variable phy config value
In-Reply-To: <1525421338-1021-2-git-send-email-hl@rock-chips.com>
References: <1525421338-1021-2-git-send-email-hl@rock-chips.com>
Message-ID: <201805050142.oFVRtcS4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/drm-rockchip-add-transfer-function-for-cdn-dp/20180504-235745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers/phy/rockchip/phy-rockchip-typec.c: In function 'rockchip_typec_phy_probe':
>> drivers/phy/rockchip/phy-rockchip-typec.c:1227:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       tcphy->port_cfgs = &phy_cfgs[index];
                        ^
   drivers/phy/rockchip/phy-rockchip-typec.c: In function 'tcphy_cfg_dp_pll.isra.2':
>> drivers/phy/rockchip/phy-rockchip-typec.c:512:6: warning: 'clk_ctrl' may be used uninitialized in this function [-Wmaybe-uninitialized]
     u32 clk_ctrl;
         ^~~~~~~~
>> drivers/phy/rockchip/phy-rockchip-typec.c:511:18: warning: 'phy_cfg' may be used uninitialized in this function [-Wmaybe-uninitialized]
     struct phy_reg *phy_cfg;
                     ^~~~~~~

vim +/const +1227 drivers/phy/rockchip/phy-rockchip-typec.c

e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1194  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1195  static int rockchip_typec_phy_probe(struct platform_device *pdev)
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1196  {
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1197  	struct device *dev = &pdev->dev;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1198  	struct device_node *np = dev->of_node;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1199  	struct device_node *child_np;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1200  	struct rockchip_typec_phy *tcphy;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1201  	struct phy_provider *phy_provider;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1202  	struct resource *res;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1203  	const struct rockchip_usb3phy_port_cfg *phy_cfgs;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1204  	const struct of_device_id *match;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1205  	int index, ret;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1206  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1207  	tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1208  	if (!tcphy)
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1209  		return -ENOMEM;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1210  
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1211  	match = of_match_device(dev->driver->of_match_table, dev);
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1212  	if (!match || !match->data) {
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1213  		dev_err(dev, "phy configs are not assigned!\n");
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1214  		return -EINVAL;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1215  	}
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1216  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1217  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1218  	tcphy->base = devm_ioremap_resource(dev, res);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1219  	if (IS_ERR(tcphy->base))
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1220  		return PTR_ERR(tcphy->base);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1221  
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1222  	phy_cfgs = match->data;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1223  	/* find out a proper config which can be matched with dt. */
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1224  	index = 0;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1225  	while (phy_cfgs[index].reg) {
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1226  		if (phy_cfgs[index].reg == res->start) {
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16 @1227  			tcphy->port_cfgs = &phy_cfgs[index];
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1228  			break;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1229  		}
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1230  
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1231  		++index;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1232  	}
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1233  
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1234  	if (!tcphy->port_cfgs) {
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1235  		dev_err(dev, "no phy-config can be matched with %s node\n",
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1236  			np->name);
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1237  		return -EINVAL;
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1238  	}
0fbc47d9 drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-02-16  1239  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1240  	ret = tcphy_parse_dt(tcphy, dev);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1241  	if (ret)
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1242  		return ret;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1243  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1244  	tcphy->dev = dev;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1245  	platform_set_drvdata(pdev, tcphy);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1246  	mutex_init(&tcphy->lock);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1247  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1248  	typec_phy_pre_init(tcphy);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1249  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1250  	tcphy->extcon = extcon_get_edev_by_phandle(dev, 0);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1251  	if (IS_ERR(tcphy->extcon)) {
ec1fcd7b drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-03-01  1252  		if (PTR_ERR(tcphy->extcon) == -ENODEV) {
ec1fcd7b drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-03-01  1253  			tcphy->extcon = NULL;
ec1fcd7b drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-03-01  1254  		} else {
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1255  			if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1256  				dev_err(dev, "Invalid or missing extcon\n");
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1257  			return PTR_ERR(tcphy->extcon);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1258  		}
ec1fcd7b drivers/phy/rockchip/phy-rockchip-typec.c Enric Balletbo i Serra 2018-03-01  1259  	}
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1260  
cdb051be drivers/phy/rockchip/phy-rockchip-typec.c Lin Huang              2018-05-04  1261  	tcphy->typec_phy_config = type_c_dp_phy_config;
2a4d5962 drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-09-07  1262  	pm_runtime_enable(dev);
2a4d5962 drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-09-07  1263  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1264  	for_each_available_child_of_node(np, child_np) {
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1265  		struct phy *phy;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1266  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1267  		if (!of_node_cmp(child_np->name, "dp-port"))
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1268  			phy = devm_phy_create(dev, child_np,
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1269  					      &rockchip_dp_phy_ops);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1270  		else if (!of_node_cmp(child_np->name, "usb3-port"))
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1271  			phy = devm_phy_create(dev, child_np,
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1272  					      &rockchip_usb3_phy_ops);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1273  		else
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1274  			continue;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1275  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1276  		if (IS_ERR(phy)) {
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1277  			dev_err(dev, "failed to create phy: %s\n",
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1278  				child_np->name);
3cb0ab6e drivers/phy/rockchip/phy-rockchip-typec.c Chris Zhong            2016-09-08  1279  			pm_runtime_disable(dev);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1280  			return PTR_ERR(phy);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1281  		}
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1282  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1283  		phy_set_drvdata(phy, tcphy);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1284  	}
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1285  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1286  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1287  	if (IS_ERR(phy_provider)) {
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1288  		dev_err(dev, "Failed to register phy provider\n");
3cb0ab6e drivers/phy/rockchip/phy-rockchip-typec.c Chris Zhong            2016-09-08  1289  		pm_runtime_disable(dev);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1290  		return PTR_ERR(phy_provider);
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1291  	}
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1292  
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1293  	return 0;
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1294  }
e96be45c drivers/phy/phy-rockchip-typec.c          Chris Zhong            2016-08-23  1295  

:::::: The code at line 1227 was first introduced by commit
:::::: 0fbc47d9e426a934668dbfeb0db26da6f0b7f35c phy: rockchip-typec: deprecate some DT properties for various register fields.

:::::: TO: Enric Balletbo i Serra <enric.balletbo@collabora.com>
:::::: CC: Kishon Vijay Abraham I <kishon@ti.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38203 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/e57a34fa/attachment-0001.gz>
