From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:12 -0700
Subject: [PATCH 08/46] davinci: DA8XX/OMAP-L1XX: Avoid use of IO_ADDRESS for
	SYSCFG module
In-Reply-To: <1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Avoid use of IO_ADDRESS() for SYSCFG module by doing an ioremap() instead.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da830.c              |    7 ++++++-
 arch/arm/mach-davinci/da850.c              |    7 ++++++-
 arch/arm/mach-davinci/devices-da8xx.c      |    2 ++
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index c2224b9..3d70eae 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1184,7 +1184,6 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.cpu_clks		= da830_clks,
 	.psc_bases		= da830_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da830_psc_bases),
-	.pinmux_base		= IO_ADDRESS(DA8XX_SYSCFG_BASE + 0x120),
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
 	.intc_base		= (void __iomem *)DA8XX_CP_INTC_VIRT,
@@ -1201,5 +1200,11 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 
 void __init da830_init(void)
 {
+	da8xx_syscfg_base = ioremap(DA8XX_SYSCFG_BASE, SZ_4K);
+	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
+		return;
+
+	davinci_soc_info_da830.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
+
 	davinci_common_init(&davinci_soc_info_da830);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 18c33b6..54d1836 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -799,7 +799,6 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.cpu_clks		= da850_clks,
 	.psc_bases		= da850_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da850_psc_bases),
-	.pinmux_base		= IO_ADDRESS(DA8XX_SYSCFG_BASE + 0x120),
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
 	.intc_base		= (void __iomem *)DA8XX_CP_INTC_VIRT,
@@ -816,5 +815,11 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 
 void __init da850_init(void)
 {
+	da8xx_syscfg_base = ioremap(DA8XX_SYSCFG_BASE, SZ_4K);
+	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
+		return;
+
+	davinci_soc_info_da850.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
+
 	davinci_common_init(&davinci_soc_info_da850);
 }
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index a54aa4e..0102e0a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -43,6 +43,8 @@
 #define DA8XX_MDIO_REG_OFFSET		0x4000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
+void __iomem *da8xx_syscfg_base;
+
 static struct plat_serial8250_port da8xx_serial_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART0_BASE,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 1c42379..11d2079 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -18,6 +18,8 @@
 #include <mach/asp.h>
 #include <mach/mmc.h>
 
+extern void __iomem *da8xx_syscfg_base;
+
 /*
  * The cp_intc interrupt controller for the da8xx isn't in the same
  * chunk of physical memory space as the other registers (like it is
@@ -30,6 +32,7 @@
 #define DA8XX_CP_INTC_VIRT	(IO_VIRT - DA8XX_CP_INTC_SIZE - SZ_4K)
 
 #define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
+#define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
-- 
1.6.4.3
