From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 16:21:26 +0200
Subject: [PATCH 3/3] RFC: mmc: mmci: add qcom specific program end support
In-Reply-To: <1477318886-24851-1-git-send-email-linus.walleij@linaro.org>
References: <1477318886-24851-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1477318886-24851-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to programend interrupt which is very
specific to QCOM integration. This interrupt is use as busy signal
when a command forces the card to enter into programming state
like CMD6 writing to ext_csd registers.

Hopefully, this also fixes the __mmc_switch timeout issue reproted
with latest versions of the eMMC used on DB600c board.

This patch is based on a WIP patch from Srinivas Kandagatla and
augmented by Linus Walleij for another approach.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Srinivas: please test to see if this fixes your problems. Sadly
it does *NOT* solve my APQ8060 issues, but it would be nice if
the common code path works for the busy detection on your
DB600c.
---
 drivers/mmc/host/mmci.c | 21 +++++++++++++++++++--
 drivers/mmc/host/mmci.h |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 06e19d8359e0..c0380713df34 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -72,7 +72,10 @@ static unsigned int fmax = 515633;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if the variant supports busy detection on DAT0.
- * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
+ * @busy_cpsm_flag: bitmask enabling busy detection in the CPSM (command
+ *		    path state machine)
+ * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM (data path
+ *		    state machine)
  * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
  * 	 	      indicating that the card is busy
  * @busy_detect_mask: bitmask identifying the bit in the MMCIMASK0 to mask for
@@ -103,6 +106,7 @@ struct variant_data {
 	bool			signal_direction;
 	bool			pwrreg_clkgate;
 	bool			busy_detect;
+	u32			busy_cpsm_flag;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
@@ -229,6 +233,10 @@ static struct variant_data variant_qcom = {
 	.datalength_bits	= 24,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
+	.busy_detect		= true,
+	.busy_cpsm_flag		= MCI_CPSM_QCOM_PROGENA,
+	.busy_detect_flag	= MCI_QCOM_PROGDONE,
+	.busy_detect_mask	= MCI_QCOM_PROGDONEMASK,
 	.explicit_mclk_control	= true,
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
@@ -903,6 +911,15 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
+	/*
+	 * Enable the program end interrupt for specific commands
+	 * used for busy detection.
+	 */
+	if (host->variant->busy_detect &&
+	    (cmd->flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+		c |= host->variant->busy_cpsm_flag;
+	}
+
 	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
 		c |= host->variant->data_cmd_enable;
 
@@ -1005,7 +1022,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		return;
 
 	/*
-	 * ST Micro variant: handle busy detection.
+	 * ST Micro and Qualcomm variants: handle busy detection.
 	 */
 	if (host->variant->busy_detect) {
 		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 38f6f1365ec4..99abf02f560e 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -130,6 +130,8 @@
 #define MCI_ST_SDIOIT		(1 << 22)
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
+/* Extended status bits for the QCOM variants */
+#define MCI_QCOM_PROGDONE	(1 << 23)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
@@ -147,6 +149,8 @@
 #define MCI_ST_SDIOITC		(1 << 22)
 #define MCI_ST_CEATAENDC	(1 << 23)
 #define MCI_ST_BUSYENDC		(1 << 24)
+/* Extended status bits for the QCOM variants */
+#define MCI_QCOM_PROGDONECLR	(1 << 23)
 
 #define MMCIMASK0		0x03c
 #define MCI_CMDCRCFAILMASK	(1 << 0)
@@ -175,6 +179,8 @@
 #define MCI_ST_SDIOITMASK	(1 << 22)
 #define MCI_ST_CEATAENDMASK	(1 << 23)
 #define MCI_ST_BUSYENDMASK	(1 << 24)
+/* Extended status bits for the Qualcomm variants */
+#define MCI_QCOM_PROGDONEMASK	(1 << 23)
 
 #define MMCIMASK1		0x040
 #define MMCIFIFOCNT		0x048
-- 
2.7.4
