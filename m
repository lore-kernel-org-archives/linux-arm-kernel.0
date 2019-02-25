Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AB820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mTZNidq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AB820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sC6kjPl6EiObWr1vkA7suegpyG9Sh94Fd5kVmgPkPhc=; b=mTZNidq7eb+X5M
	lo1Xk64L4RX8Fe/h2+5HPzGW9iGiGRPnFIdy140rpZ4wATR+q7P2r/CsjYzRPpW2hE5JhxlVkfu9N
	SN441hzAg6RG0bQc7uuKQZ+4Zdq8QzewlNjcuQNq+G8rw2mI9kgaH6nQ0wHZ0akKNl7ysH4mSIlR5
	/Sb+nj2dYSMY6iMjRd71v9I4aA3wXBZKvqR+eRrMf3RzJ0wfgwwUzJeHfHmQ1IZW255Cg2dIyo3+j
	mNnPg27RmBT7Z9jiuHIL5qgwb/e6bGOW4Fqzhcq8dPF8Ik7fXjcp5AmqQKt8PqkSitbvgn4xIZxQT
	WXGzHvZrhgv7c4/X0kJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyK35-0001Ia-6t; Mon, 25 Feb 2019 17:28:15 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyK31-0001CD-8T
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:28:13 +0000
Received: from localhost (alyon-652-1-170-85.w109-212.abo.wanadoo.fr
 [109.212.201.85])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 785A1240002;
 Mon, 25 Feb 2019 17:27:58 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: at91: fix programmable clock for sama5d2
Date: Mon, 25 Feb 2019 18:27:50 +0100
Message-Id: <20190225172750.25816-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_092811_752337_7A4DFE75 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Matthias Wieloch <matthias.wieloch@few-bauer.de>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Matthias Wieloch <matthias.wieloch@few-bauer.de>

The prescaler formula of the programmable clock has changed for sama5d2. Update
the driver accordingly. A new compatibility string is needed for this driver,
now.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[nicolas.ferre@microchip.com: adapt the prescaler range,
		fix clk_programmable_recalc_rate, split patch]
Signed-off-by: Matthias Wieloch <matthias.wieloch@few-bauer.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-programmable.c | 57 ++++++++++++++++++++++-------
 drivers/clk/at91/pmc.h              |  2 +
 drivers/clk/at91/sama5d2.c          | 10 ++++-
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 5bc68b9c5498..c3174a6bbd48 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -20,8 +20,7 @@
 #define PROG_ID_MAX		7
 
 #define PROG_STATUS_MASK(id)	(1 << ((id) + 8))
-#define PROG_PRES_MASK		0x7
-#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & PROG_PRES_MASK)
+#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & layout->pres_mask)
 #define PROG_MAX_RM9200_CSS	3
 
 struct clk_programmable {
@@ -37,20 +36,29 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
 	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	unsigned int pckr;
+	unsigned long rate;
 
 	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
 
-	return parent_rate >> PROG_PRES(prog->layout, pckr);
+	if (layout->is_pres_direct)
+		rate = parent_rate / (PROG_PRES(layout, pckr) + 1);
+	else
+		rate = parent_rate >> PROG_PRES(layout, pckr);
+
+	return rate;
 }
 
 static int clk_programmable_determine_rate(struct clk_hw *hw,
 					   struct clk_rate_request *req)
 {
+	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	struct clk_hw *parent;
 	long best_rate = -EINVAL;
 	unsigned long parent_rate;
-	unsigned long tmp_rate;
+	unsigned long tmp_rate = 0;
 	int shift;
 	int i;
 
@@ -60,10 +68,18 @@ static int clk_programmable_determine_rate(struct clk_hw *hw,
 			continue;
 
 		parent_rate = clk_hw_get_rate(parent);
-		for (shift = 0; shift < PROG_PRES_MASK; shift++) {
-			tmp_rate = parent_rate >> shift;
-			if (tmp_rate <= req->rate)
-				break;
+		if (layout->is_pres_direct) {
+			for (shift = 0; shift <= layout->pres_mask; shift++) {
+				tmp_rate = parent_rate / (shift + 1);
+				if (tmp_rate <= req->rate)
+					break;
+			}
+		} else {
+			for (shift = 0; shift < layout->pres_mask; shift++) {
+				tmp_rate = parent_rate >> shift;
+				if (tmp_rate <= req->rate)
+					break;
+			}
 		}
 
 		if (tmp_rate > req->rate)
@@ -140,16 +156,23 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!div)
 		return -EINVAL;
 
-	shift = fls(div) - 1;
+	if (layout->is_pres_direct) {
+		shift = div - 1;
 
-	if (div != (1 << shift))
-		return -EINVAL;
+		if (shift > layout->pres_mask)
+			return -EINVAL;
+	} else {
+		shift = fls(div) - 1;
 
-	if (shift >= PROG_PRES_MASK)
-		return -EINVAL;
+		if (div != (1 << shift))
+			return -EINVAL;
+
+		if (shift >= layout->pres_mask)
+			return -EINVAL;
+	}
 
 	regmap_update_bits(prog->regmap, AT91_PMC_PCKR(prog->id),
-			   PROG_PRES_MASK << layout->pres_shift,
+			   layout->pres_mask << layout->pres_shift,
 			   shift << layout->pres_shift);
 
 	return 0;
@@ -205,19 +228,25 @@ at91_clk_register_programmable(struct regmap *regmap,
 }
 
 const struct clk_programmable_layout at91rm9200_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9g45_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 1,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9x5_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 4,
 	.css_mask = 0x7,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 672a79bda88c..a0e5ce9c9b9e 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -71,9 +71,11 @@ struct clk_pll_characteristics {
 };
 
 struct clk_programmable_layout {
+	u8 pres_mask;
 	u8 pres_shift;
 	u8 css_mask;
 	u8 have_slck_mck;
+	u8 is_pres_direct;
 };
 
 extern const struct clk_programmable_layout at91rm9200_programmable_layout;
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index d69ad96fe988..31d6226b297a 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -125,6 +125,14 @@ static const struct {
 	  .pll = true },
 };
 
+static const struct clk_programmable_layout sama5d2_programmable_layout = {
+	.pres_mask = 0xff,
+	.pres_shift = 4,
+	.css_mask = 0x7,
+	.have_slck_mck = 0,
+	.is_pres_direct = 1,
+};
+
 static void __init sama5d2_pmc_setup(struct device_node *np)
 {
 	struct clk_range range = CLK_RANGE(0, 0);
@@ -248,7 +256,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 5, i,
-						    &at91sam9x5_programmable_layout);
+						    &sama5d2_programmable_layout);
 		if (IS_ERR(hw))
 			goto err_free;
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
