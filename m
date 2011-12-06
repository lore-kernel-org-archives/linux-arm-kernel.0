From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 11:26:43 +0800
Subject: [PATCH v2 1/4] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111205190946.GD7467@opensource.wolfsonmicro.com>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
 <20111202153637.GY8245@opensource.wolfsonmicro.com>
 <20111205064124.GC2980@S2100-06.ap.freescale.net>
 <20111205190946.GD7467@opensource.wolfsonmicro.com>
Message-ID: <20111206032642.GI2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 07:09:47PM +0000, Mark Brown wrote:
> On Mon, Dec 05, 2011 at 02:41:24PM +0800, Shawn Guo wrote:
> > On Fri, Dec 02, 2011 at 03:36:38PM +0000, Mark Brown wrote:
> > > On Thu, Dec 01, 2011 at 05:21:05PM +0800, Shawn Guo wrote:
> 
> > > > +Sub-nodes:
> > > > +- regulators : Contain the regulator nodes.  The bindings details of individual
> > > > +  regulator node can be found in:
> > > > +  Documentation/devicetree/bindings/regulator/regulator.txt
> 
> > > How does the driver figure out which regulators map onto which subnodes?
> 
> > There should only be one sub-node named 'regulators', otherwise, DTC
> > will report ERROR (duplicate_node_names).
> 
> That doesn't answer the question - I've still no idea how the binding is
> supposed to map the nodes contained within regulators onto the physical
> regulators.
> 
Oops, I missed the question.  It's in the patch #3.

> +struct mc13xxx_regulator_init_data * __devinit mc13xxx_parse_regulators_dt(
> +     struct platform_device *pdev, struct mc13xxx_regulator *regulators,
> +     int num_regulators)
> +{
> +     struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
> +     struct mc13xxx_regulator_init_data *data, *p;
> +     struct device_node *parent, *child;
> +     int i;
> +
> +     of_node_get(pdev->dev.parent->of_node);
> +     parent = of_find_node_by_name(pdev->dev.parent->of_node, "regulators");
> +     if (!parent)
> +             return NULL;
> +
> +     data = devm_kzalloc(&pdev->dev, sizeof(*data) * priv->num_regulators,
> +                         GFP_KERNEL);
> +     if (!data)
> +             return NULL;
> +     p = data;
> +
> +     for_each_child_of_node(parent, child) {
> +             for (i = 0; i < num_regulators; i++) {
> +                     if (!of_node_cmp(child->name,
> +                                      regulators[i].desc.name)) {

And here it is.  It finds the regulator node by looking for the
regulator name.

Regards,
Shawn

> +                             p->id = i;
> +                             p->init_data = of_get_regulator_init_data(
> +                                                     &pdev->dev, child);
> +                             p->node = child;
> +                             p++;
> +                             break;
> +                     }
> +             }
> +     }
> +
> +     return data;
> +}
