From: opendmb@gmail.com (Doug Berger)
Date: Wed, 29 Mar 2017 17:29:12 -0700
Subject: [PATCH v3 4/6] bus: brcmstb_gisb: remove low-level ARM hooks
In-Reply-To: <20170330002914.7371-1-opendmb@gmail.com>
References: <20170330002914.7371-1-opendmb@gmail.com>
Message-ID: <20170330002914.7371-5-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture can provide meaningful diagnostic
output from the GISB arbiter solely from interrupts and
notifiers without the need to hook the low level fault
handlers.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index a2e1c5c25a3a..3fbc116e6b95 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -28,11 +28,6 @@
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
 
-#ifdef CONFIG_ARM
-#include <asm/bug.h>
-#include <asm/signal.h>
-#endif
-
 #ifdef CONFIG_MIPS
 #include <asm/traps.h>
 #endif
@@ -228,27 +223,6 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	return 0;
 }
 
-#ifdef CONFIG_ARM
-static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
-				     struct pt_regs *regs)
-{
-	int ret = 0;
-	struct brcmstb_gisb_arb_device *gdev;
-
-	/* iterate over each GISB arb registered handlers */
-	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
-		ret |= brcmstb_gisb_arb_decode_addr(gdev, "bus error");
-	/*
-	 * If it was an imprecise abort, then we need to correct the
-	 * return address to be _after_ the instruction.
-	*/
-	if (fsr & (1 << 10))
-		regs->ARM_pc += 4;
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_MIPS
 static int brcmstb_bus_error_handler(struct pt_regs *regs, int is_fixup)
 {
@@ -415,10 +389,6 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 
 	list_add_tail(&gdev->next, &brcmstb_gisb_arb_device_list);
 
-#ifdef CONFIG_ARM
-	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
-			"imprecise external abort");
-#endif
 #ifdef CONFIG_MIPS
 	board_be_handler = brcmstb_bus_error_handler;
 #endif
-- 
2.12.0
