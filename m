From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 14 Oct 2016 18:30:30 +0530
Subject: [PATCH 6/9] ARM: DRA7: hwmod: Do not register RTC on DRA71
In-Reply-To: <20161014130033.14172-1-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Message-ID: <20161014130033.14172-7-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

RTC is not available on DRA71x, so accessing any of the RTC
register or clkctrl register will lead to a crash. So, do not
register RTC hwmod for DRA71x.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 1ab7096..7f48577 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -3845,7 +3845,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__pciess2,
 	&dra7xx_l4_cfg__pciess2,
 	&dra7xx_l3_main_1__qspi,
-	&dra7xx_l4_per3__rtcss,
 	&dra7xx_l4_cfg__sata,
 	&dra7xx_l4_cfg__smartreflex_core,
 	&dra7xx_l4_cfg__smartreflex_mpu,
@@ -3905,6 +3904,11 @@ static struct omap_hwmod_ocp_if *dra72x_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+static struct omap_hwmod_ocp_if *dra74x_dra72x_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l4_per3__rtcss,
+	NULL,
+};
+
 int __init dra7xx_hwmod_init(void)
 {
 	int ret;
@@ -3920,5 +3924,9 @@ int __init dra7xx_hwmod_init(void)
 	if (!ret && omap_type() == OMAP2_DEVICE_TYPE_GP)
 		ret = omap_hwmod_register_links(dra7xx_gp_hwmod_ocp_ifs);
 
+	/* now for the IPs *NOT* in dra71 */
+	if (!ret && !of_machine_is_compatible("ti,dra718"))
+		ret = omap_hwmod_register_links(dra74x_dra72x_hwmod_ocp_ifs);
+
 	return ret;
 }
-- 
2.9.3
