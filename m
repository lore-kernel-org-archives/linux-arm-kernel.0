From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed,  1 Jun 2016 19:18:59 +0800
Subject: [RFC PATCH 4/4] stm: Mark the functions of writing buffer with notrace
In-Reply-To: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1464779939-24986-5-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STM_FTRACE is selected, Function trace data would be
writen to STM buffer, all  functions that related to writing data
packets to STM buffer should be marked 'notrace' to avoid being
traced by Ftrace, otherwise the program would stall into an endless loop.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c |  2 +-
 drivers/hwtracing/intel_th/sth.c            | 11 +++++++----
 drivers/hwtracing/stm/core.c                |  7 ++++---
 drivers/hwtracing/stm/dummy_stm.c           |  2 +-
 include/linux/stm.h                         |  4 ++--
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 73be58a..345c81e 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -386,7 +386,7 @@ static long stm_generic_set_options(struct stm_data *stm_data,
 	return 0;
 }
 
-static ssize_t stm_generic_packet(struct stm_data *stm_data,
+static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 				  unsigned int master,
 				  unsigned int channel,
 				  unsigned int packet,
diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index e1aee61..b034446 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -67,10 +67,13 @@ static void sth_iowrite(void __iomem *dest, const unsigned char *payload,
 	}
 }
 
-static ssize_t sth_stm_packet(struct stm_data *stm_data, unsigned int master,
-			      unsigned int channel, unsigned int packet,
-			      unsigned int flags, unsigned int size,
-			      const unsigned char *payload)
+static ssize_t notrace sth_stm_packet(struct stm_data *stm_data,
+				      unsigned int master,
+				      unsigned int channel,
+				      unsigned int packet,
+				      unsigned int flags,
+				      unsigned int size,
+				      const unsigned char *payload)
 {
 	struct sth_device *sth = container_of(stm_data, struct sth_device, stm);
 	struct intel_th_channel __iomem *out =
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index ff31108..3139b01 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -424,7 +424,7 @@ static int stm_file_assign(struct stm_file *stmf, char *id, unsigned int width)
 	return ret;
 }
 
-static ssize_t stm_write(struct stm_data *data, unsigned int master,
+static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
 			  unsigned int channel, const char *buf, size_t count)
 {
 	unsigned int flags = STP_PACKET_TIMESTAMPED;
@@ -1069,8 +1069,9 @@ void stm_source_unregister_device(struct stm_source_data *data)
 }
 EXPORT_SYMBOL_GPL(stm_source_unregister_device);
 
-int stm_source_write(struct stm_source_data *data, unsigned int chan,
-		     const char *buf, size_t count)
+int notrace stm_source_write(struct stm_source_data *data,
+			     unsigned int chan,
+			     const char *buf, size_t count)
 {
 	struct stm_source_device *src = data->src;
 	struct stm_device *stm;
diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index a86612d..c5f94ca 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/stm.h>
 
-static ssize_t
+static ssize_t notrace
 dummy_stm_packet(struct stm_data *stm_data, unsigned int master,
 		 unsigned int channel, unsigned int packet, unsigned int flags,
 		 unsigned int size, const unsigned char *payload)
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 8369d8a..210ff22 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -133,7 +133,7 @@ int stm_source_register_device(struct device *parent,
 			       struct stm_source_data *data);
 void stm_source_unregister_device(struct stm_source_data *data);
 
-int stm_source_write(struct stm_source_data *data, unsigned int chan,
-		     const char *buf, size_t count);
+int notrace stm_source_write(struct stm_source_data *data, unsigned int chan,
+			     const char *buf, size_t count);
 
 #endif /* _STM_H_ */
-- 
1.9.1
