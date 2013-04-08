From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Apr 2013 10:23:28 +0900
Subject: [PATCH 01/02] ARM: shmobile: force enable of r8a7790 arch timer
In-Reply-To: <20130408012318.13555.58237.sendpatchset@w520>
References: <20130408012318.13555.58237.sendpatchset@w520>
Message-ID: <20130408012328.13555.44487.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Implement a SoC-specific timer init function for
r8a7790 that makes sure the architected timer
is started regardless of boot loader setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-04-08 10:13:38.000000000 +0900
@@ -4,5 +4,6 @@
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
+void r8a7790_timer_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-04-08 10:13:38.000000000 +0900
@@ -117,6 +117,18 @@ void __init r8a7790_add_standard_devices
 	r8a7790_register_irqc(0);
 }
 
+void __init r8a7790_timer_init(void)
+{
+	void __iomem *cntcr;
+
+	/* make sure arch timer is started by setting bit 0 of CNTCT */
+	cntcr = ioremap(0xe6080000, PAGE_SIZE);
+	iowrite32(1, cntcr);
+	iounmap(cntcr);
+
+	shmobile_timer_init();
+}
+
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
@@ -131,7 +143,7 @@ static const char *r8a7790_boards_compat
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
-	.init_time	= shmobile_timer_init,
+	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
