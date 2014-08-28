From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:08 +0100
Subject: [PATCH 02/11] misc: st_core: Protect unsigned value against becoming
 negative
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coverity reported:
  This less-than-zero comparison of an unsigned value is never true.

In answer to that, we only ever decrement if protos_registered is
positive.  We can subsequently remove the paranoid checking during
unregister.

Cc: gregkh at linuxfoundation.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ti-st/st_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 1972d57a..54be83d 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -153,8 +153,9 @@ static void st_reg_complete(struct st_data_s *st_gdata, char err)
 				(st_gdata->list[i]->priv_data, err);
 			pr_info("protocol %d's cb sent %d\n", i, err);
 			if (err) { /* cleanup registered protocol */
-				st_gdata->protos_registered--;
 				st_gdata->is_registered[i] = false;
+				if (st_gdata->protos_registered)
+					st_gdata->protos_registered--;
 			}
 		}
 	}
@@ -639,14 +640,12 @@ long st_unregister(struct st_proto_s *proto)
 		return -EPROTONOSUPPORT;
 	}
 
-	st_gdata->protos_registered--;
+	if (st_gdata->protos_registered)
+		st_gdata->protos_registered--;
+
 	remove_channel_from_table(st_gdata, proto);
 	spin_unlock_irqrestore(&st_gdata->lock, flags);
 
-	/* paranoid check */
-	if (st_gdata->protos_registered < ST_EMPTY)
-		st_gdata->protos_registered = ST_EMPTY;
-
 	if ((st_gdata->protos_registered == ST_EMPTY) &&
 	    (!test_bit(ST_REG_PENDING, &st_gdata->st_state))) {
 		pr_info(" all chnl_ids unregistered ");
-- 
1.9.1
