From: lkp@intel.com (kbuild test robot)
Date: Sat, 21 Jul 2018 08:03:13 +0800
Subject: [PATCH RESEND 5/7] drm/sun4i: Rely on dma-parent for our RAM
 offset
In-Reply-To: <4e8314d579b8e78b8d40f03ff99cdfa22c43d462.1532098561.git-series.maxime.ripard@bootlin.com>
References: <4e8314d579b8e78b8d40f03ff99cdfa22c43d462.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <201807210745.Wn8dECfz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/sunxi-Add-DT-representation-for-the-MBUS-controller/20180721-052652
base:    
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_bind':
>> drivers/gpu/drm/sun4i/sun4i_backend.c:776:9: error: too few arguments to function 'of_dma_configure'
      ret = of_dma_configure(drm->dev, dev->of_node);
            ^~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/sun4i/sun4i_backend.c:24:0:
   include/linux/of_device.h:58:5: note: declared here
    int of_dma_configure(struct device *dev,
        ^~~~~~~~~~~~~~~~

vim +/of_dma_configure +776 drivers/gpu/drm/sun4i/sun4i_backend.c

   749	
   750	static int sun4i_backend_bind(struct device *dev, struct device *master,
   751				      void *data)
   752	{
   753		struct platform_device *pdev = to_platform_device(dev);
   754		struct drm_device *drm = data;
   755		struct sun4i_drv *drv = drm->dev_private;
   756		struct sun4i_backend *backend;
   757		const struct sun4i_backend_quirks *quirks;
   758		struct resource *res;
   759		void __iomem *regs;
   760		int i, ret;
   761	
   762		backend = devm_kzalloc(dev, sizeof(*backend), GFP_KERNEL);
   763		if (!backend)
   764			return -ENOMEM;
   765		dev_set_drvdata(dev, backend);
   766		spin_lock_init(&backend->frontend_lock);
   767	
   768		if (of_find_property(dev->of_node, "dma-parent", NULL)) {
   769			/*
   770			 * This assume we have the same DMA constraints for all our the
   771			 * devices in our pipeline (all the backends, but also the
   772			 * frontends). This sounds bad, but it has always been the case
   773			 * for us, and DRM doesn't do per-device allocation either, so
   774			 * we would need to fix DRM first...
   775			 */
 > 776			ret = of_dma_configure(drm->dev, dev->of_node);
   777			if (ret)
   778				return ret;
   779		} else {
   780			/*
   781			 * If we don't have the dma-parent property, most likely
   782			 * because of an old DT, we need to set the DMA offset by hand
   783			 * on our device since the RAM mapping is at 0 for the DMA bus,
   784			 * unlike the CPU.
   785			 */
   786			drm->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
   787		}
   788	
   789		backend->engine.node = dev->of_node;
   790		backend->engine.ops = &sun4i_backend_engine_ops;
   791		backend->engine.id = sun4i_backend_of_get_id(dev->of_node);
   792		if (backend->engine.id < 0)
   793			return backend->engine.id;
   794	
   795		backend->frontend = sun4i_backend_find_frontend(drv, dev->of_node);
   796		if (IS_ERR(backend->frontend))
   797			dev_warn(dev, "Couldn't find matching frontend, frontend features disabled\n");
   798	
   799		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   800		regs = devm_ioremap_resource(dev, res);
   801		if (IS_ERR(regs))
   802			return PTR_ERR(regs);
   803	
   804		backend->reset = devm_reset_control_get(dev, NULL);
   805		if (IS_ERR(backend->reset)) {
   806			dev_err(dev, "Couldn't get our reset line\n");
   807			return PTR_ERR(backend->reset);
   808		}
   809	
   810		ret = reset_control_deassert(backend->reset);
   811		if (ret) {
   812			dev_err(dev, "Couldn't deassert our reset line\n");
   813			return ret;
   814		}
   815	
   816		backend->bus_clk = devm_clk_get(dev, "ahb");
   817		if (IS_ERR(backend->bus_clk)) {
   818			dev_err(dev, "Couldn't get the backend bus clock\n");
   819			ret = PTR_ERR(backend->bus_clk);
   820			goto err_assert_reset;
   821		}
   822		clk_prepare_enable(backend->bus_clk);
   823	
   824		backend->mod_clk = devm_clk_get(dev, "mod");
   825		if (IS_ERR(backend->mod_clk)) {
   826			dev_err(dev, "Couldn't get the backend module clock\n");
   827			ret = PTR_ERR(backend->mod_clk);
   828			goto err_disable_bus_clk;
   829		}
   830		clk_prepare_enable(backend->mod_clk);
   831	
   832		backend->ram_clk = devm_clk_get(dev, "ram");
   833		if (IS_ERR(backend->ram_clk)) {
   834			dev_err(dev, "Couldn't get the backend RAM clock\n");
   835			ret = PTR_ERR(backend->ram_clk);
   836			goto err_disable_mod_clk;
   837		}
   838		clk_prepare_enable(backend->ram_clk);
   839	
   840		if (of_device_is_compatible(dev->of_node,
   841					    "allwinner,sun8i-a33-display-backend")) {
   842			ret = sun4i_backend_init_sat(dev);
   843			if (ret) {
   844				dev_err(dev, "Couldn't init SAT resources\n");
   845				goto err_disable_ram_clk;
   846			}
   847		}
   848	
   849		backend->engine.regs = devm_regmap_init_mmio(dev, regs,
   850							     &sun4i_backend_regmap_config);
   851		if (IS_ERR(backend->engine.regs)) {
   852			dev_err(dev, "Couldn't create the backend regmap\n");
   853			return PTR_ERR(backend->engine.regs);
   854		}
   855	
   856		list_add_tail(&backend->engine.list, &drv->engine_list);
   857	
   858		/*
   859		 * Many of the backend's layer configuration registers have
   860		 * undefined default values. This poses a risk as we use
   861		 * regmap_update_bits in some places, and don't overwrite
   862		 * the whole register.
   863		 *
   864		 * Clear the registers here to have something predictable.
   865		 */
   866		for (i = 0x800; i < 0x1000; i += 4)
   867			regmap_write(backend->engine.regs, i, 0);
   868	
   869		/* Disable registers autoloading */
   870		regmap_write(backend->engine.regs, SUN4I_BACKEND_REGBUFFCTL_REG,
   871			     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS);
   872	
   873		/* Enable the backend */
   874		regmap_write(backend->engine.regs, SUN4I_BACKEND_MODCTL_REG,
   875			     SUN4I_BACKEND_MODCTL_DEBE_EN |
   876			     SUN4I_BACKEND_MODCTL_START_CTL);
   877	
   878		/* Set output selection if needed */
   879		quirks = of_device_get_match_data(dev);
   880		if (quirks->needs_output_muxing) {
   881			/*
   882			 * We assume there is no dynamic muxing of backends
   883			 * and TCONs, so we select the backend with same ID.
   884			 *
   885			 * While dynamic selection might be interesting, since
   886			 * the CRTC is tied to the TCON, while the layers are
   887			 * tied to the backends, this means, we will need to
   888			 * switch between groups of layers. There might not be
   889			 * a way to represent this constraint in DRM.
   890			 */
   891			regmap_update_bits(backend->engine.regs,
   892					   SUN4I_BACKEND_MODCTL_REG,
   893					   SUN4I_BACKEND_MODCTL_OUT_SEL,
   894					   (backend->engine.id
   895					    ? SUN4I_BACKEND_MODCTL_OUT_LCD1
   896					    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
   897		}
   898	
   899		return 0;
   900	
   901	err_disable_ram_clk:
   902		clk_disable_unprepare(backend->ram_clk);
   903	err_disable_mod_clk:
   904		clk_disable_unprepare(backend->mod_clk);
   905	err_disable_bus_clk:
   906		clk_disable_unprepare(backend->bus_clk);
   907	err_assert_reset:
   908		reset_control_assert(backend->reset);
   909		return ret;
   910	}
   911	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23133 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/f5123d57/attachment-0001.gz>
