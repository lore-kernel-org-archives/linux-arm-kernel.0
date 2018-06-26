From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jun 2018 19:41:47 +0800
Subject: [PATCH v4 2/2] drm/rockchip: Add support for Rockchip Soc RGB
 output interface
In-Reply-To: <1529997340-156879-3-git-send-email-hjc@rock-chips.com>
References: <1529997340-156879-3-git-send-email-hjc@rock-chips.com>
Message-ID: <201806261951.uInQT6ix%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.18-rc2 next-20180626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sandy-Huang/Add-support-rockchip-RGB-output-interface/20180626-154044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu//drm/rockchip/rockchip_rgb.c: In function 'rockchip_rgb_encoder_enable':
>> drivers/gpu//drm/rockchip/rockchip_rgb.c:98:36: error: dereferencing pointer to incomplete type 'struct dev_pin_info'
     if (rgb->pins && !IS_ERR(rgb->pins->default_state))
                                       ^~
>> drivers/gpu//drm/rockchip/rockchip_rgb.c:99:3: error: implicit declaration of function 'pinctrl_select_state'; did you mean 'pci_store_saved_state'? [-Werror=implicit-function-declaration]
      pinctrl_select_state(rgb->pins->p, rgb->pins->default_state);
      ^~~~~~~~~~~~~~~~~~~~
      pci_store_saved_state
   drivers/gpu//drm/rockchip/rockchip_rgb.c: In function 'rockchip_rgb_bind':
>> drivers/gpu//drm/rockchip/rockchip_rgb.c:245:12: error: 'struct drm_connector' has no member named 'port'
      connector->port = dev->of_node;
               ^~
   drivers/gpu//drm/rockchip/rockchip_rgb.c: In function 'rockchip_rgb_probe':
>> drivers/gpu//drm/rockchip/rockchip_rgb.c:318:17: error: implicit declaration of function 'devm_pinctrl_get'; did you mean 'drm_connector_get'? [-Werror=implicit-function-declaration]
     rgb->pins->p = devm_pinctrl_get(rgb->dev);
                    ^~~~~~~~~~~~~~~~
                    drm_connector_get
>> drivers/gpu//drm/rockchip/rockchip_rgb.c:325:4: error: implicit declaration of function 'pinctrl_lookup_state'; did you mean 'inc_node_state'? [-Werror=implicit-function-declaration]
       pinctrl_lookup_state(rgb->pins->p, "lcdc");
       ^~~~~~~~~~~~~~~~~~~~
       inc_node_state
   cc1: some warnings being treated as errors

vim +98 drivers/gpu//drm/rockchip/rockchip_rgb.c

    91	
    92	static void rockchip_rgb_encoder_enable(struct drm_encoder *encoder)
    93	{
    94		struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
    95	
    96		drm_panel_prepare(rgb->panel);
    97		/* iomux to LCD data/sync mode */
  > 98		if (rgb->pins && !IS_ERR(rgb->pins->default_state))
  > 99			pinctrl_select_state(rgb->pins->p, rgb->pins->default_state);
   100	
   101		drm_panel_enable(rgb->panel);
   102	}
   103	
   104	static void rockchip_rgb_encoder_disable(struct drm_encoder *encoder)
   105	{
   106		struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
   107	
   108		drm_panel_disable(rgb->panel);
   109		drm_panel_unprepare(rgb->panel);
   110	}
   111	
   112	static int
   113	rockchip_rgb_encoder_atomic_check(struct drm_encoder *encoder,
   114					   struct drm_crtc_state *crtc_state,
   115					   struct drm_connector_state *conn_state)
   116	{
   117		struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
   118		struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
   119	
   120		s->output_mode = rgb->output_mode;
   121		s->output_type = DRM_MODE_CONNECTOR_LVDS;
   122	
   123		return 0;
   124	}
   125	
   126	static const
   127	struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
   128		.enable = rockchip_rgb_encoder_enable,
   129		.disable = rockchip_rgb_encoder_disable,
   130		.atomic_check = rockchip_rgb_encoder_atomic_check,
   131	};
   132	
   133	static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
   134		.destroy = drm_encoder_cleanup,
   135	};
   136	
   137	static const struct of_device_id rockchip_rgb_dt_ids[] = {
   138		{
   139			.compatible = "rockchip,px30-rgb",
   140		},
   141		{
   142			.compatible = "rockchip,rv1108-rgb",
   143		},
   144		{}
   145	};
   146	
   147	MODULE_DEVICE_TABLE(of, rockchip_rgb_dt_ids);
   148	
   149	static int rockchip_rgb_bind(struct device *dev, struct device *master,
   150				     void *data)
   151	{
   152		struct rockchip_rgb *rgb = dev_get_drvdata(dev);
   153		struct drm_device *drm_dev = data;
   154		struct drm_encoder *encoder;
   155		struct drm_connector *connector;
   156		struct device_node *remote = NULL;
   157		struct device_node  *port, *endpoint;
   158		u32 endpoint_id;
   159		const char *name;
   160		int ret = 0, child_count = 0;
   161	
   162		rgb->drm_dev = drm_dev;
   163		port = of_graph_get_port_by_id(dev->of_node, 1);
   164		if (!port) {
   165			DRM_DEV_ERROR(dev,
   166				      "can't found port point, please init rgb panel port!\n");
   167			return -EINVAL;
   168		}
   169		for_each_child_of_node(port, endpoint) {
   170			child_count++;
   171			if (of_property_read_u32(endpoint, "reg", &endpoint_id))
   172				endpoint_id = 0;
   173			ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
   174							  &rgb->panel, &rgb->bridge);
   175			if (!ret)
   176				break;
   177		}
   178		if (!child_count) {
   179			DRM_DEV_ERROR(dev, "rgb port does not have any children\n");
   180			ret = -EINVAL;
   181			goto err_put_port;
   182		} else if (ret) {
   183			DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
   184			ret = -EPROBE_DEFER;
   185			goto err_put_port;
   186		}
   187		if (rgb->panel)
   188			remote = rgb->panel->dev->of_node;
   189		else
   190			remote = rgb->bridge->of_node;
   191		if (of_property_read_string(remote, "rgb-mode", &name))
   192			/* default set it as output mode P888 */
   193			rgb->output_mode = ROCKCHIP_OUT_MODE_P888;
   194		else
   195			rgb->output_mode = name_to_output_mode(name);
   196		if (rgb->output_mode < 0) {
   197			DRM_DEV_ERROR(dev, "invalid rockchip,rgb-mode [%s]\n", name);
   198			ret = rgb->output_mode;
   199			goto err_put_remote;
   200		}
   201	
   202		encoder = &rgb->encoder;
   203		encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
   204								     dev->of_node);
   205	
   206		ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
   207				       DRM_MODE_ENCODER_NONE, NULL);
   208		if (ret < 0) {
   209			DRM_DEV_ERROR(drm_dev->dev,
   210				      "failed to initialize encoder: %d\n", ret);
   211			goto err_put_remote;
   212		}
   213	
   214		drm_encoder_helper_add(encoder, &rockchip_rgb_encoder_helper_funcs);
   215	
   216		if (rgb->panel) {
   217			connector = &rgb->connector;
   218			connector->dpms = DRM_MODE_DPMS_OFF;
   219			ret = drm_connector_init(drm_dev, connector,
   220						 &rockchip_rgb_connector_funcs,
   221						 DRM_MODE_CONNECTOR_Unknown);
   222			if (ret < 0) {
   223				DRM_DEV_ERROR(drm_dev->dev,
   224					      "failed to initialize connector: %d\n",
   225					      ret);
   226				goto err_free_encoder;
   227			}
   228	
   229			drm_connector_helper_add(connector,
   230						 &rockchip_rgb_connector_helper_funcs);
   231	
   232			ret = drm_mode_connector_attach_encoder(connector, encoder);
   233			if (ret < 0) {
   234				DRM_DEV_ERROR(drm_dev->dev,
   235					      "failed to attach encoder: %d\n", ret);
   236				goto err_free_connector;
   237			}
   238	
   239			ret = drm_panel_attach(rgb->panel, connector);
   240			if (ret < 0) {
   241				DRM_DEV_ERROR(drm_dev->dev,
   242					      "failed to attach panel: %d\n", ret);
   243				goto err_free_connector;
   244			}
 > 245			connector->port = dev->of_node;
   246		} else {
   247			rgb->bridge->encoder = encoder;
   248			ret = drm_bridge_attach(encoder, rgb->bridge, NULL);
   249			if (ret) {
   250				DRM_DEV_ERROR(drm_dev->dev,
   251					      "failed to attach bridge: %d\n", ret);
   252				goto err_free_encoder;
   253			}
   254			encoder->bridge = rgb->bridge;
   255		}
   256	
   257		of_node_put(remote);
   258		of_node_put(port);
   259	
   260		return 0;
   261	
   262	err_free_connector:
   263		drm_connector_cleanup(connector);
   264	err_free_encoder:
   265		drm_encoder_cleanup(encoder);
   266	err_put_remote:
   267		of_node_put(remote);
   268	err_put_port:
   269		of_node_put(port);
   270	
   271		return ret;
   272	}
   273	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66161 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180626/65aacc4c/attachment-0001.gz>
