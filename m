Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296F7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:20:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB5420882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNh/Q4ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB5420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/4Q2DWJeWjGemOi4Osd9jQSOOIB6H90t6JMmSdrIfg=; b=nNh/Q4uiZLO4c9
	poih0WM7izNHx48VvenbwkPNwF9EcndC4iY4OoWHxVu4pf0avj8F1nQXBKm1K5TdwQgY8KTGxivVY
	G6hpPKGhpSaC6dPFaplPLq1hNVlbVvWQA9UvCuYClA26g8WbddT3GqOuIH/W7qCAuuEjxLfuwvx8V
	t7YafOempAuPR4huOMd1P0hZ4SO40Gj/qz+yDaf+fFU9xe2vypSn+STZrAlEABJ9vvU2PT6fhMCV6
	WWs8UkbTqFy7oAktAQixNSivnGuxEin1uEnVGmpPPIAqnZHNq7D5FouN+Y3ltT/CcVujwis3ScQXC
	OCSBaTWEWE5yLsSelyjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom32-00082g-Ua; Wed, 30 Jan 2019 09:20:44 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom1E-000522-Vv; Wed, 30 Jan 2019 09:19:04 +0000
X-UUID: afb3de740947403eb8b95c0f789a3cf4-20190130
X-UUID: afb3de740947403eb8b95c0f789a3cf4-20190130
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <hsin-hsiung.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 711179075; Wed, 30 Jan 2019 01:18:35 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 01:18:33 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 17:18:24 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 30 Jan 2019 17:18:24 +0800
From: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/6] mfd: mt6397: extract irq related code from core driver
Date: Wed, 30 Jan 2019 17:18:06 +0800
Message-ID: <1548839891-20932-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 95E9344D4856C646A8B2382C26E892E4AA99CA82BCF19446D9E217118A1B1C6F2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011853_643549_42ED289E 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to support different types of irq design,
we decide to add separate irq drivers for different
design and keep mt6397 mfd core simple and reusable
to all generations of PMICs so far.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 drivers/mfd/Makefile            |   2 +-
 drivers/mfd/mt6397-core.c       | 235 +++++++---------------------------------
 drivers/mfd/mt6397-irq.c        | 214 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h |  12 ++
 4 files changed, 265 insertions(+), 198 deletions(-)
 create mode 100644 drivers/mfd/mt6397-irq.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4..088e249 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -230,7 +230,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
-obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
+obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o mt6397-irq.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 77b64bd..a72524d 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -12,23 +12,19 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/mfd/core.h>
-#include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6323/core.h>
-#include <linux/mfd/mt6397/registers.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6397/registers.h>
 
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e
 
-#define MT6323_CID_CODE		0x23
-#define MT6391_CID_CODE		0x91
-#define MT6397_CID_CODE		0x97
 
 static const struct resource mt6397_rtc_resources[] = {
 	{
@@ -94,188 +90,46 @@
 	}
 };
 
-static void mt6397_irq_lock(struct irq_data *data)
-{
-	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
-
-	mutex_lock(&mt6397->irqlock);
-}
-
-static void mt6397_irq_sync_unlock(struct irq_data *data)
-{
-	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
-
-	regmap_write(mt6397->regmap, mt6397->int_con[0],
-		     mt6397->irq_masks_cur[0]);
-	regmap_write(mt6397->regmap, mt6397->int_con[1],
-		     mt6397->irq_masks_cur[1]);
-
-	mutex_unlock(&mt6397->irqlock);
-}
-
-static void mt6397_irq_disable(struct irq_data *data)
-{
-	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
-	int shift = data->hwirq & 0xf;
-	int reg = data->hwirq >> 4;
-
-	mt6397->irq_masks_cur[reg] &= ~BIT(shift);
-}
-
-static void mt6397_irq_enable(struct irq_data *data)
-{
-	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
-	int shift = data->hwirq & 0xf;
-	int reg = data->hwirq >> 4;
-
-	mt6397->irq_masks_cur[reg] |= BIT(shift);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
-{
-	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
-	int shift = irq_data->hwirq & 0xf;
-	int reg = irq_data->hwirq >> 4;
-
-	if (on)
-		mt6397->wake_mask[reg] |= BIT(shift);
-	else
-		mt6397->wake_mask[reg] &= ~BIT(shift);
-
-	return 0;
-}
-#else
-#define mt6397_irq_set_wake NULL
-#endif
-
-static struct irq_chip mt6397_irq_chip = {
-	.name = "mt6397-irq",
-	.irq_bus_lock = mt6397_irq_lock,
-	.irq_bus_sync_unlock = mt6397_irq_sync_unlock,
-	.irq_enable = mt6397_irq_enable,
-	.irq_disable = mt6397_irq_disable,
-	.irq_set_wake = mt6397_irq_set_wake,
+struct chip_data {
+	u32 cid_addr;
 };
 
-static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
-		int irqbase)
-{
-	unsigned int status;
-	int i, irq, ret;
-
-	ret = regmap_read(mt6397->regmap, reg, &status);
-	if (ret) {
-		dev_err(mt6397->dev, "Failed to read irq status: %d\n", ret);
-		return;
-	}
-
-	for (i = 0; i < 16; i++) {
-		if (status & BIT(i)) {
-			irq = irq_find_mapping(mt6397->irq_domain, irqbase + i);
-			if (irq)
-				handle_nested_irq(irq);
-		}
-	}
-
-	regmap_write(mt6397->regmap, reg, status);
-}
-
-static irqreturn_t mt6397_irq_thread(int irq, void *data)
-{
-	struct mt6397_chip *mt6397 = data;
-
-	mt6397_irq_handle_reg(mt6397, mt6397->int_status[0], 0);
-	mt6397_irq_handle_reg(mt6397, mt6397->int_status[1], 16);
-
-	return IRQ_HANDLED;
-}
-
-static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
-					irq_hw_number_t hw)
-{
-	struct mt6397_chip *mt6397 = d->host_data;
-
-	irq_set_chip_data(irq, mt6397);
-	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
-	irq_set_nested_thread(irq, 1);
-	irq_set_noprobe(irq);
-
-	return 0;
-}
+static const struct chip_data mt6323_core = {
+	.cid_addr = MT6323_CID,
+};
 
-static const struct irq_domain_ops mt6397_irq_domain_ops = {
-	.map = mt6397_irq_domain_map,
+static const struct chip_data mt6397_core = {
+	.cid_addr = MT6397_CID,
 };
 
-static int mt6397_irq_init(struct mt6397_chip *mt6397)
+static int mt6397_probe(struct platform_device *pdev)
 {
 	int ret;
+	unsigned int id;
+	struct mt6397_chip *pmic;
+	struct regmap *regmap;
+	const struct chip_data *pmic_core;
 
-	mutex_init(&mt6397->irqlock);
-
-	/* Mask all interrupt sources */
-	regmap_write(mt6397->regmap, mt6397->int_con[0], 0x0);
-	regmap_write(mt6397->regmap, mt6397->int_con[1], 0x0);
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
 
-	mt6397->irq_domain = irq_domain_add_linear(mt6397->dev->of_node,
-		MT6397_IRQ_NR, &mt6397_irq_domain_ops, mt6397);
-	if (!mt6397->irq_domain) {
-		dev_err(mt6397->dev, "could not create irq domain\n");
-		return -ENOMEM;
-	}
+	pmic_core = of_device_get_match_data(&pdev->dev);
+	if (!pmic_core)
+		return -ENODEV;
 
-	ret = devm_request_threaded_irq(mt6397->dev, mt6397->irq, NULL,
-		mt6397_irq_thread, IRQF_ONESHOT, "mt6397-pmic", mt6397);
+	ret = regmap_read(regmap, pmic_core->cid_addr, &id);
 	if (ret) {
-		dev_err(mt6397->dev, "failed to register irq=%d; err: %d\n",
-			mt6397->irq, ret);
+		dev_err(&pdev->dev, "Failed to read chip id: %d\n", ret);
 		return ret;
 	}
 
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int mt6397_irq_suspend(struct device *dev)
-{
-	struct mt6397_chip *chip = dev_get_drvdata(dev);
-
-	regmap_write(chip->regmap, chip->int_con[0], chip->wake_mask[0]);
-	regmap_write(chip->regmap, chip->int_con[1], chip->wake_mask[1]);
-
-	enable_irq_wake(chip->irq);
-
-	return 0;
-}
-
-static int mt6397_irq_resume(struct device *dev)
-{
-	struct mt6397_chip *chip = dev_get_drvdata(dev);
-
-	regmap_write(chip->regmap, chip->int_con[0], chip->irq_masks_cur[0]);
-	regmap_write(chip->regmap, chip->int_con[1], chip->irq_masks_cur[1]);
-
-	disable_irq_wake(chip->irq);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
-			mt6397_irq_resume);
-
-static int mt6397_probe(struct platform_device *pdev)
-{
-	int ret;
-	unsigned int id;
-	struct mt6397_chip *pmic;
-
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
 		return -ENOMEM;
 
 	pmic->dev = &pdev->dev;
+	pmic->chip_id = id & 0xff;
 
 	/*
 	 * mt6397 MFD is child device of soc pmic wrapper.
@@ -287,26 +141,16 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmic);
 
-	ret = regmap_read(pmic->regmap, MT6397_CID, &id);
-	if (ret) {
-		dev_err(pmic->dev, "Failed to read chip id: %d\n", ret);
-		return ret;
-	}
-
 	pmic->irq = platform_get_irq(pdev, 0);
 	if (pmic->irq <= 0)
 		return pmic->irq;
 
-	switch (id & 0xff) {
-	case MT6323_CID_CODE:
-		pmic->int_con[0] = MT6323_INT_CON0;
-		pmic->int_con[1] = MT6323_INT_CON1;
-		pmic->int_status[0] = MT6323_INT_STATUS0;
-		pmic->int_status[1] = MT6323_INT_STATUS1;
-		ret = mt6397_irq_init(pmic);
-		if (ret)
-			return ret;
+	ret = mt6397_irq_init(pmic);
+	if (ret)
+		return ret;
 
+	switch (pmic->chip_id) {
+	case MT6323_CID_CODE:
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
 					   ARRAY_SIZE(mt6323_devs), NULL,
 					   0, pmic->irq_domain);
@@ -314,21 +158,13 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	case MT6397_CID_CODE:
 	case MT6391_CID_CODE:
-		pmic->int_con[0] = MT6397_INT_CON0;
-		pmic->int_con[1] = MT6397_INT_CON1;
-		pmic->int_status[0] = MT6397_INT_STATUS0;
-		pmic->int_status[1] = MT6397_INT_STATUS1;
-		ret = mt6397_irq_init(pmic);
-		if (ret)
-			return ret;
-
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
 					   ARRAY_SIZE(mt6397_devs), NULL,
 					   0, pmic->irq_domain);
 		break;
 
 	default:
-		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
+		dev_err(&pdev->dev, "unsupported chip: %d\n", pmic->chip_id);
 		ret = -ENODEV;
 		break;
 	}
@@ -342,9 +178,15 @@ static int mt6397_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt6397_of_match[] = {
-	{ .compatible = "mediatek,mt6397" },
-	{ .compatible = "mediatek,mt6323" },
-	{ }
+	{
+		.compatible = "mediatek,mt6323",
+		.data = &mt6323_core,
+	}, {
+		.compatible = "mediatek,mt6397",
+		.data = &mt6397_core,
+	}, {
+		/* sentinel */
+	}
 };
 MODULE_DEVICE_TABLE(of, mt6397_of_match);
 
@@ -359,7 +201,6 @@ static int mt6397_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "mt6397",
 		.of_match_table = of_match_ptr(mt6397_of_match),
-		.pm = &mt6397_pm_ops,
 	},
 	.id_table = mt6397_id,
 };
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
new file mode 100644
index 0000000..58a528f
--- /dev/null
+++ b/drivers/mfd/mt6397-irq.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2019 MediaTek Inc.
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/suspend.h>
+#include <linux/mfd/mt6323/core.h>
+#include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/registers.h>
+
+static void mt6397_irq_lock(struct irq_data *data)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&mt6397->irqlock);
+}
+
+static void mt6397_irq_sync_unlock(struct irq_data *data)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
+
+	regmap_write(mt6397->regmap, mt6397->int_con[0],
+		     mt6397->irq_masks_cur[0]);
+	regmap_write(mt6397->regmap, mt6397->int_con[1],
+		     mt6397->irq_masks_cur[1]);
+
+	mutex_unlock(&mt6397->irqlock);
+}
+
+static void mt6397_irq_disable(struct irq_data *data)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
+	int shift = data->hwirq & 0xf;
+	int reg = data->hwirq >> 4;
+
+	mt6397->irq_masks_cur[reg] &= ~BIT(shift);
+}
+
+static void mt6397_irq_enable(struct irq_data *data)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
+	int shift = data->hwirq & 0xf;
+	int reg = data->hwirq >> 4;
+
+	mt6397->irq_masks_cur[reg] |= BIT(shift);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
+	int shift = irq_data->hwirq & 0xf;
+	int reg = irq_data->hwirq >> 4;
+
+	if (on)
+		mt6397->wake_mask[reg] |= BIT(shift);
+	else
+		mt6397->wake_mask[reg] &= ~BIT(shift);
+
+	return 0;
+}
+#else
+#define mt6397_irq_set_wake NULL
+#endif
+
+static struct irq_chip mt6397_irq_chip = {
+	.name = "mt6397-irq",
+	.irq_bus_lock = mt6397_irq_lock,
+	.irq_bus_sync_unlock = mt6397_irq_sync_unlock,
+	.irq_enable = mt6397_irq_enable,
+	.irq_disable = mt6397_irq_disable,
+	.irq_set_wake = mt6397_irq_set_wake,
+};
+
+static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
+				  int irqbase)
+{
+	unsigned int status;
+	int i, irq, ret;
+
+	ret = regmap_read(mt6397->regmap, reg, &status);
+	if (ret) {
+		dev_err(mt6397->dev, "Failed to read irq status: %d\n", ret);
+		return;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (status & BIT(i)) {
+			irq = irq_find_mapping(mt6397->irq_domain, irqbase + i);
+			if (irq)
+				handle_nested_irq(irq);
+		}
+	}
+
+	regmap_write(mt6397->regmap, reg, status);
+}
+
+static irqreturn_t mt6397_irq_thread(int irq, void *data)
+{
+	struct mt6397_chip *mt6397 = data;
+
+	mt6397_irq_handle_reg(mt6397, mt6397->int_status[0], 0);
+	mt6397_irq_handle_reg(mt6397, mt6397->int_status[1], 16);
+
+	return IRQ_HANDLED;
+}
+
+static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hw)
+{
+	struct mt6397_chip *mt6397 = d->host_data;
+
+	irq_set_chip_data(irq, mt6397);
+	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
+	irq_set_nested_thread(irq, 1);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mt6397_irq_domain_ops = {
+	.map = mt6397_irq_domain_map,
+};
+
+static int mt6397_irq_pm_notifier(struct notifier_block *notifier,
+				  unsigned long pm_event, void *unused)
+{
+	struct mt6397_chip *chip =
+		container_of(notifier, struct mt6397_chip, pm_nb);
+
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+		regmap_write(chip->regmap,
+			     chip->int_con[0], chip->wake_mask[0]);
+		regmap_write(chip->regmap,
+			     chip->int_con[1], chip->wake_mask[1]);
+		enable_irq_wake(chip->irq);
+		break;
+
+	case PM_POST_SUSPEND:
+		regmap_write(chip->regmap,
+			     chip->int_con[0], chip->irq_masks_cur[0]);
+		regmap_write(chip->regmap,
+			     chip->int_con[1], chip->irq_masks_cur[1]);
+		disable_irq_wake(chip->irq);
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int mt6397_irq_init(struct mt6397_chip *chip)
+{
+	int ret;
+
+	mutex_init(&chip->irqlock);
+
+	switch (chip->chip_id) {
+	case MT6323_CID_CODE:
+		chip->int_con[0] = MT6323_INT_CON0;
+		chip->int_con[1] = MT6323_INT_CON1;
+		chip->int_status[0] = MT6323_INT_STATUS0;
+		chip->int_status[1] = MT6323_INT_STATUS1;
+		break;
+
+	case MT6391_CID_CODE:
+	case MT6397_CID_CODE:
+		chip->int_con[0] = MT6397_INT_CON0;
+		chip->int_con[1] = MT6397_INT_CON1;
+		chip->int_status[0] = MT6397_INT_STATUS0;
+		chip->int_status[1] = MT6397_INT_STATUS1;
+		break;
+
+	default:
+		dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);
+		return -ENODEV;
+	}
+
+	/* Mask all interrupt sources */
+	regmap_write(chip->regmap, chip->int_con[0], 0x0);
+	regmap_write(chip->regmap, chip->int_con[1], 0x0);
+
+	chip->pm_nb.notifier_call = mt6397_irq_pm_notifier;
+	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
+						 MT6397_IRQ_NR,
+						 &mt6397_irq_domain_ops,
+						 chip);
+	if (!chip->irq_domain) {
+		dev_err(chip->dev, "could not create irq domain\n");
+		return -ENOMEM;
+	}
+
+	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
+					mt6397_irq_thread, IRQF_ONESHOT,
+					"mt6397-pmic", chip);
+	if (ret) {
+		dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
+			chip->irq, ret);
+		return ret;
+	}
+
+	register_pm_notifier(&chip->pm_nb);
+	return 0;
+}
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index d678f52..ad27d19 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -15,6 +15,14 @@
 #ifndef __MFD_MT6397_CORE_H__
 #define __MFD_MT6397_CORE_H__
 
+#include <linux/notifier.h>
+
+enum chip_id {
+	MT6323_CID_CODE = 0x23,
+	MT6391_CID_CODE = 0x91,
+	MT6397_CID_CODE = 0x97,
+};
+
 enum mt6397_irq_numbers {
 	MT6397_IRQ_SPKL_AB = 0,
 	MT6397_IRQ_SPKR_AB,
@@ -54,6 +62,7 @@ enum mt6397_irq_numbers {
 struct mt6397_chip {
 	struct device *dev;
 	struct regmap *regmap;
+	struct notifier_block pm_nb;
 	int irq;
 	struct irq_domain *irq_domain;
 	struct mutex irqlock;
@@ -62,6 +71,9 @@ struct mt6397_chip {
 	u16 irq_masks_cache[2];
 	u16 int_con[2];
 	u16 int_status[2];
+	u16 chip_id;
 };
 
+int mt6397_irq_init(struct mt6397_chip *mt6397);
+
 #endif /* __MFD_MT6397_CORE_H__ */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
