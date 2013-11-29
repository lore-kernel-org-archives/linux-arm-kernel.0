From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 29 Nov 2013 12:18:53 +0000
Subject: [PATCH v3 04/36] mtd: st_spi_fsm: Supply framework for device requests
In-Reply-To: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1385727565-25794-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSM hardware works by setting a predetermined sequence of register
writes. Rather than open coding them inside each functional block we're
going to define them in a series of formatted 'sequence structures'.
This patch provides the framework which shall be used for every action.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/st_spi_fsm.h | 14 ++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index fe96b47..8ac8cd9 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -25,6 +25,11 @@
 
 #include "st_spi_fsm.h"
 
+static inline int stfsm_is_idle(struct stfsm *fsm)
+{
+	return readl(fsm->base + SPI_FAST_SEQ_STA) & 0x10;
+}
+
 static inline uint32_t stfsm_fifo_available(struct stfsm *fsm)
 {
 	return (readl(fsm->base + SPI_FAST_SEQ_STA) >> 5) & 0x7f;
@@ -46,6 +51,36 @@ static void stfsm_clear_fifo(struct stfsm *fsm)
 	}
 }
 
+static inline void stfsm_load_seq(struct stfsm *fsm,
+				  const struct stfsm_seq *seq)
+{
+	void __iomem *dst = fsm->base + SPI_FAST_SEQ_TRANSFER_SIZE;
+	const uint32_t *src = (const uint32_t *)seq;
+	int words = STFSM_SEQ_SIZE / sizeof(uint32_t);
+
+	BUG_ON(!stfsm_is_idle(fsm));
+
+	while (words--) {
+		writel(*src, dst);
+		src++;
+		dst += 4;
+	}
+}
+
+static void stfsm_wait_seq(struct stfsm *fsm)
+{
+	unsigned long timeo = jiffies + HZ;
+
+	while (time_before(jiffies, timeo)) {
+		if (stfsm_is_idle(fsm))
+			return;
+
+		cond_resched();
+	}
+
+	dev_err(fsm->dev, "timeout on sequence completion\n");
+}
+
 static int stfsm_set_mode(struct stfsm *fsm, uint32_t mode)
 {
 	int ret, timeout = 10;
diff --git a/drivers/mtd/devices/st_spi_fsm.h b/drivers/mtd/devices/st_spi_fsm.h
index 4e92e58..6164142 100644
--- a/drivers/mtd/devices/st_spi_fsm.h
+++ b/drivers/mtd/devices/st_spi_fsm.h
@@ -199,4 +199,18 @@ struct stfsm {
 	uint32_t		fifo_dir_delay;
 };
 
+struct stfsm_seq {
+	uint32_t data_size;
+	uint32_t addr1;
+	uint32_t addr2;
+	uint32_t addr_cfg;
+	uint32_t seq_opc[5];
+	uint32_t mode;
+	uint32_t dummy;
+	uint32_t status;
+	uint8_t  seq[16];
+	uint32_t seq_cfg;
+} __attribute__((__packed__, aligned(4)));
+#define STFSM_SEQ_SIZE sizeof(struct stfsm_seq)
+
 #endif	/* ST_SPI_FSM_H */
-- 
1.8.3.2
