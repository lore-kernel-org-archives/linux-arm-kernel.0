From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 10:57:29 +0900
Subject: [PATCH v5 15/20] ARM: shmobile: marzen-reference: Work around core
 clock issues
In-Reply-To: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
References: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1397613454-7522-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms@verge.net.au>

Due to issues with runtime PM clock management, clocks not explicitly
managed by their drivers may not be enabled at all, or be inadvertently
disabled by the clk_disable_unused() late initcall.

Until this is fixed, add a temporary workaround, calling
shmobile_clk_workaround() with enable == true.

For now this enables the clocks for: sdhi0, and thermal.
More clocks can be added if needed.

Based on work by Geert Uytterhoeven for the Koelsch board.

Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v5
* First post
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 5823c83..1fb5768 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -55,10 +55,19 @@ static const struct clk_name clk_names[] __initconst = {
 };
 #endif
 
+/*
+ * This is a really crude hack to work around core platform clock issues
+ */
+static const struct clk_name clk_enables[] __initconst = {
+	{ "sdhi0", NULL, "ffe4c000.sd" },
+	{ "thermal", NULL, "ffc48000.thermal" },
+};
+
 static void __init marzen_init(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 #else
 	r8a7779_clock_init();
 #endif
-- 
1.8.5.2
