From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  3 Aug 2011 17:34:39 +0800
Subject: [PATCH 07/17] mach-integrator: introduce cm_read function helper to
	read CM_CTRL register
In-Reply-To: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1312364089-32380-8-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-integrator/core.c            |   17 +++++++++++++++++
 arch/arm/mach-integrator/include/mach/cm.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 77315b9..0ee6af6 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -225,6 +225,23 @@ void cm_control(u32 mask, u32 set)
 
 EXPORT_SYMBOL(cm_control);
 
+/**
+ * cm_read - read the CM_CTRL register.
+ */
+u32 cm_read(void)
+{
+	unsigned long flags;
+	u32 val = 0;
+
+	spin_lock_irqsave(&cm_lock, flags);
+	val = readl(CM_CTRL);
+	spin_unlock_irqrestore(&cm_lock, flags);
+
+	return val;
+}
+
+EXPORT_SYMBOL(cm_read);
+
 /*
  * We need to stop things allocating the low memory; ideally we need a
  * better implementation of GFP_DMA which does not assume that DMA-able
diff --git a/arch/arm/mach-integrator/include/mach/cm.h b/arch/arm/mach-integrator/include/mach/cm.h
index 445d57a..3731508 100644
--- a/arch/arm/mach-integrator/include/mach/cm.h
+++ b/arch/arm/mach-integrator/include/mach/cm.h
@@ -2,6 +2,7 @@
  * update the core module control register.
  */
 void cm_control(u32, u32);
+u32 cm_read(void);
 
 #define CM_CTRL_LED			(1 << 0)
 #define CM_CTRL_nMBDET			(1 << 1)
-- 
1.7.5
