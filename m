Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1EC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB9E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uM2CqZHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB9E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Em47n4rMl2XS1EO52Wib9n+JQPXS3JakuCpG+Gq18C0=; b=uM2CqZHPvn93fq
	NjHMDZfcga6RdS5JU2Nc6A9cOjL6DCK3KD8C97xdiMY0UK78t1NOSqgE3YT46L7AHalEB931/fndk
	43X1MXY+7zFRAhRI27EiWRcBWPJoNoi+5sT6qkyRjgMh58mtzwKtCh+0WthV9D0A9UPmrOrY74BXI
	aL2jYJSXxkXRPBGs4/vLsiKSZiZgOH2ReRm092gjurENbesj3P1CkufjP+3cXjco//PJPuWDrttlW
	K+AeDXhWUVbM6N3lGdZYT70xHviGaNF/jGp/cj4C+8UlcbmJJjTs/Fy1b+Nms6c1nGP8F6YOO0eMp
	ubH6EaLp8l444NA0pNIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggrmz-0007rd-F2; Tue, 08 Jan 2019 13:51:29 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggrmg-0007Z8-J9; Tue, 08 Jan 2019 13:51:12 +0000
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 8 Jan 2019
 21:51:32 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Subject: [PATCH v9 1/4] clk: meson: add one based divider support for sclk
 divider
Date: Tue, 8 Jan 2019 21:50:41 +0800
Message-ID: <1546955444-7549-2-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.18.11.217]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_055110_631511_74939015 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
one based divider (div = val), and zero value gates the clock

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/Makefile     |  3 ++-
 drivers/clk/meson/clkc-audio.h |  8 ------
 drivers/clk/meson/clkc.h       | 10 ++++++-
 drivers/clk/meson/sclk-div.c   | 59 ++++++++++++++++++++++++++++--------------
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index a849aa8..acd8694 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,7 +4,8 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += sclk-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) += clk-triphase.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 0a7c157..286ff12 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -15,14 +15,6 @@ struct meson_clk_triphase_data {
 	struct parm ph2;
 };
 
-struct meson_sclk_div_data {
-	struct parm div;
-	struct parm hi;
-	unsigned int cached_div;
-	struct clk_duty cached_duty;
-};
-
 extern const struct clk_ops meson_clk_triphase_ops;
-extern const struct clk_ops meson_sclk_div_ops;
 
 #endif /* __MESON_CLKC_AUDIO_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6183b22..00b3320 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -27,6 +27,14 @@ struct parm {
 	u8	width;
 };
 
+struct meson_sclk_div_data {
+	struct parm div;
+	struct parm hi;
+	unsigned int cached_div;
+	struct clk_duty cached_duty;
+	u8 flags;
+};
+
 static inline unsigned int meson_parm_read(struct regmap *map, struct parm *p)
 {
 	unsigned int val;
@@ -118,10 +126,10 @@ struct clk_regmap _name = {						\
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
+extern const struct clk_ops meson_sclk_div_ops;
 
 struct clk_hw *meson_clk_hw_register_input(struct device *dev,
 					   const char *of_name,
 					   const char *clk_name,
 					   unsigned long flags);
-
 #endif /* __CLKC_H */
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index bc64019..a6c425b 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -4,42 +4,60 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  *
  * Sample clock generator divider:
- * This HW divider gates with value 0 but is otherwise a zero based divider:
+ * This HW divider gates with value 0
  *
  * val >= 1
- * divider = val + 1
+ * divider = val + 1 if ONE_BASED is not set, otherwise divider = val.
  *
  * The duty cycle may also be set for the LR clock variant. The duty cycle
  * ratio is:
  *
  * hi = [0 - val]
- * duty_cycle = (1 + hi) / (1 + val)
+ * duty_cycle = (1 + hi) / (1 + val) if ONE_BASED is not set, otherwise:
+ * duty_cycle = hi / (1 + val)
  */
 
-#include "clkc-audio.h"
+#include "clkc.h"
 
-static inline struct meson_sclk_div_data *
-meson_sclk_div_data(struct clk_regmap *clk)
+static inline int get_reg(int val, unsigned char flag)
 {
-	return (struct meson_sclk_div_data *)clk->data;
+	WARN_ON(val < 1);
+	if ((flag & CLK_DIVIDER_ONE_BASED) || !val)
+		return val;
+	else
+		return val - 1;
+}
+
+static inline int get_value(int reg, unsigned char flag)
+{
+	if (flag & CLK_DIVIDER_ONE_BASED)
+		return reg;
+	else
+		return reg + 1;
 }
 
-static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
+static inline struct meson_sclk_div_data *
+meson_sclk_div_data(struct clk_regmap *clk)
 {
-	return (1 << sclk->div.width) - 1;
+	return (struct meson_sclk_div_data *)clk->data;
 }
 
 static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
 {
-	return sclk_div_maxval(sclk) + 1;
+	unsigned int reg = clk_div_mask(sclk->div.width);
+
+	return get_value(reg, sclk->flags);
 }
 
 static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
 			   unsigned long prate, int maxdiv)
 {
 	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	int mindiv = get_value(1, sclk->flags);
 
-	return clamp(div, 2, maxdiv);
+	return clamp(div, mindiv, maxdiv);
 }
 
 static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
@@ -47,7 +65,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 			    struct meson_sclk_div_data *sclk)
 {
 	struct clk_hw *parent = clk_hw_get_parent(hw);
-	int bestdiv = 0, i;
+	int bestdiv = 0, i, mindiv;
 	unsigned long maxdiv, now, parent_now;
 	unsigned long best = 0, best_parent = 0;
 
@@ -64,8 +82,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 	 * unsigned long in rate * i below
 	 */
 	maxdiv = min(ULONG_MAX / rate, maxdiv);
+	mindiv = get_value(1, sclk->flags);
 
-	for (i = 2; i <= maxdiv; i++) {
+	for (i = mindiv; i <= maxdiv; i++) {
 		/*
 		 * It's the most ideal case if the requested rate can be
 		 * divided from parent clock without needing to change
@@ -111,10 +130,7 @@ static void sclk_apply_ratio(struct clk_regmap *clk,
 					    sclk->cached_duty.num,
 					    sclk->cached_duty.den);
 
-	if (hi)
-		hi -= 1;
-
-	meson_parm_write(clk->map, &sclk->hi, hi);
+	meson_parm_write(clk->map, &sclk->hi, get_reg(hi, sclk->flags));
 }
 
 static int sclk_div_set_duty_cycle(struct clk_hw *hw,
@@ -145,7 +161,7 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
 	}
 
 	hi = meson_parm_read(clk->map, &sclk->hi);
-	duty->num = hi + 1;
+	duty->num = get_value(hi, sclk->flags);
 	duty->den = sclk->cached_div;
 	return 0;
 }
@@ -153,10 +169,13 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
 static void sclk_apply_divider(struct clk_regmap *clk,
 			       struct meson_sclk_div_data *sclk)
 {
+	unsigned int div;
+
 	if (MESON_PARM_APPLICABLE(&sclk->hi))
 		sclk_apply_ratio(clk, sclk);
 
-	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
+	div = get_reg(sclk->cached_div, sclk->flags);
+	meson_parm_write(clk->map, &sclk->div, div);
 }
 
 static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -224,7 +243,7 @@ static void sclk_div_init(struct clk_hw *hw)
 	if (!val)
 		sclk->cached_div = sclk_div_maxdiv(sclk);
 	else
-		sclk->cached_div = val + 1;
+		sclk->cached_div = get_value(val, sclk->flags);
 
 	sclk_div_get_duty_cycle(hw, &sclk->cached_duty);
 }
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
