From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:55 +0100
Subject: [PATCH 09/63] dmaengine: ste_dma40: Rectify incorrect configuration
 validation checking
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we compare an event's group (dev_type / 16) with STEDMA40_DEV_DST_MEMORY
(-1), the only way we'd obtain a positive result is if we passed -16 as a
device type, which is unfeasible. Instead, it would be much more sane to
compare STEDMA40_DEV_DST_MEMORY against the raw dev_type in order to expect
the expected result.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 3b83dee..c79853f 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1771,19 +1771,19 @@ static int d40_validate_conf(struct d40_chan *d40c,
 	}
 
 	if (conf->dir == STEDMA40_MEM_TO_PERIPH &&
-	    dst_event_group == STEDMA40_DEV_DST_MEMORY) {
+	    conf->dst_dev_type == STEDMA40_DEV_DST_MEMORY) {
 		chan_err(d40c, "Invalid dst\n");
 		res = -EINVAL;
 	}
 
 	if (conf->dir == STEDMA40_PERIPH_TO_MEM &&
-	    src_event_group == STEDMA40_DEV_SRC_MEMORY) {
+	    conf->src_dev_type == STEDMA40_DEV_SRC_MEMORY) {
 		chan_err(d40c, "Invalid src\n");
 		res = -EINVAL;
 	}
 
-	if (src_event_group == STEDMA40_DEV_SRC_MEMORY &&
-	    dst_event_group == STEDMA40_DEV_DST_MEMORY && is_log) {
+	if (conf->src_dev_type == STEDMA40_DEV_SRC_MEMORY &&
+	    conf->dst_dev_type == STEDMA40_DEV_DST_MEMORY && is_log) {
 		chan_err(d40c, "No event line\n");
 		res = -EINVAL;
 	}
-- 
1.7.10.4
