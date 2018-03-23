From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Mar 2018 13:28:13 +0800
Subject: [PATCH V2 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
In-Reply-To: <1521602391-30356-5-git-send-email-aisheng.dong@nxp.com>
References: <1521602391-30356-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201803231355.8w9QsOLo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-new-APIs-to-handle-all-available-clocks/20180323-122451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-randconfig-x007-201811 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/video/fbdev/simplefb.c: In function 'simplefb_clocks_enable':
>> drivers/video/fbdev/simplefb.c:250:42: warning: no return statement in function returning non-void [-Wreturn-type]
    static int simplefb_clocks_enable(struct simplefb_par *par) { }
                                             ^~~~~~~~~~~~
   drivers/video/fbdev/simplefb.c: In function 'simplefb_probe':
>> drivers/video/fbdev/simplefb.c:442:2: error: too many arguments to function 'simplefb_clocks_enable'
     simplefb_clocks_enable(par, pdev);
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/simplefb.c:250:12: note: declared here
    static int simplefb_clocks_enable(struct simplefb_par *par) { }
               ^~~~~~~~~~~~~~~~~~~~~~

vim +/simplefb_clocks_enable +442 drivers/video/fbdev/simplefb.c

fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  239  
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  240  static void simplefb_clocks_destroy(struct simplefb_par *par)
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  241  {
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  242  	if (par->clks_enabled)
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21  243  		clk_bulk_disable_unprepare(par->clk_count, par->clks);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  244  
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21  245  	clk_bulk_put_all(par->clk_count, par->clks);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  246  }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  247  #else
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  248  static int simplefb_clocks_get(struct simplefb_par *par,
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  249  	struct platform_device *pdev) { return 0; }
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21 @250  static int simplefb_clocks_enable(struct simplefb_par *par) { }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  251  static void simplefb_clocks_destroy(struct simplefb_par *par) { }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  252  #endif
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  253  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  254  #if defined CONFIG_OF && defined CONFIG_REGULATOR
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  255  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  256  #define SUPPLY_SUFFIX "-supply"
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  257  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  258  /*
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  259   * Regulator handling code.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  260   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  261   * Here we handle the num-supplies and vin*-supply properties of our
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  262   * "simple-framebuffer" dt node. This is necessary so that we can make sure
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  263   * that any regulators needed by the display hardware that the bootloader
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  264   * set up for us (and for which it provided a simplefb dt node), stay up,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  265   * for the life of the simplefb driver.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  266   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  267   * When the driver unloads, we cleanly disable, and then release the
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  268   * regulators.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  269   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  270   * We only complain about errors here, no action is taken as the most likely
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  271   * error can only happen due to a mismatch between the bootloader which set
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  272   * up simplefb, and the regulator definitions in the device tree. Chances are
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  273   * that there are no adverse effects, and if there are, a clean teardown of
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  274   * the fb probe will not help us much either. So just complain and carry on,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  275   * and hope that the user actually gets a working fb at the end of things.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  276   */
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  277  static int simplefb_regulators_get(struct simplefb_par *par,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  278  				   struct platform_device *pdev)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  279  {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  280  	struct device_node *np = pdev->dev.of_node;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  281  	struct property *prop;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  282  	struct regulator *regulator;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  283  	const char *p;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  284  	int count = 0, i = 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  285  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  286  	if (dev_get_platdata(&pdev->dev) || !np)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  287  		return 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  288  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  289  	/* Count the number of regulator supplies */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  290  	for_each_property_of_node(np, prop) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  291  		p = strstr(prop->name, SUPPLY_SUFFIX);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  292  		if (p && p != prop->name)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  293  			count++;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  294  	}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  295  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  296  	if (!count)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  297  		return 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  298  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  299  	par->regulators = devm_kcalloc(&pdev->dev, count,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  300  				       sizeof(struct regulator *), GFP_KERNEL);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  301  	if (!par->regulators)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  302  		return -ENOMEM;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  303  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  304  	/* Get all the regulators */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  305  	for_each_property_of_node(np, prop) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  306  		char name[32]; /* 32 is max size of property name */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  307  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  308  		p = strstr(prop->name, SUPPLY_SUFFIX);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  309  		if (!p || p == prop->name)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  310  			continue;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  311  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  312  		strlcpy(name, prop->name,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  313  			strlen(prop->name) - strlen(SUPPLY_SUFFIX) + 1);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  314  		regulator = devm_regulator_get_optional(&pdev->dev, name);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  315  		if (IS_ERR(regulator)) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  316  			if (PTR_ERR(regulator) == -EPROBE_DEFER)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  317  				return -EPROBE_DEFER;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  318  			dev_err(&pdev->dev, "regulator %s not found: %ld\n",
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  319  				name, PTR_ERR(regulator));
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  320  			continue;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  321  		}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  322  		par->regulators[i++] = regulator;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  323  	}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  324  	par->regulator_count = i;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  325  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  326  	return 0;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  327  }
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  328  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  329  static void simplefb_regulators_enable(struct simplefb_par *par,
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  330  				       struct platform_device *pdev)
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  331  {
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  332  	int i, ret;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  333  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  334  	/* Enable all the regulators */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  335  	for (i = 0; i < par->regulator_count; i++) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  336  		ret = regulator_enable(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  337  		if (ret) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  338  			dev_err(&pdev->dev,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  339  				"failed to enable regulator %d: %d\n",
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  340  				i, ret);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  341  			devm_regulator_put(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  342  			par->regulators[i] = NULL;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  343  		}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  344  	}
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  345  	par->regulators_enabled = true;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  346  }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  347  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  348  static void simplefb_regulators_destroy(struct simplefb_par *par)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  349  {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  350  	int i;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  351  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  352  	if (!par->regulators || !par->regulators_enabled)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  353  		return;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  354  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  355  	for (i = 0; i < par->regulator_count; i++)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  356  		if (par->regulators[i])
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  357  			regulator_disable(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  358  }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  359  #else
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  360  static int simplefb_regulators_get(struct simplefb_par *par,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  361  	struct platform_device *pdev) { return 0; }
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  362  static void simplefb_regulators_enable(struct simplefb_par *par,
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  363  	struct platform_device *pdev) { }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  364  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  365  #endif
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  366  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  367  static int simplefb_probe(struct platform_device *pdev)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  368  {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  369  	int ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  370  	struct simplefb_params params;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  371  	struct fb_info *info;
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  372  	struct simplefb_par *par;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  373  	struct resource *mem;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  374  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  375  	if (fb_get_options("simplefb", NULL))
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  376  		return -ENODEV;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  377  
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  378  	ret = -ENODEV;
129f1be4 drivers/video/simplefb.c       Jingoo Han     2013-09-17  379  	if (dev_get_platdata(&pdev->dev))
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  380  		ret = simplefb_parse_pd(pdev, &params);
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  381  	else if (pdev->dev.of_node)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  382  		ret = simplefb_parse_dt(pdev, &params);
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  383  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  384  	if (ret)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  385  		return ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  386  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  387  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  388  	if (!mem) {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  389  		dev_err(&pdev->dev, "No memory resource\n");
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  390  		return -EINVAL;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  391  	}
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  392  
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  393  	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  394  	if (!info)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  395  		return -ENOMEM;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  396  	platform_set_drvdata(pdev, info);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  397  
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  398  	par = info->par;
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  399  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  400  	info->fix = simplefb_fix;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  401  	info->fix.smem_start = mem->start;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  402  	info->fix.smem_len = resource_size(mem);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  403  	info->fix.line_length = params.stride;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  404  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  405  	info->var = simplefb_var;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  406  	info->var.xres = params.width;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  407  	info->var.yres = params.height;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  408  	info->var.xres_virtual = params.width;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  409  	info->var.yres_virtual = params.height;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  410  	info->var.bits_per_pixel = params.format->bits_per_pixel;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  411  	info->var.red = params.format->red;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  412  	info->var.green = params.format->green;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  413  	info->var.blue = params.format->blue;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  414  	info->var.transp = params.format->transp;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  415  
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  416  	info->apertures = alloc_apertures(1);
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  417  	if (!info->apertures) {
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  418  		ret = -ENOMEM;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  419  		goto error_fb_release;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  420  	}
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  421  	info->apertures->ranges[0].base = info->fix.smem_start;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  422  	info->apertures->ranges[0].size = info->fix.smem_len;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  423  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  424  	info->fbops = &simplefb_ops;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  425  	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
9e210be6 drivers/video/simplefb.c       David Herrmann 2013-10-02  426  	info->screen_base = ioremap_wc(info->fix.smem_start,
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  427  				       info->fix.smem_len);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  428  	if (!info->screen_base) {
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  429  		ret = -ENOMEM;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  430  		goto error_fb_release;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  431  	}
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  432  	info->pseudo_palette = par->palette;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  433  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  434  	ret = simplefb_clocks_get(par, pdev);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  435  	if (ret < 0)
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  436  		goto error_unmap;
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  437  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  438  	ret = simplefb_regulators_get(par, pdev);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  439  	if (ret < 0)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  440  		goto error_clocks;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  441  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11 @442  	simplefb_clocks_enable(par, pdev);
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  443  	simplefb_regulators_enable(par, pdev);
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  444  
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  445  	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  446  			     info->fix.smem_start, info->fix.smem_len,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  447  			     info->screen_base);
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  448  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  449  			     params.format->name,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  450  			     info->var.xres, info->var.yres,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  451  			     info->var.bits_per_pixel, info->fix.line_length);
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  452  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  453  	ret = register_framebuffer(info);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  454  	if (ret < 0) {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  455  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  456  		goto error_regulators;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  457  	}
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  458  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  459  	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  460  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  461  	return 0;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  462  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  463  error_regulators:
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  464  	simplefb_regulators_destroy(par);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  465  error_clocks:
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  466  	simplefb_clocks_destroy(par);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  467  error_unmap:
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  468  	iounmap(info->screen_base);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  469  error_fb_release:
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  470  	framebuffer_release(info);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  471  	return ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  472  }
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  473  

:::::: The code at line 442 was first introduced by commit
:::::: a3accfd70e166af4956a686ffcdf414702c0a13e video: fbdev: simplefb: Separate clk / regulator get and enable steps

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32787 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180323/d3494521/attachment-0001.gz>
