From: s-anna@ti.com (Suman Anna)
Date: Tue, 11 Sep 2018 12:46:43 -0500
Subject: [PATCH] samples/rpmsg: Introduce a module parameter for message count
Message-ID: <20180911174643.26199-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current rpmsg_client_sample uses a fixed number of messages to
be sent to each instance. This is currently set at 100. Introduce
an optional module parameter 'count' so that the number of messages
to be exchanged can be made flexible.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index f161dfd3e70a..9b6b27ea504f 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -22,7 +22,9 @@
 #include <linux/rpmsg.h>
 
 #define MSG		"hello world!"
-#define MSG_LIMIT	100
+
+static int count = 100;
+module_param(count, int, 0644);
 
 struct instance_data {
 	int rx_count;
@@ -41,7 +43,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 		       data, len,  true);
 
 	/* samples should not live forever */
-	if (idata->rx_count >= MSG_LIMIT) {
+	if (idata->rx_count >= count) {
 		dev_info(&rpdev->dev, "goodbye!\n");
 		return 0;
 	}
-- 
2.18.0
