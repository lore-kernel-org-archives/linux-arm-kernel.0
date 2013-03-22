From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 22 Mar 2013 00:14:59 -0700 (PDT)
Subject: [RFC][PATCH 2/3] ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
In-Reply-To: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87wqszewi8.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds r8a7778_init_irq_extpin() for IRQ0 - IRQ3.
But this patch doesn't enable DT settings on r8a7778.dts,
because R8A7778 chip external IRQ depends on
IRQ0 - IRQ3 pin encoding which came from platform board
implementation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   44 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index a755dca..e0c6205 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -24,5 +24,6 @@ extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
+extern void r8a7778_init_irq_extpin(int irlm);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 45a1a53..7d8bcaf 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -23,6 +23,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip.h>
 #include <linux/serial_sci.h>
@@ -112,6 +113,49 @@ void __init r8a7778_add_standard_devices(void)
 		platform_device_register_full(&platform_devinfo[i]);
 }
 
+static struct renesas_intc_irqpin_config irqpin_platform_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
+	.sense_bitfield_width = 2,
+};
+
+static struct resource irqpin_resources[] = {
+	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
+	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
+	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
+	DEFINE_RES_MEM(0xfe780044, 4), /* INTMSK0 */
+	DEFINE_RES_MEM(0xfe780064, 4), /* INTMSKCLR0 */
+	DEFINE_RES_IRQ(gic_iid(0x3b)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_iid(0x3c)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_iid(0x3d)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_iid(0x3e)), /* IRQ3 */
+};
+
+static struct platform_device_info intc_devinfo =
+	PLATFORM_FULL_INFO("renesas_intc_irqpin", -1, irqpin);
+
+void __init r8a7778_init_irq_extpin(int irlm)
+{
+	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
+	unsigned long tmp;
+
+	if (!icr0) {
+		pr_warn("r8a7778: unable to setup external irq pin mode\n");
+		return;
+	}
+
+	tmp = ioread32(icr0);
+	if (irlm)
+		tmp |= 1 << 23; /* IRQ0 -> IRQ3 as individual pins */
+	else
+		tmp &= ~(1 << 23); /* IRL mode - not supported */
+	tmp |= (1 << 21); /* LVLMODE = 1 */
+	iowrite32(tmp, icr0);
+	iounmap(icr0);
+
+	if (irlm)
+		platform_device_register_full(&intc_devinfo);
+}
+
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
 
-- 
1.7.9.5
