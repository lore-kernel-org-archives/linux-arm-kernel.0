From: thara@ti.com (Thara Gopinath)
Date: Mon, 20 Dec 2010 22:30:35 +0530
Subject: [PATCH v5 3/5] OMAP4: PM: Program correct init voltages for scalable
	VDDs
In-Reply-To: <1292864437-15353-1-git-send-email-thara@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>
Message-ID: <1292864437-15353-4-git-send-email-thara@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default the system boots up at nominal voltage for every
voltage domain in the system. This patch puts vdd_mpu, vdd_iva
and vdd_core to the correct boot up voltage as per the opp tables
specified. This patch implements this by matching the rate of
the main clock of the voltage domain with the opp table and
picking up the correct voltage.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 8d0b03b..2e80de8 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -209,6 +209,16 @@ static void __init omap3_init_voltages(void)
 	omap2_set_init_voltage("core", "l3_ick", l3_dev);
 }
 
+static void __init omap4_init_voltages(void)
+{
+	if (!cpu_is_omap44xx())
+		return;
+
+	omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
+	omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
+	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
+}
+
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
@@ -229,6 +239,7 @@ static int __init omap2_common_pm_late_init(void)
 
 	/* Initialize the voltages */
 	omap3_init_voltages();
+	omap4_init_voltages();
 
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
-- 
1.7.0.4
