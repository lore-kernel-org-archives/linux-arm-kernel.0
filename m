From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:34:11 +0000
Subject: [PATCH 09/17] ARM: sa11x0: neponset: save and restore MDM_CTL_0
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOtf-0001C6-4N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save and restore the modem output control register across a suspend/
resume, as well as the NCR register.  Place these in a locally
allocated data structure rather than needing a new static variable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   53 ++++++++++++++++++++++++++++++--------
 1 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 1beaa0e..6f0aa91 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -1,12 +1,13 @@
 /*
  * linux/arch/arm/mach-sa1100/neponset.c
- *
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/slab.h>
 
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -20,6 +21,13 @@
 #include <mach/assabet.h>
 #include <mach/neponset.h>
 
+struct neponset_drvdata {
+#ifdef CONFIG_PM_SLEEP
+	u32 ncr0;
+	u32 mdm_ctl_0;
+#endif
+};
+
 void neponset_ncr_frob(unsigned int mask, unsigned int val)
 {
 	unsigned long flags;
@@ -200,6 +208,15 @@ static struct platform_device smc91x_device = {
 
 static int __devinit neponset_probe(struct platform_device *dev)
 {
+	struct neponset_drvdata *d;
+	int ret;
+
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
 	sa1100_register_uart_fns(&neponset_port_fns);
 
 	/*
@@ -234,29 +251,42 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	 */
 	NCR_0 = NCR_GP01_OFF;
 
+	platform_set_drvdata(dev, d);
+
 	return 0;
+
+ err_alloc:
+	return ret;
 }
 
-#ifdef CONFIG_PM
+static int __devexit neponset_remove(struct platform_device *dev)
+{
+	struct neponset_drvdata *d = platform_get_drvdata(dev);
 
-/*
- * LDM power management.
- */
-static unsigned int neponset_saved_state;
+	irq_set_chained_handler(IRQ_GPIO25, NULL);
+
+	kfree(d);
+
+	return 0;
+}
 
+#ifdef CONFIG_PM
 static int neponset_suspend(struct platform_device *dev, pm_message_t state)
 {
-	/*
-	 * Save state.
-	 */
-	neponset_saved_state = NCR_0;
+	struct neponset_drvdata *d = platform_get_drvdata(dev);
+
+	d->ncr0 = NCR_0;
+	d->mdm_ctl_0 = MDM_CTL_0;
 
 	return 0;
 }
 
 static int neponset_resume(struct platform_device *dev)
 {
-	NCR_0 = neponset_saved_state;
+	struct neponset_drvdata *d = platform_get_drvdata(dev);
+
+	NCR_0 = d->ncr0;
+	MDM_CTL_0 = d->mdm_ctl_0;
 
 	return 0;
 }
@@ -268,6 +298,7 @@ static int neponset_resume(struct platform_device *dev)
 
 static struct platform_driver neponset_device_driver = {
 	.probe		= neponset_probe,
+	.remove		= __devexit_p(neponset_remove),
 	.suspend	= neponset_suspend,
 	.resume		= neponset_resume,
 	.driver		= {
-- 
1.7.4.4
