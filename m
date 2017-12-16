From: lkp@intel.com (kbuild test robot)
Date: Sat, 16 Dec 2017 15:00:32 +0800
Subject: [PATCH 5/8] drm/sun4i: Add a driver for the display frontend
In-Reply-To: <600d29233eb0dcca3af815fbed8995e35f78b4ee.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <600d29233eb0dcca3af815fbed8995e35f78b4ee.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <201712161445.bGQnvl24%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Support-the-Display-Engine-frontend/20171216-122702
base:    
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Maxime-Ripard/drm-sun4i-Support-the-Display-Engine-frontend/20171216-122702 HEAD c38c4ce4b14c4c68a9fde0cc35ead5b1c894776b builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_bind':
>> drivers/gpu/drm/sun4i/sun4i_backend.c:370:22: error: implicit declaration of function 'sun4i_backend_find_frontend'; did you mean 'sun4i_backend_bind'? [-Werror=implicit-function-declaration]
     backend->frontend = sun4i_backend_find_frontend(drv, dev->of_node);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                         sun4i_backend_bind
>> drivers/gpu/drm/sun4i/sun4i_backend.c:370:20: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     backend->frontend = sun4i_backend_find_frontend(drv, dev->of_node);
                       ^
   cc1: some warnings being treated as errors

vim +370 drivers/gpu/drm/sun4i/sun4i_backend.c

   346	
   347	static int sun4i_backend_bind(struct device *dev, struct device *master,
   348				      void *data)
   349	{
   350		struct platform_device *pdev = to_platform_device(dev);
   351		struct drm_device *drm = data;
   352		struct sun4i_drv *drv = drm->dev_private;
   353		struct sun4i_backend *backend;
   354		const struct sun4i_backend_quirks *quirks;
   355		struct resource *res;
   356		void __iomem *regs;
   357		int i, ret;
   358	
   359		backend = devm_kzalloc(dev, sizeof(*backend), GFP_KERNEL);
   360		if (!backend)
   361			return -ENOMEM;
   362		dev_set_drvdata(dev, backend);
   363	
   364		backend->engine.node = dev->of_node;
   365		backend->engine.ops = &sun4i_backend_engine_ops;
   366		backend->engine.id = sun4i_backend_of_get_id(dev->of_node);
   367		if (backend->engine.id < 0)
   368			return backend->engine.id;
   369	
 > 370		backend->frontend = sun4i_backend_find_frontend(drv, dev->of_node);
   371		if (IS_ERR(backend->frontend)) {
   372			dev_err(dev, "Couldn't find matching frontend, frontend features disabled\n");
   373		}
   374	
   375		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   376		regs = devm_ioremap_resource(dev, res);
   377		if (IS_ERR(regs))
   378			return PTR_ERR(regs);
   379	
   380		backend->reset = devm_reset_control_get(dev, NULL);
   381		if (IS_ERR(backend->reset)) {
   382			dev_err(dev, "Couldn't get our reset line\n");
   383			return PTR_ERR(backend->reset);
   384		}
   385	
   386		ret = reset_control_deassert(backend->reset);
   387		if (ret) {
   388			dev_err(dev, "Couldn't deassert our reset line\n");
   389			return ret;
   390		}
   391	
   392		backend->bus_clk = devm_clk_get(dev, "ahb");
   393		if (IS_ERR(backend->bus_clk)) {
   394			dev_err(dev, "Couldn't get the backend bus clock\n");
   395			ret = PTR_ERR(backend->bus_clk);
   396			goto err_assert_reset;
   397		}
   398		clk_prepare_enable(backend->bus_clk);
   399	
   400		backend->mod_clk = devm_clk_get(dev, "mod");
   401		if (IS_ERR(backend->mod_clk)) {
   402			dev_err(dev, "Couldn't get the backend module clock\n");
   403			ret = PTR_ERR(backend->mod_clk);
   404			goto err_disable_bus_clk;
   405		}
   406		clk_prepare_enable(backend->mod_clk);
   407	
   408		backend->ram_clk = devm_clk_get(dev, "ram");
   409		if (IS_ERR(backend->ram_clk)) {
   410			dev_err(dev, "Couldn't get the backend RAM clock\n");
   411			ret = PTR_ERR(backend->ram_clk);
   412			goto err_disable_mod_clk;
   413		}
   414		clk_prepare_enable(backend->ram_clk);
   415	
   416		if (of_device_is_compatible(dev->of_node,
   417					    "allwinner,sun8i-a33-display-backend")) {
   418			ret = sun4i_backend_init_sat(dev);
   419			if (ret) {
   420				dev_err(dev, "Couldn't init SAT resources\n");
   421				goto err_disable_ram_clk;
   422			}
   423		}
   424	
   425		backend->engine.regs = devm_regmap_init_mmio(dev, regs,
   426							     &sun4i_backend_regmap_config);
   427		if (IS_ERR(backend->engine.regs)) {
   428			dev_err(dev, "Couldn't create the backend regmap\n");
   429			return PTR_ERR(backend->engine.regs);
   430		}
   431	
   432		list_add_tail(&backend->engine.list, &drv->engine_list);
   433	
   434		/*
   435		 * Many of the backend's layer configuration registers have
   436		 * undefined default values. This poses a risk as we use
   437		 * regmap_update_bits in some places, and don't overwrite
   438		 * the whole register.
   439		 *
   440		 * Clear the registers here to have something predictable.
   441		 */
   442		for (i = 0x800; i < 0x1000; i += 4)
   443			regmap_write(backend->engine.regs, i, 0);
   444	
   445		/* Disable registers autoloading */
   446		regmap_write(backend->engine.regs, SUN4I_BACKEND_REGBUFFCTL_REG,
   447			     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS);
   448	
   449		/* Enable the backend */
   450		regmap_write(backend->engine.regs, SUN4I_BACKEND_MODCTL_REG,
   451			     SUN4I_BACKEND_MODCTL_DEBE_EN |
   452			     SUN4I_BACKEND_MODCTL_START_CTL);
   453	
   454		/* Set output selection if needed */
   455		quirks = of_device_get_match_data(dev);
   456		if (quirks->needs_output_muxing) {
   457			/*
   458			 * We assume there is no dynamic muxing of backends
   459			 * and TCONs, so we select the backend with same ID.
   460			 *
   461			 * While dynamic selection might be interesting, since
   462			 * the CRTC is tied to the TCON, while the layers are
   463			 * tied to the backends, this means, we will need to
   464			 * switch between groups of layers. There might not be
   465			 * a way to represent this constraint in DRM.
   466			 */
   467			regmap_update_bits(backend->engine.regs,
   468					   SUN4I_BACKEND_MODCTL_REG,
   469					   SUN4I_BACKEND_MODCTL_OUT_SEL,
   470					   (backend->engine.id
   471					    ? SUN4I_BACKEND_MODCTL_OUT_LCD1
   472					    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
   473		}
   474	
   475		return 0;
   476	
   477	err_disable_ram_clk:
   478		clk_disable_unprepare(backend->ram_clk);
   479	err_disable_mod_clk:
   480		clk_disable_unprepare(backend->mod_clk);
   481	err_disable_bus_clk:
   482		clk_disable_unprepare(backend->bus_clk);
   483	err_assert_reset:
   484		reset_control_assert(backend->reset);
   485		return ret;
   486	}
   487	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23186 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171216/09df427a/attachment-0001.gz>
