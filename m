From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jul 2015 14:27:49 +0200
Subject: [PATCH 2/2] ARM: integrator: unexport IM-PD1 external interface
Message-ID: <1438172869-11518-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this IM/PD1 driver fully self-contained. No external driver
uses this symbol so unexport it, move all definitons into the
driver and remove the header file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c | 14 +++++++++++---
 arch/arm/mach-integrator/impd1.h | 14 --------------
 2 files changed, 11 insertions(+), 17 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/impd1.h

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index f164643b7c59..a03e9a1a32f4 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -31,7 +31,17 @@
 
 #include <asm/sizes.h>
 #include "lm.h"
-#include "impd1.h"
+
+#define IMPD1_LEDS	0x0c
+#define IMPD1_INT	0x10
+#define IMPD1_SW	0x14
+#define IMPD1_CTRL	0x18
+
+#define IMPD1_CTRL_DISP_LCD	(0 << 0)
+#define IMPD1_CTRL_DISP_VGA	(1 << 0)
+#define IMPD1_CTRL_DISP_LCD1	(2 << 0)
+#define IMPD1_CTRL_DISP_ENABLE	(1 << 2)
+#define IMPD1_CTRL_DISP_MASK	(7 << 0)
 
 static int module_id;
 
@@ -53,8 +63,6 @@ void impd1_tweak_control(struct device *dev, u32 mask, u32 val)
 	writel(cur | val, impd1->base + IMPD1_CTRL);
 }
 
-EXPORT_SYMBOL(impd1_tweak_control);
-
 /*
  * MMC support
  */
diff --git a/arch/arm/mach-integrator/impd1.h b/arch/arm/mach-integrator/impd1.h
deleted file mode 100644
index 76de4dc9bee4..000000000000
--- a/arch/arm/mach-integrator/impd1.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#define IMPD1_LEDS	0x0c
-#define IMPD1_INT	0x10
-#define IMPD1_SW	0x14
-#define IMPD1_CTRL	0x18
-
-#define IMPD1_CTRL_DISP_LCD	(0 << 0)
-#define IMPD1_CTRL_DISP_VGA	(1 << 0)
-#define IMPD1_CTRL_DISP_LCD1	(2 << 0)
-#define IMPD1_CTRL_DISP_ENABLE	(1 << 2)
-#define IMPD1_CTRL_DISP_MASK	(7 << 0)
-
-struct device;
-
-void impd1_tweak_control(struct device *dev, u32 mask, u32 val);
-- 
2.4.3
