From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 09:20:56 +0000
Subject: [PATCH v6 24/36] mtd: st_spi_fsm: Prepare default sequences for
 read/write/erase
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395307268-12721-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most chips require a predefined set of FSM message sequences for read,
write and erase operations. This patch provides a way to set them up,
which it will do so if a chip specific initialisation routine isn't
been provided.

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index b4d2a18..b4afee0 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -845,6 +845,38 @@ static int stfsm_search_prepare_rw_seq(struct stfsm *fsm,
 	return 0;
 }
 
+/* Prepare a READ/WRITE/ERASE 'default' sequences */
+static int stfsm_prepare_rwe_seqs_default(struct stfsm *fsm)
+{
+	uint32_t flags = fsm->info->flags;
+	int ret;
+
+	/* Configure 'READ' sequence */
+	ret = stfsm_search_prepare_rw_seq(fsm, &stfsm_seq_read,
+					  default_read_configs);
+	if (ret) {
+		dev_err(fsm->dev,
+			"failed to prep READ sequence with flags [0x%08x]\n",
+			flags);
+		return ret;
+	}
+
+	/* Configure 'WRITE' sequence */
+	ret = stfsm_search_prepare_rw_seq(fsm, &stfsm_seq_write,
+					  default_write_configs);
+	if (ret) {
+		dev_err(fsm->dev,
+			"failed to prep WRITE sequence with flags [0x%08x]\n",
+			flags);
+		return ret;
+	}
+
+	/* Configure 'ERASE_SECTOR' sequence */
+	stfsm_prepare_erasesec_seq(fsm, &stfsm_seq_erase_sector);
+
+	return 0;
+}
+
 static int stfsm_n25q_config(struct stfsm *fsm)
 {
 	uint32_t flags = fsm->info->flags;
@@ -1151,6 +1183,10 @@ static int stfsm_probe(struct platform_device *pdev)
 		ret = info->config(fsm);
 		if (ret)
 			return ret;
+	} else {
+		ret = stfsm_prepare_rwe_seqs_default(fsm);
+		if (ret)
+			return ret;
 	}
 
 	fsm->mtd.dev.parent	= &pdev->dev;
-- 
1.8.3.2
