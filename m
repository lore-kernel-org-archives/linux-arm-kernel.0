From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Jan 2011 15:25:52 +0800
Subject: [PATCH v5 09/10] ARM: mxs/mx28evk: read fec mac address from ocotp
In-Reply-To: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1294989952-20813-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read fec mac address from ocotp and save it into fec_platform_data
mac field for fec driver to use.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/mach-mx28evk.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 8e2c597..e8db99f 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -119,7 +119,7 @@ static void __init mx28evk_fec_reset(void)
 	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
 }
 
-static struct fec_platform_data mx28_fec_pdata[] = {
+static struct fec_platform_data mx28_fec_pdata[] __initdata = {
 	{
 		/* fec0 */
 		.phy = PHY_INTERFACE_MODE_RMII,
@@ -129,12 +129,45 @@ static struct fec_platform_data mx28_fec_pdata[] = {
 	},
 };
 
+static int __init mx28evk_fec_get_mac(void)
+{
+	int i;
+	u32 val;
+	const u32 *ocotp = mxs_get_ocotp();
+
+	if (!ocotp)
+		goto error;
+
+	/*
+	 * OCOTP only stores the last 4 octets for each mac address,
+	 * so hard-code Freescale OUI (00:04:9f) here.
+	 */
+	for (i = 0; i < 2; i++) {
+		val = ocotp[i * 4];
+		mx28_fec_pdata[i].mac[0] = 0x00;
+		mx28_fec_pdata[i].mac[1] = 0x04;
+		mx28_fec_pdata[i].mac[2] = 0x9f;
+		mx28_fec_pdata[i].mac[3] = (val >> 16) & 0xff;
+		mx28_fec_pdata[i].mac[4] = (val >> 8) & 0xff;
+		mx28_fec_pdata[i].mac[5] = (val >> 0) & 0xff;
+	}
+
+	return 0;
+
+error:
+	pr_err("%s: timeout when reading fec mac from OCOTP\n", __func__);
+	return -ETIMEDOUT;
+}
+
 static void __init mx28evk_init(void)
 {
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
 
+	if (mx28evk_fec_get_mac())
+		pr_warn("%s: failed on fec mac setup\n", __func__);
+
 	mx28evk_fec_reset();
 	mx28_add_fec(0, &mx28_fec_pdata[0]);
 	mx28_add_fec(1, &mx28_fec_pdata[1]);
-- 
1.7.1
