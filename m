From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  2 Feb 2016 14:13:58 -0700
Subject: [PATCH 4/7] coresight: release reference taken by 'bus_find_device()'
In-Reply-To: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454447641-29153-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference count taken by function bus_find_device() needs
to be released if a child device is found, something this patch
is adding.

Reported-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 8872db4410eb..a35ca54a76c9 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -570,6 +570,8 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 
 		if (dev) {
 			conn->child_dev = to_coresight_device(dev);
+			/* and put reference from 'bus_find_device()' */
+			put_device(dev);
 		} else {
 			csdev->orphan = true;
 			conn->child_dev = NULL;
-- 
2.1.4
