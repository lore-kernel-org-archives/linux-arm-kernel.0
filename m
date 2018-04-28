From: lkp@intel.com (kbuild test robot)
Date: Sat, 28 Apr 2018 16:09:45 +0800
Subject: [PATCH 22/24] drm/bridge: remove the .of_node member
In-Reply-To: <20180426223139.16740-23-peda@axentia.se>
References: <20180426223139.16740-23-peda@axentia.se>
Message-ID: <201804281608.Iji1Keed%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc2]
[also build test ERROR on next-20180426]
[cannot apply to drm/drm-next robclark/msm-next drm-exynos/exynos-drm/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/device-link-bridge-supplier-drm-device/20180428-135229
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu//drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_bind':
>> drivers/gpu//drm/rockchip/rockchip_lvds.c:381:24: error: 'struct drm_bridge' has no member named 'of_node'
      remote = lvds->bridge->of_node;
                           ^~

vim +381 drivers/gpu//drm/rockchip/rockchip_lvds.c

34cc0aa25 Sandy Huang 2017-09-02  340  
34cc0aa25 Sandy Huang 2017-09-02  341  static int rockchip_lvds_bind(struct device *dev, struct device *master,
34cc0aa25 Sandy Huang 2017-09-02  342  			      void *data)
34cc0aa25 Sandy Huang 2017-09-02  343  {
34cc0aa25 Sandy Huang 2017-09-02  344  	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
34cc0aa25 Sandy Huang 2017-09-02  345  	struct drm_device *drm_dev = data;
34cc0aa25 Sandy Huang 2017-09-02  346  	struct drm_encoder *encoder;
34cc0aa25 Sandy Huang 2017-09-02  347  	struct drm_connector *connector;
34cc0aa25 Sandy Huang 2017-09-02  348  	struct device_node *remote = NULL;
34cc0aa25 Sandy Huang 2017-09-02  349  	struct device_node  *port, *endpoint;
6bf2e0324 Sean Paul   2017-09-20  350  	int ret = 0, child_count = 0;
34cc0aa25 Sandy Huang 2017-09-02  351  	const char *name;
34cc0aa25 Sandy Huang 2017-09-02  352  	u32 endpoint_id;
34cc0aa25 Sandy Huang 2017-09-02  353  
34cc0aa25 Sandy Huang 2017-09-02  354  	lvds->drm_dev = drm_dev;
34cc0aa25 Sandy Huang 2017-09-02  355  	port = of_graph_get_port_by_id(dev->of_node, 1);
34cc0aa25 Sandy Huang 2017-09-02  356  	if (!port) {
34cc0aa25 Sandy Huang 2017-09-02  357  		DRM_DEV_ERROR(dev,
34cc0aa25 Sandy Huang 2017-09-02  358  			      "can't found port point, please init lvds panel port!\n");
34cc0aa25 Sandy Huang 2017-09-02  359  		return -EINVAL;
34cc0aa25 Sandy Huang 2017-09-02  360  	}
34cc0aa25 Sandy Huang 2017-09-02  361  	for_each_child_of_node(port, endpoint) {
6bf2e0324 Sean Paul   2017-09-20  362  		child_count++;
34cc0aa25 Sandy Huang 2017-09-02  363  		of_property_read_u32(endpoint, "reg", &endpoint_id);
34cc0aa25 Sandy Huang 2017-09-02  364  		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
34cc0aa25 Sandy Huang 2017-09-02  365  						  &lvds->panel, &lvds->bridge);
34cc0aa25 Sandy Huang 2017-09-02  366  		if (!ret)
34cc0aa25 Sandy Huang 2017-09-02  367  			break;
34cc0aa25 Sandy Huang 2017-09-02  368  	}
6bf2e0324 Sean Paul   2017-09-20  369  	if (!child_count) {
6bf2e0324 Sean Paul   2017-09-20  370  		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
6bf2e0324 Sean Paul   2017-09-20  371  		ret = -EINVAL;
6bf2e0324 Sean Paul   2017-09-20  372  		goto err_put_port;
6bf2e0324 Sean Paul   2017-09-20  373  	} else if (ret) {
34cc0aa25 Sandy Huang 2017-09-02  374  		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
34cc0aa25 Sandy Huang 2017-09-02  375  		ret = -EPROBE_DEFER;
34cc0aa25 Sandy Huang 2017-09-02  376  		goto err_put_port;
34cc0aa25 Sandy Huang 2017-09-02  377  	}
34cc0aa25 Sandy Huang 2017-09-02  378  	if (lvds->panel)
34cc0aa25 Sandy Huang 2017-09-02  379  		remote = lvds->panel->dev->of_node;
34cc0aa25 Sandy Huang 2017-09-02  380  	else
34cc0aa25 Sandy Huang 2017-09-02 @381  		remote = lvds->bridge->of_node;
34cc0aa25 Sandy Huang 2017-09-02  382  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
34cc0aa25 Sandy Huang 2017-09-02  383  		/* default set it as output rgb */
34cc0aa25 Sandy Huang 2017-09-02  384  		lvds->output = DISPLAY_OUTPUT_RGB;
34cc0aa25 Sandy Huang 2017-09-02  385  	else
34cc0aa25 Sandy Huang 2017-09-02  386  		lvds->output = lvds_name_to_output(name);
34cc0aa25 Sandy Huang 2017-09-02  387  
34cc0aa25 Sandy Huang 2017-09-02  388  	if (lvds->output < 0) {
34cc0aa25 Sandy Huang 2017-09-02  389  		DRM_DEV_ERROR(dev, "invalid output type [%s]\n", name);
34cc0aa25 Sandy Huang 2017-09-02  390  		ret = lvds->output;
34cc0aa25 Sandy Huang 2017-09-02  391  		goto err_put_remote;
34cc0aa25 Sandy Huang 2017-09-02  392  	}
34cc0aa25 Sandy Huang 2017-09-02  393  
34cc0aa25 Sandy Huang 2017-09-02  394  	if (of_property_read_string(remote, "data-mapping", &name))
34cc0aa25 Sandy Huang 2017-09-02  395  		/* default set it as format vesa 18 */
34cc0aa25 Sandy Huang 2017-09-02  396  		lvds->format = LVDS_VESA_18;
34cc0aa25 Sandy Huang 2017-09-02  397  	else
34cc0aa25 Sandy Huang 2017-09-02  398  		lvds->format = lvds_name_to_format(name);
34cc0aa25 Sandy Huang 2017-09-02  399  
34cc0aa25 Sandy Huang 2017-09-02  400  	if (lvds->format < 0) {
34cc0aa25 Sandy Huang 2017-09-02  401  		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
34cc0aa25 Sandy Huang 2017-09-02  402  		ret = lvds->format;
34cc0aa25 Sandy Huang 2017-09-02  403  		goto err_put_remote;
34cc0aa25 Sandy Huang 2017-09-02  404  	}
34cc0aa25 Sandy Huang 2017-09-02  405  
34cc0aa25 Sandy Huang 2017-09-02  406  	encoder = &lvds->encoder;
34cc0aa25 Sandy Huang 2017-09-02  407  	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
34cc0aa25 Sandy Huang 2017-09-02  408  							     dev->of_node);
34cc0aa25 Sandy Huang 2017-09-02  409  
34cc0aa25 Sandy Huang 2017-09-02  410  	ret = drm_encoder_init(drm_dev, encoder, &rockchip_lvds_encoder_funcs,
34cc0aa25 Sandy Huang 2017-09-02  411  			       DRM_MODE_ENCODER_LVDS, NULL);
34cc0aa25 Sandy Huang 2017-09-02  412  	if (ret < 0) {
34cc0aa25 Sandy Huang 2017-09-02  413  		DRM_DEV_ERROR(drm_dev->dev,
34cc0aa25 Sandy Huang 2017-09-02  414  			      "failed to initialize encoder: %d\n", ret);
34cc0aa25 Sandy Huang 2017-09-02  415  		goto err_put_remote;
34cc0aa25 Sandy Huang 2017-09-02  416  	}
34cc0aa25 Sandy Huang 2017-09-02  417  
34cc0aa25 Sandy Huang 2017-09-02  418  	drm_encoder_helper_add(encoder, &rockchip_lvds_encoder_helper_funcs);
34cc0aa25 Sandy Huang 2017-09-02  419  
34cc0aa25 Sandy Huang 2017-09-02  420  	if (lvds->panel) {
34cc0aa25 Sandy Huang 2017-09-02  421  		connector = &lvds->connector;
34cc0aa25 Sandy Huang 2017-09-02  422  		connector->dpms = DRM_MODE_DPMS_OFF;
34cc0aa25 Sandy Huang 2017-09-02  423  		ret = drm_connector_init(drm_dev, connector,
34cc0aa25 Sandy Huang 2017-09-02  424  					 &rockchip_lvds_connector_funcs,
34cc0aa25 Sandy Huang 2017-09-02  425  					 DRM_MODE_CONNECTOR_LVDS);
34cc0aa25 Sandy Huang 2017-09-02  426  		if (ret < 0) {
34cc0aa25 Sandy Huang 2017-09-02  427  			DRM_DEV_ERROR(drm_dev->dev,
34cc0aa25 Sandy Huang 2017-09-02  428  				      "failed to initialize connector: %d\n", ret);
34cc0aa25 Sandy Huang 2017-09-02  429  			goto err_free_encoder;
34cc0aa25 Sandy Huang 2017-09-02  430  		}
34cc0aa25 Sandy Huang 2017-09-02  431  
34cc0aa25 Sandy Huang 2017-09-02  432  		drm_connector_helper_add(connector,
34cc0aa25 Sandy Huang 2017-09-02  433  					 &rockchip_lvds_connector_helper_funcs);
34cc0aa25 Sandy Huang 2017-09-02  434  
34cc0aa25 Sandy Huang 2017-09-02  435  		ret = drm_mode_connector_attach_encoder(connector, encoder);
34cc0aa25 Sandy Huang 2017-09-02  436  		if (ret < 0) {
34cc0aa25 Sandy Huang 2017-09-02  437  			DRM_DEV_ERROR(drm_dev->dev,
34cc0aa25 Sandy Huang 2017-09-02  438  				      "failed to attach encoder: %d\n", ret);
34cc0aa25 Sandy Huang 2017-09-02  439  			goto err_free_connector;
34cc0aa25 Sandy Huang 2017-09-02  440  		}
34cc0aa25 Sandy Huang 2017-09-02  441  
34cc0aa25 Sandy Huang 2017-09-02  442  		ret = drm_panel_attach(lvds->panel, connector);
34cc0aa25 Sandy Huang 2017-09-02  443  		if (ret < 0) {
34cc0aa25 Sandy Huang 2017-09-02  444  			DRM_DEV_ERROR(drm_dev->dev,
34cc0aa25 Sandy Huang 2017-09-02  445  				      "failed to attach panel: %d\n", ret);
34cc0aa25 Sandy Huang 2017-09-02  446  			goto err_free_connector;
34cc0aa25 Sandy Huang 2017-09-02  447  		}
34cc0aa25 Sandy Huang 2017-09-02  448  	} else {
34cc0aa25 Sandy Huang 2017-09-02  449  		lvds->bridge->encoder = encoder;
34cc0aa25 Sandy Huang 2017-09-02  450  		ret = drm_bridge_attach(encoder, lvds->bridge, NULL);
34cc0aa25 Sandy Huang 2017-09-02  451  		if (ret) {
34cc0aa25 Sandy Huang 2017-09-02  452  			DRM_DEV_ERROR(drm_dev->dev,
34cc0aa25 Sandy Huang 2017-09-02  453  				      "failed to attach bridge: %d\n", ret);
34cc0aa25 Sandy Huang 2017-09-02  454  			goto err_free_encoder;
34cc0aa25 Sandy Huang 2017-09-02  455  		}
34cc0aa25 Sandy Huang 2017-09-02  456  		encoder->bridge = lvds->bridge;
34cc0aa25 Sandy Huang 2017-09-02  457  	}
34cc0aa25 Sandy Huang 2017-09-02  458  
34cc0aa25 Sandy Huang 2017-09-02  459  	pm_runtime_enable(dev);
34cc0aa25 Sandy Huang 2017-09-02  460  	of_node_put(remote);
34cc0aa25 Sandy Huang 2017-09-02  461  	of_node_put(port);
34cc0aa25 Sandy Huang 2017-09-02  462  
34cc0aa25 Sandy Huang 2017-09-02  463  	return 0;
34cc0aa25 Sandy Huang 2017-09-02  464  
34cc0aa25 Sandy Huang 2017-09-02  465  err_free_connector:
34cc0aa25 Sandy Huang 2017-09-02  466  	drm_connector_cleanup(connector);
34cc0aa25 Sandy Huang 2017-09-02  467  err_free_encoder:
34cc0aa25 Sandy Huang 2017-09-02  468  	drm_encoder_cleanup(encoder);
34cc0aa25 Sandy Huang 2017-09-02  469  err_put_remote:
34cc0aa25 Sandy Huang 2017-09-02  470  	of_node_put(remote);
34cc0aa25 Sandy Huang 2017-09-02  471  err_put_port:
34cc0aa25 Sandy Huang 2017-09-02  472  	of_node_put(port);
34cc0aa25 Sandy Huang 2017-09-02  473  
34cc0aa25 Sandy Huang 2017-09-02  474  	return ret;
34cc0aa25 Sandy Huang 2017-09-02  475  }
34cc0aa25 Sandy Huang 2017-09-02  476  

:::::: The code at line 381 was first introduced by commit
:::::: 34cc0aa2545603560c79aaea3340d8ff3a71bd10 drm/rockchip: Add support for Rockchip Soc LVDS

:::::: TO: Sandy Huang <hjc@rock-chips.com>
:::::: CC: Mark Yao <mark.yao@rock-chips.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180428/285eb5d4/attachment-0001.gz>
