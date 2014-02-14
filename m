From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:29:26 +0100
Subject: [PATCH 1/6] ARM: integrator: localize the lm.h header
In-Reply-To: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1392373771-17303-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we move toward multiplatform support for the Integrator family
we need to localize all <mach/*> headers. This moves the lm.h
header down to the machine folder as it is not used outside it
anyway.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c           |  2 +-
 arch/arm/mach-integrator/include/mach/lm.h | 23 -----------------------
 arch/arm/mach-integrator/integrator_ap.c   |  3 +--
 arch/arm/mach-integrator/integrator_cp.c   |  3 ---
 arch/arm/mach-integrator/lm.c              |  2 +-
 arch/arm/mach-integrator/lm.h              | 23 +++++++++++++++++++++++
 6 files changed, 26 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/lm.h
 create mode 100644 arch/arm/mach-integrator/lm.h

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index d9b784824808..a90e83fe8776 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -25,9 +25,9 @@
 #include <linux/slab.h>
 #include <linux/irqchip/arm-vic.h>
 
-#include <mach/lm.h>
 #include <mach/impd1.h>
 #include <asm/sizes.h>
+#include "lm.h"
 
 static int module_id;
 
diff --git a/arch/arm/mach-integrator/include/mach/lm.h b/arch/arm/mach-integrator/include/mach/lm.h
deleted file mode 100644
index 28186b6f2c09..000000000000
--- a/arch/arm/mach-integrator/include/mach/lm.h
+++ /dev/null
@@ -1,23 +0,0 @@
-
-struct lm_device {
-	struct device		dev;
-	struct resource		resource;
-	unsigned int		irq;
-	unsigned int		id;
-};
-
-struct lm_driver {
-	struct device_driver	drv;
-	int			(*probe)(struct lm_device *);
-	void			(*remove)(struct lm_device *);
-	int			(*suspend)(struct lm_device *, pm_message_t);
-	int			(*resume)(struct lm_device *);
-};
-
-int lm_driver_register(struct lm_driver *drv);
-void lm_driver_unregister(struct lm_driver *drv);
-
-int lm_device_register(struct lm_device *dev);
-
-#define lm_get_drvdata(lm)	dev_get_drvdata(&(lm)->dev)
-#define lm_set_drvdata(lm,d)	dev_set_drvdata(&(lm)->dev, d)
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index fedcd2fab094..f4ef41707046 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -51,8 +51,6 @@
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
 
-#include <mach/lm.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
@@ -61,6 +59,7 @@
 #include "cm.h"
 #include "common.h"
 #include "pci_v3.h"
+#include "lm.h"
 
 /* Base address to the AP system controller */
 void __iomem *ap_syscon_base;
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 0ad5f60598c8..9af1ed995faa 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -32,9 +32,6 @@
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-
-#include <mach/lm.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-integrator/lm.c b/arch/arm/mach-integrator/lm.c
index f52c7af31eaa..3f9e9f043168 100644
--- a/arch/arm/mach-integrator/lm.c
+++ b/arch/arm/mach-integrator/lm.c
@@ -12,7 +12,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 
-#include <mach/lm.h>
+#include "lm.h"
 
 #define to_lm_device(d)	container_of(d, struct lm_device, dev)
 #define to_lm_driver(d)	container_of(d, struct lm_driver, drv)
diff --git a/arch/arm/mach-integrator/lm.h b/arch/arm/mach-integrator/lm.h
new file mode 100644
index 000000000000..28186b6f2c09
--- /dev/null
+++ b/arch/arm/mach-integrator/lm.h
@@ -0,0 +1,23 @@
+
+struct lm_device {
+	struct device		dev;
+	struct resource		resource;
+	unsigned int		irq;
+	unsigned int		id;
+};
+
+struct lm_driver {
+	struct device_driver	drv;
+	int			(*probe)(struct lm_device *);
+	void			(*remove)(struct lm_device *);
+	int			(*suspend)(struct lm_device *, pm_message_t);
+	int			(*resume)(struct lm_device *);
+};
+
+int lm_driver_register(struct lm_driver *drv);
+void lm_driver_unregister(struct lm_driver *drv);
+
+int lm_device_register(struct lm_device *dev);
+
+#define lm_get_drvdata(lm)	dev_get_drvdata(&(lm)->dev)
+#define lm_set_drvdata(lm,d)	dev_set_drvdata(&(lm)->dev, d)
-- 
1.8.5.3
