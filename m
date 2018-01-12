From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 12 Jan 2018 13:15:57 +0100
Subject: [PATCH 03/14] mmc: mmci: Add support for setting pad type via pinctrl
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515759368-16946-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

The STM32 variant hasn't the control bit to switch pads in opendrain mode.
In this case we can achieve the same result by asking to the pinmux driver
to configure pins for us.

This patch make the mmci driver able to do this whenever needed.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/mmc/host/mmci.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7e56f85..38e8c20 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -85,6 +85,8 @@
  * @mmcimask1: true if variant have a MMCIMASK1 register.
  * @start_err: true is the variant has STARTBITERR bit inside MMCISTATUS
  *	       register.
+ * @opendrain: true if variant have dedicated bit for opendrain pins
+ *	       configuration.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -116,6 +118,7 @@ struct variant_data {
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
 	bool			start_err;
+	bool			opendrain;
 };
 
 static struct variant_data variant_arm = {
@@ -127,6 +130,7 @@ struct variant_data {
 	.reversed_irq_handling	= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -137,6 +141,7 @@ struct variant_data {
 	.f_max			= 100000000,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -148,6 +153,7 @@ struct variant_data {
 	.f_max			= 100000000,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_u300 = {
@@ -165,6 +171,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_nomadik = {
@@ -183,6 +190,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -207,6 +215,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -233,6 +242,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 static struct variant_data variant_qcom = {
@@ -253,6 +263,7 @@ struct variant_data {
 	.qcom_dml		= true,
 	.mmcimask1		= true,
 	.start_err		= true,
+	.opendrain		= true,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -1394,9 +1405,11 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct variant_data *variant = host->variant;
+	struct pinctrl_state *pins;
 	u32 pwr = 0;
 	unsigned long flags;
 	int ret;
+	bool is_opendrain;
 
 	if (host->plat->ios_handler &&
 		host->plat->ios_handler(mmc_dev(mmc), ios))
@@ -1455,16 +1468,31 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				~MCI_ST_DATA2DIREN);
 	}
 
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
-		if (host->hw_designer != AMBA_VENDOR_ST)
-			pwr |= MCI_ROD;
-		else {
-			/*
-			 * The ST Micro variant use the ROD bit for something
-			 * else and only has OD (Open Drain).
-			 */
-			pwr |= MCI_OD;
+	if (host->variant->opendrain) {
+		if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
+			if (host->hw_designer != AMBA_VENDOR_ST) {
+				pwr |= MCI_ROD;
+			} else {
+				/*
+				 * The ST Micro variant use the ROD bit for
+				 * something else and only has OD (Open Drain).
+				 */
+				pwr |= MCI_OD;
+			}
 		}
+	} else {
+		/*
+		 * If the variant cannot configure the pads by its own, then we
+		 * expect the pinctrl to be able to do that for us
+		 */
+		is_opendrain = (ios->bus_mode == MMC_BUSMODE_OPENDRAIN);
+		pins = pinctrl_lookup_state(host->pinctrl, is_opendrain ?
+					MMCI_PINCTRL_STATE_OPENDRAIN :
+					MMCI_PINCTRL_STATE_PUSHPULL);
+		if (IS_ERR(pins))
+			dev_warn(mmc_dev(mmc), "Cannot select pin drive type via pinctrl\n");
+		else
+			pinctrl_select_state(host->pinctrl, pins);
 	}
 
 	/*
@@ -1609,6 +1637,14 @@ static int mmci_probe(struct amba_device *dev,
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
+	if (!variant->opendrain) {
+		host->pinctrl = devm_pinctrl_get(&dev->dev);
+		if (IS_ERR(host->pinctrl)) {
+			dev_err(&dev->dev, "failed to get pinctrl");
+			goto host_free;
+		}
+	}
+
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 83160a9..de3d0b3 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -192,6 +192,10 @@
 
 #define NR_SG		128
 
+/* pinctrl configs */
+#define MMCI_PINCTRL_STATE_PUSHPULL "default"
+#define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
+
 struct clk;
 struct variant_data;
 struct dma_chan;
@@ -227,6 +231,7 @@ struct mmci_host {
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
+	struct pinctrl		*pinctrl;
 
 	u8			hw_designer;
 	u8			hw_revision:4;
-- 
1.9.1
