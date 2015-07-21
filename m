From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 21 Jul 2015 16:05:41 -0500
Subject: [PATCHv2] ARM: socfpga: add reset for the Arria 10 platform
Message-ID: <1437512741-14099-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Since the Arria10's reset register offset is different from the Cyclone/Arria 5,
it's best to add a new DT_MACHINE_START() for the Arria10.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: use altera_a10_dt_match for the A10 machine desc
---
 arch/arm/mach-socfpga/core.h    |  1 +
 arch/arm/mach-socfpga/socfpga.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 7259c37..5bc6ea8 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -25,6 +25,7 @@
 #define SOCFPGA_RSTMGR_MODPERRST	0x14
 #define SOCFPGA_RSTMGR_BRGMODRST	0x1c
 
+#define SOCFPGA_A10_RSTMGR_CTRL		0xC
 #define SOCFPGA_A10_RSTMGR_MODMPURST	0x20
 
 /* System Manager bits */
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 19643a7..a1c0efa 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -74,6 +74,19 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
+static void socfpga_arria10_restart(enum reboot_mode mode, const char *cmd)
+{
+	u32 temp;
+
+	temp = readl(rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
+
+	if (mode == REBOOT_HARD)
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	writel(temp, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
+}
+
 static const char *altera_dt_match[] = {
 	"altr,socfpga",
 	NULL
@@ -86,3 +99,16 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
 MACHINE_END
+
+static const char *altera_a10_dt_match[] = {
+	"altr,socfpga-arria10",
+	NULL
+};
+
+DT_MACHINE_START(SOCFPGA_A10, "Altera SOCFPGA Arria10")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.init_irq	= socfpga_init_irq,
+	.restart	= socfpga_arria10_restart,
+	.dt_compat	= altera_a10_dt_match,
+MACHINE_END
-- 
2.4.5
