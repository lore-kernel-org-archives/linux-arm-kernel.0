From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 22 Dec 2012 20:41:08 +0100
Subject: [PATCH 1/2] cpts: fix build error by removing useless code.
In-Reply-To: <cover.1356204860.git.richardcochran@gmail.com>
References: <cover.1356204860.git.richardcochran@gmail.com>
Message-ID: <2cc4445dc92ddadb69b3e2feb9d8de38727ea0d4.1356204860.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpts driver tries to obtain the input clock frequency by calling the
clock's internal 'recalc' method. Since <plat/clock.h> has been removed,
this code can no longer compile.

However, the driver never makes use of the frequency value, so this patch
fixes the issue by removing the offending code altogether.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/cpts.c |    1 -
 drivers/net/ethernet/ti/cpts.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 5e62c1a..5ab8fb4 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -248,7 +248,6 @@ static void cpts_clk_init(struct cpts *cpts)
 		return;
 	}
 	clk_enable(cpts->refclk);
-	cpts->freq = cpts->refclk->recalc(cpts->refclk);
 }
 
 static void cpts_clk_release(struct cpts *cpts)
diff --git a/drivers/net/ethernet/ti/cpts.h b/drivers/net/ethernet/ti/cpts.h
index e1bba3a..fe993cd 100644
--- a/drivers/net/ethernet/ti/cpts.h
+++ b/drivers/net/ethernet/ti/cpts.h
@@ -120,7 +120,6 @@ struct cpts {
 	struct delayed_work overflow_work;
 	int phc_index;
 	struct clk *refclk;
-	unsigned long freq;
 	struct list_head events;
 	struct list_head pool;
 	struct cpts_event pool_data[CPTS_MAX_EVENTS];
-- 
1.7.2.5
