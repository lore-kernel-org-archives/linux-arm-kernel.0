Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EED206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DdMk/FLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EED206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DhmF4LnMSbO9xKo6nhfH4l8ULuPdpDsh6MZ5fiznlyY=; b=DdMk/FLpVwFQRo
	S8aYU2uF8cP7OsttiMr3z74m9w3X14iT4jSYU693GahWRCNKwkNVuerLtmtTFmsAi4O75dqzjy8ms
	drwvJdZgaBDR3K50hY3HbXE6nBy9AKiku3ApstenyyxmlblIn6mi4NslZSDK0ogV5y9UuORgbnKg5
	U76JNu9EPweVl+WO5cVCqZYoEhuCmCS9XnFoNs7imrgQzAoinXs7aWoCYI+nlHUb4aR8E6dUl4Brr
	hDyk490sqVYfb4FteuQlEVhFX0eVRrpY0mCBSqQwxW8D9XOI5uLz1vLiWkr1FHWzFBDzYzo2oxMn6
	ML9+KZvREN+fborVXjaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gicWh-0006Vp-E9; Sun, 13 Jan 2019 09:57:55 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gicWU-0006JE-Rh
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 09:57:44 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 0073E5F861; Sun, 13 Jan 2019 17:57:36 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/2] pinctrl: sunxi: Consider pin_base when calculating
 regulator array index
Date: Sun, 13 Jan 2019 17:57:23 +0800
Message-Id: <20190113095723.25295-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113095723.25295-1-wens@csie.org>
References: <20190113095723.25295-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_015743_023054_22D1BEAA 
X-CRM114-Status: GOOD (  13.55  )
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

On most newer Allwinner SoCs, there are two pinctrl devices, the PIO and
R_PIO. PIO covers pin-banks PA to PI (PJ and PK have not been seen),
while R_PIO covers PL to PN. The regulator array only has space for 12
entries, which was designed to cover PA to PL. On the A80, the pin banks
go up to PN, which would be the 14th entry in the regulator array.
However since the driver only needs to track regulators for its own pin
banks, the array only needs to have 9 entries, and also take in to
account the value of pin_base, such that the regulator for the first
pin-bank of the pinctrl device, be it "PA" or "PL" uses the first entry
of the array.

Base the regulator array index on pin_base, such that "PA" for PIO and
"PL" for R_PIO both take the first element within their respective
device's regulator array.

Also decrease the size of the regulator array to 9, just enough to cover
"PA" to "PI".

Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:

  - Take in to account pin_base when handling regulator array index
    instead of enlarging the array to encompass PA - PN.
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 8 ++++++--
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 9ad6e9c2adab..0e7fa69e93df 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -698,7 +698,9 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned short bank = offset / PINS_PER_BANK;
-	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank];
+	unsigned short bank_offset = bank - pctl->desc->pin_base /
+					    PINS_PER_BANK;
+	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank_offset];
 	struct regulator *reg = s_reg->regulator;
 	char supply[16];
 	int ret;
@@ -738,7 +740,9 @@ static int sunxi_pmx_free(struct pinctrl_dev *pctldev, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned short bank = offset / PINS_PER_BANK;
-	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank];
+	unsigned short bank_offset = bank - pctl->desc->pin_base /
+					    PINS_PER_BANK;
+	struct sunxi_pinctrl_regulator *s_reg = &pctl->regulators[bank_offset];
 
 	if (!refcount_dec_and_test(&s_reg->refcount))
 		return 0;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index e340d2a24b44..034c0317c8d6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -136,7 +136,7 @@ struct sunxi_pinctrl {
 	struct gpio_chip		*chip;
 	const struct sunxi_pinctrl_desc	*desc;
 	struct device			*dev;
-	struct sunxi_pinctrl_regulator	regulators[12];
+	struct sunxi_pinctrl_regulator	regulators[9];
 	struct irq_domain		*domain;
 	struct sunxi_pinctrl_function	*functions;
 	unsigned			nfunctions;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
