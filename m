From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Nov 2015 10:22:27 +0800
Subject: [arm:drm-etnaviv-devel 70/148]
 drivers/staging/etnaviv/etnaviv_gpu.c:1214:21: error: 'PHYS_OFFSET'
 undeclared
Message-ID: <201511061025.qvxFswvW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   bd1b8b0fa6076246d48362fbb7ec1107836bf1c7
commit: 284db6f2172274723c836908c530f970da2d97d6 [70/148] staging: etnaviv: add support for offset physical memory
config: i386-randconfig-s1-201544 (attached as .config)
reproduce:
        git checkout 284db6f2172274723c836908c530f970da2d97d6
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/staging/etnaviv/etnaviv_gpu.c: In function 'etnaviv_gpu_hw_resume':
   drivers/staging/etnaviv/etnaviv_gpu.c:1079:5: error: 'struct etnaviv_gpu' has no member named 'switch_context'
     gpu->switch_context = true;
        ^
   drivers/staging/etnaviv/etnaviv_gpu.c: In function 'etnaviv_gpu_platform_probe':
>> drivers/staging/etnaviv/etnaviv_gpu.c:1214:21: error: 'PHYS_OFFSET' undeclared (first use in this function)
     gpu->memory_base = PHYS_OFFSET;
                        ^
   drivers/staging/etnaviv/etnaviv_gpu.c:1214:21: note: each undeclared identifier is reported only once for each function it appears in

vim +/PHYS_OFFSET +1214 drivers/staging/etnaviv/etnaviv_gpu.c

  1073		clock = VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS |
  1074			VIVS_HI_CLOCK_CONTROL_FSCALE_VAL(0x40);
  1075	
  1076		etnaviv_gpu_load_clock(gpu, clock);
  1077		etnaviv_gpu_hw_init(gpu);
  1078	
> 1079		gpu->switch_context = true;
  1080	
  1081		mutex_unlock(&drm->struct_mutex);
  1082	
  1083		return 0;
  1084	}
  1085	
  1086	static int etnaviv_gpu_bind(struct device *dev, struct device *master,
  1087		void *data)
  1088	{
  1089		struct drm_device *drm = data;
  1090		struct etnaviv_drm_private *priv = drm->dev_private;
  1091		struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
  1092		int idx = gpu->pipe;
  1093		int ret;
  1094	
  1095		dev_info(dev, "pre gpu[idx]: %p\n", priv->gpu[idx]);
  1096	
  1097		if (priv->gpu[idx] == NULL) {
  1098			dev_info(dev, "adding core @idx %d\n", idx);
  1099			priv->gpu[idx] = gpu;
  1100		} else {
  1101			dev_err(dev, "failed to add core @idx %d\n", idx);
  1102			goto fail;
  1103		}
  1104	
  1105		dev_info(dev, "post gpu[idx]: %p\n", priv->gpu[idx]);
  1106	
  1107	#ifdef CONFIG_PM
  1108		ret = pm_runtime_get_sync(gpu->dev);
  1109	#else
  1110		ret = etnaviv_gpu_clk_enable(gpu);
  1111	#endif
  1112		if (ret < 0)
  1113			return ret;
  1114	
  1115		gpu->drm = drm;
  1116	
  1117		INIT_LIST_HEAD(&gpu->active_list);
  1118		INIT_WORK(&gpu->retire_work, retire_worker);
  1119		INIT_WORK(&gpu->recover_work, recover_worker);
  1120	
  1121		setup_timer(&gpu->hangcheck_timer, hangcheck_handler,
  1122				(unsigned long)gpu);
  1123	
  1124		pm_runtime_mark_last_busy(gpu->dev);
  1125		pm_runtime_put_autosuspend(gpu->dev);
  1126	
  1127		return 0;
  1128	fail:
  1129		return -1;
  1130	}
  1131	
  1132	static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
  1133		void *data)
  1134	{
  1135		struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
  1136	
  1137		DBG("%s", dev_name(gpu->dev));
  1138	
  1139		hangcheck_disable(gpu);
  1140	
  1141		WARN_ON(!list_empty(&gpu->active_list));
  1142	
  1143	#ifdef CONFIG_PM
  1144		pm_runtime_get_sync(gpu->dev);
  1145		pm_runtime_put_sync_suspend(gpu->dev);
  1146	#else
  1147		etnaviv_gpu_hw_suspend(gpu);
  1148	#endif
  1149	
  1150		if (gpu->buffer) {
  1151			drm_gem_object_unreference_unlocked(gpu->buffer);
  1152			gpu->buffer = NULL;
  1153		}
  1154	
  1155		if (gpu->mmu) {
  1156			etnaviv_iommu_destroy(gpu->mmu);
  1157			gpu->mmu = NULL;
  1158		}
  1159	
  1160		gpu->drm = NULL;
  1161	}
  1162	
  1163	static const struct component_ops gpu_ops = {
  1164		.bind = etnaviv_gpu_bind,
  1165		.unbind = etnaviv_gpu_unbind,
  1166	};
  1167	
  1168	static const struct of_device_id etnaviv_gpu_match[] = {
  1169		{
  1170			.compatible = "vivante,vivante-gpu-2d",
  1171			.data = (void *)ETNA_PIPE_2D
  1172		},
  1173		{
  1174			.compatible = "vivante,vivante-gpu-3d",
  1175			.data = (void *)ETNA_PIPE_3D
  1176		},
  1177		{
  1178			.compatible = "vivante,vivante-gpu-vg",
  1179			.data = (void *)ETNA_PIPE_VG
  1180		},
  1181		{ }
  1182	};
  1183	
  1184	static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
  1185	{
  1186		const struct of_device_id *match;
  1187		struct device *dev = &pdev->dev;
  1188		struct etnaviv_gpu *gpu;
  1189		int err = 0;
  1190	
  1191		gpu = devm_kzalloc(dev, sizeof(*gpu), GFP_KERNEL);
  1192		if (!gpu)
  1193			return -ENOMEM;
  1194	
  1195		if (pdev->dev.of_node) {
  1196			match = of_match_device(etnaviv_gpu_match, &pdev->dev);
  1197			if (!match)
  1198				return -EINVAL;
  1199			gpu->pipe = (long)match->data;
  1200		} else if (pdev->id_entry) {
  1201			gpu->pipe = pdev->id_entry->driver_data;
  1202		} else {
  1203			return -EINVAL;
  1204		}
  1205	
  1206		gpu->dev = &pdev->dev;
  1207	
  1208		/*
  1209		 * Set the GPU base address to the start of physical memory.  This
  1210		 * ensures that if we have up to 2GB, the v1 MMU can address the
  1211		 * highest memory.  This is important as command buffers may be
  1212		 * allocated outside of this limit.
  1213		 */
> 1214		gpu->memory_base = PHYS_OFFSET;
  1215	
  1216		/* Map registers: */
  1217		gpu->mmio = etnaviv_ioremap(pdev, NULL, dev_name(gpu->dev));

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20788 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/884f9b99/attachment-0001.obj>
