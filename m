From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 06:38:45 +0800
Subject: [PATCH 7/8] [media] exynos-gsc: Use clk bulk API
In-Reply-To: <1519055046-2399-8-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-8-git-send-email-m.purski@samsung.com>
Message-ID: <201802200608.dGhdr2UA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.16-rc2 next-20180219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Use-clk-bulk-API-in-exynos5433-drivers/20180220-054431
base:   git://linuxtv.org/media_tree.git master
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/media/platform/exynos-gsc/gsc-core.c: In function 'gsc_probe':
>> drivers/media/platform/exynos-gsc/gsc-core.c:1190:8: warning: passing argument 3 of 'devm_clk_bulk_alloc' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
           drv_data->clk_names);
           ^~~~~~~~
   In file included from drivers/media/platform/exynos-gsc/gsc-core.c:25:0:
   include/linux/clk.h:654:37: note: expected 'const char **' but argument is of type 'const char * const*'
    static inline struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev,
                                        ^~~~~~~~~~~~~~~~~~~

vim +1190 drivers/media/platform/exynos-gsc/gsc-core.c

  1144	
  1145	static int gsc_probe(struct platform_device *pdev)
  1146	{
  1147		struct gsc_dev *gsc;
  1148		struct resource *res;
  1149		struct device *dev = &pdev->dev;
  1150		const struct gsc_driverdata *drv_data = of_device_get_match_data(dev);
  1151		int ret;
  1152	
  1153		gsc = devm_kzalloc(dev, sizeof(struct gsc_dev), GFP_KERNEL);
  1154		if (!gsc)
  1155			return -ENOMEM;
  1156	
  1157		ret = of_alias_get_id(pdev->dev.of_node, "gsc");
  1158		if (ret < 0)
  1159			return ret;
  1160	
  1161		if (drv_data == &gsc_v_100_drvdata)
  1162			dev_info(dev, "compatible 'exynos5-gsc' is deprecated\n");
  1163	
  1164		gsc->id = ret;
  1165		if (gsc->id >= drv_data->num_entities) {
  1166			dev_err(dev, "Invalid platform device id: %d\n", gsc->id);
  1167			return -EINVAL;
  1168		}
  1169	
  1170		gsc->num_clocks = drv_data->num_clocks;
  1171		gsc->variant = drv_data->variant[gsc->id];
  1172		gsc->pdev = pdev;
  1173	
  1174		init_waitqueue_head(&gsc->irq_queue);
  1175		spin_lock_init(&gsc->slock);
  1176		mutex_init(&gsc->lock);
  1177	
  1178		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1179		gsc->regs = devm_ioremap_resource(dev, res);
  1180		if (IS_ERR(gsc->regs))
  1181			return PTR_ERR(gsc->regs);
  1182	
  1183		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
  1184		if (!res) {
  1185			dev_err(dev, "failed to get IRQ resource\n");
  1186			return -ENXIO;
  1187		}
  1188	
  1189		gsc->clocks = devm_clk_bulk_alloc(dev, gsc->num_clocks,
> 1190						  drv_data->clk_names);
  1191		if (IS_ERR(gsc->clocks))
  1192			return PTR_ERR(gsc->clocks);
  1193	
  1194		ret = devm_clk_bulk_get(dev, gsc->num_clocks,
  1195					gsc->clocks);
  1196		if (ret)
  1197			return ret;
  1198	
  1199		ret = clk_bulk_prepare_enable(gsc->num_clocks, gsc->clocks);
  1200		if (ret)
  1201			return ret;
  1202	
  1203		ret = devm_request_irq(dev, res->start, gsc_irq_handler,
  1204					0, pdev->name, gsc);
  1205		if (ret) {
  1206			dev_err(dev, "failed to install irq (%d)\n", ret);
  1207			goto err_clk;
  1208		}
  1209	
  1210		ret = v4l2_device_register(dev, &gsc->v4l2_dev);
  1211		if (ret)
  1212			goto err_clk;
  1213	
  1214		ret = gsc_register_m2m_device(gsc);
  1215		if (ret)
  1216			goto err_v4l2;
  1217	
  1218		platform_set_drvdata(pdev, gsc);
  1219	
  1220		gsc_hw_set_sw_reset(gsc);
  1221		gsc_wait_reset(gsc);
  1222	
  1223		vb2_dma_contig_set_max_seg_size(dev, DMA_BIT_MASK(32));
  1224	
  1225		dev_dbg(dev, "gsc-%d registered successfully\n", gsc->id);
  1226	
  1227		pm_runtime_set_active(dev);
  1228		pm_runtime_enable(dev);
  1229	
  1230		return 0;
  1231	
  1232	err_v4l2:
  1233		v4l2_device_unregister(&gsc->v4l2_dev);
  1234	err_clk:
  1235		clk_bulk_disable_unprepare(gsc->num_clocks, gsc->clocks);
  1236	
  1237		return ret;
  1238	}
  1239	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53401 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180220/91a5e017/attachment-0001.gz>
