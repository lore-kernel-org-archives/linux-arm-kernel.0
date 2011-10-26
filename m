From: pdeschrijver@nvidia.com (pdeschrijver at nvidia.com)
Date: Wed, 26 Oct 2011 11:41:41 +0300
Subject: [PATCHv2] arm/tegra: clk_get should not be fatal
Message-ID: <1319618501-15020-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

The timer and rtc-timer clocks aren't gated by default, so there is no reason
to crash the system if the dummy enable call failed.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/timer.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index e2272d2..2f1df47 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -186,16 +186,20 @@ static void __init tegra_init_timer(void)
 	int ret;
 
 	clk = clk_get_sys("timer", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_enable(clk);
+	if (IS_ERR(clk))
+		pr_warn("Unable to get timer clock\n");
+	else
+		clk_enable(clk);
 
 	/*
 	 * rtc registers are used by read_persistent_clock, keep the rtc clock
 	 * enabled
 	 */
 	clk = clk_get_sys("rtc-tegra", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_enable(clk);
+	if (IS_ERR(clk))
+		pr_warn("Unable to get rtc-tegra clock\n");
+	else
+		clk_enable(clk);
 
 #ifdef CONFIG_HAVE_ARM_TWD
 	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
-- 
1.7.7.rc0.72.g4b5ea.dirty
