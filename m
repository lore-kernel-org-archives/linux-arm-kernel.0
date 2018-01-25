From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Jan 2018 05:16:29 +0800
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <201801260437.xnzybhUC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15-rc9 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/usb-dwc3-add-UniPhier-dwc3-glue-layer-support/20180126-035928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/usb//dwc3/dwc3-uniphier.c: In function 'dwc3u_probe':
>> drivers/usb//dwc3/dwc3-uniphier.c:428:12: error: implicit declaration of function 'of_clk_get_parent_count'; did you mean 'clk_get_parent'? [-Werror=implicit-function-declaration]
     nr_clks = of_clk_get_parent_count(node);
               ^~~~~~~~~~~~~~~~~~~~~~~
               clk_get_parent
   cc1: some warnings being treated as errors

vim +428 drivers/usb//dwc3/dwc3-uniphier.c

   401	
   402	static int dwc3u_probe(struct platform_device *pdev)
   403	{
   404		struct device *dev = &pdev->dev;
   405		struct device_node *node;
   406		struct dwc3u_priv *priv;
   407		struct resource	*res;
   408		struct clk *clk;
   409		int i, nr_clks;
   410		int ret = 0;
   411	
   412		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
   413		if (!priv)
   414			return -ENOMEM;
   415	
   416		priv->data = of_device_get_match_data(dev);
   417		if (WARN_ON(!priv->data))
   418			return -EINVAL;
   419	
   420		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   421		priv->base = devm_ioremap_resource(dev, res);
   422		if (IS_ERR(priv->base))
   423			return PTR_ERR(priv->base);
   424	
   425		priv->dev = dev;
   426	
   427		node = dev->of_node;
 > 428		nr_clks = of_clk_get_parent_count(node);
   429		if (!nr_clks) {
   430			dev_err(dev, "failed to get clock property\n");
   431			return -ENODEV;
   432		}
   433	
   434		priv->clks = devm_kcalloc(priv->dev, nr_clks, sizeof(struct clk *),
   435					  GFP_KERNEL);
   436		if (!priv->clks)
   437			return -ENOMEM;
   438	
   439		for (i = 0; i < nr_clks; i++) {
   440			clk = of_clk_get(node, i);
   441			if (IS_ERR(clk)) {
   442				ret = PTR_ERR(clk);
   443				goto out_clk_disable;
   444			}
   445			ret = clk_prepare_enable(clk);
   446			if (ret < 0) {
   447				clk_put(clk);
   448				goto out_clk_disable;
   449			}
   450			priv->clks[i] = clk;
   451			priv->nclks = i;
   452		}
   453	
   454		priv->rst = devm_reset_control_array_get_optional_shared(priv->dev);
   455		if (IS_ERR(priv->rst)) {
   456			ret = PTR_ERR(priv->rst);
   457			goto out_clk_disable;
   458		}
   459		ret = reset_control_deassert(priv->rst);
   460		if (ret)
   461			goto out_clk_disable;
   462	
   463		ret = dwc3u_init(priv);
   464		if (ret)
   465			goto out_rst_assert;
   466	
   467		platform_set_drvdata(pdev, priv);
   468	
   469		ret = of_platform_populate(node, NULL, NULL, priv->dev);
   470		if (ret)
   471			goto out_exit;
   472	
   473		return 0;
   474	
   475	out_exit:
   476		dwc3u_exit(priv);
   477	out_rst_assert:
   478		reset_control_assert(priv->rst);
   479	out_clk_disable:
   480		dwc3u_disable_clk(priv);
   481	
   482		return ret;
   483	}
   484	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49793 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/0b69fbdb/attachment-0001.gz>
