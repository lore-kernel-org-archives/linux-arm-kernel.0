From: opendmb@gmail.com (Doug Berger)
Date: Fri, 24 Mar 2017 07:46:28 -0700
Subject: [PATCH 5/9] bus: brcmstb_gisb: Correct hooking of ARM aborts
In-Reply-To: <20170324144632.5896-1-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
Message-ID: <20170324144632.5896-6-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fault status reporting in the FSR registers is different depending
on whether the Long Physical Address Extension (LPAE) is being used.

This commit corrects the registerring of fault handlers for arm
architecture kernels when the LPAE is enabled.  It also forces the
handler to report that the abort exception was unhandled so that the
appropriate signal is sent to the offending user process.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index a94598d0945a..9eba0143f1a4 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -225,27 +225,29 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 				     struct pt_regs *regs)
 {
-	int ret = 0;
 	struct brcmstb_gisb_arb_device *gdev;
 
 	/* iterate over each GISB arb registered handlers */
 	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
-		ret |= brcmstb_gisb_arb_decode_addr(gdev, "bus error");
+		brcmstb_gisb_arb_decode_addr(gdev, "bus error");
+
+#if !defined(CONFIG_ARM_LPAE)
 	/*
 	 * If it was an imprecise abort, then we need to correct the
 	 * return address to be _after_ the instruction.
 	*/
 	if (fsr & (1 << 10))
 		regs->ARM_pc += 4;
+#endif
 
-	return ret;
+	/* Always report unhandled exception */
+	return 1;
 }
 #endif
 
 #ifdef CONFIG_MIPS
 static int brcmstb_bus_error_handler(struct pt_regs *regs, int is_fixup)
 {
-	int ret = 0;
 	struct brcmstb_gisb_arb_device *gdev;
 	u32 cap_status;
 
@@ -258,7 +260,7 @@ static int brcmstb_bus_error_handler(struct pt_regs *regs, int is_fixup)
 			goto out;
 		}
 
-		ret |= brcmstb_gisb_arb_decode_addr(gdev, "bus error");
+		brcmstb_gisb_arb_decode_addr(gdev, "bus error");
 	}
 out:
 	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
@@ -379,9 +381,16 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	list_add_tail(&gdev->next, &brcmstb_gisb_arb_device_list);
 
 #ifdef CONFIG_ARM
+#ifdef CONFIG_ARM_LPAE
+	hook_fault_code(16, brcmstb_bus_error_handler, SIGBUS, 0,
+			"synchronous external abort");
+	hook_fault_code(17, brcmstb_bus_error_handler, SIGBUS, 0,
+			"asynchronous external abort");
+#else
 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
 			"imprecise external abort");
 #endif
+#endif /* CONFIG_ARM */
 #ifdef CONFIG_MIPS
 	board_be_handler = brcmstb_bus_error_handler;
 #endif
-- 
2.12.0
