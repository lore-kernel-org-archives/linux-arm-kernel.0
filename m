Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5A22084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WUJk+vMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5A22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eZt8Z0S+hJHt/H6FgbFauEUfQM+Btopc9A3moTKGeMg=; b=WUJk+vMmOxvKea
	nhqQM/L5DtfruCbn+wVeObfzF8UPax2mTEp2Hke//l1y0LvxAG5gpgY4crGi6IaSKPkEnwv2GlBwA
	du1+mCWv3/yhBbcNpfvHHmgABkDyQQ12HAvK/R5Mx89XGFd9YSXV/DNnXoZ4aaLrmDk8t2iTLM/IP
	DP0Y/nC6EyDIKk2sdhyagCSnEllNztIY4Bt1Y/fBqXrTlshMTT7N571E9dzWcsJtVZHmgagziEMkC
	fuhYffvgBlJSDS9ZwZEvZOnqhZiWGofRmUAewe4wh61ofWKs9rtWvTuFF2uXNdnmIGh5lUt5TLPsZ
	x6Z7/JlORE9FXagnZOuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gicWW-0006Jx-TY; Sun, 13 Jan 2019 09:57:44 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gicWT-0006JF-PK
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 09:57:43 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id E6D645FD20; Sun, 13 Jan 2019 17:57:36 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] pinctrl: sunxi: Fix and simplify pin bank regulator
 handling
Date: Sun, 13 Jan 2019 17:57:22 +0800
Message-Id: <20190113095723.25295-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_015741_949115_044230FD 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The new per-pin-bank regulator handling code in the sunxi pinctrl driver
has mismatched conditions for enabling and disabling the regulator: it
is enabled each time a pin is requested, but only disabled when the
pin-bank's reference count reaches zero.

Since we are doing reference counting already, there's no need to enable
the regulator each time a pin is requested. Instead we can just do it
for the first requested pin of each pin-bank. Thus we can reverse the
test and bail out early if it's not the first occurrence.

Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:

  - Moved before the other fix. Both fixes are needed, but having this
    one first made reworking the other one easier.

---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 36 ++++++++++++---------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 5d9184d18c16..9ad6e9c2adab 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -699,25 +699,21 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned short bank = offset / PINS_PER_BANK;
 	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank];
-	struct regulator *reg;
+	struct regulator *reg = s_reg->regulator;
+	char supply[16];
 	int ret;
 
-	reg = s_reg->regulator;
-	if (!reg) {
-		char supply[16];
-
-		snprintf(supply, sizeof(supply), "vcc-p%c", 'a' + bank);
-		reg = regulator_get(pctl->dev, supply);
-		if (IS_ERR(reg)) {
-			dev_err(pctl->dev, "Couldn't get bank P%c regulator\n",
-				'A' + bank);
-			return PTR_ERR(reg);
-		}
-
-		s_reg->regulator = reg;
-		refcount_set(&s_reg->refcount, 1);
-	} else {
+	if (reg) {
 		refcount_inc(&s_reg->refcount);
+		return 0;
+	}
+
+	snprintf(supply, sizeof(supply), "vcc-p%c", 'a' + bank);
+	reg = regulator_get(pctl->dev, supply);
+	if (IS_ERR(reg)) {
+		dev_err(pctl->dev, "Couldn't get bank P%c regulator\n",
+			'A' + bank);
+		return PTR_ERR(reg);
 	}
 
 	ret = regulator_enable(reg);
@@ -727,13 +723,13 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 		goto out;
 	}
 
+	s_reg->regulator = reg;
+	refcount_set(&s_reg->refcount, 1);
+
 	return 0;
 
 out:
-	if (refcount_dec_and_test(&s_reg->refcount)) {
-		regulator_put(s_reg->regulator);
-		s_reg->regulator = NULL;
-	}
+	regulator_put(s_reg->regulator);
 
 	return ret;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
