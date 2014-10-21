From: johan@kernel.org (Johan Hovold)
Date: Tue, 21 Oct 2014 19:37:49 +0200
Subject: [PATCH v2 03/20] rtc: omap: fix interrupt disable at probe
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Message-ID: <1413913086-12730-4-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use writel instead of writeb when disabling interrupts at probe as
ALARM2 is not cleared otherwise on some IP-block revisions (e.g.
AM3352).

Note that the driver currently never enables the ALARM2 interrupt.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 828cb9983cc2..813d475fe7c6 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -427,10 +427,12 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, rtc);
 
-	/* clear pending irqs, and set 1/second periodic,
-	 * which we'll use instead of update irqs
+	/*
+	 * disable interrupts
+	 *
+	 * NOTE: ALARM2 is not cleared on AM3352 if rtc_write (writeb) is used
 	 */
-	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+	rtc_writel(0, OMAP_RTC_INTERRUPTS_REG);
 
 	/* enable RTC functional clock */
 	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN) {
-- 
2.0.4
