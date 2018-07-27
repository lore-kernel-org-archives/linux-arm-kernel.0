From: lkp@intel.com (kbuild test robot)
Date: Sat, 28 Jul 2018 04:53:47 +0800
Subject: [PATCH v4 2/2] fpga: zynq-fpga: Add support for readback of FPGA
 configuration data and registers
In-Reply-To: <1532672551-22146-2-git-send-email-appana.durga.rao@xilinx.com>
References: <1532672551-22146-2-git-send-email-appana.durga.rao@xilinx.com>
Message-ID: <201807280410.sCpMAPxV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Appana,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sof-driver-fuweitax/master]
[cannot apply to v4.18-rc6 next-20180727]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Appana-Durga-Kedareswara-rao/fpga-fpga-mgr-Add-readback-support/20180728-034920
base:   https://github.com/fuweitax/linux master
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/fpga/zynq-fpga.c: In function 'zynq_fpga_probe':
>> drivers/fpga/zynq-fpga.c:1032:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     struct dentry *d;
     ^~~~~~

vim +1032 drivers/fpga/zynq-fpga.c

   963	
   964	static int zynq_fpga_probe(struct platform_device *pdev)
   965	{
   966		struct device *dev = &pdev->dev;
   967		struct zynq_fpga_priv *priv;
   968		struct resource *res;
   969		int err;
   970	
   971		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   972		if (!priv)
   973			return -ENOMEM;
   974		spin_lock_init(&priv->dma_lock);
   975	
   976		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   977		priv->io_base = devm_ioremap_resource(dev, res);
   978		if (IS_ERR(priv->io_base))
   979			return PTR_ERR(priv->io_base);
   980	
   981		priv->slcr = syscon_regmap_lookup_by_phandle(dev->of_node,
   982			"syscon");
   983		if (IS_ERR(priv->slcr)) {
   984			dev_err(dev, "unable to get zynq-slcr regmap\n");
   985			return PTR_ERR(priv->slcr);
   986		}
   987	
   988		init_completion(&priv->dma_done);
   989	
   990		priv->irq = platform_get_irq(pdev, 0);
   991		if (priv->irq < 0) {
   992			dev_err(dev, "No IRQ available\n");
   993			return priv->irq;
   994		}
   995	
   996		priv->clk = devm_clk_get(dev, "ref_clk");
   997		if (IS_ERR(priv->clk)) {
   998			dev_err(dev, "input clock not found\n");
   999			return PTR_ERR(priv->clk);
  1000		}
  1001	
  1002		err = clk_prepare_enable(priv->clk);
  1003		if (err) {
  1004			dev_err(dev, "unable to enable clock\n");
  1005			return err;
  1006		}
  1007	
  1008		/* unlock the device */
  1009		zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
  1010	
  1011		zynq_fpga_set_irq(priv, 0);
  1012		zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
  1013		err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
  1014				       priv);
  1015		if (err) {
  1016			dev_err(dev, "unable to request IRQ\n");
  1017			clk_disable_unprepare(priv->clk);
  1018			return err;
  1019		}
  1020	
  1021		clk_disable(priv->clk);
  1022	
  1023		err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
  1024					&zynq_fpga_ops, priv);
  1025		if (err) {
  1026			dev_err(dev, "unable to register FPGA manager\n");
  1027			clk_unprepare(priv->clk);
  1028			return err;
  1029		}
  1030	
  1031	#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> 1032		struct dentry *d;
  1033		struct fpga_manager *mgr;
  1034	
  1035		mgr = platform_get_drvdata(pdev);
  1036		mutex_init(&priv->ref_mutex);
  1037	
  1038		d = debugfs_create_dir(pdev->dev.kobj.name, mgr->dir);
  1039		if (!d)
  1040			return err;
  1041	
  1042		priv->dir = d;
  1043		d = debugfs_create_file("cfg_reg", 0644, priv->dir, mgr,
  1044					&zynq_fpga_ops_cfg_reg);
  1045		if (!d) {
  1046			debugfs_remove_recursive(mgr->dir);
  1047			return err;
  1048		}
  1049	#endif
  1050	
  1051		return 0;
  1052	}
  1053	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52967 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180728/721d0696/attachment-0001.gz>
