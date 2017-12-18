From: ladis@linux-mips.org (Ladislav Michl)
Date: Mon, 18 Dec 2017 12:31:53 +0100
Subject: [PATCH 2/2] clocksource: timer-dm: Check prescaler value
In-Reply-To: <20171218111610.GA16906@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch>
Message-ID: <20171218113153.GB18637@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Invalid prescaler value is silently ignored. Fix that
by returning -EINVAL in such case. As invalid value
disabled use of the prescaler, use -1 explicitely for
that purpose.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index ec3a28c90c70..95cd98be8541 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -609,6 +609,9 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
+	} else {
+		if (prescaler != -1)
+			return -EINVAL;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-- 
2.15.1
