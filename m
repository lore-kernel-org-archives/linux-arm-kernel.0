From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Mar 2017 11:52:41 +0200
Subject: [PATCH] mmc: host: s3cmci: fix broken conditional expression
Message-ID: <20170329095250.2937200-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT support introduced a typo that gcc detects when -Wempty-body
is enabled:

drivers/mmc/host/s3cmci.c: In function 's3cmci_probe_pdata':
drivers/mmc/host/s3cmci.c:1543:29: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  if (pdata->wprotect_invert);

Clearly the ';' was not intended here, so remove it.

Fixes: 4b13f3b290d1 ("mmc: host: s3cmci: allow probing from device tree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 09eab2120bbd..bbf1fbbc8e2a 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1540,7 +1540,7 @@ static int s3cmci_probe_pdata(struct s3cmci_host *host)
 	if (pdata->no_detect)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	if (pdata->wprotect_invert);
+	if (pdata->wprotect_invert)
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
 	if (pdata->detect_invert)
-- 
2.9.0
