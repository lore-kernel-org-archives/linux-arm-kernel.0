From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Thu,  5 May 2011 14:51:12 +0300
Subject: [PATCH 12/22] mmc: omap_hsmmc: introduce start_clock and re-use
	stop_clock
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Message-ID: <1304596282-4095-13-git-send-email-adrian.hunter@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There is similar piece of code in two functions which enables clock. Split this
code to omap_hsmmc_start_clock(). Re-use omap_hsmmc_stop_clock() in
omap_hsmmc_context_restore() as well.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 045c581..ae6d204 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -560,6 +560,15 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 }
 
 /*
+ * Start clock to the card
+ */
+static void omap_hsmmc_start_clock(struct omap_hsmmc_host *host)
+{
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+}
+
+/*
  * Stop clock to the card
  */
 static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
@@ -700,8 +709,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		break;
 	}
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
+	omap_hsmmc_stop_clock(host);
+
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		(calc_divisor(ios) << 6) | (DTO << 16));
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
@@ -712,8 +721,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		;
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+	omap_hsmmc_start_clock(host);
 
 	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
@@ -1692,8 +1700,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		&& time_before(jiffies, timeout))
 		msleep(1);
 
-	OMAP_HSMMC_WRITE(host->base, SYSCTL,
-		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+	omap_hsmmc_start_clock(host);
 
 	if (do_send_init_stream)
 		send_init_stream(host);
-- 
1.7.0.4
