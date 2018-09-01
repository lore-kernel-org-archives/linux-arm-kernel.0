From: lkp@intel.com (kbuild test robot)
Date: Sat, 1 Sep 2018 11:57:11 +0800
Subject: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
In-Reply-To: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <201809011144.mFh1nyXD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matti,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/clk-clkdev-of_clk-add-managed-lookup-and-provider-registrations/20180831-045158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/clk/clk-bd718x7.c: In function 'bd71837_clk_set':
   drivers/clk/clk-bd718x7.c:28:39: error: dereferencing pointer to incomplete type 'struct bd718xx'
     return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
                                          ^~
   drivers/clk/clk-bd718x7.c: In function 'bd71837_clk_probe':
   drivers/clk/clk-bd718x7.c:91:11: error: 'BD718XX_REG_OUT32K' undeclared (first use in this function); did you mean 'BD71837_REG_OUT32K'?
     c->reg = BD718XX_REG_OUT32K;
              ^~~~~~~~~~~~~~~~~~
              BD71837_REG_OUT32K
   drivers/clk/clk-bd718x7.c:91:11: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clk/clk-bd718x7.c:92:12: error: 'BD718XX_OUT32K_EN' undeclared (first use in this function); did you mean 'BD718XX_REG_OUT32K'?
     c->mask = BD718XX_OUT32K_EN;
               ^~~~~~~~~~~~~~~~~
               BD718XX_REG_OUT32K
   drivers/clk/clk-bd718x7.c: In function 'bd71837_clk_set':
   drivers/clk/clk-bd718x7.c:29:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +92 drivers/clk/clk-bd718x7.c

    23	
    24	static int bd71837_clk_set(struct clk_hw *hw, int status)
    25	{
    26		struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
    27	
  > 28		return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
    29	}
    30	
    31	static void bd71837_clk_disable(struct clk_hw *hw)
    32	{
    33		int rv;
    34		struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
    35	
    36		rv = bd71837_clk_set(hw, 0);
    37		if (rv)
    38			dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
    39	}
    40	
    41	static int bd71837_clk_enable(struct clk_hw *hw)
    42	{
    43		return bd71837_clk_set(hw, 1);
    44	}
    45	
    46	static int bd71837_clk_is_enabled(struct clk_hw *hw)
    47	{
    48		int enabled;
    49		int rval;
    50		struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
    51	
    52		rval = regmap_read(c->mfd->regmap, c->reg, &enabled);
    53	
    54		if (rval)
    55			return rval;
    56	
    57		return enabled & c->mask;
    58	}
    59	
    60	static const struct clk_ops bd71837_clk_ops = {
    61		.prepare = &bd71837_clk_enable,
    62		.unprepare = &bd71837_clk_disable,
    63		.is_prepared = &bd71837_clk_is_enabled,
    64	};
    65	
    66	static int bd71837_clk_probe(struct platform_device *pdev)
    67	{
    68		struct bd718xx_clk *c;
    69		int rval = -ENOMEM;
    70		const char *parent_clk;
    71		struct device *parent = pdev->dev.parent;
    72		struct bd718xx *mfd = dev_get_drvdata(parent);
    73		struct clk_init_data init = {
    74			.name = "bd718xx-32k-out",
    75			.ops = &bd71837_clk_ops,
    76		};
    77	
    78		c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
    79		if (!c)
    80			return -ENOMEM;
    81	
    82		init.num_parents = 1;
    83		parent_clk = of_clk_get_parent_name(parent->of_node, 0);
    84	
    85		init.parent_names = &parent_clk;
    86		if (!parent_clk) {
    87			dev_err(&pdev->dev, "No parent clk found\n");
    88			return -EINVAL;
    89		}
    90	
    91		c->reg = BD718XX_REG_OUT32K;
  > 92		c->mask = BD718XX_OUT32K_EN;
    93		c->mfd = mfd;
    94		c->pdev = pdev;
    95		c->hw.init = &init;
    96	
    97		of_property_read_string_index(parent->of_node,
    98					      "clock-output-names", 0, &init.name);
    99	
   100		rval = devm_clk_hw_register(&pdev->dev, &c->hw);
   101		if (!rval) {
   102			rval = devm_clk_hw_register_clkdev(&pdev->dev,
   103							   &c->hw, init.name, NULL);
   104			if (rval)
   105				dev_warn(&pdev->dev, "Failed to register clkdev\n");
   106			if (parent->of_node) {
   107				rval = devm_of_clk_add_parent_hw_provider(&pdev->dev,
   108						     of_clk_hw_simple_get, &c->hw);
   109				if (rval)
   110					dev_err(&pdev->dev,
   111						"adding clk provider failed\n");
   112			}
   113		} else {
   114			dev_err(&pdev->dev, "failed to register 32K clk");
   115		}
   116	
   117		return rval;
   118	}
   119	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64474 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180901/261cbc81/attachment-0001.gz>
