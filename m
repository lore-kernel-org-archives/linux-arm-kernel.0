From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed,  9 Jul 2014 15:12:44 +0200
Subject: [PATCH v5 8/8] ARM: shmobile: genmai-reference: Enable MTU2 in device
 tree
In-Reply-To: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more device needs to be added from platform code when booting the
reference platform, move MTU2 registration from setup-r7s72100.c to
board-genmai.c and remove the now empty r7s72100_add_dt_devices()
function.

As the genmai_add_standard_devices() function is now identical to the
default init_machine implementation, remove it as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r7s72100-genmai.dts           |  4 ++++
 arch/arm/mach-shmobile/board-genmai-reference.c | 20 --------------------
 arch/arm/mach-shmobile/board-genmai.c           | 14 +++++++++++++-
 arch/arm/mach-shmobile/r7s72100.h               |  1 -
 arch/arm/mach-shmobile/setup-r7s72100.c         | 21 ---------------------
 5 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 56849b5..a352734 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -43,6 +43,10 @@
 	clock-frequency = <48000000>;
 };
 
+&mtu2 {
+	status = "ok";
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index e5448f7..bc52677 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -19,29 +19,10 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/of_platform.h>
 
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include "clock.h"
 #include "common.h"
-#include "r7s72100.h"
-
-/*
- * This is a really crude hack to provide clkdev support to platform
- * devices until they get moved to DT.
- */
-static const struct clk_name clk_names[] = {
-	{ "mtu2", "fck", "sh-mtu2" },
-};
-
-static void __init genmai_add_standard_devices(void)
-{
-	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), true);
-	r7s72100_add_dt_devices();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static const char * const genmai_boards_compat_dt[] __initconst = {
 	"renesas,genmai",
@@ -50,6 +31,5 @@ static const char * const genmai_boards_compat_dt[] __initconst = {
 
 DT_MACHINE_START(GENMAI_DT, "genmai")
 	.init_early	= shmobile_init_delay,
-	.init_machine	= genmai_add_standard_devices,
 	.dt_compat	= genmai_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index e2a3ba4..b5dee53 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_eth.h>
+#include <linux/sh_timer.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 
@@ -126,10 +127,21 @@ R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
 					  &scif##index##_platform_data,	       \
 					  sizeof(scif##index##_platform_data))
 
+static struct resource mtu2_resources[] __initdata = {
+	DEFINE_RES_MEM(0xfcff0000, 0x400),
+	DEFINE_RES_IRQ_NAMED(gic_iid(139), "tgi0a"),
+};
+
+#define r7s72100_register_mtu2()					\
+	platform_device_register_resndata(&platform_bus, "sh-mtu2",	\
+					  -1, mtu2_resources,		\
+					  ARRAY_SIZE(mtu2_resources),	\
+					  NULL, 0)
+
 static void __init genmai_add_standard_devices(void)
 {
 	r7s72100_clock_init();
-	r7s72100_add_dt_devices();
+	r7s72100_register_mtu2();
 
 	platform_device_register_full(&ether_info);
 
diff --git a/arch/arm/mach-shmobile/r7s72100.h b/arch/arm/mach-shmobile/r7s72100.h
index efb723c..321ae4e 100644
--- a/arch/arm/mach-shmobile/r7s72100.h
+++ b/arch/arm/mach-shmobile/r7s72100.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_R7S72100_H__
 #define __ASM_R7S72100_H__
 
-void r7s72100_add_dt_devices(void);
 void r7s72100_clock_init(void);
 
 #endif /* __ASM_R7S72100_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 4a98b23..d898cef 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -18,32 +18,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/of_platform.h>
-#include <linux/sh_timer.h>
 
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "irqs.h"
-#include "r7s72100.h"
-
-static struct resource mtu2_resources[] __initdata = {
-	DEFINE_RES_MEM(0xfcff0000, 0x400),
-	DEFINE_RES_IRQ_NAMED(gic_iid(139), "tgi0a"),
-};
-
-#define r7s72100_register_mtu2()					\
-	platform_device_register_resndata(&platform_bus, "sh-mtu2",	\
-					  -1, mtu2_resources,		\
-					  ARRAY_SIZE(mtu2_resources),	\
-					  NULL, 0)
-
-void __init r7s72100_add_dt_devices(void)
-{
-	r7s72100_register_mtu2();
-}
 
 #ifdef CONFIG_USE_OF
 static const char *r7s72100_boards_compat_dt[] __initdata = {
-- 
1.8.5.5
