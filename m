From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 21:40:53 +0000
Subject: [PATCH] ARM: cti: fix manipulation of debug lock registers
Message-ID: <1353015653-23711-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LOCKSTATUS register for memory-mapped coresight devices indicates
whether or not the device in question implements hardware locking. If
not, locking is not present (i.e. LSR.SLI == 0) and LAR is write-ignore,
so software doesn't actually need to check the status register at all.

This patch removes the broken LSR checks.

Cc: Ming Lei <ming.lei@canonical.com>
Reported-by: Mike Williams <michael.williams@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cti.h |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
index a0ada3e..f2e5cad 100644
--- a/arch/arm/include/asm/cti.h
+++ b/arch/arm/include/asm/cti.h
@@ -146,15 +146,7 @@ static inline void cti_irq_ack(struct cti *cti)
  */
 static inline void cti_unlock(struct cti *cti)
 {
-	void __iomem *base = cti->base;
-	unsigned long val;
-
-	val = __raw_readl(base + LOCKSTATUS);
-
-	if (val & 1) {
-		val = LOCKCODE;
-		__raw_writel(val, base + LOCKACCESS);
-	}
+	__raw_writel(LOCKCODE, cti->base + LOCKACCESS);
 }
 
 /**
@@ -166,14 +158,6 @@ static inline void cti_unlock(struct cti *cti)
  */
 static inline void cti_lock(struct cti *cti)
 {
-	void __iomem *base = cti->base;
-	unsigned long val;
-
-	val = __raw_readl(base + LOCKSTATUS);
-
-	if (!(val & 1)) {
-		val = ~LOCKCODE;
-		__raw_writel(val, base + LOCKACCESS);
-	}
+	__raw_writel(~LOCKCODE, cti->base + LOCKACCESS);
 }
 #endif
-- 
1.7.4.1
