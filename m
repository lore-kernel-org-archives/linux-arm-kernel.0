From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Oct 2015 09:29:57 +0300
Subject: [PATCH] rtc: ds1307: Fix alarm programming for mcp794xx
Message-ID: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mcp794xx alarm registers must be written in BCD format. However, the
alarm programming logic neglected this by adding one to the value
after bin2bcd conversion has been already done, writing bad values
to month register in case the alarm being set is in October. In this
case, the alarm month value becomes 0x0a instead of the expected 0x10.

Fix by moving the +1 addition within the bin2bcd call also.

Fixes: 1d1945d261a2 ("drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips")

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/rtc/rtc-ds1307.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a705e64..188006c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -718,9 +718,9 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	regs[3] = bin2bcd(t->time.tm_sec);
 	regs[4] = bin2bcd(t->time.tm_min);
 	regs[5] = bin2bcd(t->time.tm_hour);
-	regs[6] = bin2bcd(t->time.tm_wday) + 1;
+	regs[6] = bin2bcd(t->time.tm_wday + 1);
 	regs[7] = bin2bcd(t->time.tm_mday);
-	regs[8] = bin2bcd(t->time.tm_mon) + 1;
+	regs[8] = bin2bcd(t->time.tm_mon + 1);
 
 	/* Clear the alarm 0 interrupt flag. */
 	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
-- 
1.7.9.5
