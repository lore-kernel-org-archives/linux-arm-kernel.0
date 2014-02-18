From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Feb 2014 14:55:56 +0000
Subject: [PATCH 29/35] mtd: st_spi_fsm: Add the ability to read the FSM's
 status
In-Reply-To: <1392735362-1245-1-git-send-email-lee.jones@linaro.org>
References: <1392735362-1245-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1392735362-1245-30-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index a5e2c5a..5b2993d 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -793,6 +793,30 @@ static uint8_t stfsm_wait_busy(struct stfsm *fsm)
 	return FLASH_STATUS_TIMEOUT;
 }
 
+static int stfsm_read_status(struct stfsm *fsm, uint8_t cmd,
+			   uint8_t *status)
+{
+	struct stfsm_seq *seq = &stfsm_seq_read_status_fifo;
+	uint32_t tmp;
+
+	dev_dbg(fsm->dev, "reading STA[%s]\n",
+		(cmd == FLASH_CMD_RDSR) ? "1" : "2");
+
+	seq->seq_opc[0] = (SEQ_OPC_PADS_1 |
+			   SEQ_OPC_CYCLES(8) |
+			   SEQ_OPC_OPCODE(cmd)),
+
+	stfsm_load_seq(fsm, seq);
+
+	stfsm_read_fifo(fsm, &tmp, 4);
+
+	*status = (uint8_t)(tmp >> 24);
+
+	stfsm_wait_seq(fsm);
+
+	return 0;
+}
+
 static int stfsm_wrvcr(struct stfsm *fsm, uint8_t data)
 {
 	struct stfsm_seq *seq = &stfsm_seq_wrvcr;
-- 
1.8.3.2
