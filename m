From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Feb 2015 11:32:24 +0100
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <54E1D1F5.2050603@ti.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de>
 <20150212103944.GA1290@victor>
 <20150212122405.GW12209@pengutronix.de>
 <20150212125646.GT8656@n2100.arm.linux.org.uk>
 <20150212134131.GX12209@pengutronix.de> <54DE0BB8.7070004@ti.com>
 <20150213185713.GA12209@pengutronix.de> <54E1D1F5.2050603@ti.com>
Message-ID: <20150217103224.GS12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 01:18:13PM +0200, Tomi Valkeinen wrote:
> On 13/02/15 20:57, Sascha Hauer wrote:
> > On Fri, Feb 13, 2015 at 04:35:36PM +0200, Tomi Valkeinen wrote:
> >> On 12/02/15 15:41, Sascha Hauer wrote:
> >>
> >>> Tomis patch is based on the assumption that clk_set_rate(clk_round_rate(rate))
> >>> is equal to clk_round_rate(rate). So when this assumption is wrong then
> >>> it should simply be reverted.
> >>
> >> When is it not equal?
> >>
> >> I agree that doing clk_set_rate(clk, clk_round_rate(clk, rate)) is
> >> pointless, but shouldn't it still work?
> >>
> >> And we can forget about clk_round_rate. Without my patch, this would
> >> behave oddly also:
> >>
> >> rate = clk_get_rate(clk);
> >> clk_set_rate(clk, rate);
> >>
> >> The end result could be something else than 'rate'.
> > 
> > I agree that it's a bit odd, but I think it has to be like this.
> > Consider that you request a rate of 100Hz, but the clock can only
> > produce 99.5Hz, so due to rounding clk_round_rate() returns 99Hz.
> > Now when you request 99Hz from clk_set_rate() the 99.5Hz value
> > can't be used because it's too high.
> 
> Would that problem better be fixed by changing the clock driver so that
> when asked for 99Hz, it would look for rates less than 100Hz?
> 
> I think the old behavior was so odd that I would call it broken, so I
> hope the current problems can be fixed via some other ways than breaking
> it again.

I gave it a try, but so far I have no idea how to implement the divider
correctly and bullet proof.

What I have so far is a test which creates some cascaded dividers and sets
rates on them. The test iterates over the frequency range and a) calls
clk_round_rate with the iterator, b) sets the clk to the iterator, c)
sets the clk to the rounded rate.

Be prepared for surprises and try to fix the results... I failed for
now and wonder if the approach to the divider is wrong.

Sascha

>From 58a46b16d4b67d5cd7df4af6deb5b96e19afe230 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 17 Feb 2015 11:24:10 +0100
Subject: [PATCH] clk: clk-divider: Add a simple test for dividers

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clk-divider.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index c0a842b..cd66625 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -463,3 +463,89 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 			width, clk_divider_flags, table, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider_table);
+
+/*
+ * Simple test of dividers. Try to set rates between 1 and 10000Hz and
+ *  - get output of clk_round_rate()
+ *  - set the current target rate, get the rate
+ *  - set the rate to the rounded rate, get the rate
+ *
+ * Whenever a value changed print the results
+ */
+static void clktest_one(struct clk *clk)
+{
+	int i, ret;
+	unsigned long roundsetrate, last_roundsetrate = 0;
+	unsigned long roundrate, last_roundrate = 0;
+	unsigned long setrate, last_setrate = 0;
+
+	for (i = 1; i < 10000; i++) {
+		roundrate = clk_round_rate(clk, i);
+
+		clk_set_rate(clk, i);
+		setrate = clk_get_rate(clk);
+
+		ret = clk_set_rate(clk, roundrate);
+		if (ret) {
+			printk("clkdivtest: Failed to set rate: %d\n", ret);
+			return;
+		}
+
+		roundsetrate = clk_get_rate(clk);
+
+		if (last_roundsetrate != roundsetrate ||
+				last_roundrate != roundrate ||
+				last_setrate != setrate)
+			printk("target rate: %4d rounded: %4ld set: %4ld round/set: %4ld\n",
+					i, roundrate, setrate, roundsetrate);
+
+		last_roundsetrate = roundsetrate;
+		last_roundrate = roundrate;
+		last_setrate = setrate;
+	}
+}
+
+static int clktest(void)
+{
+	u32 reg_div1 = 0;
+	u32 reg_div2 = 0;
+	u32 reg_div3 = 0;
+	struct clk *clktest_base = ERR_PTR(-ENODEV);
+	struct clk *clktest_div1 = ERR_PTR(-ENODEV);
+	struct clk *clktest_div2 = ERR_PTR(-ENODEV);
+	struct clk *clktest_div3 = ERR_PTR(-ENODEV);
+
+	clktest_base = clk_register_fixed_rate(NULL, "clktest_base", NULL, 0, 10000);
+	clktest_div1 = clk_register_divider(NULL, "clktest_div1", "clktest_base",
+			0, &reg_div1, 0, 4, 0, NULL);
+	clktest_div2 = clk_register_divider(NULL, "clktest_div2", "clktest_div1",
+			CLK_SET_RATE_PARENT, &reg_div2, 0, 4, 0, NULL);
+	clktest_div3 = clk_register_divider(NULL, "clktest_div3", "clktest_div2",
+			CLK_SET_RATE_PARENT, &reg_div3, 0, 4, 0, NULL);
+
+	if (IS_ERR(clktest_base) || IS_ERR(clktest_div1) ||
+			IS_ERR(clktest_div2) || IS_ERR(clktest_div3)) {
+		printk("clkdivtest: Failed to register clocks\n");
+		goto err_out;
+	}
+
+	printk("------------------ Single divider, fin=10000Hz ------------------\n");
+	clktest_one(clktest_div1);
+	printk("--------------- two cascaded dividers, fin=10000Hz --------------\n");
+	clktest_one(clktest_div2);
+	printk("-------------- three cascaded dividers, fin=10000Hz -------------\n");
+	clktest_one(clktest_div3);
+
+err_out:
+	if (!IS_ERR(clktest_base))
+		clk_unregister(clktest_base);
+	if (!IS_ERR(clktest_div1))
+		clk_unregister(clktest_div1);
+	if (!IS_ERR(clktest_div2))
+		clk_unregister(clktest_div2);
+	if (!IS_ERR(clktest_div3))
+		clk_unregister(clktest_div3);
+
+	return 0;
+}
+late_initcall(clktest);
-- 
2.1.4


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
