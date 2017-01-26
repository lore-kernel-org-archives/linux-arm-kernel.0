From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 00:37:23 +0100
Subject: [PATCH 10/13] mmc: bcm2835: work queue is dead code now, zap
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Message-ID: <1485473846-24537-11-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 5c588d9..6a1fef3 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -148,7 +148,6 @@ struct bcm2835_host {
 	int			clock;		/* Current clock speed */
 	unsigned int		max_clk;	/* Max possible freq */
 	struct tasklet_struct	finish_tasklet;	/* Tasklet structures */
-	struct work_struct	cmd_wait_wq;	/* Workqueue function */
 	struct timer_list	timer;		/* Timer for timeouts */
 	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
 	unsigned int		blocks;		/* remaining PIO blocks */
@@ -1301,27 +1300,6 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	.hw_reset = bcm2835_reset,
 };
 
-static void bcm2835_cmd_wait_work(struct work_struct *work)
-{
-	struct bcm2835_host *host;
-
-	host = container_of(work, struct bcm2835_host, cmd_wait_wq);
-
-	mutex_lock(&host->mutex);
-
-	/* If this tasklet gets rescheduled while running, it will
-	 * be run again afterwards but without any active request.
-	 */
-	if (!host->mrq) {
-		mutex_unlock(&host->mutex);
-		return;
-	}
-
-	bcm2835_finish_command(host);
-
-	mutex_unlock(&host->mutex);
-}
-
 static void bcm2835_tasklet_finish(unsigned long param)
 {
 	struct bcm2835_host *host = (struct bcm2835_host *)param;
@@ -1427,8 +1405,6 @@ int bcm2835_add_host(struct bcm2835_host *host)
 	tasklet_init(&host->finish_tasklet,
 		     bcm2835_tasklet_finish, (unsigned long)host);
 
-	INIT_WORK(&host->cmd_wait_wq, bcm2835_cmd_wait_work);
-
 	setup_timer(&host->timer, bcm2835_timeout,
 		    (unsigned long)host);
 
-- 
1.8.3.1
