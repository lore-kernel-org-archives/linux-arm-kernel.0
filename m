From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 26 Jul 2013 10:18:01 -0300
Subject: [PATCH v9 24/30] ARM: kirkwood: Split DT and legacy MBus
 initialization
In-Reply-To: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374844687-19981-25-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit replaces the legacy MBus initialization with the new
DT-based in Kirkwood. For boards that are not yet converted to DT,
we keep the legacy initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-kirkwood/board-dt.c | 1 +
 arch/arm/mach-kirkwood/common.c   | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 6e122ed..682b7ac 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -87,6 +87,7 @@ static void __init kirkwood_dt_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
+	BUG_ON(mvebu_mbus_dt_init());
 	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 165e751..15b7e72 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -534,10 +534,6 @@ void __init kirkwood_cpuidle_init(void)
 void __init kirkwood_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
-
-	mvebu_mbus_init("marvell,kirkwood-mbus",
-			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
-			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ);
 }
 
 int kirkwood_tclk;
@@ -713,6 +709,10 @@ void __init kirkwood_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
+	BUG_ON(mvebu_mbus_init("marvell,kirkwood-mbus",
+			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
+			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ));
+
 	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
-- 
1.8.1.5
