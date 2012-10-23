From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:51 +0800
Subject: [PATCH 02/10] ARM: imx: allow timer counter to roll over
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer is configured in free-run mode.  The counter should be
allowed to roll over to 0 when reaching 0xffffffff.  Let's do that
by always returning 0 in set_next_event.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index f017302..858098c 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -139,8 +139,7 @@ static int mx1_2_set_next_event(unsigned long evt,
 
 	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
-				-ETIME : 0;
+	return 0;
 }
 
 static int v2_set_next_event(unsigned long evt,
@@ -152,8 +151,7 @@ static int v2_set_next_event(unsigned long evt,
 
 	__raw_writel(tcmp, timer_base + V2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
-				-ETIME : 0;
+	return 0;
 }
 
 #ifdef DEBUG
-- 
1.7.9.5
