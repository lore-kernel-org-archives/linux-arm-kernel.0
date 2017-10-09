From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  9 Oct 2017 15:11:48 +0100
Subject: [PATCH v3 3/7] nvmem: imx-ocotp: Add support for banked OTP addressing
In-Reply-To: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507558312-20580-4-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX7S/D takes the bank address in the CTRLn.ADDR field and the data
value in one of the DATAx {0, 1, 2, 3} register fields. The current write
routine is based on writing the CTRLn.ADDR field and writing a single DATA
register only.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 drivers/nvmem/imx-ocotp.c | 70 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7798571..927d525 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -40,7 +40,10 @@
 #define IMX_OCOTP_ADDR_CTRL_SET		0x0004
 #define IMX_OCOTP_ADDR_CTRL_CLR		0x0008
 #define IMX_OCOTP_ADDR_TIMING		0x0010
-#define IMX_OCOTP_ADDR_DATA		0x0020
+#define IMX_OCOTP_ADDR_DATA0		0x0020
+#define IMX_OCOTP_ADDR_DATA1		0x0030
+#define IMX_OCOTP_ADDR_DATA2		0x0040
+#define IMX_OCOTP_ADDR_DATA3		0x0050
 
 #define IMX_OCOTP_BM_CTRL_ADDR		0x0000007F
 #define IMX_OCOTP_BM_CTRL_BUSY		0x00000100
@@ -55,6 +58,7 @@ static DEFINE_MUTEX(ocotp_mutex);
 
 struct ocotp_params {
 	unsigned int nregs;
+	unsigned int bank_address_words;
 };
 
 struct ocotp_priv {
@@ -176,6 +180,7 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	u32 timing = 0;
 	u32 ctrl;
 	u8 waddr;
+	u8 word = 0;
 
 	/* allow only writing one complete OTP word at a time */
 	if ((bytes != priv->config->word_size) ||
@@ -228,8 +233,22 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	 * description. Both the unlock code and address can be written in the
 	 * same operation.
 	 */
-	/* OTP write/read address specifies one of 128 word address locations */
-	waddr = offset / 4;
+	if (priv->params->bank_address_words != 0) {
+		/*
+		 * In banked mode the OTP register bank goes into waddr see
+		 * i.MX 7Solo Applications Processor Reference Manual, Rev. 0.1
+		 * 6.4.3.1
+		 */
+		offset = offset / priv->config->word_size;
+		waddr = offset / priv->params->bank_address_words;
+		word  = offset & (priv->params->bank_address_words - 1);
+	} else {
+		/*
+		 * OTP write/read address specifies one of 128 word address
+		 * locations
+		 */
+		waddr = offset / 4;
+	}
 
 	ctrl = readl(priv->base + IMX_OCOTP_ADDR_CTRL);
 	ctrl &= ~IMX_OCOTP_BM_CTRL_ADDR;
@@ -255,8 +274,41 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	 * shift right (with zero fill). This shifting is required to program
 	 * the OTP serially. During the write operation, HW_OCOTP_DATA cannot be
 	 * modified.
+	 * Note: on i.MX7 there are four data fields to write for banked write
+	 *       with the fuse blowing operation only taking place after data0
+	 *	 has been written. This is why data0 must always be the last
+	 *	 register written.
 	 */
-	writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA);
+	if (priv->params->bank_address_words == 0) {
+		writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA0);
+	} else {
+		switch (word) {
+		case 0:
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA1);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA2);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA3);
+			writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA0);
+			break;
+		case 1:
+			writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA1);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA2);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA3);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA0);
+			break;
+		case 2:
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA1);
+			writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA2);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA3);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA0);
+			break;
+		case 3:
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA1);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA2);
+			writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA3);
+			writel(0, priv->base + IMX_OCOTP_ADDR_DATA0);
+			break;
+		}
+	}
 
 	/* 47.4.1.4.5
 	 * Once complete, the controller will clear BUSY. A write request to a
@@ -313,11 +365,11 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 };
 
 static const struct ocotp_params params[] = {
-	{ .nregs = 128 },
-	{ .nregs = 64 },
-	{ .nregs = 128 },
-	{ .nregs = 128 },
-	{ .nregs = 64 },
+	{ .nregs = 128, .bank_address_words = 0 },
+	{ .nregs = 64,  .bank_address_words = 0 },
+	{ .nregs = 128, .bank_address_words = 0 },
+	{ .nregs = 128, .bank_address_words = 0 },
+	{ .nregs = 64,  .bank_address_words = 4 },
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
-- 
2.7.4
