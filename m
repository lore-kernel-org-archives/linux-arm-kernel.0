From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu,  6 Mar 2014 12:32:25 +0100
Subject: [PATCH V2 05/12] ARM: shmobile: r7s72100: use workaround for non
 DT-clocks
In-Reply-To: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394105552-9744-6-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

SCIF2 and MTU2 are not yet prepared for DT usage, so use the common
workaround via clkdev for now.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

No changes since V1.

 arch/arm/mach-shmobile/board-genmai-reference.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c1053e32..91dcdd0e026d 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -18,18 +18,29 @@
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
+	{ "mtu2", NULL, "sh_mtu2.0" },
+	{ "scif2", NULL, "sh-sci.2" },
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
1.9.0
