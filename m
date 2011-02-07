From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Feb 2011 16:35:22 +0100
Subject: [PATCH 4/4] ARM: mxc91231: use .init_early to initialize cpu type
In-Reply-To: <20110126103107.GA4232@n2100.arm.linux.org.uk>
References: <20110126103107.GA4232@n2100.arm.linux.org.uk>
Message-ID: <1297092922-12741-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This used to be done in .map_io which is supposed to only setup the memory
mapping.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxc91231/magx-zn5.c       |   11 ++++++-----
 arch/arm/mach-mxc91231/mm.c             |    7 +++++--
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mxc91231/magx-zn5.c b/arch/arm/mach-mxc91231/magx-zn5.c
index 395d83b..f31a45e 100644
--- a/arch/arm/mach-mxc91231/magx-zn5.c
+++ b/arch/arm/mach-mxc91231/magx-zn5.c
@@ -53,9 +53,10 @@ struct sys_timer zn5_timer = {
 };
 
 MACHINE_START(MAGX_ZN5, "Motorola Zn5")
-	.boot_params	= MXC91231_PHYS_OFFSET + 0x100,
-	.map_io		= mxc91231_map_io,
-	.init_irq	= mxc91231_init_irq,
-	.timer		= &zn5_timer,
-	.init_machine	= zn5_init,
+	.boot_params = MXC91231_PHYS_OFFSET + 0x100,
+	.map_io = mxc91231_map_io,
+	.init_early = mxc91231_init_early,
+	.init_irq = mxc91231_init_irq,
+	.timer = &zn5_timer,
+	.init_machine = zn5_init,
 MACHINE_END
diff --git a/arch/arm/mach-mxc91231/mm.c b/arch/arm/mach-mxc91231/mm.c
index 7652c30..a77f6da 100644
--- a/arch/arm/mach-mxc91231/mm.c
+++ b/arch/arm/mach-mxc91231/mm.c
@@ -45,11 +45,14 @@ static struct map_desc mxc91231_io_desc[] __initdata = {
  */
 void __init mxc91231_map_io(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MXC91231);
-
 	iotable_init(mxc91231_io_desc, ARRAY_SIZE(mxc91231_io_desc));
 }
 
+void __init mxc91231_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MXC91231);
+}
+
 int mxc91231_register_gpios(void);
 
 void __init mxc91231_init_irq(void)
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4746b9a..a22ebe1 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -33,6 +33,7 @@ extern void imx35_init_early(void);
 extern void imx50_init_early(void);
 extern void imx51_init_early(void);
 extern void imx53_init_early(void);
+extern void mxc91231_init_early(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
-- 
1.7.2.3
