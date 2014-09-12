From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:34:31 +0200
Subject: [PATCH 3/3] ARM: rockchip: add a cpufreq-cpu0 device
In-Reply-To: <1410561271-19197-1-git-send-email-heiko@sntech.de>
References: <1410561271-19197-1-git-send-email-heiko@sntech.de>
Message-ID: <1410561271-19197-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip SoCs can sucessfully use the generic cpufreq-cpu0 driver to
do frequency scaling. Therefore add a platform device in the machine
init code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 8ab9e0e..eea1f06 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -24,6 +24,12 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 
+static void __init rockchip_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_simple("cpufreq-cpu0", 0, NULL, 0);
+}
+
 static const char * const rockchip_board_dt_compat[] = {
 	"rockchip,rk2928",
 	"rockchip,rk3066a",
@@ -37,4 +43,5 @@ DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
 	.dt_compat	= rockchip_board_dt_compat,
+	.init_machine	= rockchip_dt_init,
 MACHINE_END
-- 
2.0.1
