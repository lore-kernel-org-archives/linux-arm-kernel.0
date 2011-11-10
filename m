From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:14 +0800
Subject: [PATCH 9/9] ARM: mxs: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-9-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-mxs/system.c |    4 +++-
 arch/arm/mach-mxs/timer.c  |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
index 20ec3bd..57ce7f7 100644
--- a/arch/arm/mach-mxs/system.c
+++ b/arch/arm/mach-mxs/system.c
@@ -65,8 +65,10 @@ static int __init mxs_arch_reset_init(void)
 						 MX28_CLKCTRL_RESET_OFFSET);
 
 	clk = clk_get_sys("rtc", NULL);
-	if (!IS_ERR(clk))
+	if (!IS_ERR(clk)) {
+		clk_prepare(clk);
 		clk_enable(clk);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index cace0d2..ba87b30 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -245,6 +245,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 
 void __init mxs_timer_init(struct clk *timer_clk, int irq)
 {
+	clk_prepare(timer_clk);
 	clk_enable(timer_clk);
 
 	/*
-- 
1.7.5.4
