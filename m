From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:37 +0900
Subject: [PATCH 12/12] ARM: shmobile: r7s72100: use workaround for non
 DT-clocks
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <9fbb1ae01b878e2cce9626fa6fdc9e5dcefeb6b5.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

MTU2 is not yet prepared for DT usage, so use the common workaround via
clkdev for now.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c10..33015e5 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -18,18 +18,28 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#ifdef CONFIG_COMMON_CLK
+/*
+ * This is a really crude hack to provide clkdev support to platform
+ * devices until they get moved to DT.
+ */
+static const struct clk_name clk_names[] = {
+	{ "mtu2", "fck", "sh-mtu2" },
+};
+#endif
+
 static void __init genmai_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), true);
 #else
 	r7s72100_clock_init();
 #endif
-- 
1.8.5.2
