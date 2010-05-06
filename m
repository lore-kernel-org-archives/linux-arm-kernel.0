From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:00 -0700
Subject: [PATCH 09/34] Davinci: enable timer clock before use
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-10-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

timer_init() programs timer64 hardware.  The module should ideally be brought
out of reset before this happens.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/time.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 9e0b106..b21f763 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -361,13 +361,13 @@ static void __init davinci_timer_init(void)
 		}
 	}
 
-	/* init timer hw */
-	timer_init();
-
 	timer_clk = clk_get(NULL, "timer0");
 	BUG_ON(IS_ERR(timer_clk));
 	clk_enable(timer_clk);
 
+	/* init timer hw */
+	timer_init();
+
 	davinci_clock_tick_rate = clk_get_rate(timer_clk);
 
 	/* setup clocksource */
-- 
1.7.0.2
