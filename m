From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 21:15:57 +0100
Subject: [PATCH v2 3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
In-Reply-To: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388175362-17132-4-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
v2:
  - Correct platform device names ("rspi%u.0" -> "rspi.%u")
  - Add missing platform data
  - Correct summary (resources -> platform devices)

 arch/arm/mach-shmobile/setup-r7s72100.c |   34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 9c0b3a9d5f7a..c353549cad03 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <linux/spi/rspi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r7s72100.h>
@@ -81,6 +82,34 @@ static struct resource mtu2_0_resources[] __initdata = {
 					  &mtu2_##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
+/* RSPI */
+#define RSPI_RESOURCE(idx, baseaddr, irq)				\
+static const struct resource rspi##idx##_resources[] __initconst = {	\
+	DEFINE_RES_MEM(baseaddr, 0x24),					\
+	DEFINE_RES_IRQ(irq),		/* SPEI */			\
+	DEFINE_RES_IRQ(irq + 1),	/* SPRI */			\
+	DEFINE_RES_IRQ(irq + 2),	/* SPTI */			\
+}
+
+RSPI_RESOURCE(0, 0xe800c800, gic_iid(270));
+RSPI_RESOURCE(1, 0xe800d000, gic_iid(273));
+RSPI_RESOURCE(2, 0xe800d800, gic_iid(276));
+RSPI_RESOURCE(3, 0xe800e000, gic_iid(279));
+RSPI_RESOURCE(4, 0xe800e800, gic_iid(282));
+
+static const struct rspi_plat_data rspi_pdata __initconst = {
+	.data_width	= 8,
+	.txmode		= false,
+	.spcr2		= false,
+	.num_chipselect	= 1,
+};
+
+#define r7s72100_register_rspi(idx)					\
+	platform_device_register_resndata(&platform_bus, "rspi", idx,	\
+					rspi##idx##_resources,		\
+					ARRAY_SIZE(rspi##idx##_resources), \
+					&rspi_pdata, sizeof(rspi_pdata))
+
 void __init r7s72100_add_dt_devices(void)
 {
 	r7s72100_register_scif(0);
@@ -92,6 +121,11 @@ void __init r7s72100_add_dt_devices(void)
 	r7s72100_register_scif(6);
 	r7s72100_register_scif(7);
 	r7s72100_register_mtu2(0);
+	r7s72100_register_rspi(0);
+	r7s72100_register_rspi(1);
+	r7s72100_register_rspi(2);
+	r7s72100_register_rspi(3);
+	r7s72100_register_rspi(4);
 }
 
 void __init r7s72100_init_early(void)
-- 
1.7.9.5
