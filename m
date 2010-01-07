From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 08 Jan 2010 10:44:12 +1100
Subject: [RFC,PATCH 3/7] arm/versatile: use generic struct clk
In-Reply-To: <1262907852.736281.78480196040.1.gpush@pororo>
Message-ID: <1262907852.737098.239895305858.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common struct clk interface for the versatile clocks.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/Kconfig                |    1 
 arch/arm/mach-versatile/clock.c |   44 ++++++++-------------------
 arch/arm/mach-versatile/clock.h |   23 +++++++++-----
 arch/arm/mach-versatile/core.c  |   52 ++++++++++++++++----------------
 4 files changed, 57 insertions(+), 63 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b6eaf10..7e59bce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -249,6 +249,7 @@ config ARCH_VERSATILE
 	select ICST307
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select HAVE_COMMON_STRUCT_CLK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  This enables support for ARM Ltd Versatile board.
diff --git a/arch/arm/mach-versatile/clock.c b/arch/arm/mach-versatile/clock.c
index c50a44e..9b47e38 100644
--- a/arch/arm/mach-versatile/clock.c
+++ b/arch/arm/mach-versatile/clock.c
@@ -18,48 +18,32 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 
-#include <asm/clkdev.h>
+#include <asm/clk.h>
 #include <asm/hardware/icst307.h>
 
 #include "clock.h"
 
-int clk_enable(struct clk *clk)
+unsigned long clk_versatile_get_rate(struct clk *clk)
 {
-	return 0;
+	return to_clk_versatile(clk)->rate;
 }
-EXPORT_SYMBOL(clk_enable);
 
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
+long clk_versatile_round_rate(struct clk *clk, unsigned long rate)
 {
+	const struct icst307_params *params = &to_clk_versatile(clk)->params;
 	struct icst307_vco vco;
-	vco = icst307_khz_to_vco(clk->params, rate / 1000);
-	return icst307_khz(clk->params, vco) * 1000;
+	vco = icst307_khz_to_vco(params, rate / 1000);
+	return icst307_khz(params, vco) * 1000;
 }
-EXPORT_SYMBOL(clk_round_rate);
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+int clk_versatile_set_rate(struct clk *clk, unsigned long rate)
 {
-	int ret = -EIO;
+	struct clk_versatile *v_clk = to_clk_versatile(clk);
+	struct icst307_vco vco;
 
-	if (clk->setvco) {
-		struct icst307_vco vco;
+	vco = icst307_khz_to_vco(&v_clk->params, rate / 1000);
+	v_clk->rate = icst307_khz(&v_clk->params, vco) * 1000;
+	v_clk->setvco(v_clk, vco);
 
-		vco = icst307_khz_to_vco(clk->params, rate / 1000);
-		clk->rate = icst307_khz(clk->params, vco) * 1000;
-		clk->setvco(clk, vco);
-		ret = 0;
-	}
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-versatile/clock.h b/arch/arm/mach-versatile/clock.h
index 03468fd..8b0ec44 100644
--- a/arch/arm/mach-versatile/clock.h
+++ b/arch/arm/mach-versatile/clock.h
@@ -8,13 +8,20 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-struct module;
-struct icst307_params;
 
-struct clk {
-	unsigned long		rate;
-	const struct icst307_params *params;
-	u32			oscoff;
-	void			*data;
-	void			(*setvco)(struct clk *, struct icst307_vco vco);
+struct clk_versatile {
+	struct clk			clk;
+	unsigned long			rate;
+	const struct icst307_params	params;
+	u32				oscoff;
+	void				(*setvco)(struct clk_versatile *,
+						  struct icst307_vco);
 };
+
+unsigned long clk_versatile_get_rate(struct clk *clk);
+
+long clk_versatile_round_rate(struct clk *clk, unsigned long rate);
+
+int clk_versatile_set_rate(struct clk *clk, unsigned long rate);
+
+#define to_clk_versatile(clk) (container_of(clk, struct clk_versatile, clk))
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e13be7c..fb66b20 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -379,16 +379,8 @@ static struct mmci_platform_data mmc0_plat_data = {
 /*
  * Clock handling
  */
-static const struct icst307_params versatile_oscvco_params = {
-	.ref		= 24000,
-	.vco_max	= 200000,
-	.vd_min		= 4 + 8,
-	.vd_max		= 511 + 8,
-	.rd_min		= 1 + 2,
-	.rd_max		= 127 + 2,
-};
 
-static void versatile_oscvco_set(struct clk *clk, struct icst307_vco vco)
+static void versatile_oscvco_set(struct clk_versatile *clk, struct icst307_vco vco)
 {
 	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
 	void __iomem *sys_lock = sys + VERSATILE_SYS_LOCK_OFFSET;
@@ -402,47 +394,57 @@ static void versatile_oscvco_set(struct clk *clk, struct icst307_vco vco)
 	writel(0, sys_lock);
 }
 
-static struct clk osc4_clk = {
-	.params	= &versatile_oscvco_params,
-	.oscoff	= VERSATILE_SYS_OSCCLCD_OFFSET,
-	.setvco	= versatile_oscvco_set,
+static struct clk_versatile osc4_clk = {
+	.clk = {
+		.get_rate = clk_versatile_get_rate,
+		.round_rate = clk_versatile_round_rate,
+		.set_rate = clk_versatile_set_rate,
+	},
+	.params = {
+		.ref		= 24000,
+		.vco_max	= 200000,
+		.vd_min		= 4 + 8,
+		.vd_max		= 511 + 8,
+		.rd_min		= 1 + 2,
+		.rd_max		= 127 + 2,
+	},
+	.oscoff = VERSATILE_SYS_OSCCLCD_OFFSET,
+	.setvco = versatile_oscvco_set,
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
 		.dev_id		= "dev:f1",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART1 */
 		.dev_id		= "dev:f2",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART2 */
 		.dev_id		= "dev:f3",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* UART3 */
 		.dev_id		= "fpga:09",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* KMI0 */
 		.dev_id		= "fpga:06",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* KMI1 */
 		.dev_id		= "fpga:07",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* MMC0 */
 		.dev_id		= "fpga:05",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* MMC1 */
 		.dev_id		= "fpga:0b",
-		.clk		= &ref24_clk,
+		.clk		= &ref24_clk.clk,
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
-		.clk		= &osc4_clk,
+		.clk		= &osc4_clk.clk,
 	}
 };
 
