Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8ECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:11:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252D820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bc2rsVxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252D820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGulrYwkkRlKjCcGVoVij8vwYsLP5qYr376EwwMOz6Y=; b=Bc2rsVxRjslJ09
	ru3d+iXDICgEOfUo+fBJMjQAg/bSyeKwW3gEbd6Z3wZvwMMhbhGSOOynQYXPE5huj1n8Gys513tNn
	aEnztur+LgvNl+tG640Dsjmz9VngoLphkb5PWVAo1khQhQ+83vJHnzIA3GTkLgMPMZzfkKGBwQJNk
	algc7XLAN7kOQvyqRuKHkT8CHxdszBmmv8d+KmMUQT69ZJWVmxux2ZopBHxkNCNokKRyU1gBNqxvC
	WrW79NhJiV6AUAWpK/0GZ0NGa+gopspG9X2AgZeDBSV2VrX7mnX+jV3uLdATaIOqhhfr7inJsBABm
	2/41kn47vFbG8o64I3VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpsL-0007ic-5H; Mon, 03 Dec 2018 15:11:09 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpgV-0005yT-B3
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:59:13 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 728AE5FD90; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/14] rtc: sun6i: Add support for different variants
Date: Mon,  3 Dec 2018 22:58:17 +0800
Message-Id: <20181203145825.20511-7-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065856_936220_FBFDC1F5 
X-CRM114-Status: GOOD (  19.42  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Amongst the Allwinner SoCs that have seen some kind of coverage by the
linux-sunxi community, whether it be mainline Linux or U-boot support,
or just available datasheets, most newer chips use the RTC design first
seen in the A31 (sun6i).

Overall there have been some minor differences. This patch covers the
following:

  - average clock rate of the internal RC oscillator
    + presence of fixed and adjustable prescaler for this clock
  - availability of an external (to the SoC) clock output

One major difference regarding the H6 is the 24 MHz crystal is now
routed through the RTC, as a digitally compensated oscillator (DCXO).
This is not covered in this patch and will be supported later.

Other differences are either unrelated to RTC or clock functionality,
such as boot or crypto related registers, or the driver simply doesn't
use the feature in question. One example of the latter is the
calibration function for the RC oscillator. We consider this clock to
be very bad and avoid using it.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 58 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 8edd9e1ec007..d1866d90b9ef 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -118,9 +118,30 @@
 #define SUN6I_YEAR_MAX				2033
 #define SUN6I_YEAR_OFF				(SUN6I_YEAR_MIN - 1900)
 
+/*
+ * There are other differences between models, including:
+ *
+ *   - number of GPIO pins that can be configured to hold a certain level
+ *   - crypto-key related registers (H5, H6)
+ *   - boot process related (super standby, secondary processor entry address)
+ *     registers (R40, H6)
+ *   - SYS power domain controls (R40)
+ *   - DCXO controls (H6)
+ *   - RC oscillator calibration (H6)
+ *
+ * These functions are not covered by this driver.
+ */
+struct sun6i_rtc_clk_data {
+	unsigned long rc_osc_rate;
+	unsigned int fixed_prescaler : 16;
+	unsigned int has_prescaler : 1;
+	unsigned int has_out_clk : 1;
+};
+
 struct sun6i_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
+	const struct sun6i_rtc_clk_data *data;
 	void __iomem *base;
 	int irq;
 	unsigned long alarm;
@@ -139,14 +160,19 @@ static unsigned long sun6i_rtc_osc_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
 	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
-	u32 val;
+	u32 val = 0;
 
 	val = readl(rtc->base + SUN6I_LOSC_CTRL);
 	if (val & SUN6I_LOSC_CTRL_EXT_OSC)
 		return parent_rate;
 
-	val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
-	val &= GENMASK(4, 0);
+	if (rtc->data->fixed_prescaler)
+		parent_rate /= rtc->data->fixed_prescaler;
+
+	if (rtc->data->has_prescaler) {
+		val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
+		val &= GENMASK(4, 0);
+	}
 
 	return parent_rate / (val + 1);
 }
@@ -185,7 +211,8 @@ static const struct clk_ops sun6i_rtc_osc_ops = {
 	.set_parent	= sun6i_rtc_osc_set_parent,
 };
 
-static void __init sun6i_rtc_clk_init(struct device_node *node)
+static void __init sun6i_rtc_clk_init(struct device_node *node,
+				      const struct sun6i_rtc_clk_data *data)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct sun6i_rtc_dev *rtc;
@@ -200,6 +227,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	if (!rtc)
 		return;
 
+	rtc->data = data;
 	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
@@ -228,7 +256,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								"rtc-int-osc",
 								NULL, 0,
-								667000,
+								rtc->data->rc_osc_rate,
 								300000000);
 	if (IS_ERR(rtc->int_osc)) {
 		pr_crit("Couldn't register the internal oscillator\n");
@@ -271,8 +299,18 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 err:
 	kfree(clk_data);
 }
-CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
-		      sun6i_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun6i_a31_rtc_data = {
+	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
+	.has_prescaler = 1,
+};
+
+static void __init sun6i_a31_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun6i_a31_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
+		      sun6i_a31_rtc_clk_init);
 
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
@@ -579,6 +617,12 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * As far as RTC functionality goes, all models are the same. The
+ * datasheets claim that different models have different number of
+ * registers available for non-volatile storage, but experiments show
+ * that all SoCs have 16 registers available for this purpose.
+ */
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
