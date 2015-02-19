From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 19 Feb 2015 00:09:45 -0600
Subject: [RFC PATCH] arm: cti: fix up cti pmu build
In-Reply-To: <1424326185-31463-1-git-send-email-dinguyen@opensource.altera.com>
References: <1424326185-31463-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1424326185-31463-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

commit "184901a06a36 ARM: removing support for etb/etm in "arch/arm/kernel/"
removed arch/arm/include/asm/hardware/coresight.h

then

commit "a06ae8609b3d coresight: add CoreSight core layer framework" added
include/linux/coresight.h

Update cti.h to use thew new coresight.h and replace CS_LAR_KEY with
CORESIGHT_UNLOCK.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cti.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
index 2381199..044fda8 100644
--- a/arch/arm/include/asm/cti.h
+++ b/arch/arm/include/asm/cti.h
@@ -2,7 +2,7 @@
 #define __ASMARM_CTI_H
 
 #include	<asm/io.h>
-#include	<asm/hardware/coresight.h>
+#include	<linux/coresight.h>
 
 /* The registers' definition is from section 3.2 of
  * Embedded Cross Trigger Revision: r0p0
@@ -142,7 +142,7 @@ static inline void cti_irq_ack(struct cti *cti)
  */
 static inline void cti_unlock(struct cti *cti)
 {
-	__raw_writel(CS_LAR_KEY, cti->base + LOCKACCESS);
+	__raw_writel(CORESIGHT_UNLOCK, cti->base + LOCKACCESS);
 }
 
 /**
@@ -154,6 +154,6 @@ static inline void cti_unlock(struct cti *cti)
  */
 static inline void cti_lock(struct cti *cti)
 {
-	__raw_writel(~CS_LAR_KEY, cti->base + LOCKACCESS);
+	__raw_writel(~CORESIGHT_UNLOCK, cti->base + LOCKACCESS);
 }
 #endif
-- 
2.2.1
