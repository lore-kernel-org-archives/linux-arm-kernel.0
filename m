From: lkp@intel.com (kbuild test robot)
Date: Mon, 18 Sep 2017 11:12:23 +0800
Subject: [PATCH v3 1/3] media: ov7670: Add entity pads initialization
In-Reply-To: <20170918012928.13278-2-wenyou.yang@microchip.com>
Message-ID: <201709181018.Giind5Al%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.14-rc1 next-20170915]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/media-ov7670-Add-entity-init-and-power-operation/20170918-093913
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-x009-09180108 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/media/i2c/ov7670.c: In function 'ov7670_probe':
>> drivers/media/i2c/ov7670.c:1694:10: error: 'struct v4l2_subdev' has no member named 'entity'
     info->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
             ^
   drivers/media/i2c/ov7670.c:1695:40: error: 'struct v4l2_subdev' has no member named 'entity'
     ret = media_entity_pads_init(&info->sd.entity, 1, &info->pad);
                                           ^
   drivers/media/i2c/ov7670.c:1708:32: error: 'struct v4l2_subdev' has no member named 'entity'
     media_entity_cleanup(&info->sd.entity);
                                   ^
   drivers/media/i2c/ov7670.c: In function 'ov7670_remove':
   drivers/media/i2c/ov7670.c:1725:32: error: 'struct v4l2_subdev' has no member named 'entity'
     media_entity_cleanup(&info->sd.entity);
                                   ^

vim +1694 drivers/media/i2c/ov7670.c

  1575	
  1576	static int ov7670_probe(struct i2c_client *client,
  1577				const struct i2c_device_id *id)
  1578	{
  1579		struct v4l2_fract tpf;
  1580		struct v4l2_subdev *sd;
  1581		struct ov7670_info *info;
  1582		int ret;
  1583	
  1584		info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
  1585		if (info == NULL)
  1586			return -ENOMEM;
  1587		sd = &info->sd;
  1588		v4l2_i2c_subdev_init(sd, client, &ov7670_ops);
  1589	
  1590		info->clock_speed = 30; /* default: a guess */
  1591		if (client->dev.platform_data) {
  1592			struct ov7670_config *config = client->dev.platform_data;
  1593	
  1594			/*
  1595			 * Must apply configuration before initializing device, because it
  1596			 * selects I/O method.
  1597			 */
  1598			info->min_width = config->min_width;
  1599			info->min_height = config->min_height;
  1600			info->use_smbus = config->use_smbus;
  1601	
  1602			if (config->clock_speed)
  1603				info->clock_speed = config->clock_speed;
  1604	
  1605			/*
  1606			 * It should be allowed for ov7670 too when it is migrated to
  1607			 * the new frame rate formula.
  1608			 */
  1609			if (config->pll_bypass && id->driver_data != MODEL_OV7670)
  1610				info->pll_bypass = true;
  1611	
  1612			if (config->pclk_hb_disable)
  1613				info->pclk_hb_disable = true;
  1614		}
  1615	
  1616		info->clk = devm_clk_get(&client->dev, "xclk");
  1617		if (IS_ERR(info->clk))
  1618			return PTR_ERR(info->clk);
  1619		ret = clk_prepare_enable(info->clk);
  1620		if (ret)
  1621			return ret;
  1622	
  1623		ret = ov7670_init_gpio(client, info);
  1624		if (ret)
  1625			goto clk_disable;
  1626	
  1627		info->clock_speed = clk_get_rate(info->clk) / 1000000;
  1628		if (info->clock_speed < 10 || info->clock_speed > 48) {
  1629			ret = -EINVAL;
  1630			goto clk_disable;
  1631		}
  1632	
  1633		/* Make sure it's an ov7670 */
  1634		ret = ov7670_detect(sd);
  1635		if (ret) {
  1636			v4l_dbg(1, debug, client,
  1637				"chip found @ 0x%x (%s) is not an ov7670 chip.\n",
  1638				client->addr << 1, client->adapter->name);
  1639			goto clk_disable;
  1640		}
  1641		v4l_info(client, "chip found @ 0x%02x (%s)\n",
  1642				client->addr << 1, client->adapter->name);
  1643	
  1644		info->devtype = &ov7670_devdata[id->driver_data];
  1645		info->fmt = &ov7670_formats[0];
  1646		info->clkrc = 0;
  1647	
  1648		/* Set default frame rate to 30 fps */
  1649		tpf.numerator = 1;
  1650		tpf.denominator = 30;
  1651		info->devtype->set_framerate(sd, &tpf);
  1652	
  1653		if (info->pclk_hb_disable)
  1654			ov7670_write(sd, REG_COM10, COM10_PCLK_HB);
  1655	
  1656		v4l2_ctrl_handler_init(&info->hdl, 10);
  1657		v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1658				V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
  1659		v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1660				V4L2_CID_CONTRAST, 0, 127, 1, 64);
  1661		v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1662				V4L2_CID_VFLIP, 0, 1, 1, 0);
  1663		v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1664				V4L2_CID_HFLIP, 0, 1, 1, 0);
  1665		info->saturation = v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1666				V4L2_CID_SATURATION, 0, 256, 1, 128);
  1667		info->hue = v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1668				V4L2_CID_HUE, -180, 180, 5, 0);
  1669		info->gain = v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1670				V4L2_CID_GAIN, 0, 255, 1, 128);
  1671		info->auto_gain = v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1672				V4L2_CID_AUTOGAIN, 0, 1, 1, 1);
  1673		info->exposure = v4l2_ctrl_new_std(&info->hdl, &ov7670_ctrl_ops,
  1674				V4L2_CID_EXPOSURE, 0, 65535, 1, 500);
  1675		info->auto_exposure = v4l2_ctrl_new_std_menu(&info->hdl, &ov7670_ctrl_ops,
  1676				V4L2_CID_EXPOSURE_AUTO, V4L2_EXPOSURE_MANUAL, 0,
  1677				V4L2_EXPOSURE_AUTO);
  1678		sd->ctrl_handler = &info->hdl;
  1679		if (info->hdl.error) {
  1680			ret = info->hdl.error;
  1681	
  1682			goto hdl_free;
  1683		}
  1684		/*
  1685		 * We have checked empirically that hw allows to read back the gain
  1686		 * value chosen by auto gain but that's not the case for auto exposure.
  1687		 */
  1688		v4l2_ctrl_auto_cluster(2, &info->auto_gain, 0, true);
  1689		v4l2_ctrl_auto_cluster(2, &info->auto_exposure,
  1690				       V4L2_EXPOSURE_MANUAL, false);
  1691		v4l2_ctrl_cluster(2, &info->saturation);
  1692	
  1693		info->pad.flags = MEDIA_PAD_FL_SOURCE;
> 1694		info->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
  1695		ret = media_entity_pads_init(&info->sd.entity, 1, &info->pad);
  1696		if (ret < 0)
  1697			goto hdl_free;
  1698	
  1699		v4l2_ctrl_handler_setup(&info->hdl);
  1700	
  1701		ret = v4l2_async_register_subdev(&info->sd);
  1702		if (ret < 0)
  1703			goto entity_cleanup;
  1704	
  1705		return 0;
  1706	
  1707	entity_cleanup:
  1708		media_entity_cleanup(&info->sd.entity);
  1709	hdl_free:
  1710		v4l2_ctrl_handler_free(&info->hdl);
  1711	clk_disable:
  1712		clk_disable_unprepare(info->clk);
  1713		return ret;
  1714	}
  1715	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28336 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/ae926693/attachment-0001.gz>
