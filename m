From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 28 Apr 2016 10:57:50 +0200
Subject: [PATCH v6 1/2] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <CACh+v5MM68U64PQYKBzaKZehfEs7qNNH3XYXm0HyO=Lwy=KAkg@mail.gmail.com>
References: <1461767754-12189-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461767754-12189-2-git-send-email-boris.brezillon@free-electrons.com>
 <CACh+v5MM68U64PQYKBzaKZehfEs7qNNH3XYXm0HyO=Lwy=KAkg@mail.gmail.com>
Message-ID: <20160428105750.01a32818@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Apr 2016 10:47:24 +0200
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:

> > +static int at91_ebi_probe(struct platform_device *pdev)
> > +{
> > +       const struct of_device_id *match;
> > +       struct device_node *child;
> > +       struct at91_ebi *ebi;
> > +       struct clk *clk;
> > +       int ret;
> > +
> > +       match = of_match_device(at91_ebi_id_table, &pdev->dev);
> > +       if (!match || !match->data)
> > +               return -EINVAL;
> > +
> > +       ebi = devm_kzalloc(&pdev->dev, sizeof(*ebi), GFP_KERNEL);
> > +       if (!ebi)
> > +               return -ENOMEM;
> > +
> > +       ebi->caps = match->data;
> > +       ebi->dev = &pdev->dev;
> > +
> > +       clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(clk))
> > +               return PTR_ERR(clk);
> > +
> > +       ebi->clk = clk;
> > +
> > +       ebi->smc = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                                                  "atmel,smc");
> > +       if (IS_ERR(ebi->smc))
> > +               return PTR_ERR(ebi->smc);
> > +
> > +       /*
> > +        * The sama5d3 does not provide an EBICSA register and thus does need
> > +        * to access the matrix registers.
> > +        */
> > +       if (ebi->caps->ebi_csa) {
> > +               ebi->matrix =
> > +                       syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                                                       "atmel,matrix");
> > +               if (IS_ERR(ebi->matrix))
> > +                       return PTR_ERR(ebi->matrix);
> > +
> > +               ebi->ebi_csa = regmap_field_alloc(ebi->matrix,
> > +                                                 *ebi->caps->ebi_csa);
> > +               if (IS_ERR(ebi->ebi_csa))
> > +                       return PTR_ERR(ebi->ebi_csa);
> > +       }
> > +
> > +       ret = ebi->caps->init(ebi);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for_each_child_of_node(pdev->dev.of_node, child) {
> > +               ret = at91_ebi_dev_setup(ebi, child);
> > +               if (ret)
> > +                       return ret;  
> 
> I'm not sure about breaking out of the loop here, if
> at91_ebi_dev_setup() for a device fail then the remaining devices
> won't be probed. If you add a bad config for a fpga on CS1, you can
> prevent your NAND  on CS2 to be probed.

Fair enough, I'll continue iterating even if an error occurs.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
