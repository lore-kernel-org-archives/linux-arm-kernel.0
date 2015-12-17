From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 17 Dec 2015 08:47:02 -0700
Subject: [PATCH 1/2] coresight: checking for NULL string in
 coresight_name_match()
In-Reply-To: <1450367223-21068-1-git-send-email-mathieu.poirier@linaro.org>
References: <1450367223-21068-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1450367223-21068-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Connection child names associated to ports can sometimes be NULL,
which is the case when booting a system on QEMU or when the Coresight
power domain isn't switched on.

This patch is adding a check to make sure a NULL string isn't fed
to strcmp(), something that avoid crashing the system.

Cc: <stable@vger.kernel.org> # v3.18+
Reported-by: Tyler Baker <tyler.baker@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e25492137d8b..93738dfbf631 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -548,7 +548,7 @@ static int coresight_name_match(struct device *dev, void *data)
 	to_match = data;
 	i_csdev = to_coresight_device(dev);
 
-	if (!strcmp(to_match, dev_name(&i_csdev->dev)))
+	if (to_match && !strcmp(to_match, dev_name(&i_csdev->dev)))
 		return 1;
 
 	return 0;
-- 
2.1.4
