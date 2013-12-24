From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:07:04 +0900
Subject: [PATCH 11/13] ARM: shmobile: rcar-gen2: Initialize CCF before clock
 sources
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <4b5c211f9f93c3919f23c88d808a4eda104ec8b2.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

When CONFIG_COMMON_CLOCK is enabled, call rcar_gen2_clocks_init() in the
timer init function to initialize the common clock framework before
initializing the clock sources. This will take care of clock
initialization when the r8a779[01] boards will be switched to
multiplatform kernels.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index b6275ab..69ccc6c 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk/shmobile.h>
 #include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -44,8 +45,10 @@ u32 __init rcar_gen2_read_mode_pins(void)
 
 void __init rcar_gen2_timer_init(void)
 {
-#ifdef CONFIG_ARM_ARCH_TIMER
+#if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
 	u32 mode = rcar_gen2_read_mode_pins();
+#endif
+#ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
 	u32 freq;
@@ -98,5 +101,8 @@ void __init rcar_gen2_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
+#ifdef CONFIG_COMMON_CLK
+	rcar_gen2_clocks_init(mode);
+#endif
 	clocksource_of_init();
 }
-- 
1.8.4
