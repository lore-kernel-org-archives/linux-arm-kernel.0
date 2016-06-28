From: andi@etezian.org (Andi Shyti)
Date: Wed, 29 Jun 2016 01:09:22 +0900
Subject: [PATCH 1/2] clk: clk-rk3*: set CLK_IS_CRITICAL flag to critical
 clocks
In-Reply-To: <29356205.Gk5k6xKH6K@phil>
References: <1467125137-25999-1-git-send-email-andi@etezian.org>
 <1467125137-25999-2-git-send-email-andi@etezian.org>
 <29356205.Gk5k6xKH6K@phil>
Message-ID: <20160628160922.GN424@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

> >  			RK2928_CLKSEL_CON(0), 14, 2, MFLAGS, 8, 5, DFLAGS),
> > -	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
> > +	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src",
> > +			CLK_IS_CRITICAL | CLK_IGNORE_UNUSED,
> 
> - you'll never need both critical and ignore_unused

Indeed I was unsure whether I should remove the
CLK_IGNORE_UNUSED, but then I decided to leave it because that's
basically what the driver is currently doing. Thanks!

> Happens in some more cases below, but otherwise looks ok ... as written in 
> the cover-letter I'm just still trying to make up my mind if it's worth 
> waiting for the handoff mechanism.

You mean something similar (*)?

Thanks,
Andi

(*)

@@ -2403,7 +2407,7 @@ static int __clk_core_init(struct clk_core *core)
        if (core->ops->init)
                core->ops->init(core->hw);
 
-       if (core->flags & CLK_IS_CRITICAL) {
+       if (core->flags & CLK_IS_CRITICAL || core->flags & CLK_HANDOFF) {
                unsigned long flags;
 
                clk_core_prepare(core);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 89cc700..5698ef1 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -201,11 +201,19 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
        if (dev) {
                clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
-               if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+               if (!IS_ERR(clk)) {
+                       clk->clk_core->flags &= ~CLK_HANDOFF;
+                       return clk;
+               }
+               if (PTR_ERR(clk) == -EPROBE_DEFER)
                        return clk;
        }
 
-       return clk_get_sys(dev_id, con_id);
+       clk = clk_get_sys(dev_id, con_id);
+       if (!IS_ERR(clk))
+               clk->clk_core->flags &= ~CLK_HANDOFF;
+
+       return clk;
 }
 EXPORT_SYMBOL(clk_get);

 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index fb39d5a..39684ec 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -33,6 +33,7 @@
 #define CLK_RECALC_NEW_RATES   BIT(9) /* recalc rates after notifications */
 #define CLK_SET_RATE_UNGATE    BIT(10) /* clock needs to run to set rate */
 #define CLK_IS_CRITICAL                BIT(11) /* do not gate, ever */
+#define CLK_HANDOFF         BIT(12) /* do not gate, ever */
 
 struct clk;
 struct clk_hw;
