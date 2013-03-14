From: avinashphilip@ti.com (Philip Avinash)
Date: Thu, 14 Mar 2013 16:07:32 +0530
Subject: [PATCH 2/3] ARM: davinci: da850: Enable EHRPWM TBCLK from CFG_CHIP1
In-Reply-To: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
References: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1363257453-24747-3-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

da850 platforms require TBCLK synchronization in CFG_CHIP1 register for
TBCLK enable in EHRPWM modules. Enabling of TBCLK is done only if EHRPWM
DT node status is set to "okay" DT blob.
Also adds macro definitions for DA8XX_EHRPWM_TBCLKSYNC and
DA8XX_CFGCHIP1_REG.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
:100644 100644 6b7a0a2... 72466ab... M	arch/arm/mach-davinci/da8xx-dt.c
:100644 100644 de439b7... be77ce2... M	arch/arm/mach-davinci/include/mach/da8xx.h
 arch/arm/mach-davinci/da8xx-dt.c           |   15 +++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 6b7a0a2..72466ab 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -19,6 +19,7 @@
 #include <mach/da8xx.h>
 
 #define DA8XX_NUM_UARTS	3
+#define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
 
 void __init da8xx_uart_clk_enable(void)
 {
@@ -47,10 +48,24 @@ struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
+	struct device_node *ehrpwm_np;
+	const char *ehrpwm_compat = "ti,da850-ehrpwm";
+	void __iomem *cfg_chip1_base;
+
+	cfg_chip1_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG);
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     da850_auxdata_lookup, NULL);
 
 	da8xx_uart_clk_enable();
+
+	for_each_compatible_node(ehrpwm_np, NULL, ehrpwm_compat)
+		if (of_device_is_available(ehrpwm_np)) {
+			/* Enable TBCLK synchronization for EHRWPM modules */
+			writel(readl(cfg_chip1_base) | DA8XX_EHRPWM_TBCLKSYNC,
+					cfg_chip1_base);
+			break;
+		}
 }
 
 static const char *da850_boards_compat[] __initdata = {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index de439b7..be77ce2 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -55,6 +55,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_SYSCFG0_VIRT(x)	(da8xx_syscfg0_base + (x))
 #define DA8XX_JTAG_ID_REG	0x18
 #define DA8XX_CFGCHIP0_REG	0x17c
+#define DA8XX_CFGCHIP1_REG	0x180
 #define DA8XX_CFGCHIP2_REG	0x184
 #define DA8XX_CFGCHIP3_REG	0x188
 
-- 
1.7.9.5
