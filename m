From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 14 Dec 2017 14:08:37 +0800
Subject: [xlnx:master 1118/1121]
 drivers/gpu/drm/xilinx/xilinx_drm_drv.c:401:24: warning: format '%lu'
 expects argument of type 'long unsigned int', but argument 3 has type
 'unsigned int'
Message-ID: <201712141432.TwKyJyZu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   9c2e29b2c81dbb1efb7ee4944b18e12226b97513
commit: ea3243d34738a7900ce247f812a16405fc25d0ef [1118/1121] drm: xilinx: drv: Update dma mask accordingly
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout ea3243d34738a7900ce247f812a16405fc25d0ef
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/dma-mapping.h:6:0,
                    from include/drm/drmP.h:37,
                    from drivers/gpu/drm/xilinx/xilinx_drm_drv.c:18:
   drivers/gpu/drm/xilinx/xilinx_drm_drv.c: In function 'xilinx_drm_load':
>> drivers/gpu/drm/xilinx/xilinx_drm_drv.c:401:24: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
      dev_info(&pdev->dev, "failed to set coherent mask (%lu)\n",
                           ^
   include/linux/device.h:1195:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +401 drivers/gpu/drm/xilinx/xilinx_drm_drv.c

   288	
   289	/* load xilinx drm */
   290	static int xilinx_drm_load(struct drm_device *drm, unsigned long flags)
   291	{
   292		struct xilinx_drm_private *private;
   293		struct drm_encoder *encoder;
   294		struct drm_connector *connector;
   295		struct device_node *encoder_node, *ep = NULL, *remote;
   296		struct platform_device *pdev = drm->platformdev;
   297		struct component_match *match = NULL;
   298		unsigned int align, depth, i = 0;
   299		int bpp, ret;
   300	
   301		private = devm_kzalloc(drm->dev, sizeof(*private), GFP_KERNEL);
   302		if (!private)
   303			return -ENOMEM;
   304	
   305		drm_mode_config_init(drm);
   306	
   307		/* create a xilinx crtc */
   308		private->crtc = xilinx_drm_crtc_create(drm);
   309		if (IS_ERR(private->crtc)) {
   310			DRM_DEBUG_DRIVER("failed to create xilinx crtc\n");
   311			ret = PTR_ERR(private->crtc);
   312			goto err_out;
   313		}
   314	
   315		while ((encoder_node = of_parse_phandle(drm->dev->of_node,
   316							"xlnx,encoder-slave", i))) {
   317			encoder = xilinx_drm_encoder_create(drm, encoder_node);
   318			of_node_put(encoder_node);
   319			if (IS_ERR(encoder)) {
   320				DRM_DEBUG_DRIVER("failed to create xilinx encoder\n");
   321				ret = PTR_ERR(encoder);
   322				goto err_out;
   323			}
   324	
   325			connector = xilinx_drm_connector_create(drm, encoder, i);
   326			if (IS_ERR(connector)) {
   327				DRM_DEBUG_DRIVER("failed to create xilinx connector\n");
   328				ret = PTR_ERR(connector);
   329				goto err_out;
   330			}
   331	
   332			i++;
   333		}
   334	
   335		while (1) {
   336			ep = of_graph_get_next_endpoint(drm->dev->of_node, ep);
   337			if (!ep)
   338				break;
   339	
   340			of_node_put(ep);
   341			remote = of_graph_get_remote_port_parent(ep);
   342			if (!remote || !of_device_is_available(remote)) {
   343				of_node_put(remote);
   344				continue;
   345			}
   346	
   347			component_match_add(drm->dev, &match, compare_of, remote);
   348			of_node_put(remote);
   349			i++;
   350		}
   351	
   352		if (i == 0) {
   353			DRM_ERROR("failed to get an encoder slave node\n");
   354			return -ENODEV;
   355		}
   356	
   357		ret = drm_vblank_init(drm, 1);
   358		if (ret) {
   359			dev_err(&pdev->dev, "failed to initialize vblank\n");
   360			goto err_master;
   361		}
   362	
   363		/* enable irq to enable vblank feature */
   364		drm->irq_enabled = 1;
   365	
   366		drm->dev_private = private;
   367		private->drm = drm;
   368		xilinx_drm_mode_config_init(drm);
   369	
   370		/* initialize xilinx framebuffer */
   371		drm_fb_get_bpp_depth(xilinx_drm_crtc_get_format(private->crtc),
   372				     &depth, &bpp);
   373		if (bpp) {
   374			align = xilinx_drm_crtc_get_align(private->crtc);
   375			private->fb = xilinx_drm_fb_init(drm, bpp, 1, 1, align,
   376							 xilinx_drm_fbdev_vres);
   377			if (IS_ERR(private->fb)) {
   378				DRM_ERROR("failed to initialize drm fb\n");
   379				private->fb = NULL;
   380			}
   381		}
   382		if (!private->fb)
   383			dev_info(&pdev->dev, "fbdev is not initialized\n");
   384	
   385		drm_kms_helper_poll_init(drm);
   386	
   387		drm_helper_disable_unused_functions(drm);
   388	
   389		platform_set_drvdata(pdev, private);
   390	
   391		if (match) {
   392			ret = component_master_add_with_match(drm->dev,
   393							      &xilinx_drm_ops, match);
   394			if (ret)
   395				goto err_fb;
   396		}
   397	
   398		ret = dma_set_coherent_mask(&pdev->dev,
   399					    DMA_BIT_MASK(sizeof(dma_addr_t) * 8));
   400		if (ret) {
 > 401			dev_info(&pdev->dev, "failed to set coherent mask (%lu)\n",
   402				 sizeof(dma_addr_t));
   403		}
   404	
   405		return 0;
   406	
   407	err_fb:
   408		drm_vblank_cleanup(drm);
   409	err_master:
   410		component_master_del(drm->dev, &xilinx_drm_ops);
   411	err_out:
   412		drm_mode_config_cleanup(drm);
   413		if (ret == -EPROBE_DEFER)
   414			DRM_INFO("load() is defered & will be called again\n");
   415		return ret;
   416	}
   417	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57103 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/ee33c5e2/attachment-0001.gz>
