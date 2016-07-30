From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jul 2016 12:32:35 +0800
Subject: [PATCH net-next 08/10] drivers: net: xgene: Poll link status via
 GPIO
In-Reply-To: <1469838843-19943-9-git-send-email-isubramanian@apm.com>
Message-ID: <201607301242.96Hv3p6V%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/Fix-warning-and-issues/20160730-083713
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_irq_set_type':
>> drivers/gpio/gpio-xgene-sb.c:111:3: error: implicit declaration of function 'irq_chip_set_type_parent' [-Werror=implicit-function-declaration]
      return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
      ^
   drivers/gpio/gpio-xgene-sb.c: At top level:
>> drivers/gpio/gpio-xgene-sb.c:118:13: error: 'irq_chip_eoi_parent' undeclared here (not in a function)
     .irq_eoi = irq_chip_eoi_parent,
                ^
>> drivers/gpio/gpio-xgene-sb.c:119:20: error: 'irq_chip_mask_parent' undeclared here (not in a function)
     .irq_mask       = irq_chip_mask_parent,
                       ^
>> drivers/gpio/gpio-xgene-sb.c:120:20: error: 'irq_chip_unmask_parent' undeclared here (not in a function)
     .irq_unmask     = irq_chip_unmask_parent,
                       ^
   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_domain_alloc':
>> drivers/gpio/gpio-xgene-sb.c:198:3: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
      irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
      ^
>> drivers/gpio/gpio-xgene-sb.c:201:31: error: 'struct irq_domain' has no member named 'parent'
     parent_fwspec.fwnode = domain->parent->fwnode;
                                  ^
>> drivers/gpio/gpio-xgene-sb.c:215:2: error: implicit declaration of function 'irq_domain_alloc_irqs_parent' [-Werror=implicit-function-declaration]
     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
     ^
   drivers/gpio/gpio-xgene-sb.c: At top level:
>> drivers/gpio/gpio-xgene-sb.c:220:2: error: unknown field 'translate' specified in initializer
     .translate      = xgene_gpio_sb_domain_translate,
     ^
>> drivers/gpio/gpio-xgene-sb.c:220:2: warning: initialization from incompatible pointer type
   drivers/gpio/gpio-xgene-sb.c:220:2: warning: (near initialization for 'xgene_gpio_sb_domain_ops.match')
>> drivers/gpio/gpio-xgene-sb.c:221:2: error: unknown field 'alloc' specified in initializer
     .alloc          = xgene_gpio_sb_domain_alloc,
     ^
   drivers/gpio/gpio-xgene-sb.c:221:2: warning: initialization from incompatible pointer type
   drivers/gpio/gpio-xgene-sb.c:221:2: warning: (near initialization for 'xgene_gpio_sb_domain_ops.select')
>> drivers/gpio/gpio-xgene-sb.c:222:2: error: unknown field 'free' specified in initializer
     .free           = irq_domain_free_irqs_common,
     ^
>> drivers/gpio/gpio-xgene-sb.c:222:20: error: 'irq_domain_free_irqs_common' undeclared here (not in a function)
     .free           = irq_domain_free_irqs_common,
                       ^
>> drivers/gpio/gpio-xgene-sb.c:223:2: error: unknown field 'activate' specified in initializer
     .activate = xgene_gpio_sb_domain_activate,
     ^
   drivers/gpio/gpio-xgene-sb.c:223:2: warning: initialization from incompatible pointer type
   drivers/gpio/gpio-xgene-sb.c:223:2: warning: (near initialization for 'xgene_gpio_sb_domain_ops.unmap')
>> drivers/gpio/gpio-xgene-sb.c:224:2: error: unknown field 'deactivate' specified in initializer
     .deactivate = xgene_gpio_sb_domain_deactivate,
     ^
   drivers/gpio/gpio-xgene-sb.c:224:2: warning: initialization from incompatible pointer type
   drivers/gpio/gpio-xgene-sb.c:224:2: warning: (near initialization for 'xgene_gpio_sb_domain_ops.xlate')
   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_probe':
>> drivers/gpio/gpio-xgene-sb.c:293:2: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
     ^
>> drivers/gpio/gpio-xgene-sb.c:293:19: warning: assignment makes pointer from integer without a cast
     priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
                      ^
   cc1: some warnings being treated as errors

vim +/irq_chip_set_type_parent +111 drivers/gpio/gpio-xgene-sb.c

1013fc417 Quan Nguyen        2016-02-17  105  			gpio * 2, 1);
1013fc417 Quan Nguyen        2016-02-17  106  	xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_INT_LVL,
1013fc417 Quan Nguyen        2016-02-17  107  			d->hwirq, lvl_type);
1013fc417 Quan Nguyen        2016-02-17  108  
1013fc417 Quan Nguyen        2016-02-17  109  	/* Propagate IRQ type setting to parent */
1013fc417 Quan Nguyen        2016-02-17  110  	if (type & IRQ_TYPE_EDGE_BOTH)
1013fc417 Quan Nguyen        2016-02-17 @111  		return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
1013fc417 Quan Nguyen        2016-02-17  112  	else
1013fc417 Quan Nguyen        2016-02-17  113  		return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
1013fc417 Quan Nguyen        2016-02-17  114  }
1013fc417 Quan Nguyen        2016-02-17  115  
1013fc417 Quan Nguyen        2016-02-17  116  static struct irq_chip xgene_gpio_sb_irq_chip = {
1013fc417 Quan Nguyen        2016-02-17  117  	.name           = "sbgpio",
1013fc417 Quan Nguyen        2016-02-17 @118  	.irq_eoi	= irq_chip_eoi_parent,
1013fc417 Quan Nguyen        2016-02-17 @119  	.irq_mask       = irq_chip_mask_parent,
1013fc417 Quan Nguyen        2016-02-17 @120  	.irq_unmask     = irq_chip_unmask_parent,
1013fc417 Quan Nguyen        2016-02-17  121  	.irq_set_type   = xgene_gpio_sb_irq_set_type,
1013fc417 Quan Nguyen        2016-02-17  122  };
b2b35e108 Y Vo               2015-01-16  123  
1013fc417 Quan Nguyen        2016-02-17  124  static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
1013fc417 Quan Nguyen        2016-02-17  125  {
1013fc417 Quan Nguyen        2016-02-17  126  	struct xgene_gpio_sb *priv = gpiochip_get_data(gc);
1013fc417 Quan Nguyen        2016-02-17  127  	struct irq_fwspec fwspec;
b2b35e108 Y Vo               2015-01-16  128  
1013fc417 Quan Nguyen        2016-02-17  129  	if ((gpio < priv->irq_start) ||
1013fc417 Quan Nguyen        2016-02-17  130  			(gpio > HWIRQ_TO_GPIO(priv, priv->nirq)))
b2b35e108 Y Vo               2015-01-16  131  		return -ENXIO;
1013fc417 Quan Nguyen        2016-02-17  132  
1013fc417 Quan Nguyen        2016-02-17  133  	if (gc->parent->of_node)
1013fc417 Quan Nguyen        2016-02-17  134  		fwspec.fwnode = of_node_to_fwnode(gc->parent->of_node);
1013fc417 Quan Nguyen        2016-02-17  135  	else
1013fc417 Quan Nguyen        2016-02-17  136  		fwspec.fwnode = gc->parent->fwnode;
1013fc417 Quan Nguyen        2016-02-17  137  	fwspec.param_count = 2;
1013fc417 Quan Nguyen        2016-02-17  138  	fwspec.param[0] = GPIO_TO_HWIRQ(priv, gpio);
1013fc417 Quan Nguyen        2016-02-17  139  	fwspec.param[1] = IRQ_TYPE_NONE;
1013fc417 Quan Nguyen        2016-02-17  140  	return irq_create_fwspec_mapping(&fwspec);
1013fc417 Quan Nguyen        2016-02-17  141  }
1013fc417 Quan Nguyen        2016-02-17  142  
1013fc417 Quan Nguyen        2016-02-17  143  static void xgene_gpio_sb_domain_activate(struct irq_domain *d,
1013fc417 Quan Nguyen        2016-02-17  144  		struct irq_data *irq_data)
1013fc417 Quan Nguyen        2016-02-17  145  {
1013fc417 Quan Nguyen        2016-02-17  146  	struct xgene_gpio_sb *priv = d->host_data;
1013fc417 Quan Nguyen        2016-02-17  147  	u32 gpio = HWIRQ_TO_GPIO(priv, irq_data->hwirq);
1013fc417 Quan Nguyen        2016-02-17  148  
1013fc417 Quan Nguyen        2016-02-17  149  	if (gpiochip_lock_as_irq(&priv->gc, gpio)) {
1013fc417 Quan Nguyen        2016-02-17  150  		dev_err(priv->gc.parent,
1013fc417 Quan Nguyen        2016-02-17  151  		"Unable to configure XGene GPIO standby pin %d as IRQ\n",
1013fc417 Quan Nguyen        2016-02-17  152  				gpio);
1013fc417 Quan Nguyen        2016-02-17  153  		return;
1013fc417 Quan Nguyen        2016-02-17  154  	}
1013fc417 Quan Nguyen        2016-02-17  155  
1013fc417 Quan Nguyen        2016-02-17  156  	xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
1013fc417 Quan Nguyen        2016-02-17  157  			gpio * 2, 1);
1013fc417 Quan Nguyen        2016-02-17  158  }
1013fc417 Quan Nguyen        2016-02-17  159  
1013fc417 Quan Nguyen        2016-02-17  160  static void xgene_gpio_sb_domain_deactivate(struct irq_domain *d,
1013fc417 Quan Nguyen        2016-02-17  161  		struct irq_data *irq_data)
1013fc417 Quan Nguyen        2016-02-17  162  {
1013fc417 Quan Nguyen        2016-02-17  163  	struct xgene_gpio_sb *priv = d->host_data;
1013fc417 Quan Nguyen        2016-02-17  164  	u32 gpio = HWIRQ_TO_GPIO(priv, irq_data->hwirq);
1013fc417 Quan Nguyen        2016-02-17  165  
1013fc417 Quan Nguyen        2016-02-17  166  	gpiochip_unlock_as_irq(&priv->gc, gpio);
1013fc417 Quan Nguyen        2016-02-17  167  	xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
1013fc417 Quan Nguyen        2016-02-17  168  			gpio * 2, 0);
1013fc417 Quan Nguyen        2016-02-17  169  }
1013fc417 Quan Nguyen        2016-02-17  170  
1013fc417 Quan Nguyen        2016-02-17  171  static int xgene_gpio_sb_domain_translate(struct irq_domain *d,
1013fc417 Quan Nguyen        2016-02-17  172  		struct irq_fwspec *fwspec,
1013fc417 Quan Nguyen        2016-02-17  173  		unsigned long *hwirq,
1013fc417 Quan Nguyen        2016-02-17  174  		unsigned int *type)
1013fc417 Quan Nguyen        2016-02-17  175  {
1013fc417 Quan Nguyen        2016-02-17  176  	struct xgene_gpio_sb *priv = d->host_data;
1013fc417 Quan Nguyen        2016-02-17  177  
1013fc417 Quan Nguyen        2016-02-17  178  	if ((fwspec->param_count != 2) ||
1013fc417 Quan Nguyen        2016-02-17  179  		(fwspec->param[0] >= priv->nirq))
1013fc417 Quan Nguyen        2016-02-17  180  		return -EINVAL;
1013fc417 Quan Nguyen        2016-02-17  181  	*hwirq = fwspec->param[0];
1013fc417 Quan Nguyen        2016-02-17  182  	*type = fwspec->param[1];
1013fc417 Quan Nguyen        2016-02-17  183  	return 0;
b2b35e108 Y Vo               2015-01-16  184  }
b2b35e108 Y Vo               2015-01-16  185  
1013fc417 Quan Nguyen        2016-02-17  186  static int xgene_gpio_sb_domain_alloc(struct irq_domain *domain,
1013fc417 Quan Nguyen        2016-02-17  187  					unsigned int virq,
1013fc417 Quan Nguyen        2016-02-17  188  					unsigned int nr_irqs, void *data)
1013fc417 Quan Nguyen        2016-02-17  189  {
1013fc417 Quan Nguyen        2016-02-17  190  	struct irq_fwspec *fwspec = data;
1013fc417 Quan Nguyen        2016-02-17  191  	struct irq_fwspec parent_fwspec;
1013fc417 Quan Nguyen        2016-02-17  192  	struct xgene_gpio_sb *priv = domain->host_data;
1013fc417 Quan Nguyen        2016-02-17  193  	irq_hw_number_t hwirq;
1013fc417 Quan Nguyen        2016-02-17  194  	unsigned int i;
1013fc417 Quan Nguyen        2016-02-17  195  
1013fc417 Quan Nguyen        2016-02-17  196  	hwirq = fwspec->param[0];
1013fc417 Quan Nguyen        2016-02-17  197  	for (i = 0; i < nr_irqs; i++)
1013fc417 Quan Nguyen        2016-02-17 @198  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
1013fc417 Quan Nguyen        2016-02-17  199  				&xgene_gpio_sb_irq_chip, priv);
1013fc417 Quan Nguyen        2016-02-17  200  
1013fc417 Quan Nguyen        2016-02-17 @201  	parent_fwspec.fwnode = domain->parent->fwnode;
1013fc417 Quan Nguyen        2016-02-17  202  	if (is_of_node(parent_fwspec.fwnode)) {
1013fc417 Quan Nguyen        2016-02-17  203  		parent_fwspec.param_count = 3;
1013fc417 Quan Nguyen        2016-02-17  204  		parent_fwspec.param[0] = 0;/* SPI */
1013fc417 Quan Nguyen        2016-02-17  205  		/* Skip SGIs and PPIs*/
1013fc417 Quan Nguyen        2016-02-17  206  		parent_fwspec.param[1] = hwirq + priv->parent_irq_base - 32;
1013fc417 Quan Nguyen        2016-02-17  207  		parent_fwspec.param[2] = fwspec->param[1];
1013fc417 Quan Nguyen        2016-02-17  208  	} else if (is_fwnode_irqchip(parent_fwspec.fwnode)) {
1013fc417 Quan Nguyen        2016-02-17  209  		parent_fwspec.param_count = 2;
1013fc417 Quan Nguyen        2016-02-17  210  		parent_fwspec.param[0] = hwirq + priv->parent_irq_base;
1013fc417 Quan Nguyen        2016-02-17  211  		parent_fwspec.param[1] = fwspec->param[1];
1013fc417 Quan Nguyen        2016-02-17  212  	} else
1013fc417 Quan Nguyen        2016-02-17  213  		return -EINVAL;
1013fc417 Quan Nguyen        2016-02-17  214  
1013fc417 Quan Nguyen        2016-02-17 @215  	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
1013fc417 Quan Nguyen        2016-02-17  216  			&parent_fwspec);
1013fc417 Quan Nguyen        2016-02-17  217  }
1013fc417 Quan Nguyen        2016-02-17  218  
1013fc417 Quan Nguyen        2016-02-17  219  static const struct irq_domain_ops xgene_gpio_sb_domain_ops = {
1013fc417 Quan Nguyen        2016-02-17 @220  	.translate      = xgene_gpio_sb_domain_translate,
1013fc417 Quan Nguyen        2016-02-17 @221  	.alloc          = xgene_gpio_sb_domain_alloc,
c6cc75fec Axel Lin           2016-03-17 @222  	.free           = irq_domain_free_irqs_common,
1013fc417 Quan Nguyen        2016-02-17 @223  	.activate	= xgene_gpio_sb_domain_activate,
1013fc417 Quan Nguyen        2016-02-17 @224  	.deactivate	= xgene_gpio_sb_domain_deactivate,
1013fc417 Quan Nguyen        2016-02-17  225  };
1013fc417 Quan Nguyen        2016-02-17  226  
b2b35e108 Y Vo               2015-01-16  227  static int xgene_gpio_sb_probe(struct platform_device *pdev)
b2b35e108 Y Vo               2015-01-16  228  {
b2b35e108 Y Vo               2015-01-16  229  	struct xgene_gpio_sb *priv;
67ebb742b Andrzej Hajda      2016-02-23  230  	int ret;
b2b35e108 Y Vo               2015-01-16  231  	struct resource *res;
b2b35e108 Y Vo               2015-01-16  232  	void __iomem *regs;
1013fc417 Quan Nguyen        2016-02-17  233  	struct irq_domain *parent_domain = NULL;
1013fc417 Quan Nguyen        2016-02-17  234  	struct fwnode_handle *fwnode;
1013fc417 Quan Nguyen        2016-02-17  235  	u32 val32;
b2b35e108 Y Vo               2015-01-16  236  
b2b35e108 Y Vo               2015-01-16  237  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
b2b35e108 Y Vo               2015-01-16  238  	if (!priv)
b2b35e108 Y Vo               2015-01-16  239  		return -ENOMEM;
b2b35e108 Y Vo               2015-01-16  240  
b2b35e108 Y Vo               2015-01-16  241  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
b2b35e108 Y Vo               2015-01-16  242  	regs = devm_ioremap_resource(&pdev->dev, res);
33c07b467 Vladimir Zapolskiy 2015-03-29  243  	if (IS_ERR(regs))
b2b35e108 Y Vo               2015-01-16  244  		return PTR_ERR(regs);
b2b35e108 Y Vo               2015-01-16  245  
1013fc417 Quan Nguyen        2016-02-17  246  	priv->regs = regs;
1013fc417 Quan Nguyen        2016-02-17  247  
1013fc417 Quan Nguyen        2016-02-17  248  	ret = platform_get_irq(pdev, 0);
1013fc417 Quan Nguyen        2016-02-17  249  	if (ret > 0) {
1013fc417 Quan Nguyen        2016-02-17  250  		priv->parent_irq_base = irq_get_irq_data(ret)->hwirq;
1013fc417 Quan Nguyen        2016-02-17  251  		parent_domain = irq_get_irq_data(ret)->domain;
1013fc417 Quan Nguyen        2016-02-17  252  	}
1013fc417 Quan Nguyen        2016-02-17  253  	if (!parent_domain) {
1013fc417 Quan Nguyen        2016-02-17  254  		dev_err(&pdev->dev, "unable to obtain parent domain\n");
1013fc417 Quan Nguyen        2016-02-17  255  		return -ENODEV;
1013fc417 Quan Nguyen        2016-02-17  256  	}
1013fc417 Quan Nguyen        2016-02-17  257  
0f4630f37 Linus Walleij      2015-12-04  258  	ret = bgpio_init(&priv->gc, &pdev->dev, 4,
b2b35e108 Y Vo               2015-01-16  259  			regs + MPA_GPIO_IN_ADDR,
b2b35e108 Y Vo               2015-01-16  260  			regs + MPA_GPIO_OUT_ADDR, NULL,
b2b35e108 Y Vo               2015-01-16  261  			regs + MPA_GPIO_OE_ADDR, NULL, 0);
b2b35e108 Y Vo               2015-01-16  262          if (ret)
b2b35e108 Y Vo               2015-01-16  263                  return ret;
b2b35e108 Y Vo               2015-01-16  264  
1013fc417 Quan Nguyen        2016-02-17  265  	priv->gc.to_irq = xgene_gpio_sb_to_irq;
b2b35e108 Y Vo               2015-01-16  266  
1013fc417 Quan Nguyen        2016-02-17  267  	/* Retrieve start irq pin, use default if property not found */
1013fc417 Quan Nguyen        2016-02-17  268  	priv->irq_start = XGENE_DFLT_IRQ_START_PIN;
1013fc417 Quan Nguyen        2016-02-17  269  	if (!device_property_read_u32(&pdev->dev,
1013fc417 Quan Nguyen        2016-02-17  270  					XGENE_IRQ_START_PROPERTY, &val32))
1013fc417 Quan Nguyen        2016-02-17  271  		priv->irq_start = val32;
b2b35e108 Y Vo               2015-01-16  272  
1013fc417 Quan Nguyen        2016-02-17  273  	/* Retrieve number irqs, use default if property not found */
1013fc417 Quan Nguyen        2016-02-17  274  	priv->nirq = XGENE_DFLT_MAX_NIRQ;
1013fc417 Quan Nguyen        2016-02-17  275  	if (!device_property_read_u32(&pdev->dev, XGENE_NIRQ_PROPERTY, &val32))
1013fc417 Quan Nguyen        2016-02-17  276  		priv->nirq = val32;
b2b35e108 Y Vo               2015-01-16  277  
1013fc417 Quan Nguyen        2016-02-17  278  	/* Retrieve number gpio, use default if property not found */
1013fc417 Quan Nguyen        2016-02-17  279  	priv->gc.ngpio = XGENE_DFLT_MAX_NGPIO;
1013fc417 Quan Nguyen        2016-02-17  280  	if (!device_property_read_u32(&pdev->dev, XGENE_NGPIO_PROPERTY, &val32))
1013fc417 Quan Nguyen        2016-02-17  281  		priv->gc.ngpio = val32;
1013fc417 Quan Nguyen        2016-02-17  282  
1013fc417 Quan Nguyen        2016-02-17  283  	dev_info(&pdev->dev, "Support %d gpios, %d irqs start from pin %d\n",
1013fc417 Quan Nguyen        2016-02-17  284  			priv->gc.ngpio, priv->nirq, priv->irq_start);
b2b35e108 Y Vo               2015-01-16  285  
b2b35e108 Y Vo               2015-01-16  286  	platform_set_drvdata(pdev, priv);
b2b35e108 Y Vo               2015-01-16  287  
1013fc417 Quan Nguyen        2016-02-17  288  	if (pdev->dev.of_node)
1013fc417 Quan Nguyen        2016-02-17  289  		fwnode = of_node_to_fwnode(pdev->dev.of_node);
b2b35e108 Y Vo               2015-01-16  290  	else
1013fc417 Quan Nguyen        2016-02-17  291  		fwnode = pdev->dev.fwnode;
1013fc417 Quan Nguyen        2016-02-17  292  
1013fc417 Quan Nguyen        2016-02-17 @293  	priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
1013fc417 Quan Nguyen        2016-02-17  294  					0, priv->nirq, fwnode,
1013fc417 Quan Nguyen        2016-02-17  295  					&xgene_gpio_sb_domain_ops, priv);
1013fc417 Quan Nguyen        2016-02-17  296  	if (!priv->irq_domain)

:::::: The code at line 111 was first introduced by commit
:::::: 1013fc417cc15ead7c3a9091a47617f357db71a4 gpio: xgene: Enable X-Gene standby GPIO as interrupt controller

:::::: TO: Quan Nguyen <qnguyen@apm.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45764 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/4baf7fb6/attachment-0001.obj>
