From: lkp@intel.com (kbuild test robot)
Date: Sun, 30 Jul 2017 08:45:45 +0800
Subject: [PATCH] memory: mtk-smi: Use of_device_get_match_data helper
In-Reply-To: <1501062725-8571-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <201707300800.UX7FZ2fo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Honghui,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc2 next-20170728]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/honghui-zhang-mediatek-com/memory-mtk-smi-Use-of_device_get_match_data-helper/20170728-161812
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers//memory/mtk-smi.c: In function 'mtk_smi_common_probe':
>> drivers//memory/mtk-smi.c:341:10: error: incompatible types when assigning to type 'enum mtk_smi_gen' from type 'const void *'
     smi_gen = of_device_get_match_data(dev);
             ^

vim +341 drivers//memory/mtk-smi.c

   311	
   312	static int mtk_smi_common_probe(struct platform_device *pdev)
   313	{
   314		struct device *dev = &pdev->dev;
   315		struct mtk_smi *common;
   316		struct resource *res;
   317		enum mtk_smi_gen smi_gen;
   318	
   319		if (!dev->pm_domain)
   320			return -EPROBE_DEFER;
   321	
   322		common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
   323		if (!common)
   324			return -ENOMEM;
   325		common->dev = dev;
   326	
   327		common->clk_apb = devm_clk_get(dev, "apb");
   328		if (IS_ERR(common->clk_apb))
   329			return PTR_ERR(common->clk_apb);
   330	
   331		common->clk_smi = devm_clk_get(dev, "smi");
   332		if (IS_ERR(common->clk_smi))
   333			return PTR_ERR(common->clk_smi);
   334	
   335		/*
   336		 * for mtk smi gen 1, we need to get the ao(always on) base to config
   337		 * m4u port, and we need to enable the aync clock for transform the smi
   338		 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
   339		 * base.
   340		 */
 > 341		smi_gen = of_device_get_match_data(dev);
   342		if (smi_gen == MTK_SMI_GEN1) {
   343			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   344			common->smi_ao_base = devm_ioremap_resource(dev, res);
   345			if (IS_ERR(common->smi_ao_base))
   346				return PTR_ERR(common->smi_ao_base);
   347	
   348			common->clk_async = devm_clk_get(dev, "async");
   349			if (IS_ERR(common->clk_async))
   350				return PTR_ERR(common->clk_async);
   351	
   352			clk_prepare_enable(common->clk_async);
   353		}
   354		pm_runtime_enable(dev);
   355		platform_set_drvdata(pdev, common);
   356		return 0;
   357	}
   358	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56840 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170730/8992a771/attachment-0001.gz>
