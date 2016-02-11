From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 Feb 2016 18:28:03 +0800
Subject: [PATCH] dmaengine: omap-dma: Implement device_synchronize callback
In-Reply-To: <1455180894-2672-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <201602111822.fILxzr2p%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test ERROR on slave-dma/next]
[also build test ERROR on v4.5-rc3 next-20160211]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Ujfalusi/dmaengine-omap-dma-Implement-device_synchronize-callback/20160211-165914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/dma/omap-dma.c: In function 'omap_dma_synchronize':
>> drivers/dma/omap-dma.c:1014:20: error: 'c' redeclared as different kind of symbol
     struct omap_chan *c = to_omap_dma_chan(chan);
                       ^
   drivers/dma/omap-dma.c:1012:51: note: previous definition of 'c' was here
    static void omap_dma_synchronize(struct dma_chan *c)
                                                      ^
>> drivers/dma/omap-dma.c:1014:41: error: 'chan' undeclared (first use in this function)
     struct omap_chan *c = to_omap_dma_chan(chan);
                                            ^
   drivers/dma/omap-dma.c:1014:41: note: each undeclared identifier is reported only once for each function it appears in
   drivers/dma/omap-dma.c: In function 'omap_dma_probe':
>> drivers/dma/omap-dma.c:1122:5: error: 'ddev' undeclared (first use in this function)
     od-ddev.device_synchronize = omap_dma_synchronize;
        ^

vim +/c +1014 drivers/dma/omap-dma.c

  1006		spin_unlock_irqrestore(&c->vc.lock, flags);
  1007		vchan_dma_desc_free_list(&c->vc, &head);
  1008	
  1009		return 0;
  1010	}
  1011	
> 1012	static void omap_dma_synchronize(struct dma_chan *c)
  1013	{
> 1014		struct omap_chan *c = to_omap_dma_chan(chan);
  1015	
  1016		vchan_synchronize(&c->vc);
  1017	}
  1018	
  1019	static int omap_dma_pause(struct dma_chan *chan)
  1020	{
  1021		struct omap_chan *c = to_omap_dma_chan(chan);
  1022	
  1023		/* Pause/Resume only allowed with cyclic mode */
  1024		if (!c->cyclic)
  1025			return -EINVAL;
  1026	
  1027		if (!c->paused) {
  1028			omap_dma_stop(c);
  1029			c->paused = true;
  1030		}
  1031	
  1032		return 0;
  1033	}
  1034	
  1035	static int omap_dma_resume(struct dma_chan *chan)
  1036	{
  1037		struct omap_chan *c = to_omap_dma_chan(chan);
  1038	
  1039		/* Pause/Resume only allowed with cyclic mode */
  1040		if (!c->cyclic)
  1041			return -EINVAL;
  1042	
  1043		if (c->paused) {
  1044			mb();
  1045	
  1046			/* Restore channel link register */
  1047			omap_dma_chan_write(c, CLNK_CTRL, c->desc->clnk_ctrl);
  1048	
  1049			omap_dma_start(c, c->desc);
  1050			c->paused = false;
  1051		}
  1052	
  1053		return 0;
  1054	}
  1055	
  1056	static int omap_dma_chan_init(struct omap_dmadev *od)
  1057	{
  1058		struct omap_chan *c;
  1059	
  1060		c = kzalloc(sizeof(*c), GFP_KERNEL);
  1061		if (!c)
  1062			return -ENOMEM;
  1063	
  1064		c->reg_map = od->reg_map;
  1065		c->vc.desc_free = omap_dma_desc_free;
  1066		vchan_init(&c->vc, &od->ddev);
  1067	
  1068		return 0;
  1069	}
  1070	
  1071	static void omap_dma_free(struct omap_dmadev *od)
  1072	{
  1073		while (!list_empty(&od->ddev.channels)) {
  1074			struct omap_chan *c = list_first_entry(&od->ddev.channels,
  1075				struct omap_chan, vc.chan.device_node);
  1076	
  1077			list_del(&c->vc.chan.device_node);
  1078			tasklet_kill(&c->vc.task);
  1079			kfree(c);
  1080		}
  1081	}
  1082	
  1083	#define OMAP_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
  1084					 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
  1085					 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
  1086	
  1087	static int omap_dma_probe(struct platform_device *pdev)
  1088	{
  1089		struct omap_dmadev *od;
  1090		struct resource *res;
  1091		int rc, i, irq;
  1092	
  1093		od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
  1094		if (!od)
  1095			return -ENOMEM;
  1096	
  1097		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1098		od->base = devm_ioremap_resource(&pdev->dev, res);
  1099		if (IS_ERR(od->base))
  1100			return PTR_ERR(od->base);
  1101	
  1102		od->plat = omap_get_plat_info();
  1103		if (!od->plat)
  1104			return -EPROBE_DEFER;
  1105	
  1106		od->reg_map = od->plat->reg_map;
  1107	
  1108		dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
  1109		dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
  1110		dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
  1111		od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
  1112		od->ddev.device_free_chan_resources = omap_dma_free_chan_resources;
  1113		od->ddev.device_tx_status = omap_dma_tx_status;
  1114		od->ddev.device_issue_pending = omap_dma_issue_pending;
  1115		od->ddev.device_prep_slave_sg = omap_dma_prep_slave_sg;
  1116		od->ddev.device_prep_dma_cyclic = omap_dma_prep_dma_cyclic;
  1117		od->ddev.device_prep_dma_memcpy = omap_dma_prep_dma_memcpy;
  1118		od->ddev.device_config = omap_dma_slave_config;
  1119		od->ddev.device_pause = omap_dma_pause;
  1120		od->ddev.device_resume = omap_dma_resume;
  1121		od->ddev.device_terminate_all = omap_dma_terminate_all;
> 1122		od-ddev.device_synchronize = omap_dma_synchronize;
  1123		od->ddev.src_addr_widths = OMAP_DMA_BUSWIDTHS;
  1124		od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
  1125		od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/7c8db97c/attachment-0001.obj>
