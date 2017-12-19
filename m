From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Dec 2017 11:22:47 -0800
Subject: [PATCH v2 9/9] soc: brcmstb: biuctrl: Move to early_initcall
In-Reply-To: <20171219192247.29799-1-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
Message-ID: <20171219192247.29799-10-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being called during early_initcall() is early enough that it occurs
before SMP initialization, which is all we care about for the Bus
Interface Unit configuration.

This solves lack of BIU initialization on ARM64 platforms where we do
not have an anchor where to put the BIU initialization (since there are
no machine descriptors).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/brcmstb.c         | 2 --
 drivers/soc/bcm/brcmstb/biuctrl.c   | 6 ++++--
 include/linux/soc/brcmstb/brcmstb.h | 6 ------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 07e3a86c6466..5f127d5f1045 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
-#include <linux/soc/brcmstb/brcmstb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,7 +37,6 @@ u32 brcmstb_uart_config[3] = {
 static void __init brcmstb_init_irq(void)
 {
 	irqchip_init();
-	brcmstb_biuctrl_init();
 }
 
 static const char *const brcmstb_match[] __initconst = {
diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index dd45bbfe64dd..2b23ae7b5e9b 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -240,7 +240,7 @@ static struct syscore_ops brcmstb_cpu_credit_syscore_ops = {
 #endif
 
 
-void __init brcmstb_biuctrl_init(void)
+static int __init brcmstb_biuctrl_init(void)
 {
 	int ret;
 
@@ -249,11 +249,13 @@ void __init brcmstb_biuctrl_init(void)
 	ret = mcp_write_pairing_set();
 	if (ret) {
 		pr_err("MCP: Unable to disable write pairing!\n");
-		return;
+		return ret;
 	}
 
 	mcp_b53_set();
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
 #endif
+	return 0;
 }
+early_initcall(brcmstb_biuctrl_init);
diff --git a/include/linux/soc/brcmstb/brcmstb.h b/include/linux/soc/brcmstb/brcmstb.h
index 12e548938bbb..8e884e0dda0a 100644
--- a/include/linux/soc/brcmstb/brcmstb.h
+++ b/include/linux/soc/brcmstb/brcmstb.h
@@ -13,12 +13,6 @@ static inline u32 BRCM_REV(u32 reg)
 }
 
 /*
- * Bus Interface Unit control register setup, must happen early during boot,
- * before SMP is brought up, called by machine entry point.
- */
-void brcmstb_biuctrl_init(void);
-
-/*
  * Helper functions for getting family or product id from the
  * SoC driver.
  */
-- 
2.9.3
