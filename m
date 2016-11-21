From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 15:57:21 +0800
Subject: [PATCH V9 4/6] intel_th: Mark sth_stm_packet() with notrace
In-Reply-To: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
References: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1479715043-6534-5-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be
writen to sink via STM, all functions that related to writing data
packets to STM should be marked 'notrace' to avoid being traced by
Ftrace, otherwise the program would stall into an endless loop.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/sth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

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
-- 
2.7.4
