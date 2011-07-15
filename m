From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri, 15 Jul 2011 11:04:02 -0400
Subject: [PATCH 3/3] watchdog: sp805: Flush posted writes in enable/disable.
In-Reply-To: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
References: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <1310742242-14647-4-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no reads in these functions, so if MMIO writes are posted,
the writes in enable/disable may not have completed by the time these
functions return.  If the functions run from different CPUs, it's
in theory possible for the writes to be interleaved, which would be
disastrous for this driver.

At the very least, we need an mmiowb() before releasing the lock, but
since it seems desirable for the watchdog timer to be actually stopped
or reset when these functions return, read the lock register to force
the writes out.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
 drivers/watchdog/sp805_wdt.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c1e099a..cc2cfbe 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -134,6 +134,8 @@ static void wdt_enable(void)
 	writel(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
 	writel(LOCK, wdt->base + WDTLOCK);
 
+	/* Flush posted writes. */
+	readl(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 }
 
@@ -146,6 +148,8 @@ static void wdt_disable(void)
 	writel(0, wdt->base + WDTCONTROL);
 	writel(LOCK, wdt->base + WDTLOCK);
 
+	/* Flush posted writes. */
+	readl(wdt->base + WDTLOCK);
 	spin_unlock(&wdt->lock);
 }
 
-- 
1.7.3.4
