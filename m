From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed,  4 Oct 2017 23:25:18 +0100
Subject: [RESEND][PATCH 4/7] nvmem: imx-ocotp: Move i.MX6 write clock setup to
 dedicated function
In-Reply-To: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507155921-824-5-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX7S/D has a different set of timing requirements, as a pre-cursor to
adding the i.MX7 timing parameters, move the i.MX6 stuff to a dedicated
function.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 drivers/nvmem/imx-ocotp.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 8034937..0cd7e03 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -169,6 +169,31 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	return ret;
 }
 
+static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
+{
+	unsigned long clk_rate = 0;
+	unsigned long strobe_read, relax, strobe_prog;
+	u32 timing = 0;
+
+	/* 47.3.1.3.1
+	 * Program HW_OCOTP_TIMING[STROBE_PROG] and HW_OCOTP_TIMING[RELAX]
+	 * fields with timing values to match the current frequency of the
+	 * ipg_clk. OTP writes will work at maximum bus frequencies as long
+	 * as the HW_OCOTP_TIMING parameters are set correctly.
+	 */
+	clk_rate = clk_get_rate(priv->clk);
+
+	relax = clk_rate / (1000000000 / DEF_RELAX) - 1;
+	strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
+	strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
+
+	timing = strobe_prog & 0x00000FFF;
+	timing |= (relax       << 12) & 0x0000F000;
+	timing |= (strobe_read << 16) & 0x003F0000;
+
+	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
+}
+
 static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -176,9 +201,6 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	u32 *buf = val;
 	int ret;
 
-	unsigned long clk_rate = 0;
-	unsigned long strobe_read, relax, strobe_prog;
-	u32 timing = 0;
 	u32 ctrl;
 	u8 waddr;
 	u8 word = 0;
@@ -197,23 +219,8 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 		return ret;
 	}
 
-	/* 47.3.1.3.1
-	 * Program HW_OCOTP_TIMING[STROBE_PROG] and HW_OCOTP_TIMING[RELAX]
-	 * fields with timing values to match the current frequency of the
-	 * ipg_clk. OTP writes will work at maximum bus frequencies as long
-	 * as the HW_OCOTP_TIMING parameters are set correctly.
-	 */
-	clk_rate = clk_get_rate(priv->clk);
-
-	relax = clk_rate / (1000000000 / DEF_RELAX) - 1;
-	strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
-	strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
-
-	timing = strobe_prog & 0x00000FFF;
-	timing |= (relax       << 12) & 0x0000F000;
-	timing |= (strobe_read << 16) & 0x003F0000;
-
-	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
+	/* Setup the write timing values */
+	imx_ocotp_set_imx6_timing(priv);
 
 	/* 47.3.1.3.2
 	 * Check that HW_OCOTP_CTRL[BUSY] and HW_OCOTP_CTRL[ERROR] are clear.
-- 
2.7.4
