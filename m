From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Aug 2016 11:22:00 -0700
Subject: [PATCH v6 1/2] clk: uniphier: add core support code for UniPhier
 clock driver
In-Reply-To: <CAK7LNAQownrE0n8rAYGgUs9_byvok8W0V=c6gts_C=8Wvio86g@mail.gmail.com>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
 <20160819002507.GS361@codeaurora.org>
 <CAK7LNAQg-LcK-vsWVU-b0WsF=Y_NBNR_cWqNDJKyMqp7Svdvqg@mail.gmail.com>
 <20160819191612.GU361@codeaurora.org>
 <CAK7LNAQownrE0n8rAYGgUs9_byvok8W0V=c6gts_C=8Wvio86g@mail.gmail.com>
Message-ID: <20160829182200.GD19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29, Masahiro Yamada wrote:
> Hi Stephen,
> 
> 
> 2016-08-20 4:16 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> >>
> >> >> +
> >> >> +     parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> >> >> +     regmap = syscon_node_to_regmap(parent);
> >> >> +     of_node_put(parent);
> >> >
> >> > devm_get_regmap(dev->parent) should work then? Why do we need to
> >> > use OF APIs?
> >>
> >> "git grep devm_get_regmap" did not hit anything.
> >>
> >> Where is it defined?
> >>
> >
> > Sorry I meant dev_get_regmap().
> >
> 
> I tried this, but it did not work.
> 
> To make dev_get_regmap() work,
> the parent device needs to call dev_regmap_init_mmio() beforehand.
> 
> 
> Since commit bdb0066df96e74a4002125467ebe459feff1ebef
> (mfd: syscon: Decouple syscon interface from platform devices),
> syscon_probe() is not called for platform devices,
> so that never happens.
> 

Ok. Is the syscon also a simple-mfd?

It sounds like there's a device for the parent, but we've failed
to attach a regmap to it. Maybe the core DT code should assign
the regmap to the parent device when it creates it so that child
devices don't need to know this detail? It could look for
simple-mfd devices with compatible = "syscon" and then create the
regmap? Here's a totally untested patch for that.

----8<----
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 2f2225e845ef..5f7d3f015b82 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -136,6 +136,17 @@ struct regmap *syscon_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
+int device_attach_syscon(struct device *dev)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return regmap_attach_dev(dev, regmap, &syscon_regmap_config);
+}
+
 struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 {
 	struct device_node *syscon_np;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8aa197691074..58a018e15006 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -25,6 +25,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
 
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
@@ -383,7 +384,12 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
+
 	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	if (of_device_is_compatible(bus, "simple-mfd") &&
+	    of_device_is_compatible(bus, "syscon"))
+		device_attach_syscon(&dev->dev);
+
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 40a76b97b7ab..e19e5d15f4e6 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -18,9 +18,11 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 
+struct device;
 struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
+extern int device_attach_syscon(struct device *dev);
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
@@ -28,6 +30,11 @@ extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
 #else
+static inline int device_attach_syscon(struct device *dev)
+{
+	return 0;
+}
+
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
