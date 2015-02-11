From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 11 Feb 2015 16:40:58 +0100
Subject: [PATCH soc] ARM: BCM5301X: Ignore another (BCM4709 specific) fault
 code
Message-ID: <1423669258-27449-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom ARM devices seem to generate some fault once per boot. We
already have an ignoring handler for BCM4707/BCM4708, but BCM4709
generates different code.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/mach-bcm/bcm_5301x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index e9bcbdb..7aef927 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -18,15 +18,16 @@ static bool first_fault = true;
 static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
 				 struct pt_regs *regs)
 {
-	if (fsr == 0x1c06 && first_fault) {
+	if ((fsr == 0x1406 || fsr == 0x1c06) && first_fault) {
 		first_fault = false;
 
 		/*
-		 * These faults with code 0x1c06 happens for no good reason,
-		 * possibly left over from the CFE boot loader.
+		 * These faults with codes 0x1406 (BCM4709) or 0x1c06 happens
+		 * for no good reason, possibly left over from the CFE boot
+		 * loader.
 		 */
 		pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
-		addr, fsr);
+			addr, fsr);
 
 		/* Returning non-zero causes fault display and panic */
 		return 0;
-- 
1.8.4.5
