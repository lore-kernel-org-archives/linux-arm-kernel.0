From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:29:27 +0100
Subject: [PATCH 2/6] ARM: integrator: localize the impd1.h header
In-Reply-To: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1392373771-17303-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we move toward multiplatform support for the Integrator family
we need to localize all <mach/*> headers. This moves the impd1.h
header down to the machine folder, copying the the three defines
only used by the clock driver down into the clock driver.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, looking for an ACK on this patch.
---
 arch/arm/mach-integrator/impd1.c              |  2 +-
 arch/arm/mach-integrator/impd1.h              | 14 ++++++++++++++
 arch/arm/mach-integrator/include/mach/impd1.h | 18 ------------------
 drivers/clk/versatile/clk-impd1.c             |  6 ++++--
 4 files changed, 19 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/mach-integrator/impd1.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/impd1.h

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a90e83fe8776..0e870ea818c4 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -25,9 +25,9 @@
 #include <linux/slab.h>
 #include <linux/irqchip/arm-vic.h>
 
-#include <mach/impd1.h>
 #include <asm/sizes.h>
 #include "lm.h"
+#include "impd1.h"
 
 static int module_id;
 
diff --git a/arch/arm/mach-integrator/impd1.h b/arch/arm/mach-integrator/impd1.h
new file mode 100644
index 000000000000..76de4dc9bee4
--- /dev/null
+++ b/arch/arm/mach-integrator/impd1.h
@@ -0,0 +1,14 @@
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
+
+struct device;
+
+void impd1_tweak_control(struct device *dev, u32 mask, u32 val);
diff --git a/arch/arm/mach-integrator/include/mach/impd1.h b/arch/arm/mach-integrator/include/mach/impd1.h
deleted file mode 100644
index d75de4b14237..000000000000
--- a/arch/arm/mach-integrator/include/mach/impd1.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#define IMPD1_OSC1	0x00
-#define IMPD1_OSC2	0x04
-#define IMPD1_LOCK	0x08
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
-
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 6d8b8e1a080a..31b44f025f9e 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -13,10 +13,12 @@
 #include <linux/io.h>
 #include <linux/platform_data/clk-integrator.h>
 
-#include <mach/impd1.h>
-
 #include "clk-icst.h"
 
+#define IMPD1_OSC1	0x00
+#define IMPD1_OSC2	0x04
+#define IMPD1_LOCK	0x08
+
 struct impd1_clk {
 	char *vco1name;
 	struct clk *vco1clk;
-- 
1.8.5.3
