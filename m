From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Apr 2015 16:05:24 +0900
Subject: [PATCH v3 1/2] ARM: EXYNOS: Get current parent clock for power domain
 on/off
Message-ID: <1430377525-3145-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a fixed (by DTS) parent for clocks when turning on the power domain
may introduce issues in other drivers. For example when such driver
changes the parent during runtime and expects that he is the only place
of such change.

Do not rely on DTS providing the fixed parent for such clocks. Instead
before switching domain off, grab a current parent of a clock with
clk_get_parent().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

---

Changes since v2:
1. Don't store the parent of the clock on driver init but instead mark
   it as -EINVAL. This means that on first power up of the domain (when
   system is booted with domain being off) the parent won't be set. This
   is a special rare condition because all domains are being turned on:
   either by reset value or by bootloader. Javier's reviewed by
   retained.
2. Add Javier's tags.

Changes since v1:
1. Drop "pclk" bindings entirely as suggested by Andrzej Hajda.
   This was significant change so I did not add Javier's
   reviewed/tested tags.
---
 .../devicetree/bindings/arm/exynos/power_domain.txt      |  7 ++++---
 arch/arm/mach-exynos/pm_domains.c                        | 16 +++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 5da38c5ed476..e151057d92f0 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -19,9 +19,10 @@ Optional Properties:
 	domains.
 - clock-names: The following clocks can be specified:
 	- oscclk: Oscillator clock.
-	- pclkN, clkN: Pairs of parent of input clock and input clock to the
-		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
-		are supported currently.
+	- clkN: Input clocks to the devices in this power domain. These clocks
+		will be reparented to oscclk before swithing power domain off.
+		Their original parent will be brought back after turning on
+		the domain. Maximum of 4 clocks (N = 0 to 3) are supported.
 	- asbN: Clocks required by asynchronous bridges (ASB) present in
 		the power domain. These clock should be enabled during power
 		domain on/off operations.
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index cbe56b35aea0..294fc7e956aa 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -62,6 +62,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
 			if (IS_ERR(pd->clk[i]))
 				break;
+			pd->pclk[i] = clk_get_parent(pd->clk[i]);
 			if (clk_set_parent(pd->clk[i], pd->oscclk))
 				pr_err("%s: error setting oscclk as parent to clock %d\n",
 						pd->name, i);
@@ -90,6 +91,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
 			if (IS_ERR(pd->clk[i]))
 				break;
+
+			if (IS_ERR(pd->clk[i]))
+				continue; /* Skip on first power up */
 			if (clk_set_parent(pd->clk[i], pd->pclk[i]))
 				pr_err("%s: error setting parent to clock%d\n",
 						pd->name, i);
@@ -161,13 +165,11 @@ static __init int exynos4_pm_init_power_domain(void)
 			pd->clk[i] = clk_get(dev, clk_name);
 			if (IS_ERR(pd->clk[i]))
 				break;
-			snprintf(clk_name, sizeof(clk_name), "pclk%d", i);
-			pd->pclk[i] = clk_get(dev, clk_name);
-			if (IS_ERR(pd->pclk[i])) {
-				clk_put(pd->clk[i]);
-				pd->clk[i] = ERR_PTR(-EINVAL);
-				break;
-			}
+			/*
+			 * Skip setting parent on first power up.
+			 * The parent at this time may not be useful at all.
+			 */
+			pd->pclk[i] = ERR_PTR(-EINVAL);
 		}
 
 		if (IS_ERR(pd->clk[0]))
-- 
1.9.1
