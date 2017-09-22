From: allen.lkml@gmail.com (Allen Pais)
Date: Fri, 22 Sep 2017 17:10:57 +0530
Subject: [PATCH] arm: mach-footbridge: use setup_timer() helper.
Message-ID: <1506080457-6019-1-git-send-email-allen.lkml@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/arm/mach-footbridge/dc21285.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 96a3d73..f8d011b 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -323,13 +323,8 @@ void __init dc21285_preinit(void)
 		*CSR_PCICMD = (*CSR_PCICMD & 0xffff) | PCICMD_ERROR_BITS;
 	}
 
-	init_timer(&serr_timer);
-	init_timer(&perr_timer);
-
-	serr_timer.data = IRQ_PCI_SERR;
-	serr_timer.function = dc21285_enable_error;
-	perr_timer.data = IRQ_PCI_PERR;
-	perr_timer.function = dc21285_enable_error;
+	setup_timer(&serr_timer, dc21285_enable_error, IRQ_PCI_SERR);
+	setup_timer(&perr_timer, dc21285_enable_error, IRQ_PCI_PERR);
 
 	/*
 	 * We don't care if these fail.
-- 
2.7.4
