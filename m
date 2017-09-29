From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Fri, 29 Sep 2017 15:09:12 +0200
Subject: [RFC 10/11] hack: mtk-sd: use old driver from vendor kernel
In-Reply-To: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1506690553-27357-11-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainline driver doesn't work on R13, haven't looked into this yet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 465 +++++++++++++++++++++++-----------------------
 1 file changed, 230 insertions(+), 235 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 267f7ab..1286256 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/of_address.h>
@@ -28,7 +29,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/interrupt.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/core.h>
@@ -76,7 +76,6 @@
 #define MSDC_PATCH_BIT1  0xb4
 #define MSDC_PAD_TUNE    0xec
 #define PAD_DS_TUNE      0x188
-#define PAD_CMD_TUNE     0x18c
 #define EMMC50_CFG0      0x208
 
 /*--------------------------------------------------------------------------*/
@@ -119,6 +118,7 @@
 #define MSDC_PS_CDSTS           (0x1 << 1)	/* R  */
 #define MSDC_PS_CDDEBOUNCE      (0xf << 12)	/* RW */
 #define MSDC_PS_DAT             (0xff << 16)	/* R  */
+#define MSDC_PS_DATA1           (0x1 << 17)	/* R  */
 #define MSDC_PS_CMD             (0x1 << 24)	/* R  */
 #define MSDC_PS_WP              (0x1 << 31)	/* R  */
 
@@ -212,17 +212,13 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
-#define MSDC_PAD_TUNE_DATWRDLY	  (0x1f <<  0)	/* RW */
-#define MSDC_PAD_TUNE_DATRRDLY	  (0x1f <<  8)	/* RW */
-#define MSDC_PAD_TUNE_CMDRDLY	  (0x1f << 16)  /* RW */
-#define MSDC_PAD_TUNE_CMDRRDLY	  (0x1f << 22)	/* RW */
-#define MSDC_PAD_TUNE_CLKTDLY	  (0x1f << 27)  /* RW */
-
-#define PAD_DS_TUNE_DLY1	  (0x1f << 2)   /* RW */
-#define PAD_DS_TUNE_DLY2	  (0x1f << 7)   /* RW */
-#define PAD_DS_TUNE_DLY3	  (0x1f << 12)  /* RW */
+#define MSDC_PAD_TUNE_DATRRDLY    (0x1f <<  8)	/* RW */
+#define MSDC_PAD_TUNE_CMDRDLY     (0x1f << 16)  /* RW */
+#define MSDC_PAD_TUNE_CLKTDLY     (0x1f << 27)  /* RW */
 
-#define PAD_CMD_TUNE_RX_DLY3	  (0x1f << 1)  /* RW */
+#define PAD_DS_TUNE_DLY1          (0x1f << 2)   /* RW */
+#define PAD_DS_TUNE_DLY2          (0x1f << 7)   /* RW */
+#define PAD_DS_TUNE_DLY3          (0x1f << 12)  /* RW */
 
 #define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
 #define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
@@ -291,14 +287,12 @@ struct msdc_save_para {
 	u32 patch_bit0;
 	u32 patch_bit1;
 	u32 pad_ds_tune;
-	u32 pad_cmd_tune;
 	u32 emmc50_cfg0;
 };
 
 struct msdc_tune_para {
 	u32 iocon;
 	u32 pad_tune;
-	u32 pad_cmd_tune;
 };
 
 struct msdc_delay_phase {
@@ -313,6 +307,7 @@ struct msdc_host {
 	int cmd_rsp;
 
 	spinlock_t lock;
+	spinlock_t irqlock;
 	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
@@ -331,19 +326,18 @@ struct msdc_host {
 	struct pinctrl_state *pins_uhs;
 	struct delayed_work req_timeout;
 	int irq;		/* host interrupt */
+	bool irq_thread_alive;
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
 	u32 sclk;		/* SD/MS bus clock frequency */
+	bool clock_on;
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 hs400_ds_delay;
-	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
-	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
-	bool hs400_cmd_resp_sel_rising;
-				 /* cmd response sample selection for HS400 */
+	u32 sdr104_clk_delay;
 	bool hs400_mode;	/* current eMMC will run@hs400 mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
@@ -400,6 +394,7 @@ static void msdc_reset_hw(struct msdc_host *host)
 
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd);
+static void msdc_recheck_sdio_irq(struct msdc_host *host);
 
 static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
 			MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
@@ -474,9 +469,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
+		bool read = (data->flags & MMC_DATA_READ) != 0;
+
 		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
-					    mmc_get_dma_dir(data));
+					   read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
 }
 
@@ -488,8 +485,10 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
 		return;
 
 	if (data->host_cookie & MSDC_PREPARE_FLAG) {
+		bool read = (data->flags & MMC_DATA_READ) != 0;
+
 		dma_unmap_sg(host->dev, data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+			     read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		data->host_cookie &= ~MSDC_PREPARE_FLAG;
 	}
 }
@@ -522,6 +521,7 @@ static void msdc_gate_clock(struct msdc_host *host)
 {
 	clk_disable_unprepare(host->src_clk);
 	clk_disable_unprepare(host->h_clk);
+	host->clock_on = false;
 }
 
 static void msdc_ungate_clock(struct msdc_host *host)
@@ -530,6 +530,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 	clk_prepare_enable(host->src_clk);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
+	host->clock_on = true;
 }
 
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
@@ -538,6 +539,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 flags;
 	u32 div;
 	u32 sclk;
+	unsigned long irq_flags;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -546,8 +548,11 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		return;
 	}
 
+	spin_lock_irqsave(&host->irqlock, irq_flags);
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
+	spin_unlock_irqrestore(&host->irqlock, irq_flags);
+
 	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
 	if (timing == MMC_TIMING_UHS_DDR50 ||
 	    timing == MMC_TIMING_MMC_DDR52 ||
@@ -588,7 +593,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		}
 	}
 	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
-		      (mode << 8) | div);
+			(mode << 8) | (div % 0xff));
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
@@ -597,7 +602,10 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	host->timing = timing;
 	/* need because clk changed. */
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
+
+	spin_lock_irqsave(&host->irqlock, irq_flags);
 	sdr_set_bits(host->base + MSDC_INTEN, flags);
+	spin_unlock_irqrestore(&host->irqlock, irq_flags);
 
 	/*
 	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
@@ -609,14 +617,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	} else {
 		writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
 		writel(host->saved_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
-		writel(host->saved_tune_para.pad_cmd_tune,
-		       host->base + PAD_CMD_TUNE);
 	}
 
-	if (timing == MMC_TIMING_MMC_HS400)
-		sdr_set_field(host->base + PAD_CMD_TUNE,
-			      MSDC_PAD_TUNE_CMDRRDLY,
-			      host->hs400_cmd_int_delay);
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
 }
 
@@ -661,7 +663,8 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 
 	host->cmd_rsp = resp;
 
-	if ((opcode == SD_IO_RW_DIRECT && cmd->flags == (unsigned int) -1) ||
+	if ((opcode == SD_IO_RW_DIRECT &&
+	    ((cmd->arg >> 9) & 0x1ffff) == SDIO_CCCR_ABORT) ||
 	    opcode == MMC_STOP_TRANSMISSION)
 		rawcmd |= (0x1 << 14);
 	else if (opcode == SD_SWITCH_VOLTAGE)
@@ -705,6 +708,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
 			    struct mmc_command *cmd, struct mmc_data *data)
 {
+	unsigned long flags;
 	bool read;
 
 	WARN_ON(host->data);
@@ -713,8 +717,12 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
 
 	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 	msdc_dma_setup(host, &host->dma, data);
+
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
 	dev_dbg(host->dev, "DMA start\n");
 	dev_dbg(host->dev, "%s: cmd=%d DMA data: %d blocks; read=%d\n",
 			__func__, cmd->opcode, data->blocks, read);
@@ -771,6 +779,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
 	mmc_request_done(host->mmc, mrq);
+	msdc_recheck_sdio_irq(host);
 }
 
 /* returns true if command is fully handled; returns false otherwise */
@@ -794,15 +803,17 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 					| MSDC_INT_CMDTMO)))
 		return done;
 
-	spin_lock_irqsave(&host->lock, flags);
 	done = !host->cmd;
+	spin_lock_irqsave(&host->lock, flags);
 	host->cmd = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (done)
 		return true;
 
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
@@ -841,6 +852,15 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	return true;
 }
 
+static int msdc_card_busy(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 status = readl(host->base + MSDC_PS);
+
+	/* check if data0 is low */
+	return !(status & BIT(16));
+}
+
 /* It is the core layer's responsibility to ensure card status
  * is correct before issue a request. but host design do below
  * checks recommended.
@@ -850,10 +870,20 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 {
 	/* The max busy time we can endure is 20ms */
 	unsigned long tmo = jiffies + msecs_to_jiffies(20);
+	u32 count = 0;
+
+	if (in_interrupt()) {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       (count < 1000)) {
+			udelay(1);
+			count++;
+		}
+	} else {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       time_before(jiffies, tmo))
+			cpu_relax();
+	}
 
-	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
-			time_before(jiffies, tmo))
-		cpu_relax();
 	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
 		dev_err(host->dev, "CMD bus busy detected\n");
 		host->error |= REQ_CMD_BUSY;
@@ -861,17 +891,35 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 		return false;
 	}
 
-	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
-		/* R1B or with data, should check SDCBUSY */
-		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
-				time_before(jiffies, tmo))
-			cpu_relax();
-		if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
-			dev_err(host->dev, "Controller busy detected\n");
-			host->error |= REQ_CMD_BUSY;
-			msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
-			return false;
+	if (cmd->opcode != MMC_SEND_STATUS) {
+		count = 0;
+		/* Consider that CMD6 crc error before card was init done,
+		 * mmc_retune() will return directly as host->card is null.
+		 * and CMD6 will retry 3 times, must ensure card is in transfer
+		 * state when retry.
+		 */
+		tmo = jiffies + msecs_to_jiffies(60 * 1000);
+		while (1) {
+			if (msdc_card_busy(host->mmc)) {
+				if (in_interrupt()) {
+					udelay(1);
+					count++;
+				} else {
+					msleep_interruptible(10);
+				}
+			} else {
+				break;
+			}
+			/* Timeout if the device never
+			 * leaves the program state.
+			 */
+			if (count > 1000 || time_after(jiffies, tmo)) {
+				pr_err("%s: Card stuck in programming state! %s\n",
+				       mmc_hostname(host->mmc), __func__);
+				host->error |= REQ_CMD_BUSY;
+				msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
+				return false;
+			}
 		}
 	}
 	return true;
@@ -880,6 +928,7 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
+	unsigned long flags;
 	u32 rawcmd;
 
 	WARN_ON(host->cmd);
@@ -898,7 +947,10 @@ static void msdc_start_command(struct msdc_host *host,
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
 	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 
+	spin_lock_irqsave(&host->irqlock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
@@ -990,8 +1042,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 	     | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
 	     | MSDC_INT_DMA_PROTECT);
 
-	spin_lock_irqsave(&host->lock, flags);
 	done = !host->data;
+	spin_lock_irqsave(&host->lock, flags);
 	if (check_data)
 		host->data = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1002,11 +1054,14 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 	if (check_data || (stop && stop->error)) {
 		dev_dbg(host->dev, "DMA status: 0x%8X\n",
 				readl(host->base + MSDC_DMA_CFG));
-		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
-				1);
+		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP, 1);
 		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
 			cpu_relax();
+
+		spin_lock_irqsave(&host->irqlock, flags);
 		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+
 		dev_dbg(host->dev, "DMA stop\n");
 
 		if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
@@ -1084,15 +1139,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
-static int msdc_card_busy(struct mmc_host *mmc)
-{
-	struct msdc_host *host = mmc_priv(mmc);
-	u32 status = readl(host->base + MSDC_PS);
-
-	/* only check if data0 is low */
-	return !(status & BIT(16));
-}
-
 static void msdc_request_timeout(struct work_struct *work)
 {
 	struct msdc_host *host = container_of(work, struct msdc_host,
@@ -1104,14 +1150,16 @@ static void msdc_request_timeout(struct work_struct *work)
 		dev_err(host->dev, "%s: aborting mrq=%p cmd=%d\n", __func__,
 				host->mrq, host->mrq->cmd->opcode);
 		if (host->cmd) {
-			dev_err(host->dev, "%s: aborting cmd=%d\n",
-					__func__, host->cmd->opcode);
+			dev_err(host->dev,
+				"%s: aborting cmd=%d, arg=0x%x\n", __func__,
+				host->cmd->opcode, host->cmd->arg);
 			msdc_cmd_done(host, MSDC_INT_CMDTMO, host->mrq,
 					host->cmd);
 		} else if (host->data) {
-			dev_err(host->dev, "%s: abort data: cmd%d; %d blocks\n",
-					__func__, host->mrq->cmd->opcode,
-					host->data->blocks);
+			dev_err(host->dev,
+				"%s: aborting data: cmd%d; %d blocks\n",
+				    __func__, host->mrq->cmd->opcode,
+				    host->data->blocks);
 			msdc_data_xfer_done(host, MSDC_INT_DATTMO, host->mrq,
 					host->data);
 		}
@@ -1120,44 +1168,47 @@ static void msdc_request_timeout(struct work_struct *work)
 
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
+	unsigned long flags;
 	struct msdc_host *host = (struct msdc_host *) dev_id;
+	struct mmc_request *mrq;
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	u32 events, event_mask;
+
+	spin_lock_irqsave(&host->irqlock, flags);
+	events = readl(host->base + MSDC_INT);
+	event_mask = readl(host->base + MSDC_INTEN);
+	/* clear interrupts */
+	writel(events & event_mask, host->base + MSDC_INT);
+
+	mrq = host->mrq;
+	cmd = host->cmd;
+	data = host->data;
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
+	if ((events & event_mask)& MSDC_INT_SDIOIRQ) {
+		mmc_signal_sdio_irq(host->mmc);
+		if (!mrq)
+			return IRQ_HANDLED;
+	}
 
-	while (true) {
-		unsigned long flags;
-		struct mmc_request *mrq;
-		struct mmc_command *cmd;
-		struct mmc_data *data;
-		u32 events, event_mask;
-
-		spin_lock_irqsave(&host->lock, flags);
-		events = readl(host->base + MSDC_INT);
-		event_mask = readl(host->base + MSDC_INTEN);
-		/* clear interrupts */
-		writel(events & event_mask, host->base + MSDC_INT);
-
-		mrq = host->mrq;
-		cmd = host->cmd;
-		data = host->data;
-		spin_unlock_irqrestore(&host->lock, flags);
-
-		if (!(events & event_mask))
-			break;
+	if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
+		return IRQ_HANDLED;
 
-		if (!mrq) {
-			dev_err(host->dev,
+	if (!mrq) {
+		dev_err(host->dev,
 				"%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
 				__func__, events, event_mask);
-			WARN_ON(1);
-			break;
-		}
+		WARN_ON(1);
+		return IRQ_HANDLED;
+	}
 
-		dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
+	dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
 
-		if (cmd)
-			msdc_cmd_done(host, events, mrq, cmd);
-		else if (data)
-			msdc_data_xfer_done(host, events, mrq, data);
-	}
+	if (cmd)
+		msdc_cmd_done(host, events, mrq, cmd);
+	else if (data)
+		msdc_data_xfer_done(host, events, mrq, data);
 
 	return IRQ_HANDLED;
 }
@@ -1165,6 +1216,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 static void msdc_init_hw(struct msdc_host *host)
 {
 	u32 val;
+	unsigned long flags;
 
 	/* Configure to MMC/SD mode, clock free running */
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
@@ -1176,11 +1228,14 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
 
 	/* Disable and clear all interrupts */
+	spin_lock_irqsave(&host->irqlock, flags);
 	writel(0, host->base + MSDC_INTEN);
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 
-	writel(0, host->base + MSDC_PAD_TUNE);
+	sdr_set_field(host->base + MSDC_PAD_TUNE,
+		MSDC_PAD_TUNE_CLKTDLY, host->sdr104_clk_delay);
 	writel(0, host->base + MSDC_IOCON);
 	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
 	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
@@ -1193,9 +1248,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	 */
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
 
-	/* disable detect SDIO device interrupt function */
-	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	else
+		/* disable detect SDIO device interrupt function */
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
 
@@ -1207,11 +1264,15 @@ static void msdc_init_hw(struct msdc_host *host)
 static void msdc_deinit_hw(struct msdc_host *host)
 {
 	u32 val;
+	unsigned long flags;
+
 	/* Disable and clear all interrupts */
+	spin_lock_irqsave(&host->irqlock, flags);
 	writel(0, host->base + MSDC_INTEN);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
+	spin_unlock_irqrestore(&host->irqlock, flags);
 }
 
 /* init gpd and bd list in msdc_drv_probe */
@@ -1278,6 +1339,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (host->mclk != ios->clock || host->timing != ios->timing)
 		msdc_set_mclk(host, ios->timing, ios->clock);
+
 }
 
 static u32 test_delay_bit(u32 delay, u32 bit)
@@ -1317,7 +1379,7 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 			len_final = len;
 		}
 		start += len ? len : 1;
-		if (len >= 12 && start_final < 4)
+		if (len >= 8 && start_final < 4)
 			break;
 	}
 
@@ -1340,67 +1402,36 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
-	struct msdc_delay_phase internal_delay_phase;
 	u8 final_delay, final_maxlen;
-	u32 internal_delay = 0;
 	int cmd_err;
-	int i, j;
-
-	if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
-	    mmc->ios.timing == MMC_TIMING_UHS_SDR104)
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
-			      MSDC_PAD_TUNE_CMDRRDLY,
-			      host->hs200_cmd_int_delay);
+	int i;
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
 		sdr_set_field(host->base + MSDC_PAD_TUNE,
 			      MSDC_PAD_TUNE_CMDRDLY, i);
-		/*
-		 * Using the same parameters, it may sometimes pass the test,
-		 * but sometimes it may fail. To make sure the parameters are
-		 * more stable, we test each set of parameters 3 times.
-		 */
-		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
-			if (!cmd_err) {
-				rise_delay |= (1 << i);
-			} else {
-				rise_delay &= ~(1 << i);
-				break;
-			}
-		}
+		mmc_send_tuning(mmc, opcode, &cmd_err);
+		if (!cmd_err)
+			rise_delay |= (1 << i);
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
-	if (final_rise_delay.maxlen >= 12 && final_rise_delay.start < 4)
+	if (final_rise_delay.maxlen >= 10 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
 		goto skip_fall;
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
 		sdr_set_field(host->base + MSDC_PAD_TUNE,
 			      MSDC_PAD_TUNE_CMDRDLY, i);
-		/*
-		 * Using the same parameters, it may sometimes pass the test,
-		 * but sometimes it may fail. To make sure the parameters are
-		 * more stable, we test each set of parameters 3 times.
-		 */
-		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
-			if (!cmd_err) {
-				fall_delay |= (1 << i);
-			} else {
-				fall_delay &= ~(1 << i);
-				break;
-			}
-		}
+		mmc_send_tuning(mmc, opcode, &cmd_err);
+		if (!cmd_err)
+			fall_delay |= (1 << i);
 	}
 	final_fall_delay = get_best_delay(host, fall_delay);
 
 skip_fall:
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
-	if (final_fall_delay.maxlen >= 12 && final_fall_delay.start < 4)
-		final_maxlen = final_fall_delay.maxlen;
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 		sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRDLY,
@@ -1412,71 +1443,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 			      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
 	}
-	if (host->hs200_cmd_int_delay)
-		goto skip_internal;
 
-	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
-			      MSDC_PAD_TUNE_CMDRRDLY, i);
-		mmc_send_tuning(mmc, opcode, &cmd_err);
-		if (!cmd_err)
-			internal_delay |= (1 << i);
-	}
-	dev_dbg(host->dev, "Final internal delay: 0x%x\n", internal_delay);
-	internal_delay_phase = get_best_delay(host, internal_delay);
-	sdr_set_field(host->base + MSDC_PAD_TUNE, MSDC_PAD_TUNE_CMDRRDLY,
-		      internal_delay_phase.final_phase);
-skip_internal:
-	dev_dbg(host->dev, "Final cmd pad delay: %x\n", final_delay);
-	return final_delay == 0xff ? -EIO : 0;
-}
-
-static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
-{
-	struct msdc_host *host = mmc_priv(mmc);
-	u32 cmd_delay = 0;
-	struct msdc_delay_phase final_cmd_delay = { 0,};
-	u8 final_delay;
-	int cmd_err;
-	int i, j;
-
-	/* select EMMC50 PAD CMD tune */
-	sdr_set_bits(host->base + PAD_CMD_TUNE, BIT(0));
-
-	if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
-	    mmc->ios.timing == MMC_TIMING_UHS_SDR104)
-		sdr_set_field(host->base + MSDC_PAD_TUNE,
-			      MSDC_PAD_TUNE_CMDRRDLY,
-			      host->hs200_cmd_int_delay);
-
-	if (host->hs400_cmd_resp_sel_rising)
-		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	else
-		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		sdr_set_field(host->base + PAD_CMD_TUNE,
-			      PAD_CMD_TUNE_RX_DLY3, i);
-		/*
-		 * Using the same parameters, it may sometimes pass the test,
-		 * but sometimes it may fail. To make sure the parameters are
-		 * more stable, we test each set of parameters 3 times.
-		 */
-		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
-			if (!cmd_err) {
-				cmd_delay |= (1 << i);
-			} else {
-				cmd_delay &= ~(1 << i);
-				break;
-			}
-		}
-	}
-	final_cmd_delay = get_best_delay(host, cmd_delay);
-	sdr_set_field(host->base + PAD_CMD_TUNE, PAD_CMD_TUNE_RX_DLY3,
-		      final_cmd_delay.final_phase);
-	final_delay = final_cmd_delay.final_phase;
-
-	dev_dbg(host->dev, "Final cmd pad delay: %x\n", final_delay);
 	return final_delay == 0xff ? -EIO : 0;
 }
 
@@ -1499,7 +1466,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	}
 	final_rise_delay = get_best_delay(host, rise_delay);
 	/* if rising edge has enough margin, then do not scan falling edge */
-	if (final_rise_delay.maxlen >= 12 ||
+	if (final_rise_delay.maxlen >= 10 ||
 	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
 		goto skip_fall;
 
@@ -1532,7 +1499,6 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 		final_delay = final_fall_delay.final_phase;
 	}
 
-	dev_dbg(host->dev, "Final data pad delay: %x\n", final_delay);
 	return final_delay == 0xff ? -EIO : 0;
 }
 
@@ -1541,13 +1507,10 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
-	if (host->hs400_mode)
-		ret = hs400_tune_response(mmc, opcode);
-	else
-		ret = msdc_tune_response(mmc, opcode);
+	ret = msdc_tune_response(mmc, opcode);
 	if (ret == -EIO) {
 		dev_err(host->dev, "Tune response fail!\n");
-		return ret;
+		goto out;
 	}
 	if (host->hs400_mode == false) {
 		ret = msdc_tune_data(mmc, opcode);
@@ -1557,7 +1520,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
 	host->saved_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
-	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
+out:
 	return ret;
 }
 
@@ -1579,39 +1542,64 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }
 
-static const struct mmc_host_ops mt_msdc_ops = {
+/**
+ * msdc_recheck_sdio_irq - recheck whether the SDIO IRQ is lost
+ * @host: The host to check.
+ *
+ * Host controller may lost interrupt in some special case.
+ * Add sdio IRQ recheck mechanism to make sure all interrupts
+ * can be processed immediately
+ *
+*/
+static void msdc_recheck_sdio_irq(struct msdc_host *host)
+{
+	u32 reg_int, reg_ps;
+
+	if (host->clock_on && (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		&& host->irq_thread_alive) {
+		reg_int = readl(host->base + MSDC_INT);
+		reg_ps  = readl(host->base + MSDC_PS);
+		if (!((reg_int & MSDC_INT_SDIOIRQ) || (reg_ps & MSDC_PS_DATA1))) {
+			mmc_signal_sdio_irq(host->mmc);
+		}
+	}
+}
+
+static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	host->irq_thread_alive = true;
+	if (enable) {
+		pm_runtime_get_sync(host->dev);
+		msdc_recheck_sdio_irq(host);
+
+		spin_lock_irqsave(&host->irqlock, flags);
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+	} else {
+		spin_lock_irqsave(&host->irqlock, flags);
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		spin_unlock_irqrestore(&host->irqlock, flags);
+	}
+}
+
+static struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
-	.get_cd = mmc_gpio_get_cd,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
 	.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
 	.hw_reset = msdc_hw_reset,
+	.enable_sdio_irq = msdc_enable_sdio_irq,
 };
 
-static void msdc_of_property_parse(struct platform_device *pdev,
-				   struct msdc_host *host)
-{
-	of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
-			     &host->hs400_ds_delay);
-
-	of_property_read_u32(pdev->dev.of_node, "mediatek,hs200-cmd-int-delay",
-			     &host->hs200_cmd_int_delay);
-
-	of_property_read_u32(pdev->dev.of_node, "mediatek,hs400-cmd-int-delay",
-			     &host->hs400_cmd_int_delay);
-
-	if (of_property_read_bool(pdev->dev.of_node,
-				  "mediatek,hs400-cmd-resp-sel-rising"))
-		host->hs400_cmd_resp_sel_rising = true;
-	else
-		host->hs400_cmd_resp_sel_rising = false;
-}
-
 static int msdc_drv_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
@@ -1683,14 +1671,22 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
-	msdc_of_property_parse(pdev, host);
+	if (!of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
+				  &host->hs400_ds_delay))
+		dev_dbg(&pdev->dev, "hs400-ds-delay: %x\n",
+			host->hs400_ds_delay);
+
+	if (!of_property_read_u32(pdev->dev.of_node, "sdr104-clk-delay",
+				&host->sdr104_clk_delay));
+		dev_dbg(&pdev->dev, "sdr104-clk-delay: %x\n",
+			host->sdr104_clk_delay);
 
 	host->dev = &pdev->dev;
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
 	mmc->ops = &mt_msdc_ops;
-	mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
+	mmc->f_min = host->src_clk_freq / (4 * 255);
 
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
@@ -1703,6 +1699,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc_dev(mmc)->dma_mask = &host->dma_mask;
 
 	host->timeout_clks = 3 * 1048576;
+	host->irq_thread_alive = false;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
 				2 * sizeof(struct mt_gpdma_desc),
 				&host->dma.gpd_addr, GFP_KERNEL);
@@ -1716,6 +1713,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_init_gpd_bd(host, &host->dma);
 	INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
 	spin_lock_init(&host->lock);
+	spin_lock_init(&host->irqlock);
 
 	platform_set_drvdata(pdev, mmc);
 	msdc_ungate_clock(host);
@@ -1775,7 +1773,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	pm_runtime_put_noidle(host->dev);
 	dma_free_coherent(&pdev->dev,
-			2 * sizeof(struct mt_gpdma_desc),
+			sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			host->dma.bd, host->dma.bd_addr);
@@ -1795,7 +1793,6 @@ static void msdc_save_reg(struct msdc_host *host)
 	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
 	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
 	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
-	host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
 	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
 }
 
@@ -1808,7 +1805,6 @@ static void msdc_restore_reg(struct msdc_host *host)
 	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
 	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
 	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
-	writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
 	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
 }
 
@@ -1843,7 +1839,6 @@ static const struct of_device_id msdc_of_ids[] = {
 	{   .compatible = "mediatek,mt8135-mmc", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, msdc_of_ids);
 
 static struct platform_driver mt_msdc_driver = {
 	.probe = msdc_drv_probe,
-- 
2.7.4
