From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:54 +0200
Subject: [PATCH 21/26] ARM: socfpga: remove custom .init_time hook
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-22-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dinh Nguyen <dinguyen@altera.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-socfpga/socfpga.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 6df7bb9..dd0d49c 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -14,8 +14,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -91,12 +89,6 @@ static void __init socfpga_init_irq(void)
 	socfpga_sysmgr_init();
 }
 
-static void __init socfpga_init_time(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 temp;
@@ -126,7 +118,6 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
 	.init_irq	= socfpga_init_irq,
-	.init_time	= socfpga_init_time,
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
-- 
1.7.10.4
