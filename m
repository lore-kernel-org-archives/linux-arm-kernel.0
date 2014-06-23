From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:50 +0900
Subject: [PATCH 3/9] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
Message-ID: <af164ca33dcb3c1e6a2e723f24542d1278a8bef8.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the EMEV2 specific SoC callbacks to get rid
of the calls to of_clk_init() and of_platform_populate().
Those calls are by default executed by the functions in
the shared ARM code in case the SoC specific mach
callbacks are NULL.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index e10d34e..b06a9e8 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -16,10 +16,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
+#include <linux/mm.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -42,12 +41,6 @@ static void __init emev2_map_io(void)
 	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }
 
-static void __init emev2_add_standard_devices_dt(void)
-{
-	of_clk_init(NULL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char *emev2_boards_compat_dt[] __initconst = {
 	"renesas,emev2",
 	NULL,
@@ -59,7 +52,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= shmobile_init_delay,
-	.init_machine	= emev2_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
-- 
2.0.0.rc2
