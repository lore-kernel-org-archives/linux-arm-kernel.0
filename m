From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:57 -0800
Subject: [PATCH 16/18] ARM: vf610: PM: enable Suspend-to-RAM only if hardware
 fixes are in place
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-17-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use self-refresh mode for DDR3 SDRAM memory in LPSTOPx mode, the
hardware need to have pull-ups/downs populated on RESET/CKE line of
the DDR memory. Read the device tree property which indicates whether
a given board has such resistors populated.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/pm-vf610.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-vf610.c b/arch/arm/mach-imx/pm-vf610.c
index ecc7c9c..3da93e9 100644
--- a/arch/arm/mach-imx/pm-vf610.c
+++ b/arch/arm/mach-imx/pm-vf610.c
@@ -93,6 +93,7 @@
 
 static void __iomem *suspend_ocram_base;
 static void (*vf610_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+static bool has_cke_reset_pulls;
 
 #ifdef DEBUG
 static void __iomem *uart_membase;
@@ -382,7 +383,8 @@ static int vf610_pm_enter(suspend_state_t state)
 
 static int vf610_pm_valid(suspend_state_t state)
 {
-	return (state == PM_SUSPEND_STANDBY || state == PM_SUSPEND_MEM);
+	return (state == PM_SUSPEND_STANDBY ||
+		(state == PM_SUSPEND_MEM && has_cke_reset_pulls));
 }
 
 static const struct platform_suspend_ops vf610_pm_ops = {
@@ -476,6 +478,19 @@ static int __init vf610_suspend_init(const struct vf610_pm_socdata *socdata)
 		return ret;
 #endif
 
+	node = of_find_compatible_node(NULL, NULL, socdata->ddrmc_compat);
+	if (node) {
+		has_cke_reset_pulls =
+			of_property_read_bool(node, "fsl,has-cke-reset-pulls");
+
+		of_node_put(node);
+	}
+
+	if (has_cke_reset_pulls)
+		pr_info("PM: CKE/RESET pulls available, enable Suspend-to-RAM\n");
+	else
+		pr_info("PM: No CKE/RESET pulls, disable Suspend-to-RAM\n");
+
 	suspend_set_ops(&vf610_pm_ops);
 
 	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
-- 
2.7.2
