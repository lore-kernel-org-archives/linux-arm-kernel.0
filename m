From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 Nov 2013 15:22:34 +0100
Subject: [PATCH 3/3] mmc: mvsdio: silence card detect notice
In-Reply-To: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1384525354-901-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvsdio reports method of card detection with dev_notice, while for
removable cards it may be sane, for non-removable cards it is not.
Also, as the user cannot do anything about it, silence the message
by reducing it from dev_notice to dev_dbg.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/mmc/host/mvsdio.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 25f51be..d17b399 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -816,10 +816,9 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		goto out;
 
 	if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
-		dev_notice(&pdev->dev, "using GPIO for card detection\n");
+		dev_dbg(&pdev->dev, "using GPIO for card detection\n");
 	else
-		dev_notice(&pdev->dev,
-			   "lacking card detect (fall back to polling)\n");
+		dev_dbg(&pdev->dev, "lacking card detect, fall back to polling\n");
 	return 0;
 
 out:
-- 
1.7.2.5
