From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 17:41:15 +0200
Subject: [PATCH v2 01/10] media: v4l2-ctrls: Add missing v4l2 ctrl unlock
In-Reply-To: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180419154124.17512-2-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a missing v4l2_ctrl_unlock call that is required to avoid
deadlocks.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index f67e9f5531fa..ba05a8b9a095 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3614,10 +3614,12 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 			continue;
 
 		v4l2_ctrl_lock(ctrl);
+
 		if (ref->req)
 			ptr_to_ptr(ctrl, ref->req->p_req, ref->p_req);
 		else
 			ptr_to_ptr(ctrl, ctrl->p_cur, ref->p_req);
+
 		v4l2_ctrl_unlock(ctrl);
 	}
 
@@ -3677,8 +3679,11 @@ void v4l2_ctrl_request_setup(struct media_request *req,
 				}
 			}
 		}
-		if (!have_new_data)
+
+		if (!have_new_data) {
+			v4l2_ctrl_unlock(master);
 			continue;
+		}
 
 		for (i = 0; i < master->ncontrols; i++) {
 			if (master->cluster[i]) {
-- 
2.16.3
