From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:13 -0700
Subject: [PATCH 09/46] davinci: DA8XX/OMAP-L1XX: JTAG ID register should
	offset from SYSCFG base
In-Reply-To: <1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This makes it clear that JTAG ID register is part of the
SYSCFG module

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da830.c              |    3 ++-
 arch/arm/mach-davinci/da850.c              |    3 ++-
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 3d70eae..f52174a 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1178,7 +1178,6 @@ static struct davinci_timer_info da830_timer_info = {
 static struct davinci_soc_info davinci_soc_info_da830 = {
 	.io_desc		= da830_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da830_io_desc),
-	.jtag_id_base		= IO_ADDRESS(DA8XX_JTAG_ID_REG),
 	.ids			= da830_ids,
 	.ids_num		= ARRAY_SIZE(da830_ids),
 	.cpu_clks		= da830_clks,
@@ -1204,6 +1203,8 @@ void __init da830_init(void)
 	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
 		return;
 
+	davinci_soc_info_da830.jtag_id_base =
+					DA8XX_SYSCFG_VIRT(DA8XX_JTAG_ID_REG);
 	davinci_soc_info_da830.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
 
 	davinci_common_init(&davinci_soc_info_da830);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 54d1836..f5c3a6a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -793,7 +793,6 @@ static struct davinci_timer_info da850_timer_info = {
 static struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
-	.jtag_id_base		= IO_ADDRESS(DA8XX_JTAG_ID_REG),
 	.ids			= da850_ids,
 	.ids_num		= ARRAY_SIZE(da850_ids),
 	.cpu_clks		= da850_clks,
@@ -819,6 +818,8 @@ void __init da850_init(void)
 	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
 		return;
 
+	davinci_soc_info_da850.jtag_id_base =
+					DA8XX_SYSCFG_VIRT(DA8XX_JTAG_ID_REG);
 	davinci_soc_info_da850.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
 
 	davinci_common_init(&davinci_soc_info_da850);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 11d2079..6f03650 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -33,10 +33,10 @@ extern void __iomem *da8xx_syscfg_base;
 
 #define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
 #define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
+#define DA8XX_JTAG_ID_REG	0x18
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
-#define DA8XX_JTAG_ID_REG	0x01c14018
 #define DA8XX_TIMER64P0_BASE	0x01c20000
 #define DA8XX_TIMER64P1_BASE	0x01c21000
 #define DA8XX_GPIO_BASE		0x01e26000
-- 
1.6.4.3
