From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Mon, 25 Oct 2010 19:51:46 -0500
Subject: [PATCH 8/8] staging: tidspbridge - make sync_wait_on_event
	interruptible
In-Reply-To: <1288054306-4361-8-git-send-email-x0095840@ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
	<1288054306-4361-8-git-send-email-x0095840@ti.com>
Message-ID: <1288054306-4361-9-git-send-email-x0095840@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that avoid non-killable process.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 .../staging/tidspbridge/include/dspbridge/sync.h   |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/sync.h b/drivers/staging/tidspbridge/include/dspbridge/sync.h
index e2651e7..df05b8f 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/sync.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/sync.h
@@ -80,13 +80,22 @@ void sync_set_event(struct sync_object *event);
  * This functios will wait until @event is set or until timeout. In case of
  * success the function will return 0 and
  * in case of timeout the function will return -ETIME
+ * in case of signal the function will return -ERESTARTSYS
  */
 
 static inline int sync_wait_on_event(struct sync_object *event,
 							unsigned timeout)
 {
-	return wait_for_completion_timeout(&event->comp,
-		msecs_to_jiffies(timeout)) ? 0 : -ETIME;
+	int res;
+
+	res = wait_for_completion_interruptible_timeout(&event->comp,
+						msecs_to_jiffies(timeout));
+	if (!res)
+		res = -ETIME;
+	else if (res > 0)
+		res = 0;
+
+	return res;
 }
 
 /**
-- 
1.6.3.3
