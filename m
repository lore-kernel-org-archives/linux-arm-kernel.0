From: cernekee@gmail.com (Kevin Cernekee)
Date: Tue, 25 Nov 2014 16:49:49 -0800
Subject: [PATCH 4/9] bus: brcmstb_gisb: Make the driver buildable on MIPS
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Message-ID: <1416962994-27095-5-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM7xxx ARM and MIPS platforms share a similar hardware block for
reporting GISB errors, so they both benefit from the use of this driver.
Conditionally compile the ARM-specific bus error handler so that the
GISB error IRQ handler works on other architectures.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/bus/Kconfig        | 2 +-
 drivers/bus/brcmstb_gisb.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 603eb1b..b99729e 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -6,7 +6,7 @@ menu "Bus devices"
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
-	depends on ARM
+	depends on ARM || MIPS
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f2cd6a2d..5da935a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -24,8 +24,10 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 
+#ifdef CONFIG_ARM
 #include <asm/bug.h>
 #include <asm/signal.h>
+#endif
 
 #define ARB_TIMER			0x008
 #define ARB_ERR_CAP_CLR			0x7e4
@@ -141,6 +143,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	return 0;
 }
 
+#ifdef CONFIG_ARM
 static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 				     struct pt_regs *regs)
 {
@@ -165,6 +168,7 @@ void __init brcmstb_hook_fault_code(void)
 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
 			"imprecise external abort");
 }
+#endif
 
 static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
 {
-- 
2.1.0
