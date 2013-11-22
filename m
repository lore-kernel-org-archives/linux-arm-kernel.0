From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Nov 2013 16:22:55 +0000
Subject: [PATCH 18/23] mtd: st_spi_fsm: Prepare read/write sequences according
 to configuration
In-Reply-To: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1385137380-28968-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firstly we search for our preference read/write configuration based on a
given chip's capabilities. Then we actually set up the message sequence
accordingly.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index a56fb98..85abf9a 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -225,6 +225,23 @@ static void stfsm_prepare_rw_seq(struct stfsm *fsm,
 	seq->seq[i++] = STFSM_INST_STOP;
 }
 
+static int stfsm_search_prepare_rw_seq(struct stfsm *fsm,
+				       struct stfsm_seq *seq,
+				       struct seq_rw_config *cfgs)
+{
+	struct seq_rw_config *config;
+
+	config = stfsm_search_seq_rw_configs(fsm, cfgs);
+	if (!config) {
+		dev_err(fsm->dev, "failed to find suitable config\n");
+		return -EINVAL;
+	}
+
+	stfsm_prepare_rw_seq(fsm, seq, config);
+
+	return 0;
+}
+
 static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf,
 			    const uint32_t size)
 {
-- 
1.8.1.2
