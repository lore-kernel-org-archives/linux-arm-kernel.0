Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AFBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2799F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fB6xq3pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2799F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4hDX7ZohHr9NNBwgIN3JJ1bARUFuLjbWV1O3GrEeyUY=; b=fB6xq3pNpRxqLx
	lm6Ca/mOyGES3nLk0iPnUAF7NlBGc5dY2PM3o+omm4Ay9hYd2w2k3yRE7N7u1DEq8Hbq1lDclRYpZ
	EyFSXWpeSM/sbGewAsD5Hre4/gFzLpXWV07F7dvj72zwVq0bWt2rj5/UIQiqiGqxpQzh7Hry/dhxF
	fYx/OHr+NU2dVEpTd86SgLeXqtrYwhL9uhIOEpGgf/lCeIz8M+U+3K5Lv+u3zK/NwjRiPnUt8/EZg
	g9rBanD5IMYSn++FuKHbwrgrxk4sCZSUxO592Gg3OdAYCBkfxhWFoBS9WzMnSE2sfWzaQb6ygp8aN
	EH0rUOL1S7qcF8bdIkOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8mr-0000vi-Va; Tue, 19 Feb 2019 17:02:29 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8mb-0000d4-8O
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:16 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB48F2000D;
 Tue, 19 Feb 2019 17:02:09 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/7] clk: at91: sckc: handle different RC startup time
Date: Tue, 19 Feb 2019 18:01:56 +0100
Message-Id: <20190219170200.3608-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090213_447412_29946B54 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The sama5d3 slow RC oscillator as a different startup time than all the
previous SoCs. Handle that using its own compatible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 470aef586f57..e76b1d64e905 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -321,7 +321,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	return hw;
 }
 
-static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
+static void __init at91sam9x5_sckc_register(struct device_node *np,
+					    unsigned int rc_osc_startup_us)
 {
 	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
 	void __iomem *regbase = of_iomap(np, 0);
@@ -334,7 +335,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 		return;
 
 	hw = at91_clk_register_slow_rc_osc(regbase, parent_names[0], 32768,
-					   50000000, 75);
+					   50000000, rc_osc_startup_us);
 	if (IS_ERR(hw))
 		return;
 
@@ -371,9 +372,21 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 	if (child)
 		of_clk_add_hw_provider(child, of_clk_hw_simple_get, hw);
 }
+
+static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
+{
+	at91sam9x5_sckc_register(np, 75);
+}
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
 
+static void __init of_sama5d3_sckc_setup(struct device_node *np)
+{
+	at91sam9x5_sckc_register(np, 500);
+}
+CLK_OF_DECLARE(sama5d3_clk_sckc, "atmel,sama5d3-sckc",
+	       of_sama5d3_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
