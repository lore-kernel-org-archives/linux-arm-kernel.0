Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:10:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC59420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XHNjIiXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC59420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HgQm3jh+GPFZBpWxb8UIPiPUJHRmyqLtH8HfPT5HvzE=; b=XHNjIiXXTip7Pd
	o9soLjwUD+VZAmEuWMFyvj38lmZ6x/BzYdPvlYFqXMXIIHz4SVdIG8SbriflFddqdByCeNXpdk1yQ
	g6DzXSOseum0jrorPQKq88sFESvHlHdE9/C4QjLMmIWzqmIr/wZ4GS2ZH4vebxBr9Ir7GA6oqGuxc
	T7v0HGl5O26N1tc3GXmRmuk72BbJJv6LEPcCtBfV4yF23EiSejKWlXh/c5apH9Pbj/XLyn9DynTRu
	P0qFxc3PL0P60zEvIrrZkkO8Fx1VjPbdG+qE/ike0H27LH3AGsPrrTQnQV+UW6CNgPgnp1j83TqFb
	vJ7NyB8keRRlPQjzw/sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTprc-0006y9-RL; Mon, 03 Dec 2018 15:10:24 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpgV-0005yZ-BA
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:59:00 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 7DDFC5FDB8; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/14] rtc: sun6i: Expose internal oscillator through
 device tree
Date: Mon,  3 Dec 2018 22:58:19 +0800
Message-Id: <20181203145825.20511-9-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065855_994026_1C3B02B0 
X-CRM114-Status: GOOD (  15.52  )
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

The bindings have been updated to expose the RTC's internal oscillator,
for some SoCs that have it directly feeding the PRCM block. The changes
include the index 2 for the clock outputs, as well as the clock output
names.

This patch adds the internal oscillator to the list of clocks exposed
through of_clk_add_hw_provider(), and also have the driver optionally
fetch the name of the clock from the device tree if it's available.

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 46609ae56ffd..11f56de52179 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -136,6 +136,7 @@ struct sun6i_rtc_clk_data {
 	unsigned int fixed_prescaler : 16;
 	unsigned int has_prescaler : 1;
 	unsigned int has_out_clk : 1;
+	unsigned int export_iosc : 1;
 };
 
 struct sun6i_rtc_dev {
@@ -220,6 +221,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		.ops		= &sun6i_rtc_osc_ops,
 		.name		= "losc",
 	};
+	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
 
@@ -228,7 +230,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 
 	rtc->data = data;
-	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 3), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
 		return;
@@ -253,8 +255,13 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	if (!of_get_property(node, "clocks", NULL))
 		goto err;
 
+	/* Only read IOSC name from device tree if it is exported */
+	if (rtc->data->export_iosc)
+		of_property_read_string_index(node, "clock-output-names", 2,
+					      &iosc_name);
+
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
-								"rtc-int-osc",
+								iosc_name,
 								NULL, 0,
 								rtc->data->rc_osc_rate,
 								300000000);
@@ -293,6 +300,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	clk_data->num = 2;
 	clk_data->hws[0] = &rtc->hw;
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
+	if (rtc->data->export_iosc) {
+		clk_data->hws[2] = rtc->int_osc;
+		clk_data->num = 3;
+	}
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	return;
 
@@ -330,6 +341,7 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
 	.has_out_clk = 1,
+	.export_iosc = 1,
 };
 
 static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
