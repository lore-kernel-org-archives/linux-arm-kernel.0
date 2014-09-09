From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 19:22:11 +0100
Subject: [PATCH RFC 2/3] ARM: regulator: add Freescale MXS regulator driver
In-Reply-To: <1410089869-6611-3-git-send-email-info@lategoodbye.de>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-3-git-send-email-info@lategoodbye.de>
Message-ID: <20140909182211.GG3896@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +       regs = (__raw_readl(sreg->base_addr) & ~BM_POWER_LEVEL_TRG);

I suspect you should be using the *_relaxed accessors rather than the
__raw_* accessors.

[...]

> +static int mxs_regulator_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *parent;
> +       struct regulator_desc *rdesc;
> +       struct regulator_dev *rdev;
> +       struct mxs_regulator *sreg;
> +       struct regulator_init_data *initdata;
> +       struct regulation_constraints *con;
> +       struct regulator_config config = { };
> +       void __iomem *base_addr = NULL;
> +       void __iomem *power_addr = NULL;
> +       u64 regaddr64 = 0;
> +       const u32 *regaddr_p;
> +       u32 val = 0;
> +       int ret;
> +
> +       if (!np) {
> +               dev_err(dev, "missing device tree\n");
> +               return -EINVAL;
> +       }
> +
> +       /* get device base address */
> +       base_addr = of_iomap(np, 0);
> +       if (!base_addr)
> +               return -ENXIO;
> +
> +       parent = of_get_parent(np);
> +       if (!parent)
> +               return -ENXIO;

Leak of the (successfully mapped) base_addr.

> +
> +       power_addr = of_iomap(parent, 0);
> +       if (!power_addr)
> +               return -ENXIO;

Leak of base_addr and dangling refcount on parent. These apply to all
subsequent returns.

> +
> +       regaddr_p = of_get_address(np, 0, NULL, NULL);

of_get_address returns a __be32*, not a u32*, so sparse will be very
unhappy here...

> +       if (regaddr_p)
> +               regaddr64 = of_translate_address(np, regaddr_p);

...and as of_translate_address returns a u64 you'll need a separate
variable for the input and output.

> +
> +       if (!regaddr64) {
> +               dev_err(dev, "no or invalid reg property set\n");
> +               return -EINVAL;
> +       }
> +
> +       initdata = of_get_regulator_init_data(dev, np);
> +       if (!initdata)
> +               return -EINVAL;
> +
> +       ret = of_property_read_u32(np, "mxs-max-reg-val",
> +                                  &val);
> +       if (!val) {
> +               dev_err(dev, "no or invalid mxs-max-reg-val property set\n");
> +               return ret;
> +       }
> +
> +       dev_info(dev, "regulator found\n");
> +
> +       sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
> +       if (!sreg)
> +               return -ENOMEM;
> +       sreg->initdata = initdata;
> +       sreg->name = of_get_property(np, "regulator-name", NULL);

I'm not keen on using of_get_property here. We have no idea if
regulator-name is even a string (it should be, but we have no
guarantee).

> +       sreg->cur_uA = 0;
> +       sreg->cur_uV = 0;
> +       sreg->base_addr = base_addr;
> +       sreg->power_addr = power_addr;
> +       init_waitqueue_head(&sreg->wait_q);
> +       spin_lock_init(&sreg->lock);
> +       sreg->max_reg_val = val;
> +
> +       rdesc = &sreg->rdesc;
> +       rdesc->name = sreg->name;
> +       rdesc->owner = THIS_MODULE;
> +       rdesc->ops = &mxs_rops;
> +
> +       if (strcmp(rdesc->name, "overall_current") == 0)
> +               rdesc->type = REGULATOR_CURRENT;
> +       else
> +               rdesc->type = REGULATOR_VOLTAGE;

Wouldn't it make more sense to explicitly match the names you expect?

> +       con = &initdata->constraints;
> +       rdesc->n_voltages = sreg->max_reg_val;
> +       rdesc->min_uV = con->min_uV;
> +       rdesc->uV_step = (con->max_uV - con->min_uV) / sreg->max_reg_val;
> +       rdesc->linear_min_sel = 0;
> +       rdesc->vsel_reg = regaddr64;
> +       rdesc->vsel_mask = BM_POWER_LEVEL_TRG;
> +
> +       config.dev = &pdev->dev;
> +       config.init_data = initdata;
> +       config.driver_data = sreg;
> +       config.of_node = np;
> +
> +       pr_debug("probing regulator %s %s %d\n",
> +                       sreg->name,
> +                       rdesc->name,
> +                       pdev->id);

Aren't those two names always the same per the code above?

> +
> +       /* register regulator */
> +       rdev = devm_regulator_register(dev, rdesc, &config);
> +
> +       if (IS_ERR(rdev)) {
> +               dev_err(&pdev->dev, "failed to register %s\n",
> +                       rdesc->name);
> +               return PTR_ERR(rdev);
> +       }
> +
> +       if (sreg->max_uA) {
> +               struct regulator *regu;
> +
> +               regu = regulator_get(NULL, sreg->name);
> +               sreg->nb.notifier_call = reg_callback;
> +               regulator_register_notifier(regu, &sreg->nb);
> +       }
> +
> +       platform_set_drvdata(pdev, rdev);
> +
> +       of_property_read_u32(np, "mxs-default-microvolt",
> +                                  &val);
> +
> +       if (val)
> +               mxs_set_voltage(rdev, val, val, NULL);

As I mentioned in my comments on the binding, I'd like to know why this
is necessary and if it is why it shouldn't be a standardised property.

Mark.
