From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:47:59 +0900
Subject: [PATCH 01/14] ARM: shmobile: r8a7779: Remove ->init_machine() special
 case
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094759.6530.27408.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

No need to special case r8a7779 ->init_machine(),
so get rid of undesired clock setup from the
generic long term r8a7779 DT support code.

Rework the code to let r8a7779_add_dt_devices()
act like other SoCs and make the board DT
reference code setup clocks for us.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen-reference.c |    7 ++++++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |   18 ++++++------------
 3 files changed, 13 insertions(+), 14 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2013-08-08 15:02:44.000000000 +0900
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/of_platform.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -27,7 +28,11 @@
 
 static void __init marzen_init(void)
 {
-	r8a7779_add_standard_devices_dt();
+	/* clocks are setup late during boot in the case of DT */
+	r8a7779_clock_init();
+
+	r8a7779_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2013-08-08 14:59:50.000000000 +0900
@@ -30,7 +30,7 @@ extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
-extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_add_dt_devices(void);
 extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-08-08 15:03:05.000000000 +0900
@@ -24,7 +24,6 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <linux/of_platform.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
@@ -624,6 +623,12 @@ static struct platform_device *r8a7779_s
 	&sata_device,
 };
 
+void __init r8a7779_add_dt_devices(void)
+{
+	platform_add_devices(r8a7779_devices_dt,
+			     ARRAY_SIZE(r8a7779_devices_dt));
+}
+
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -726,16 +731,6 @@ void __init r8a7779_init_delay(void)
 	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
 }
 
-void __init r8a7779_add_standard_devices_dt(void)
-{
-	/* clocks are setup late during boot in the case of DT */
-	r8a7779_clock_init();
-
-	platform_add_devices(r8a7779_devices_dt,
-			     ARRAY_SIZE(r8a7779_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char *r8a7779_compat_dt[] __initdata = {
 	"renesas,r8a7779",
 	NULL,
@@ -746,7 +741,6 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8
 	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
-	.init_machine	= r8a7779_add_standard_devices_dt,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
