From: xhp836@motorola.com (Jocelyn Falempe)
Date: Mon, 11 Oct 2010 13:37:39 +0200
Subject: [PATCH] ARM: vic: fix support for PL192
Message-ID: <AANLkTi=Zs-ByYn9-1EL5=m4Rfva7o2JqwYq8_VwYkxmR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code works with PL192, but it writes to PL190 registers which
are removed on PL192.
---
 arch/arm/common/vic.c               |   46 ++++++++++++++++++++++-------------
 arch/arm/include/asm/hardware/vic.h |    2 +
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index ba65f6e..0c2b335 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -53,6 +53,7 @@ struct vic_device {
 	u32		int_enable;
 	u32		soft_int;
 	u32		protect;
+	u32		id;
 };

 /* we cannot allocate memory when VICs are initially registered */
@@ -73,10 +74,13 @@ static inline struct vic_device *to_vic(struct
sys_device *sys)
  * Common initialisation code for registeration
  * and resume.
 */
-static void vic_init2(void __iomem *base)
+static void vic_init2(void __iomem *base, u32 id)
 {
 	int i;

+	if ((id & 0xFFF) == VIC_PL192_PARTNUMBER)
+		return;
+
 	for (i = 0; i < 16; i++) {
 		void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
 		writel(VIC_VECT_CNTL_ENABLE | i, reg);
@@ -94,7 +98,7 @@ static int vic_class_resume(struct sys_device *dev)
 	printk(KERN_DEBUG "%s: resuming vic@%p\n", __func__, base);

 	/* re-initialise static settings */
-	vic_init2(base);
+	vic_init2(base, vic->id);

 	writel(vic->int_select, base + VIC_INT_SELECT);
 	writel(vic->protect, base + VIC_PROTECT);
@@ -186,7 +190,7 @@ late_initcall(vic_pm_init);
  * of suspend and resume requests and ensure that the correct actions are
  * taken to re-instate the settings on resume.
  */
-static void __init vic_pm_register(void __iomem *base, unsigned int
irq, u32 resume_sources)
+static void __init vic_pm_register(void __iomem *base, unsigned int
irq, u32 resume_sources, u32 id)
 {
 	struct vic_device *v;

@@ -197,11 +201,12 @@ static void __init vic_pm_register(void __iomem
*base, unsigned int irq, u32 res
 		v->base = base;
 		v->resume_sources = resume_sources;
 		v->irq = irq;
+		v->id = id;
 		vic_id++;
 	}
 }
 #else
-static inline void vic_pm_register(void __iomem *base, unsigned int
irq, u32 arg1) { }
+static inline void vic_pm_register(void __iomem *base, unsigned int
irq, u32 arg1, u32 id) { }
 #endif /* CONFIG_PM */

 static void vic_ack_irq(unsigned int irq)
@@ -283,16 +288,23 @@ static void __init vic_disable(void __iomem *base)
 	writel(~0, base + VIC_INT_SOFT_CLEAR);
 }

-static void __init vic_clear_interrupts(void __iomem *base)
+static void __init vic_clear_interrupts(void __iomem *base, u32 id)
 {
 	unsigned int i;

-	writel(0, base + VIC_PL190_VECT_ADDR);
-	for (i = 0; i < 19; i++) {
-		unsigned int value;
-
-		value = readl(base + VIC_PL190_VECT_ADDR);
-		writel(value, base + VIC_PL190_VECT_ADDR);
+	if ((id & 0xFFF) == VIC_PL192_PARTNUMBER) {
+		/* reset priority stack by writing to the VICADDRESS
+		 * register 16 times */
+		for (i = 0; i < 16; i++)
+			writel(0, base + VIC_PL192_VECT_ADDR);
+	} else {
+		writel(0, base + VIC_PL190_VECT_ADDR);
+		for (i = 0; i < 19; i++) {
+			unsigned int value;
+
+			value = readl(base + VIC_PL190_VECT_ADDR);
+			writel(value, base + VIC_PL190_VECT_ADDR);
+		}
 	}
 }

@@ -321,7 +333,7 @@ static void __init vic_set_irq_sources(void __iomem *base,
  *  and 020 within the page. We call this "second block".
  */
 static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
-				u32 vic_sources)
+				u32 vic_sources, u32 id)
 {
 	unsigned int i;
 	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
@@ -336,7 +348,7 @@ static void __init vic_init_st(void __iomem *base,
unsigned int irq_start,
 	 * the second base address, which is 0x20 in the page
 	 */
 	if (vic_2nd_block) {
-		vic_clear_interrupts(base);
+		vic_clear_interrupts(base, id);

 		/* ST has 16 vectors as well, but we don't enable them by now */
 		for (i = 0; i < 16; i++) {
@@ -375,7 +387,7 @@ void __init vic_init(void __iomem *base, unsigned
int irq_start,

 	switch(vendor) {
 	case AMBA_VENDOR_ST:
-		vic_init_st(base, irq_start, vic_sources);
+		vic_init_st(base, irq_start, vic_sources, cellid);
 		return;
 	default:
 		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
@@ -388,11 +400,11 @@ void __init vic_init(void __iomem *base,
unsigned int irq_start,
 	vic_disable(base);

 	/* Make sure we clear all existing interrupts */
-	vic_clear_interrupts(base);
+	vic_clear_interrupts(base, cellid);

-	vic_init2(base);
+	vic_init2(base, cellid);

 	vic_set_irq_sources(base, irq_start, vic_sources);

-	vic_pm_register(base, irq_start, resume_sources);
+	vic_pm_register(base, irq_start, resume_sources, cellid);
 }
diff --git a/arch/arm/include/asm/hardware/vic.h
b/arch/arm/include/asm/hardware/vic.h
index 5d72550..260dc43 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -40,6 +40,8 @@

 #define VIC_PL192_VECT_ADDR		0xF00

+#define VIC_PL192_PARTNUMBER		0x192
+
 #ifndef __ASSEMBLY__
 void vic_init(void __iomem *base, unsigned int irq_start, u32
vic_sources, u32 resume_sources);
 #endif
-- 
1.7.0.4
