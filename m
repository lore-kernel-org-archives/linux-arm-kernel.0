From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  7 Mar 2014 17:00:44 +0100
Subject: [PATCH V3 08/12] ARM: shmobile: r7s72100: genmai: platform scif
 devices only for legacy support
In-Reply-To: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394208048-32495-9-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

We have now DT support for SCIF, so use the platform_device
initialization only for the legacy support.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/mach-shmobile/board-genmai-reference.c |  1 -
 arch/arm/mach-shmobile/board-genmai.c           | 44 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r7s72100.c         | 43 ------------------------
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 91dcdd0e026d..fde558b66d4e 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -33,7 +33,6 @@
  */
 static const struct clk_name clk_names[] = {
 	{ "mtu2", NULL, "sh_mtu2.0" },
-	{ "scif2", NULL, "sh-sci.2" },
 };
 #endif
 
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index 6c328d63b819..c94201ee8596 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/serial_sci.h>
 #include <linux/sh_eth.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
@@ -89,6 +90,40 @@ static const struct spi_board_info spi_info[] __initconst = {
 	},
 };
 
+/* SCIF */
+#define R7S72100_SCIF(index, baseaddr, irq)				\
+static const struct plat_sci_port scif##index##_platform_data = {	\
+	.type		= PORT_SCIF,					\
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
+			  SCSCR_REIE,					\
+};									\
+									\
+static struct resource scif##index##_resources[] = {			\
+	DEFINE_RES_MEM(baseaddr, 0x100),				\
+	DEFINE_RES_IRQ(irq + 1),					\
+	DEFINE_RES_IRQ(irq + 2),					\
+	DEFINE_RES_IRQ(irq + 3),					\
+	DEFINE_RES_IRQ(irq),						\
+}									\
+
+R7S72100_SCIF(0, 0xe8007000, gic_iid(221));
+R7S72100_SCIF(1, 0xe8007800, gic_iid(225));
+R7S72100_SCIF(2, 0xe8008000, gic_iid(229));
+R7S72100_SCIF(3, 0xe8008800, gic_iid(233));
+R7S72100_SCIF(4, 0xe8009000, gic_iid(237));
+R7S72100_SCIF(5, 0xe8009800, gic_iid(241));
+R7S72100_SCIF(6, 0xe800a000, gic_iid(245));
+R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
+
+#define r7s72100_register_scif(index)					       \
+	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+					  scif##index##_resources,	       \
+					  ARRAY_SIZE(scif##index##_resources), \
+					  &scif##index##_platform_data,	       \
+					  sizeof(scif##index##_platform_data))
+
 static void __init genmai_add_standard_devices(void)
 {
 	r7s72100_clock_init();
@@ -102,6 +137,15 @@ static void __init genmai_add_standard_devices(void)
 	r7s72100_register_rspi(3);
 	r7s72100_register_rspi(4);
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
+
+	r7s72100_register_scif(0);
+	r7s72100_register_scif(1);
+	r7s72100_register_scif(2);
+	r7s72100_register_scif(3);
+	r7s72100_register_scif(4);
+	r7s72100_register_scif(5);
+	r7s72100_register_scif(6);
+	r7s72100_register_scif(7);
 }
 
 static const char * const genmai_boards_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 2ed092241a13..7a063b60f7f6 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -21,47 +21,12 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include "common.h"
 #include "irqs.h"
 #include "r7s72100.h"
 #include <asm/mach/arch.h>
 
-#define R7S72100_SCIF(index, baseaddr, irq)				\
-static const struct plat_sci_port scif##index##_platform_data = {	\
-	.type		= PORT_SCIF,					\
-	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
-	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
-			  SCSCR_REIE,					\
-};									\
-									\
-static struct resource scif##index##_resources[] = {			\
-	DEFINE_RES_MEM(baseaddr, 0x100),				\
-	DEFINE_RES_IRQ(irq + 1),					\
-	DEFINE_RES_IRQ(irq + 2),					\
-	DEFINE_RES_IRQ(irq + 3),					\
-	DEFINE_RES_IRQ(irq),						\
-}									\
-
-R7S72100_SCIF(0, 0xe8007000, gic_iid(221));
-R7S72100_SCIF(1, 0xe8007800, gic_iid(225));
-R7S72100_SCIF(2, 0xe8008000, gic_iid(229));
-R7S72100_SCIF(3, 0xe8008800, gic_iid(233));
-R7S72100_SCIF(4, 0xe8009000, gic_iid(237));
-R7S72100_SCIF(5, 0xe8009800, gic_iid(241));
-R7S72100_SCIF(6, 0xe800a000, gic_iid(245));
-R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
-
-#define r7s72100_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
-					  scif##index##_resources,	       \
-					  ARRAY_SIZE(scif##index##_resources), \
-					  &scif##index##_platform_data,	       \
-					  sizeof(scif##index##_platform_data))
-
-
 static struct sh_timer_config mtu2_0_platform_data __initdata = {
 	.name = "MTU2_0",
 	.timer_bit = 0,
@@ -83,14 +48,6 @@ static struct resource mtu2_0_resources[] __initdata = {
 
 void __init r7s72100_add_dt_devices(void)
 {
-	r7s72100_register_scif(0);
-	r7s72100_register_scif(1);
-	r7s72100_register_scif(2);
-	r7s72100_register_scif(3);
-	r7s72100_register_scif(4);
-	r7s72100_register_scif(5);
-	r7s72100_register_scif(6);
-	r7s72100_register_scif(7);
 	r7s72100_register_mtu2(0);
 }
 
-- 
1.9.0
