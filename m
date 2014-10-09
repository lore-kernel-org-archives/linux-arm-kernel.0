From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:23 +0200
Subject: [PATCH 01/12] rtc: omap: fix clock-source configuration
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-2-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure not to reset the clock-source configuration when enabling the
32kHz clock mux.

Until the clock source can be configured through device tree we must not
overwrite settings made by the bootloader (e.g. clock-source selection).

Fixes: cd914bba03d8 ("drivers/rtc/rtc-omap.c: add support for enabling
32khz clock")
Cc: stable <stable@vger.kernel.org>

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 21142e6574a9..f842c216f2dd 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -431,8 +431,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
 
 	/* enable RTC functional clock */
-	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN)
-		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
+	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN) {
+		reg = rtc_read(OMAP_RTC_OSC_REG);
+		rtc_writel(reg | OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
+	}
 
 	/* clear old status */
 	reg = rtc_read(OMAP_RTC_STATUS_REG);
-- 
2.0.4
