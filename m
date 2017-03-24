From: opendmb@gmail.com (Doug Berger)
Date: Fri, 24 Mar 2017 07:46:30 -0700
Subject: [PATCH 7/9] bus: brcmstb_gisb: Add ARM64 support
In-Reply-To: <20170324144632.5896-1-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
Message-ID: <20170324144632.5896-8-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>

Hook to the ARM64 data abort exception #16: synchronous external
abort, which is how the GISB errors will be funneled back to the
ARM64 CPU in case of problems

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/Kconfig        |  2 +-
 drivers/bus/brcmstb_gisb.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0a52da439abf..d2a5f1184022 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -57,7 +57,7 @@ config ARM_CCN
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
-	depends on ARM || MIPS
+	depends on ARM || ARM64 || MIPS
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index c8d2a61d21ed..bf26b4017a2c 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -30,6 +30,11 @@
 #include <asm/signal.h>
 #endif
 
+#ifdef CONFIG_ARM64
+#include <asm/signal.h>
+#include <asm/system_misc.h>
+#endif
+
 #ifdef CONFIG_MIPS
 #include <asm/traps.h>
 #endif
@@ -225,7 +230,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	return 0;
 }
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 				     struct pt_regs *regs)
 {
@@ -235,7 +240,7 @@ static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
 		brcmstb_gisb_arb_decode_addr(gdev, "bus error");
 
-#if !defined(CONFIG_ARM_LPAE)
+#if defined(CONFIG_ARM) && !defined(CONFIG_ARM_LPAE)
 	/*
 	 * If it was an imprecise abort, then we need to correct the
 	 * return address to be _after_ the instruction.
@@ -247,7 +252,7 @@ static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 	/* Always report unhandled exception */
 	return 1;
 }
-#endif
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
 
 #ifdef CONFIG_MIPS
 static int brcmstb_bus_error_handler(struct pt_regs *regs, int is_fixup)
@@ -395,6 +400,10 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 			"imprecise external abort");
 #endif
 #endif /* CONFIG_ARM */
+#ifdef CONFIG_ARM64
+	hook_fault_code(16, brcmstb_bus_error_handler, SIGBUS, 0,
+			"synchronous external abort");
+#endif
 #ifdef CONFIG_MIPS
 	board_be_handler = brcmstb_bus_error_handler;
 #endif
-- 
2.12.0
