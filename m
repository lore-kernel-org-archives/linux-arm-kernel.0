From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 09:20:47 +0000
Subject: [PATCH v6 15/36] mtd: st_spi_fsm: Provide the erase one sector
 sequence
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395307268-12721-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSM Serial Flash Controller is driven by issuing a standard set of
register writes we call a message sequence. This patch supplies a method
to prepare the message sequence responsible for erasing a single sector.

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 6be2672..06e6a52 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -389,6 +389,28 @@ static struct stfsm_seq stfsm_seq_read_jedec = {
 		    SEQ_CFG_STARTSEQ),
 };
 
+static struct stfsm_seq stfsm_seq_erase_sector = {
+	/* 'addr_cfg' configured during initialisation */
+	.seq_opc = {
+		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
+		 SEQ_OPC_OPCODE(FLASH_CMD_WREN) | SEQ_OPC_CSDEASSERT),
+
+		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
+		 SEQ_OPC_OPCODE(FLASH_CMD_SE)),
+	},
+	.seq = {
+		STFSM_INST_CMD1,
+		STFSM_INST_CMD2,
+		STFSM_INST_ADD1,
+		STFSM_INST_ADD2,
+		STFSM_INST_STOP,
+	},
+	.seq_cfg = (SEQ_CFG_PADS_1 |
+		    SEQ_CFG_READNOTWRITE |
+		    SEQ_CFG_CSDEASSERT |
+		    SEQ_CFG_STARTSEQ),
+};
+
 static inline int stfsm_is_idle(struct stfsm *fsm)
 {
 	return readl(fsm->base + SPI_FAST_SEQ_STA) & 0x10;
@@ -477,6 +499,19 @@ static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf,
 	}
 }
 
+/* Configure 'addr_cfg' according to addressing mode */
+static void stfsm_prepare_erasesec_seq(struct stfsm *fsm,
+				       struct stfsm_seq *seq)
+{
+	int addr1_cycles = fsm->info->flags & FLASH_FLAG_32BIT_ADDR ? 16 : 8;
+
+	seq->addr_cfg = (ADR_CFG_CYCLES_ADD1(addr1_cycles) |
+			 ADR_CFG_PADS_1_ADD1 |
+			 ADR_CFG_CYCLES_ADD2(16) |
+			 ADR_CFG_PADS_1_ADD2 |
+			 ADR_CFG_CSDEASSERT_ADD2);
+}
+
 /* Search for preferred configuration based on available flags */
 static struct seq_rw_config *
 stfsm_search_seq_rw_configs(struct stfsm *fsm,
-- 
1.8.3.2
