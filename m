From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Feb 2016 19:07:31 -0800
Subject: [PATCH] clk: fix clk-gpio.c with optional clock= DT property
In-Reply-To: <20160218005503.GO19428@n2100.arm.linux.org.uk>
References: <E1aFJ0A-00086Z-0I@rmk-PC.arm.linux.org.uk>
 <20160217230529.GM19428@n2100.arm.linux.org.uk>
 <20160218000747.2278.46405@quark.deferred.io>
 <20160218005503.GO19428@n2100.arm.linux.org.uk>
Message-ID: <20160219030731.GS4847@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18, Russell King - ARM Linux wrote:
> This is even explained in the very first sentence of my commit
> log:
> 
> | When the clock DT property is not given, of_clk_get_parent_count()
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
> | returns -ENOENT, which then tries to allocate -2 x 4 bytes of memory,
>   ^^^^^^^^^^^^^^^
> 
> -ENOENT is a negative number.  Now look at the patch which totally
> rejects the clock if of_clk_get_parent_count() returns any negative
> number...
> 
> I assume, therefore, that you did not *even* read my commit log...
> 

Ok. So the simplest fix is to just do this? I'll write up some
commit text and get this into the rc.

---8<---
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 19fed65587e8..7b09a265d79f 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -289,7 +289,7 @@ static void __init of_gpio_clk_setup(struct device_node *node,
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 0)
-		return;
+		num_parents = 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)

Maybe we should change of_clk_get_parent_count() to return an
unsigned int as well. I'm not sure why anyone would care whether
or not a node has "clocks" or not as a property. It seems that
all the callers of this function want to know how many parents
there are. In fact, some TI drivers assign the return value from
this function directly to clk_init_data::num_parents which is an
unsigned value. That's horribly broken if there isn't a proper DT
node.

So how about we apply this patch for the next release? We could
also change the return type to unsigned so that people don't get
the wrong idea. That type of change will be a bit larger though
because we'll have to remove impossible < 0 checks in drivers;
not a huge deal but slightly annoying. I can do that legwork
tomorrow.

----8<---
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 67cd2f116c3b..cdf18f76acb0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3020,9 +3020,21 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 	return __of_clk_get_from_provider(clkspec, NULL, __func__);
 }
 
+/**
+ * of_clk_get_parent_count() - Count the number of clocks a device node has
+ * @np: device node to count
+ *
+ * Returns: The number of clocks that are possible parents of this node
+ */
 int of_clk_get_parent_count(struct device_node *np)
 {
-	return of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	int count;
+
+	count = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	if (count < 0)
+		return 0;
+
+	return count;
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
