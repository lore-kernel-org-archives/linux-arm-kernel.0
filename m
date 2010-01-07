From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 08 Jan 2010 10:44:12 +1100
Subject: [RFC,PATCH 5/7] arm/realview: use generic struct clk
In-Reply-To: <1262907852.736281.78480196040.1.gpush@pororo>
Message-ID: <1262907852.737809.681118365804.5.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common struct clk interface for the realview clocks.

Compile tested only.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/Kconfig               |    1 
 arch/arm/mach-realview/clock.c |   43 ++++++++++-------------------
 arch/arm/mach-realview/clock.h |   21 +++++++++-----
 arch/arm/mach-realview/core.c  |   48 +++++++++++++++++----------------
 4 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e59bce..a11ee79 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -236,6 +236,7 @@ config ARCH_REALVIEW
 	select ICST307
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select HAVE_COMMON_STRUCT_CLK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  This enables support for ARM Ltd RealView boards.
diff --git a/arch/arm/mach-realview/clock.c b/arch/arm/mach-realview/clock.c
index a704311..4c09166 100644
--- a/arch/arm/mach-realview/clock.c
+++ b/arch/arm/mach-realview/clock.c
@@ -18,47 +18,34 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 
+#include <asm/clk.h>
 #include <asm/hardware/icst307.h>
 
 #include "clock.h"
 
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
+#define to_clk_realview(clk) (container_of(clk, struct clk_realview, clk))
 
-unsigned long clk_get_rate(struct clk *clk)
+unsigned long clk_realview_get_rate(struct clk *clk)
 {
-	return clk->rate;
+	return to_clk_realview(clk)->rate;
 }
-EXPORT_SYMBOL(clk_get_rate);
 
-long clk_round_rate(struct clk *clk, unsigned long rate)
+long clk_realview_round_rate(struct clk *clk, unsigned long rate)
 {
+	const struct icst307_params *params = &to_clk_realview(clk)->params;
 	struct icst307_vco vco;
-	vco = icst307_khz_to_vco(clk->params, rate / 1000);
-	return icst307_khz(clk->params, vco) * 1000;
+	vco = icst307_khz_to_vco(params, rate / 1000);
+	return icst307_khz(params, vco) * 1000;
 }
-EXPORT_SYMBOL(clk_round_rate);
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+int clk_realview_set_rate(struct clk *clk, unsigned long rate)
 {
-	int ret = -EIO;
+	struct clk_realview *r_clk = to_clk_realview(clk);
+	struct icst307_vco vco;
 
-	if (clk->setvco) {
-		struct icst307_vco vco;
+	vco = icst307_khz_to_vco(&r_clk->params, rate / 1000);
+	r_clk->rate = icst307_khz(&r_clk->params, vco) * 1000;
+	r_clk->setvco(r_clk, vco);
 
-		vco = icst307_khz_to_vco(clk->params, rate / 1000);
-		clk->rate = icst307_khz(clk->params, vco) * 1000;
-		clk->setvco(clk, vco);
-		ret = 0;
-	}
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-realview/clock.h b/arch/arm/mach-realview/clock.h
index ebbb0f0..b8023f9 100644
--- a/arch/arm/mach-realview/clock.h
+++ b/arch/arm/mach-realview/clock.h
@@ -8,12 +8,19 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-struct module;
-struct icst307_params;
 
-struct clk {
-	unsigned long		rate;
-	const struct icst307_params *params;
-	void			*data;
-	void			(*setvco)(struct clk *, struct icst307_vco vco);
+#include <asm/clk.h>
+
+struct clk_realview {
+	struct clk			clk;
+	unsigned long			rate;
+	const struct icst307_params	params;
+	void				(*setvco)(struct clk_realview *,
+						  struct icst307_vco);
 };
+
+unsigned long clk_realview_get_rate(struct clk *clk);
+
+long clk_realview_round_rate(struct clk *clk, unsigned long rate);
+
+int clk_realview_set_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 9f29343..f57ae12 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -273,16 +273,8 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 /*
  * Clock handling
  */
-static const struct icst307_params realview_oscvco_params = {
-	.ref		= 24000,
-	.vco_max	= 200000,
-	.vd_min		= 4 + 8,
-	.vd_max		= 511 + 8,
-	.rd_min		= 1 + 2,
-	.rd_max		= 127 + 2,
-};
 
-static void realview_oscvco_set(struct clk *clk, struct icst307_vco vco)
+static void realview_oscvco_set(struct clk_realview *clk, struct icst307_vco vco)
 {
 	void __iomem *sys_lock = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LOCK_OFFSET;
 	void __iomem *sys_osc;
@@ -301,46 +293,56 @@ static void realview_oscvco_set(struct clk *clk, struct icst307_vco vco)
 	writel(0, sys_lock);
 }
 
-static struct clk oscvco_clk = {
-	.params	= &realview_oscvco_params,
+static struct clk_realview oscvco_clk = {
+	.clk = {
+		.get_rate = clk_realview_get_rate,
+		.round_rate = clk_realview_round_rate,
+		.set_rate = clk_realview_set_rate,
+	},
+	.params	= {
+		.ref		= 24000,
+		.vco_max	= 200000,
+		.vd_min		= 4 + 8,
+		.vd_max		= 511 + 8,
+		.rd_min		= 1 + 2,
+		.rd_max		= 127 + 2,
+	},
 	.setvco = realview_oscvco_set,
 };
 
 /*
  * These are fixed clocks.
  */
-static struct clk ref24_clk = {
-	.rate	= 24000000,
-};
+static struct clk_fixed ref24_clk = DEFINE_CLK_FIXED(24000000);
 
 static struct clk_lookup lookups[] = {
 	{	/* UART0 */
 		.dev_id		= "dev:uart0",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART1 */
 		.dev_id		= "dev:uart1",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART2 */
 		.dev_id		= "dev:uart2",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART3 */
 		.dev_id		= "fpga:uart3",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* KMI0 */
 		.dev_id		= "fpga:kmi0",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* KMI1 */
 		.dev_id		= "fpga:kmi1",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* MMC0 */
 		.dev_id		= "fpga:mmc0",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* EB:CLCD */
 		.dev_id		= "dev:clcd",
-		.clk		= &oscvco_clk,
+		.clk		= &oscvco_clk.clk,
 	}, {	/* PB:CLCD */
 		.dev_id		= "issp:clcd",
-		.clk		= &oscvco_clk,
+		.clk		= &oscvco_clk.clk,
 	}
 };
 
