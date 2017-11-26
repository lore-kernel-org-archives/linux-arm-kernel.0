From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Nov 2017 01:04:20 +0800
Subject: [PATCH v2 04/11] media: rkisp1: add Rockchip MIPI Synopsys DPHY
 driver
In-Reply-To: <20171124023706.5702-5-jacob-chen@iotwrt.com>
References: <20171124023706.5702-5-jacob-chen@iotwrt.com>
Message-ID: <201711262328.Wu1Q1zu3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on next-20171124]
[cannot apply to rockchip/for-next v4.14]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/Rockchip-ISP1-Driver/20171126-224713
base:   git://linuxtv.org/media_tree.git master
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

>> drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:634:66: error: expected identifier or '(' before '=' token
    struct v4l2_async_notifier_operationsrockchip_mipidphy_async_ops = {
                                                                     ^
   drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c: In function 'rockchip_mipidphy_media_init':
>> drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:707:24: error: 'rockchip_mipidphy_async_ops' undeclared (first use in this function)
     priv->notifier.ops = &rockchip_mipidphy_async_ops;
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:707:24: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:593:1: warning: 'rockchip_mipidphy_notifier_complete' defined but not used [-Wunused-function]
    rockchip_mipidphy_notifier_complete(struct v4l2_async_notifier *notifier)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:579:1: warning: 'rockchip_mipidphy_notifier_unbind' defined but not used [-Wunused-function]
    rockchip_mipidphy_notifier_unbind(struct v4l2_async_notifier *notifier,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c:555:1: warning: 'rockchip_mipidphy_notifier_bound' defined but not used [-Wunused-function]
    rockchip_mipidphy_notifier_bound(struct v4l2_async_notifier *notifier,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +634 drivers/media/platform/rockchip/isp1/mipi_dphy_sy.c

   632	
   633	static const
 > 634	struct v4l2_async_notifier_operationsrockchip_mipidphy_async_ops = {
   635		.bound = rockchip_mipidphy_notifier_bound,
   636		.unbind = rockchip_mipidphy_notifier_unbind,
   637		.complete = rockchip_mipidphy_notifier_complete,
   638	};
   639	
   640	static int rockchip_mipidphy_fwnode_parse(struct device *dev,
   641				     struct v4l2_fwnode_endpoint *vep,
   642				     struct v4l2_async_subdev *asd)
   643	{
   644		struct sensor_async_subdev *s_asd =
   645				container_of(asd, struct sensor_async_subdev, asd);
   646		struct v4l2_mbus_config *config = &s_asd->mbus;
   647	
   648		if (vep->bus_type != V4L2_MBUS_CSI2) {
   649			dev_err(dev, "Only CSI2 bus type is currently supported\n");
   650			return -EINVAL;
   651		}
   652	
   653		if (vep->base.port != 0) {
   654			dev_err(dev, "The PHY has only port 0\n");
   655			return -EINVAL;
   656		}
   657	
   658		config->type = V4L2_MBUS_CSI2;
   659		config->flags = vep->bus.mipi_csi2.flags;
   660		s_asd->lanes = vep->bus.mipi_csi2.num_data_lanes;
   661	
   662		switch (vep->bus.mipi_csi2.num_data_lanes) {
   663		case 1:
   664			config->flags |= V4L2_MBUS_CSI2_1_LANE;
   665			break;
   666		case 2:
   667			config->flags |= V4L2_MBUS_CSI2_2_LANE;
   668			break;
   669		case 3:
   670			config->flags |= V4L2_MBUS_CSI2_3_LANE;
   671			break;
   672		case 4:
   673			config->flags |= V4L2_MBUS_CSI2_4_LANE;
   674			break;
   675		default:
   676			return -EINVAL;
   677		}
   678	
   679		return 0;
   680	}
   681	
   682	static int rockchip_mipidphy_media_init(struct mipidphy_priv *priv)
   683	{
   684		int ret;
   685	
   686		priv->pads[MIPI_DPHY_SY_PAD_SOURCE].flags =
   687			MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
   688		priv->pads[MIPI_DPHY_SY_PAD_SINK].flags =
   689			MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
   690	
   691		ret = media_entity_pads_init(&priv->sd.entity,
   692					 MIPI_DPHY_SY_PADS_NUM, priv->pads);
   693		if (ret < 0)
   694			return ret;
   695	
   696		ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
   697			priv->dev, &priv->notifier,
   698			sizeof(struct sensor_async_subdev), 0,
   699			rockchip_mipidphy_fwnode_parse);
   700		if (ret < 0)
   701			return ret;
   702	
   703		if (!priv->notifier.num_subdevs)
   704			return -ENODEV;	/* no endpoint */
   705	
   706		priv->sd.subdev_notifier = &priv->notifier;
 > 707		priv->notifier.ops = &rockchip_mipidphy_async_ops;
   708		ret = v4l2_async_subdev_notifier_register(&priv->sd, &priv->notifier);
   709		if (ret) {
   710			dev_err(priv->dev,
   711				"failed to register async notifier : %d\n", ret);
   712			v4l2_async_notifier_cleanup(&priv->notifier);
   713			return ret;
   714		}
   715	
   716		return v4l2_async_register_subdev(&priv->sd);
   717	}
   718	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45924 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/2804215a/attachment-0001.gz>
