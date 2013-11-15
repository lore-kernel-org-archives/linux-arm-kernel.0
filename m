From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Nov 2013 15:26:14 -0800
Subject: [PATCH 06/17] ARM: IXP4xx: Switch to sched_clock_register()
In-Reply-To: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1384557985-9414-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 9edaf47..bc9d8ec 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -475,7 +475,7 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static u32 notrace ixp4xx_read_sched_clock(void)
+static u64 notrace ixp4xx_read_sched_clock(void)
 {
 	return *IXP4XX_OSTS;
 }
@@ -493,7 +493,7 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	setup_sched_clock(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
+	sched_clock_register(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
