From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:51 +0100
Subject: [PATCH 15/20] ARM: hardware: fix endian-ness in <hardware/coresight.h>
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-16-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <hardware/coresight.h> needs to take into account the endian-ness
of the processor when reading and writing data, so change to using
the readl/writel relaxed variants from the raw ones.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/hardware/coresight.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
index 0cf7a6b..ad774f3 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -24,8 +24,8 @@
 #define TRACER_TIMEOUT 10000
 
 #define etm_writel(t, v, x) \
-	(__raw_writel((v), (t)->etm_regs + (x)))
-#define etm_readl(t, x) (__raw_readl((t)->etm_regs + (x)))
+	(writel_relaxed((v), (t)->etm_regs + (x)))
+#define etm_readl(t, x) (readl_relaxed((t)->etm_regs + (x)))
 
 /* CoreSight Management Registers */
 #define CSMR_LOCKACCESS 0xfb0
@@ -142,8 +142,8 @@
 #define ETBFF_TRIGFL		BIT(10)
 
 #define etb_writel(t, v, x) \
-	(__raw_writel((v), (t)->etb_regs + (x)))
-#define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
+	(writel_relaxed((v), (t)->etb_regs + (x)))
+#define etb_readl(t, x) (readl_relaxed((t)->etb_regs + (x)))
 
 #define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
 #define etm_unlock(t) \
-- 
1.7.10.4
