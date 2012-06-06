From: andreas@biessmann.de (=?UTF-8?q?Andreas=20Bie=C3=9Fmann?=)
Date: Wed,  6 Jun 2012 13:22:58 +0200
Subject: [PATCH] arm:gemini: fix irq.c
Message-ID: <1338981778-19938-1-git-send-email-andreas@biessmann.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9f97da78bf018206fb623cd351d454af2f105fe0 moved disable_hlt() from
arch/arm/include/asm/system.h to arch/arm/include/asm/system_misc.h but missed
to change arch/arm/mach-gemini/irq.c.

This patch fixes following error:

---8<---
arch/arm/mach-gemini/irq.c: In function 'gemini_init_irq':
arch/arm/mach-gemini/irq.c:79:2: error: implicit declaration of function 'disable_hlt' [-Werror=implicit-function-declaration]
--->8---

Signed-off-by: Andreas Bie?mann <andreas@biessmann.de>
cc: Hans Ulli Kroll <ulli.kroll@googlemail.com> 
cc: Russell King <linux@arm.linux.org.uk>
cc: linux-arm-kernel at lists.infradead.org
---
Note: this is broken since 3.4 release, 3.3 is sane.

 arch/arm/mach-gemini/irq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
index ca70e5f..020852d 100644
--- a/arch/arm/mach-gemini/irq.c
+++ b/arch/arm/mach-gemini/irq.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
+#include <asm/system_misc.h>
 #include <mach/hardware.h>
 
 #define IRQ_SOURCE(base_addr)	(base_addr + 0x00)
-- 
1.7.10
