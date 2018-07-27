From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 27 Jul 2018 15:38:12 +0000
Subject: [PATCH] clk: Add functions to get optional clocks
In-Reply-To: <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
Message-ID: <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 25 July 2018 23:37, Stephen Boyd wrote:
> Quoting Phil Edworthy (2018-07-18 06:56:26)
> > On 18 July 2018 14:19, Geert Uytterhoeven wrote:
> > > On Wed, Jul 18, 2018 at 3:02 PM Russell King - ARM Linux  wrote:
> > > > On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> > > > > Behaves the same as (devm_)clk_get except where there is no
> > > > > clock producer. In this case, instead of returning -ENOENT, the
> > > > > function returns NULL. This makes error checking simpler and
> > > > > allows clk_prepare_enable, etc to be called on the returned
> > > > > reference without additional checks.
> > > >
> > > > How does this work with non-DT systems, where looking a clock up
> > > > which isn't yet registered with clkdev returns -ENOENT ?
> > > >
> > > > (clkdev doesn't know when all clocks are registered with it.)
> > >
> > > Good question.
> > >
> > > I guess all drivers trying to handle optional clocks this way are
> > > already broken on non-DT systems where clocks may be registered late...
> >
> > So how do non-DT systems that look a clock up which isn't yet
> > registered with clkdev, determine that an optional clock is there or
> > not?
> >
> 
> Short answer is they don't. I'd still prefer we have this API though.
> 
> Can you rework this patch to be a little more invasive into the
> clk_get() path, perhaps by reworking __of_clk_get_by_name() a little to
> take an 'optional' argument, so that it only returns NULL when the clk is
> looked up from DT? The fallback path in clkdev where we have a DT based
> system looking up a clk through clkdev lookups doesn't seem to be a real
> scenario that we should worry about here. I think sometimes people use
> clkdev lookups when they're migrating to DT systems and things aren't wired
> up properly in DT, but that isn't the norm.
Do you mean something like this:

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7f2cd1e..42a7d4e 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -57,7 +57,8 @@ EXPORT_SYMBOL(of_clk_get);
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
                                        const char *dev_id,
-                                       const char *name)
+                                       const char *name,
+                                       bool optional)
 {
        struct clk *clk = ERR_PTR(-ENOENT);
 
@@ -79,6 +80,8 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
                        if (PTR_ERR(clk) != -EPROBE_DEFER)
                                pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
                                        np, name ? name : "", index);
+                       if (optional && PTR_ERR(clk) == -ENOENT)
+                               clk = NULL;
                        return clk;
                }
 
@@ -109,15 +112,38 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
        if (!np)
                return ERR_PTR(-ENOENT);
 
-       return __of_clk_get_by_name(np, np->full_name, name);
+       return __of_clk_get_by_name(np, np->full_name, name, false);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 
+/**
+ * of_clk_get_by_name_optional() - Parse and lookup an optional clock referenced
+ * by a device node
+ * @np: pointer to clock consumer node
+ * @name: name of consumer's clock input, or NULL for the first clock reference
+ *
+ * This function parses the clocks and clock-names properties,
+ * and uses them to look up the struct clk from the registered list of clock
+ * providers.
+ * It behaves the same as of_clk_get_by_name(), except when no clock is found.
+ * In this case, instead of returning -ENOENT, it returns NULL.
+ */
+struct clk *of_clk_get_by_name_optional(struct device_node *np,
+                                       const char *name)
+{
+       if (!np)
+               return ERR_PTR(-ENOENT);
+
+       return __of_clk_get_by_name(np, np->full_name, name, true);
+}
+EXPORT_SYMBOL(of_clk_get_by_name_optional);
+
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
 
 static struct clk *__of_clk_get_by_name(struct device_node *np,
                                        const char *dev_id,
-                                       const char *name)
+                                       const char *name,
+                                       bool optional)
 {
        return ERR_PTR(-ENOENT);
 }
@@ -200,7 +226,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
        struct clk *clk;
 
        if (dev) {
-               clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+               clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
                if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
                        return clk;
        }
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 907202b..830209a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -771,6 +771,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
+struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)

---
A lot of drivers use devm_clk_get() so I think a devm_clk_get_optional()
version would be useful. That would probably need an additional
clk_get_optional() function.

Thanks
Phil
