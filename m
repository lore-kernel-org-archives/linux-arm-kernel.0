Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16962184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m3sbVXeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16962184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PfioyU8ux5BjH651oUSXj1JoEmLu7N03SHRPF/DD1VE=; b=m3sbVXePFIZ9yQ
	MV3hqGkOMmB8Tx3k/0oSE1PBwtXyCubkmpHkeYbLSCkKoUXwpSbFpEIXS1rPagr/4Ot0H2D1qDRjG
	+ti0B5WismqizpMGKIup3YZ2PLAYEbFbYD90HuvRP1gsoxMUahoKv5DrV9apB3WOsyCwTPptUJr+d
	ZAiXc94R8XXL1r37EGELoYCJsFBMpBgcg6LCRhze+L0lRtZHJ71qiH2k173ggOvWw8b0FHhL8+FWL
	BNsIPTYLLNWtXmmd+8wg8ECtMIYdAbYKXE8+4nbyOq2DwdNCgJET2QnRj4VBapJyWtQN5wzaDikoq
	5y3ucBOot8aH32E0fvQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDyT-000425-Mx; Wed, 06 Feb 2019 03:34:09 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxA-0002ns-54
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:51 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 969F65F92C; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on A80
Date: Wed,  6 Feb 2019 11:32:31 +0800
Message-Id: <20190206033239.3619-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193248_493066_A365C423 
X-CRM114-Status: GOOD (  17.32  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The A80 SoC has configuration registers for I/O bias voltage. Incorrect
settings would make the affected peripherals inoperable in some cases,
such as Ethernet RGMII signals biased at 2.5V with the settings still
at 3.3V. However low speed signals such as MDIO on the same group of
pins seem to be unaffected.

Previously there was no way to know what the actual voltage used was,
short of hard-coding a value in the device tree. With the new pin bank
regulator supply support in place, the driver can now query the
regulator for its voltage, and if it's valid (as opposed to being the
dummy regulator), set the bias voltage setting accordingly.

Add a quirk to denote the presence of the configuration registers, and
a function to set the correct setting based on the voltage read back
from the regulator.

This is only done when the regulator is first acquired and enabled.
While it would be nice to have a notifier on the regulator so that when
the voltage changes, the driver can update the setting, in practice no
board currently supports dynamic changing of the I/O voltages.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 41 +++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       | 12 ++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index c63086c98335..e05dd9a5551d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -153,6 +153,7 @@ static const struct sunxi_pinctrl_desc sun9i_a80_r_pinctrl_data = {
 	.pin_base = PL_BASE,
 	.irq_banks = 2,
 	.disable_strict_mode = true,
+	.has_io_bias_cfg = true,
 };
 
 static int sun9i_a80_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index 5553c0eb0f41..da37d594a13d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -722,6 +722,7 @@ static const struct sunxi_pinctrl_desc sun9i_a80_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun9i_a80_pins),
 	.irq_banks = 5,
 	.disable_strict_mode = true,
+	.has_io_bias_cfg = true,
 };
 
 static int sun9i_a80_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 0e7fa69e93df..8dd25caea2cf 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -603,6 +603,45 @@ static const struct pinconf_ops sunxi_pconf_ops = {
 	.pin_config_group_set	= sunxi_pconf_group_set,
 };
 
+static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
+					 unsigned pin,
+					 struct regulator *supply)
+{
+	u32 val, reg;
+	int uV;
+
+	if (!pctl->desc->has_io_bias_cfg)
+		return 0;
+
+	uV = regulator_get_voltage(supply);
+	if (uV < 0)
+		return uV;
+
+	/* Might be dummy regulator with no voltage set */
+	if (uV == 0)
+		return 0;
+
+	/* Configured value must be equal or greater to actual voltage */
+	if (uV <= 1800000)
+		val = 0x0; /* 1.8V */
+	else if (uV <= 2500000)
+		val = 0x6; /* 2.5V */
+	else if (uV <= 2800000)
+		val = 0x9; /* 2.8V */
+	else if (uV <= 3000000)
+		val = 0xA; /* 3.0V */
+	else
+		val = 0xD; /* 3.3V */
+
+	pin -= pctl->desc->pin_base;
+
+	reg = readl(pctl->membase + sunxi_grp_config_reg(pin));
+	reg &= ~IO_BIAS_MASK;
+	writel(reg | val, pctl->membase + sunxi_grp_config_reg(pin));
+
+	return 0;
+}
+
 static int sunxi_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
@@ -725,6 +764,8 @@ static int sunxi_pmx_request(struct pinctrl_dev *pctldev, unsigned offset)
 		goto out;
 	}
 
+	sunxi_pinctrl_set_io_bias_cfg(pctl, offset, reg);
+
 	s_reg->regulator = reg;
 	refcount_set(&s_reg->refcount, 1);
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 034c0317c8d6..ee15ab067b5f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -79,6 +79,10 @@
 #define IRQ_LEVEL_LOW		0x03
 #define IRQ_EDGE_BOTH		0x04
 
+#define GRP_CFG_REG		0x300
+
+#define IO_BIAS_MASK		GENMASK(3, 0)
+
 #define SUN4I_FUNC_INPUT	0
 #define SUN4I_FUNC_IRQ		6
 
@@ -113,6 +117,7 @@ struct sunxi_pinctrl_desc {
 	const unsigned int		*irq_bank_map;
 	bool				irq_read_needs_mux;
 	bool				disable_strict_mode;
+	bool				has_io_bias_cfg;
 };
 
 struct sunxi_pinctrl_function {
@@ -338,6 +343,13 @@ static inline u32 sunxi_irq_status_offset(u16 irq)
 	return irq_num * IRQ_STATUS_IRQ_BITS;
 }
 
+static inline u32 sunxi_grp_config_reg(u16 pin)
+{
+	u8 bank = pin / PINS_PER_BANK;
+
+	return GRP_CFG_REG + bank * 0x4;
+}
+
 int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 				    const struct sunxi_pinctrl_desc *desc,
 				    unsigned long variant);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
