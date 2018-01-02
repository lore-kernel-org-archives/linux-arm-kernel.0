From: j-keerthy@ti.com (Keerthy)
Date: Tue, 2 Jan 2018 15:39:59 +0530
Subject: [PATCH v6 10/10] clocksource: timer-dm: Check prescaler value
In-Reply-To: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1514887799-24605-11-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ladislav Michl <ladis@linux-mips.org>

Invalid prescaler value is silently ignored. Fix that
by returning -EINVAL in such case. As invalid value
disabled use of the prescaler, use -1 explicitely for
that purpose.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index 60db173..01a9cb0 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -672,6 +672,9 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
+	} else {
+		if (prescaler != -1)
+			return -EINVAL;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-- 
1.9.1
