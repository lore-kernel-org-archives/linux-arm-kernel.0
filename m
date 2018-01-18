From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 18 Jan 2018 15:34:18 +0100
Subject: [PATCH v3 02/14] mmc: mmci: Don't pretend all variants to have
 MCI_STARBITERR flag
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1516286070-24927-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch prepares for supporting the STM32 variant that
has no such bit in the status register.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ replace start_err bool type by u32


 drivers/mmc/host/mmci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3125dc0..8a4fbc2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -83,6 +83,8 @@
  * @qcom_dml: enables qcom specific dma glue for dma transfers.
  * @reversed_irq_handling: handle data irq before cmd irq.
  * @mmcimask1: true if variant have a MMCIMASK1 register.
+ * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
+ *	       register.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -113,6 +115,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
+	u32			start_err;
 };
 
 static struct variant_data variant_arm = {
@@ -123,6 +126,7 @@ struct variant_data {
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -132,6 +136,7 @@ struct variant_data {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -142,6 +147,7 @@ struct variant_data {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_u300 = {
@@ -158,6 +164,7 @@ struct variant_data {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_nomadik = {
@@ -175,6 +182,7 @@ struct variant_data {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_ux500 = {
@@ -198,6 +206,7 @@ struct variant_data {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -223,6 +232,7 @@ struct variant_data {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 static struct variant_data variant_qcom = {
@@ -242,6 +252,7 @@ struct variant_data {
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
 	.mmcimask1		= true,
+	.start_err		= MCI_STARTBITERR,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -935,8 +946,9 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		return;
 
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
-		      MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+	if (status & (MCI_DATACRCFAIL | MCI_DATATIMEOUT |
+		      host->variant->start_err |
+		      MCI_TXUNDERRUN | MCI_RXOVERRUN)) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-- 
1.9.1
