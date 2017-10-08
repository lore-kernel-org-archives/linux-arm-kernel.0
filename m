From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Sun,  8 Oct 2017 23:41:20 +0100
Subject: [PATCH v2 5/7] nvmem: imx-ocotp: Add i.MX7D timing write clock setup
 support
In-Reply-To: <1507502482-22518-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507502482-22518-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507502482-22518-6-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds logic to correctly setup the write timing parameters
when blowing an OTP fuse for the i.MX7S/D.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 drivers/nvmem/imx-ocotp.c | 65 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 74c2f15..f80aee9 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -51,16 +51,12 @@
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
 
 #define DEF_RELAX			20 /* > 16.5ns */
+#define DEF_FSOURCE			1001
 #define IMX_OCOTP_WR_UNLOCK		0x3E770000
 #define IMX_OCOTP_READ_LOCKED_VAL	0xBADABADA
 
 static DEFINE_MUTEX(ocotp_mutex);
 
-struct ocotp_params {
-	unsigned int nregs;
-	unsigned int bank_address_words;
-};
-
 struct ocotp_priv {
 	struct device *dev;
 	struct clk *clk;
@@ -69,6 +65,12 @@ struct ocotp_priv {
 	struct nvmem_config *config;
 };
 
+struct ocotp_params {
+	unsigned int nregs;
+	unsigned int bank_address_words;
+	void (*set_timing)(struct ocotp_priv *priv);
+};
+
 static int imx_ocotp_wait_for_busy(void __iomem *base, u32 flags)
 {
 	int count;
@@ -193,6 +195,25 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
 }
 
+static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
+{
+	unsigned long clk_rate = 0;
+	unsigned long fsource, strobe_prog;
+	u32 timing = 0;
+
+	/* i.MX 7Solo Applications Processor Reference Manual, Rev. 0.1
+	 * 6.4.3.3
+	 */
+	clk_rate = clk_get_rate(priv->clk);
+	fsource = DIV_ROUND_UP(((clk_rate / 1000) * DEF_FSOURCE), 1000000) + 1;
+	strobe_prog = ((clk_rate * 10) / 1000000) + 1;
+
+	timing = strobe_prog & 0x00000FFF;
+	timing |= (fsource       << 12) & 0x000FF000;
+
+	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
+}
+
 static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -219,7 +240,7 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	}
 
 	/* Setup the write timing values */
-	imx_ocotp_set_imx6_timing(priv);
+	priv->params->set_timing(priv);
 
 	/* 47.3.1.3.2
 	 * Check that HW_OCOTP_CTRL[BUSY] and HW_OCOTP_CTRL[ERROR] are clear.
@@ -371,12 +392,32 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.reg_write = imx_ocotp_write,
 };
 
-static const struct octop_params params[] = {
-	{ .nregs = 128, .bank_address_words = 0 },
-	{ .nregs = 64,  .bank_address_words = 0 },
-	{ .nregs = 128, .bank_address_words = 0 },
-	{ .nregs = 128, .bank_address_words = 0 },
-	{ .nregs = 64,  .bank_address_words = 4 },
+static const struct ocotp_params params[] = {
+	{
+		.nregs = 128,
+		.bank_address_words = 0,
+		.set_timing = imx_ocotp_set_imx6_timing,
+	},
+	{
+		.nregs = 64,
+		.bank_address_words = 0,
+		.set_timing = imx_ocotp_set_imx6_timing,
+	},
+	{
+		.nregs = 128,
+		.bank_address_words = 0,
+		.set_timing = imx_ocotp_set_imx6_timing,
+	},
+	{
+		.nregs = 128,
+		.bank_address_words = 0,
+		.set_timing = imx_ocotp_set_imx6_timing,
+	},
+	{
+		.nregs = 64,
+		.bank_address_words = 4,
+		.set_timing = imx_ocotp_set_imx7_timing,
+	},
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
-- 
2.7.4
