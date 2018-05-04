From: lkp@intel.com (kbuild test robot)
Date: Fri, 4 May 2018 10:46:17 +0800
Subject: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
In-Reply-To: <20180503213645.20694-4-yixun.lan@amlogic.com>
References: <20180503213645.20694-4-yixun.lan@amlogic.com>
Message-ID: <201805041025.Wr39N2Ip%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunny,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc3]
[also build test WARNING on next-20180503]
[cannot apply to spi/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/spi-meson-axg-add-few-enhanced-features/20180504-083512
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/spi/spi-meson-spicc.c: In function 'meson_spicc_clk_init':
>> drivers/spi/spi-meson-spicc.c:583:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     div1->reg = spicc->base + (u64) div1->reg;
                               ^
   drivers/spi/spi-meson-spicc.c:621:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     div1->reg = spicc->base + (u64) div1->reg;
                               ^
   drivers/spi/spi-meson-spicc.c:638:27: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     mux->reg = spicc->base + (u64) mux->reg;
                              ^

vim +583 drivers/spi/spi-meson-spicc.c

   546	
   547	static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
   548	{
   549		struct device *dev = &spicc->pdev->dev;
   550		struct clk_fixed_factor *div0;
   551		struct clk_divider *div1;
   552		struct clk_mux *mux;
   553		struct clk_init_data init;
   554		struct clk *clk;
   555		const char *parent_names[1];
   556		const char *mux_parent_names[2];
   557		char name[32];
   558	
   559		div0 = &meson_spicc_div0;
   560		snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
   561		init.name = name;
   562		init.ops = &clk_fixed_factor_ops;
   563		init.flags = 0;
   564		parent_names[0] = __clk_get_name(spicc->core);
   565		init.parent_names = parent_names;
   566		init.num_parents = 1;
   567	
   568		div0->hw.init = &init;
   569	
   570		clk = devm_clk_register(dev, &div0->hw);
   571		if (WARN_ON(IS_ERR(clk)))
   572			return PTR_ERR(clk);
   573	
   574		div1 = &meson_spicc_div1;
   575		snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
   576		init.name = name;
   577		init.ops = &clk_divider_ops;
   578		init.flags = CLK_SET_RATE_PARENT;
   579		parent_names[0] = __clk_get_name(clk);
   580		init.parent_names = parent_names;
   581		init.num_parents = 1;
   582	
 > 583		div1->reg = spicc->base + (u64) div1->reg;
   584		div1->hw.init = &init;
   585	
   586		clk = devm_clk_register(dev, &div1->hw);
   587		if (WARN_ON(IS_ERR(clk)))
   588			return PTR_ERR(clk);
   589	
   590		if (spicc->data->has_enhance_clk_div == false) {
   591			spicc->clk = clk;
   592			return 0;
   593		}
   594	
   595		mux_parent_names[0] = __clk_get_name(clk);
   596	
   597		div0 = &meson_spicc_div2;
   598		snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
   599		init.name = name;
   600		init.ops = &clk_fixed_factor_ops;
   601		init.flags = 0;
   602		parent_names[0] = __clk_get_name(spicc->core);
   603		init.parent_names = parent_names;
   604		init.num_parents = 1;
   605	
   606		div0->hw.init = &init;
   607	
   608		clk = devm_clk_register(dev, &div0->hw);
   609		if (WARN_ON(IS_ERR(clk)))
   610			return PTR_ERR(clk);
   611	
   612		div1 = &meson_spicc_div3;
   613		snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
   614		init.name = name;
   615		init.ops = &clk_divider_ops;
   616		init.flags = CLK_SET_RATE_PARENT;
   617		parent_names[0] = __clk_get_name(clk);
   618		init.parent_names = parent_names;
   619		init.num_parents = 1;
   620	
   621		div1->reg = spicc->base + (u64) div1->reg;
   622		div1->hw.init = &init;
   623	
   624		clk = devm_clk_register(dev, &div1->hw);
   625		if (WARN_ON(IS_ERR(clk)))
   626			return PTR_ERR(clk);
   627	
   628		mux_parent_names[1] = __clk_get_name(clk);
   629	
   630		mux = &meson_spicc_sel;
   631		snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
   632		init.name = name;
   633		init.ops = &clk_mux_ops;
   634		init.parent_names = mux_parent_names;
   635		init.num_parents = 2;
   636		init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
   637	
   638		mux->reg = spicc->base + (u64) mux->reg;
   639		mux->hw.init = &init;
   640	
   641		spicc->clk = devm_clk_register(dev, &mux->hw);
   642		if (WARN_ON(IS_ERR(spicc->clk)))
   643			return PTR_ERR(spicc->clk);
   644	
   645		clk_set_parent(spicc->clk, clk);
   646		return 0;
   647	}
   648	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52913 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/53be491b/attachment-0001.gz>
