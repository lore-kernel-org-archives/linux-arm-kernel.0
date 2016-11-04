From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:36 +0100
Subject: [PATCH 2/9] ARM: shmobile: only call rcar_gen2_clocks_init() if
 present
In-Reply-To: <cover.1478251657.git.horms+renesas@verge.net.au>
References: <cover.1478251657.git.horms+renesas@verge.net.au>
Message-ID: <e11fc795215eca872d8d64087568c28ba739f659.1478251657.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms@verge.net.au>

The RZ/G1M (r8a7743) uses the R-Car Gen2 core, but not the R-Car Gen2 clock
driver. This is a harbinger of a transition for R-Car Gen2 SoCs. As the
process to get all the required pieces in place is somewhat complex it
seems useful to try to disentangle dependencies where possible.

The approach here is to temporarily disable calling rcar_gen2_clocks_init()
if no R-Car Gen2 SoC are configured and thus the symbol will not be
present.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index afb9fdcd3d90..154e8051825a 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -15,6 +15,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/clocksource.h>
 #include <linux/device.h>
@@ -130,7 +131,15 @@ void __init rcar_gen2_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-	rcar_gen2_clocks_init(mode);
+	if (IS_ENABLED(CONFIG_ARCH_R8A7790) ||
+	    IS_ENABLED(CONFIG_ARCH_R8A7791) ||
+	    IS_ENABLED(CONFIG_ARCH_R8A7792) ||
+	    IS_ENABLED(CONFIG_ARCH_R8A7793) ||
+	    IS_ENABLED(CONFIG_ARCH_R8A7794))
+		rcar_gen2_clocks_init(mode);
+	else
+		of_clk_init(NULL);
+
 	clocksource_probe();
 }
 
-- 
2.7.0.rc3.207.g0ac5344
