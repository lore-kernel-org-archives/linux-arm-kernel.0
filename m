From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:00 +0100
Subject: [PATCH 03/19] rtc: opal: enable support for the stardard
 "wakeup-source" property
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the opal rtc driver should and will continue to support the legacy
"has-tpo" property to enable RTC as the wakeup source, we need to add
support for the new standard property "wakeup-source"

This patch adds support for "wakeup-source" property in addition to the
existing "has-tpo" property.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux at googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-opal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 6fbf9e617151..4087d53ecd73 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -199,8 +199,9 @@ static int opal_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
-	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
-						 NULL)) {
+	if (pdev->dev.of_node &&
+	    (of_property_read_bool(pdev->dev.of_node, "wakeup-source") ||
+	     of_property_read_bool(pdev->dev.of_node, "has-tpo")/* legacy */)) {
 		device_set_wakeup_capable(&pdev->dev, true);
 		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
 		opal_rtc_ops.set_alarm = opal_set_tpo_time;
-- 
1.9.1
