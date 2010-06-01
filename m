From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  1 Jun 2010 11:36:53 +0100
Subject: [PATCH] ARM: VIC: Allocate VIC PM device from slab
In-Reply-To: <1275388613-2496-1-git-send-email-ben-linux@fluff.org>
References: <1275388613-2496-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275388613-2496-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original assertion about the inability to allocate the VIC device is
wrong, and that we have the ability to allocate memory when registering
the VIC (tested on s3c6400_defconfig with SMDK6410).

Change to allocating the device at init time, putting it on a list
instead of having a static array of vics.

Note, since this is just for the PM, it does not affect the exisiting
VIC operations.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/common/vic.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index ba65f6e..b1f1a9e 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -21,6 +21,7 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/sysdev.h>
 #include <linux/device.h>
@@ -44,6 +45,7 @@
  */
 struct vic_device {
 	struct sys_device sysdev;
+	struct list_head list;
 
 	void __iomem	*base;
 	int		irq;
@@ -55,10 +57,7 @@ struct vic_device {
 	u32		protect;
 };
 
-/* we cannot allocate memory when VICs are initially registered */
-static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
-
-static int vic_id;
+static LIST_HEAD(vic_list);
 
 static inline struct vic_device *to_vic(struct sys_device *sys)
 {
@@ -147,11 +146,11 @@ struct sysdev_class vic_class = {
 */
 static int __init vic_pm_init(void)
 {
-	struct vic_device *dev = vic_devices;
+	struct vic_device *dev;
 	int err;
-	int id;
+	int id = 0;
 
-	if (vic_id == 0)
+	if (list_empty(&vic_list))
 		return 0;
 
 	err = sysdev_class_register(&vic_class);
@@ -160,8 +159,8 @@ static int __init vic_pm_init(void)
 		return err;
 	}
 
-	for (id = 0; id < vic_id; id++, dev++) {
-		dev->sysdev.id = id;
+	list_for_each_entry(dev, &vic_list, list) {
+		dev->sysdev.id = id++;
 		dev->sysdev.cls = &vic_class;
 
 		err = sysdev_register(&dev->sysdev);
@@ -190,15 +189,14 @@ static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 res
 {
 	struct vic_device *v;
 
-	if (vic_id >= ARRAY_SIZE(vic_devices))
-		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
-	else {
-		v = &vic_devices[vic_id];
+	v = kzalloc(sizeof(struct vic_device), GFP_KERNEL);
+	if (v) {
+		list_add_tail(&v->list, &vic_list);
 		v->base = base;
-		v->resume_sources = resume_sources;
 		v->irq = irq;
-		vic_id++;
-	}
+		v->resume_sources = resume_sources;
+	} else
+		printk(KERN_ERR "%s: cannot add vic at %p\n", __func__, base);
 }
 #else
 static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
@@ -230,11 +228,10 @@ static void vic_unmask_irq(unsigned int irq)
 #if defined(CONFIG_PM)
 static struct vic_device *vic_from_irq(unsigned int irq)
 {
-        struct vic_device *v = vic_devices;
 	unsigned int base_irq = irq & ~31;
-	int id;
+	struct vic_device *v;
 
-	for (id = 0; id < vic_id; id++, v++) {
+	list_for_each_entry(v, &vic_list, list) {
 		if (v->irq == base_irq)
 			return v;
 	}
-- 
1.6.3.3
