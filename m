From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:21:11 +0900
Subject: [PATCH 01/04] ARM: shmobile: Add shared EMEV2 code for
 ->init_machine()
In-Reply-To: <20131106232102.8081.20523.sendpatchset@w520>
References: <20131106232102.8081.20523.sendpatchset@w520>
Message-ID: <20131106232111.8081.53457.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a SoC specific function that initializes
clocks and starts DT probing in case of EMEV2.

This EMEV2 SoC support code may be built for
either legacy SHMOBILE or SMOBILE_MULTI.

The change allows us to support existing board
specific KZM9D DTB with these SoC specific
DT_MACHINE_START() callbacks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-11-05 15:21:42.000000000 +0900
@@ -16,6 +16,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -197,6 +198,16 @@ void __init emev2_init_delay(void)
 
 #ifdef CONFIG_USE_OF
 
+static void __init emev2_add_standard_devices_dt(void)
+{
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#else
+	emev2_clock_init();
+#endif
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *emev2_boards_compat_dt[] __initdata = {
 	"renesas,emev2",
 	NULL,
@@ -206,6 +217,7 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
+	.init_machine	= emev2_add_standard_devices_dt,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
