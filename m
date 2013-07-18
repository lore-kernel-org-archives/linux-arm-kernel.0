From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 18 Jul 2013 09:48:40 +0200
Subject: [PATCH v4 5/5] ASoC: atmel-ssc: remove clk_disable_unprepare call
 from critical section
In-Reply-To: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare/unprepare (and indirectly clk_prepare_enable/disable_unprepare)
may sleep and thus cannot be called in critical section.

This patch fix a bug introduced by commit
6f0d94790efe9f4481bbd7c174ef0e9b5e5db7c4 where clk_disable_unprepare was
called with user_lock hold.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/misc/atmel-ssc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index f7b90661..e068a76 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -66,14 +66,19 @@ EXPORT_SYMBOL(ssc_request);
 
 void ssc_free(struct ssc_device *ssc)
 {
+	bool disable_clk = true;
+
 	spin_lock(&user_lock);
-	if (ssc->user) {
+	if (ssc->user)
 		ssc->user--;
-		clk_disable_unprepare(ssc->clk);
-	} else {
+	else {
+		disable_clk = false;
 		dev_dbg(&ssc->pdev->dev, "device already free\n");
 	}
 	spin_unlock(&user_lock);
+
+	if (disable_clk)
+		clk_disable_unprepare(ssc->clk);
 }
 EXPORT_SYMBOL(ssc_free);
 
-- 
1.7.9.5
