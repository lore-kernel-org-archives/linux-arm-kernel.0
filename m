From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:05 +0530
Subject: [PATCH V3 02/19] OMAP3+: voltage: fix build warning
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle the case for a future SoC where sys_ck_name might be
uninitialized. Fixes the build warning:
arch/arm/mach-omap2/voltage.c: In function 'omap_voltage_late_init':
arch/arm/mach-omap2/voltage.c:86:8: warning: 'sys_ck_name' may be used uninitialized in this function

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index e0cbd93..56961df 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -91,10 +91,14 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
 	 * XXX Clockfw should handle this, or this should be in a
 	 * struct record
 	 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		sys_ck_name = "sys_ck";
-	else if (cpu_is_omap44xx())
+	} else if (cpu_is_omap44xx()) {
 		sys_ck_name = "sys_clkin_ck";
+	} else {
+		pr_err("%s: Unsupported OMAP\n", __func__);
+		return -EINVAL;
+	}
 
 	/*
 	 * Sys clk rate is require to calculate vp timeout value and
-- 
1.7.1
