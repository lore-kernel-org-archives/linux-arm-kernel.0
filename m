From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 19 May 2016 16:47:42 +0800
Subject: [PATCH 3/3] mmc: mmc: fix switch timeout issue caused by jiffies
 precision
In-Reply-To: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1463647662-27426-4-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

with CONFIG_HZ=100, the precision of jiffies is 10ms, and the
generic_cmd6_time of some card is also 10ms. then, may be current
time is only 5ms, but already timed out caused by jiffies precision.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 32de144..ad6e979 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -534,7 +534,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		timeout_ms = MMC_OPS_TIMEOUT_MS;
 
 	/* Must check status to be sure of no errors. */
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		/*
 		 * Due to the possibility of being preempted after
-- 
1.8.1.1.dirty
