From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 24 Oct 2015 18:51:55 +0800
Subject: [PATCH v4 8/8] rockchip: make sure timer5 is enabled on rk3036
 platforms
In-Reply-To: <1445682629-21632-1-git-send-email-zhengxing@rock-chips.com>
References: <1445682629-21632-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1445683915-21913-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer5 supplies the architected timer and thus as has to run when
the system clocksource and clockevents drivers are registered.

---

Changes in v4:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

 arch/arm/mach-rockchip/rockchip.c |   44 +++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 251c7b9..608b31c 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -29,31 +29,38 @@
 #include "core.h"
 #include "pm.h"
 
+#define RK3036_TIMER_PHYS 0x20044000
+
 #define RK3288_GRF_SOC_CON0 0x244
 #define RK3288_TIMER6_7_PHYS 0xff810000
 
+static void rockchip_init_arch_timer_supply(resource_size_t phys, int offs)
+{
+	void __iomem *reg_base = ioremap(phys, SZ_16K);
+
+	/*
+	 * Most/all uboot versions for Rockchip SoCs don't enable
+	 * timer which is needed for the architected timer to work.
+	 * So make sure it is running during early boot.
+	 */
+	if (reg_base) {
+		writel(0, reg_base + offs + 0x10);
+		writel(0xffffffff, reg_base + offs);
+		writel(0xffffffff, reg_base + offs + 0x04);
+		writel(1, reg_base + offs + 0x10);
+		dsb();
+		iounmap(reg_base);
+	} else {
+		pr_err("rockchip: could not map timer registers\n");
+	}
+}
+
 static void __init rockchip_timer_init(void)
 {
 	if (of_machine_is_compatible("rockchip,rk3288")) {
 		struct regmap *grf;
-		void __iomem *reg_base;
 
-		/*
-		 * Most/all uboot versions for rk3288 don't enable timer7
-		 * which is needed for the architected timer to work.
-		 * So make sure it is running during early boot.
-		 */
-		reg_base = ioremap(RK3288_TIMER6_7_PHYS, SZ_16K);
-		if (reg_base) {
-			writel(0, reg_base + 0x30);
-			writel(0xffffffff, reg_base + 0x20);
-			writel(0xffffffff, reg_base + 0x24);
-			writel(1, reg_base + 0x30);
-			dsb();
-			iounmap(reg_base);
-		} else {
-			pr_err("rockchip: could not map timer7 registers\n");
-		}
+		rockchip_init_arch_timer_supply(RK3288_TIMER6_7_PHYS, 0x20);
 
 		/*
 		 * Disable auto jtag/sdmmc switching that causes issues
@@ -64,6 +71,8 @@ static void __init rockchip_timer_init(void)
 			regmap_write(grf, RK3288_GRF_SOC_CON0, 0x10000000);
 		else
 			pr_err("rockchip: could not get grf syscon\n");
+	} else if (of_machine_is_compatible("rockchip,rk3036")) {
+		rockchip_init_arch_timer_supply(RK3036_TIMER_PHYS, 0xa0);
 	}
 
 	of_clk_init(NULL);
@@ -79,6 +88,7 @@ static void __init rockchip_dt_init(void)
 
 static const char * const rockchip_board_dt_compat[] = {
 	"rockchip,rk2928",
+	"rockchip,rk3036",
 	"rockchip,rk3066a",
 	"rockchip,rk3066b",
 	"rockchip,rk3188",
-- 
1.7.9.5
