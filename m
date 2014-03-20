From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 09:20:42 +0000
Subject: [PATCH v6 10/36] mtd: st_spi_fsm: Search for preferred FSM message
 sequence configurations
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395307268-12721-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we provide a means to traverse though all supplied FSM message
sequence configurations and pick one based on our chip's capabilities.
The first one we match will be the preferred one, as they are
presented in order of preference.

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 9467585..2740ae1 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -222,6 +222,18 @@ struct stfsm_seq {
 	uint32_t seq_cfg;
 } __packed __aligned(4);
 
+/* Parameters to configure a READ or WRITE FSM sequence */
+struct seq_rw_config {
+	uint32_t        flags;          /* flags to support config */
+	uint8_t         cmd;            /* FLASH command */
+	int             write;          /* Write Sequence */
+	uint8_t         addr_pads;      /* No. of addr pads (MODE & DUMMY) */
+	uint8_t         data_pads;      /* No. of data pads */
+	uint8_t         mode_data;      /* MODE data */
+	uint8_t         mode_cycles;    /* No. of MODE cycles */
+	uint8_t         dummy_cycles;   /* No. of DUMMY cycles */
+};
+
 /* SPI Flash Device Table */
 struct flash_info {
 	char            *name;
@@ -462,6 +474,21 @@ static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf,
 	}
 }
 
+/* Search for preferred configuration based on available flags */
+static struct seq_rw_config *
+stfsm_search_seq_rw_configs(struct stfsm *fsm,
+			    struct seq_rw_config cfgs[])
+{
+	struct seq_rw_config *config;
+	int flags = fsm->info->flags;
+
+	for (config = cfgs; config->cmd != 0; config++)
+		if ((config->flags & flags) == config->flags)
+			return config;
+
+	return NULL;
+}
+
 static void stfsm_read_jedec(struct stfsm *fsm, uint8_t *const jedec)
 {
 	const struct stfsm_seq *seq = &stfsm_seq_read_jedec;
-- 
1.8.3.2
