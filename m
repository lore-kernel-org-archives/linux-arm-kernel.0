From: ladis@linux-mips.org (Ladislav Michl)
Date: Fri, 23 Feb 2018 11:15:01 +0100
Subject: [PATCH 3/6] clocksource: timer-ti-dm: Check prescaler value
In-Reply-To: <20180223101254.GA5746@lenoch>
References: <20180223101254.GA5746@lenoch>
Message-ID: <20180223101501.GD5746@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Invalid value silently disables use of the prescaler.
Use -1 explicitely for that purpose and error out on
invalid value.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-ti-dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4d645d6c6c31..b57e875b74ca 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -657,13 +657,13 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 {
 	u32 l;
 
-	if (unlikely(!timer))
+	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
-	if (prescaler >= 0x00 && prescaler <= 0x07) {
+	if (prescaler >= 0) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
 	}
-- 
2.16.1
