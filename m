From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:25 -0600
Subject: [RFC PATCH 11/20] coresight: making coresight_build_paths() public
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way a path can be built outside of the core framework,
something useful when a PMU is initialised from the perf sub
system.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 3 +++
 drivers/hwtracing/coresight/coresight.c      | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 62fcd98cc7cf..8a52fdcb4bd6 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -52,6 +52,9 @@ static inline void CS_UNLOCK(void __iomem *addr)
 	} while (0);
 }
 
+int coresight_build_paths(struct coresight_device *csdev,
+			  struct list_head *path, bool enable);
+
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index a3dcafb81700..7a54d8069670 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -301,9 +301,8 @@ static int coresight_disable_path(struct list_head *path)
 	return 0;
 }
 
-static int coresight_build_paths(struct coresight_device *csdev,
-				 struct list_head *path,
-				 bool enable)
+int coresight_build_paths(struct coresight_device *csdev,
+			  struct list_head *path, bool enable)
 {
 	int i, ret = -EINVAL;
 	struct coresight_connection *conn;
-- 
1.9.1
