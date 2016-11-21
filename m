From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 15:57:23 +0800
Subject: [PATCH V9 6/6] stm: Mark the functions of writing STM with notrace
In-Reply-To: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
References: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1479715043-6534-7-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be
writen to sink via STM, all functions that related to writing data
packets to STM should be marked 'notrace' to avoid being traced by
Ftrace, otherwise the program would stall into an endless loop.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c | 7 ++++---
 include/linux/stm.h          | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 51f81d6..37d3bcb 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -425,7 +425,7 @@ static int stm_file_assign(struct stm_file *stmf, char *id, unsigned int width)
 	return ret;
 }
 
-static ssize_t stm_write(struct stm_data *data, unsigned int master,
+static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
 			  unsigned int channel, const char *buf, size_t count)
 {
 	unsigned int flags = STP_PACKET_TIMESTAMPED;
@@ -1121,8 +1121,9 @@ void stm_source_unregister_device(struct stm_source_data *data)
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
2.7.4
