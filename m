From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 27 Mar 2018 20:47:04 +0300
Subject: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
Message-ID: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
clocks used a generic clock flag, which causes a conflict with the
rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
boot failures on certain platforms where this flag is introduced, by
omitting the wait for the clockctrl module to be fully enabled before
proceeding with rest of the code.

Fix this by moving all the clkctrl specific flags to their own bit-range.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
---
 drivers/clk/ti/clock.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 90b86aa..b582780 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -76,6 +76,11 @@ enum {
 #define CLKF_CORE			(1 << 9)
 #define CLKF_J_TYPE			(1 << 10)
 
+/* CLKCTRL flags */
+#define CLKF_SW_SUP			BIT(5)
+#define CLKF_HW_SUP			BIT(6)
+#define CLKF_NO_IDLEST			BIT(7)
+
 #define CLK(dev, con, ck)		\
 	{				\
 		.lk = {			\
@@ -185,10 +190,6 @@ struct omap_clkctrl_data {
 extern const struct omap_clkctrl_data dm814_clkctrl_data[];
 extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
-#define CLKF_SW_SUP	BIT(0)
-#define CLKF_HW_SUP	BIT(1)
-#define CLKF_NO_IDLEST	BIT(2)
-
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
