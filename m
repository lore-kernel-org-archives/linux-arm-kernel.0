From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:33 +0200
Subject: [PATCH v4 19/23] ARM: shmobile: r8a7779: Stop passing mode pins state
 to clock driver
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477055857-17936-20-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the R-Car H1 CPG clock driver obtains the state of the mode pins
from the R-Car RST driver, there's no longer a need to pass this state
explicitly. Hence we can just remove the .init_time() callback, the
generic ARM code will take care of calling of_clk_init() and
clocksource_probe().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 0007ff51d180379f..0686112f243525b6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -14,8 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <linux/clk/renesas.h>
-#include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -76,30 +74,6 @@ static void __init r8a7779_init_irq_dt(void)
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
 }
 
-#define MODEMR		0xffcc0020
-
-static u32 __init r8a7779_read_mode_pins(void)
-{
-	static u32 mode;
-	static bool mode_valid;
-
-	if (!mode_valid) {
-		void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
-		BUG_ON(!modemr);
-		mode = ioread32(modemr);
-		iounmap(modemr);
-		mode_valid = true;
-	}
-
-	return mode;
-}
-
-static void __init r8a7779_init_time(void)
-{
-	r8a7779_clocks_init(r8a7779_read_mode_pins());
-	clocksource_probe();
-}
-
 static const char *const r8a7779_compat_dt[] __initconst = {
 	"renesas,r8a7779",
 	NULL,
@@ -109,7 +83,6 @@ static void __init r8a7779_init_time(void)
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
-	.init_time	= r8a7779_init_time,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7779_compat_dt,
-- 
1.9.1
