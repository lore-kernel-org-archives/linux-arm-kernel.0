From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 15 Jan 2016 10:39:01 +0100
Subject: [PATCH v3 04/13] clk: at91: make IRQ optional and register them
 later
In-Reply-To: <20160115020237.GJ22188@codeaurora.org>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20160115020237.GJ22188@codeaurora.org>
Message-ID: <20160115103901.1b987f53@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 14 Jan 2016 18:02:37 -0800
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 12/04, Alexandre Belloni wrote:
> > @@ -686,3 +652,45 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
> >  }
> >  CLK_OF_DECLARE(at91sam9x5_clk_main, "atmel,at91sam9x5-clk-main",
> >  	       of_at91sam9x5_clk_main_setup);
> > +
> > +static const struct of_device_id atmel_clk_main_dt_ids[] = {
> > +	{ .compatible = "atmel,at91rm9200-clk-main-osc" },
> > +	{ .compatible = "atmel,at91sam9x5-clk-main-rc-osc" },
> > +	{ .compatible = "atmel,at91sam9x5-clk-main" },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static int __init atmel_clk_main_probe(struct platform_device *pdev)
> > +{
> > +	struct of_phandle_args clkspec = { .np = pdev->dev.of_node};
> > +	struct clk_main *clkmain;
> > +	struct clk_hw *hw;
> > +	int ret;
> > +
> > +	hw = __clk_get_hw(of_clk_get_from_provider(&clkspec));
> > +	if (!hw)
> > +		return -ENODEV;
> > +
> > +	clkmain = to_clk_main(hw);
> > +	clkmain->irq = platform_get_irq(pdev, 0);
> > +	if (!clkmain->irq)
> > +		return 0;
> 
> Is there any way to get the irq into this probe function without
> getting a clk pointer and then unwrapping it to get an irq
> value out of the clk_hw wrapper structure? That's a pretty
> convoluted design.

Not sure I get what you're suggesting, but the only solution I see to
avoid this "get main clk pointer dance" would be to have a global
variable storing the clk_main instance (or a list of clk_main
instances).
The thing is, I'd like to avoid adding new global variables in this
clk drivers as much as possible. Moreover, the core is already taking
care of keeping the list of all registered clks, with their associated
of_node, so, is there a real point in creating a duplicated association
list in this driver too?

Maybe we could create an of_clk_hw_get_from_provider(), which would
prevent the creation of this useless per-user clk instance (see the patch
below).

> 
> > +
> > +	init_waitqueue_head(&clkmain->wait);
> > +	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
> > +	ret = devm_request_irq(&pdev->dev, clkmain->irq, clk_main_irq_handler,
> > +			       IRQF_TRIGGER_HIGH, __clk_get_name(hw->clk),
> > +			       clkmain);
> > +	if (ret)
> > +		clkmain->irq = 0;
> > +

You should probably call clk_put() on the pointer returned by
of_clk_get_from_provider(&clkspec).

> > +	return ret;
> > +}
> > +
> 

Best Regards,

Boris

--- >8 ---
>From a83670d29504e256bdc97c04f0dfd96a7d6842bf Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri, 15 Jan 2016 10:36:23 +0100
Subject: [PATCH] clk: add a function to retrieve a clk_hw instance from a
 clkspec definition

of_clk_hw_get_from_provider() is providing a way to retrieve a clk_hw
instance from a clkspec definition. Which is usefull in case a clk driver
wants to get one of its own instance from a clkspec, without allocating a
new per-user clk struct.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/clk.c            | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f13c3f4..fbef1b7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3001,6 +3001,42 @@ void of_clk_del_provider(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_clk_del_provider);
 
+/**
+ * of_clk_hw_get_from_provider() - Look for a clk_hw instance registered with
+ *				   the given clkspec definition.
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * This function looks up a struct clk_hw from the registered list of clock
+ * providers, an input is a clock specifier data structure as returned
+ * from the of_parse_phandle_with_args() function call.
+ */
+struct clk_hw *of_clk_hw_get_from_provider(struct of_phandle_args *clkspec)
+{
+	struct clk_hw *clk_hw = ERR_PTR(-EPROBE_DEFER);
+	struct of_clk_provider *provider;
+
+	if (!clkspec)
+		return ERR_PTR(-EINVAL);
+
+	/* Check if we have such a provider in our array */
+	mutex_lock(&of_clk_mutex);
+	list_for_each_entry(provider, &of_clk_providers, link) {
+		struct clk *clk = ERR_PTR(-EPROBE_DEFER);
+
+		if (provider->node == clkspec->np)
+			clk = provider->get(clkspec, provider->data);
+
+		if (!IS_ERR(clk)) {
+			clk_hw = __clk_get_hw(clk);
+			break;
+		}
+	}
+	mutex_unlock(&of_clk_mutex);
+
+	return clk_hw;
+}
+EXPORT_SYMBOL_GPL(of_clk_hw_get_from_provider);
+
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c56988a..bb62517 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -645,6 +645,7 @@ void devm_clk_unregister(struct device *dev, struct clk *clk);
 const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
 struct clk_hw *__clk_get_hw(struct clk *clk);
+struct clk_hw *of_clk_hw_get_from_provider(struct of_phandle_args *clkspec);
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
