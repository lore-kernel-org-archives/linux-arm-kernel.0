From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:17 +0100
Subject: [PATCH 20/41] ARM: ux500: Don't attempt to enable the Nomadik System
 Timer twice
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-21-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with DT enabled we already call clocksource_of_init(),
which in turn calls the OF version of nmdk_timer_init().

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index b6bd0ef..05a4ff7 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -97,8 +97,8 @@ dt_fail:
 	 * sched_clock with higher rating then MTU since is always-on.
 	 *
 	 */
-
-	nmdk_timer_init(mtu_timer_base, IRQ_MTU0);
+	if (!of_have_populated_dt())
+		nmdk_timer_init(mtu_timer_base, IRQ_MTU0);
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
 	ux500_twd_init();
 }
-- 
1.8.1.2
