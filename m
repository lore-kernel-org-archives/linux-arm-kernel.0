From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 Feb 2015 10:38:47 +0100
Subject: [PATCH] ARM: rockchip: Constify struct regmap_config and staticize
 local function
Message-ID: <1424770727-5396-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Make function rockchip_get_core_reset() static because it is not used
outside of the platsmp.c file.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-rockchip/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index f26fcdca2445..5b4ca3c3c879 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -55,7 +55,7 @@ static int pmu_power_domain_is_on(int pd)
 	return !(val & BIT(pd));
 }
 
-struct reset_control *rockchip_get_core_reset(int cpu)
+static struct reset_control *rockchip_get_core_reset(int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 	struct device_node *np;
@@ -201,7 +201,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 	return 0;
 }
 
-static struct regmap_config rockchip_pmu_regmap_config = {
+static const struct regmap_config rockchip_pmu_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
1.9.1
