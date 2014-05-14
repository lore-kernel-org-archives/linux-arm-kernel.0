From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:15 +0200
Subject: [PATCH v6 11/12] ARM: shmobile: r7s72100: use workaround for non
 DT-clocks
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400029816-24028-12-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

MTU2 is not yet prepared for DT usage, so use the common workaround via
clkdev for now.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c1053e32..33015e5ed52a 100644
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
1.9.2
