From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 16 Nov 2011 12:46:13 +0400
Subject: [PATCH] watchdog: fix initialisation printout in s3c2410_wdt
Message-ID: <1321433173-17757-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like a typo creeped in, and driver prints
s3c2410-wdt s3c2410-wdt: watchdog active, reset abled, irq abled

instead of
s3c2410-wdt s3c2410-wdt: watchdog active, reset enabled, irq enabled

Also it may completely disinform about irq status, as it prints
"irq enabled" when S3C2410_WTCON_INTEN is in fact 0.

Fix it.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---

It seems to be here for a long time, but I don't think it's
important enough for cc-ing stable.

Also I haven't tested it, as I don't have a hardware, but it's
rather trivial (and yes, I checked with datasheet that 1 in
S3C2410_WTCON_*EN bits really means 'enabled')

 drivers/watchdog/s3c2410_wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 5de7e4f..a79e384 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -401,8 +401,8 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 	dev_info(dev, "watchdog %sactive, reset %sabled, irq %sabled\n",
 		 (wtcon & S3C2410_WTCON_ENABLE) ?  "" : "in",
-		 (wtcon & S3C2410_WTCON_RSTEN) ? "" : "dis",
-		 (wtcon & S3C2410_WTCON_INTEN) ? "" : "en");
+		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
+		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
 	return 0;
 
-- 
1.7.5.1.300.gc565c
