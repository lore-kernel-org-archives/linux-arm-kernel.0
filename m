From: nm@ti.com (Nishanth Menon)
Date: Tue, 19 Apr 2016 11:23:54 -0500
Subject: [PATCH] rtc: ds1307: Use irq when available for wakeup-source device
Message-ID: <1461083034-9227-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 8bc2a40730ec ("rtc: ds1307: add support for the
DT property 'wakeup-source'") we lost the ability for rtc irq
functionality for devices that are actually hooked on a real IRQ
line and have capability to wakeup as well. This is not an expected
behavior. So, instead of just not requesting IRQ, skip the IRQ
requirement only if interrupts are not defined for the device.

Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Michael Lange <linuxstuff@milaw.biz>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee5bae1..74cd5cd544ee 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1531,7 +1531,7 @@ read_rtc:
 		return PTR_ERR(ds1307->rtc);
 	}
 
-	if (ds1307_can_wakeup_device) {
+	if (ds1307_can_wakeup_device && ds1307->client->irq <= 0) {
 		/* Disable request for an IRQ */
 		want_irq = false;
 		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
-- 
2.8.0
