Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2BC2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ddOmTyEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2BC2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c87tW1rjzxbxCBYwW4PSa+4JT9mz66fqvmhSQ/8OE+M=; b=ddOmTyECWDAErl
	fXwnobBWY+OSMZeiwjAJJkVT7maU+KJRSNnrK+xIymkbqrRDdiK56VHSaep3yiEQ7sIIA3uE+uSoK
	DlSQ9h6l4Hx3jeacR8oSXIQutx/SaHXb2FjCVUUAuM1Jz5gJNl1Pzz1d8zL2FJ77AIBfHWMrmmor1
	1qNGbVt3X32ctzHLVlvyA5FT3KrDKDze6EQWQXE/Y3T5Xe83Dp5vsM9FsbKSIvzSJGdAzc1FIfVve
	wPOX7Ml+1xmiV+tKhNpmfI0B3lDHleGU5gyhpI76JasAQ8ud3oTwVfqyWHs/Q+2kNqnHyFOXDuqtL
	kGgLznpHAuEAqMBi3fZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geBEz-0001WQ-Eh; Tue, 01 Jan 2019 04:01:17 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geBDH-00074X-Sc; Tue, 01 Jan 2019 04:00:12 +0000
X-UUID: d08f547e80cc472a81fb758585257a5d-20190101
X-UUID: d08f547e80cc472a81fb758585257a5d-20190101
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 354887650; Tue, 01 Jan 2019 11:59:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 11:59:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 11:59:19 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
Date: Tue, 1 Jan 2019 11:55:47 +0800
Message-ID: <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 669B88BA808DE7413468E1E6F9945B6BE44E630641023FC25E759CAB23F9531D2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_195933_222495_AC07DF48 
X-CRM114-Status: GOOD (  20.21  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch only move the clk_prepare_enable and config_port into the
runtime suspend/resume callback. It doesn't change the code content
and sequence.

This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
(SMI_BUS_SEL need to be restored after smi-common resume every time.)
Also it gives a chance to get rid of mtk_smi_larb_get/put which could
be a next topic.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a430721..9790801 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-static int mtk_smi_enable(const struct mtk_smi *smi)
+static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(smi->dev);
-	if (ret < 0)
-		return ret;
-
 	ret = clk_prepare_enable(smi->clk_apb);
 	if (ret)
-		goto err_put_pm;
+		return ret;
 
 	ret = clk_prepare_enable(smi->clk_smi);
 	if (ret)
@@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
-err_put_pm:
-	pm_runtime_put_sync(smi->dev);
 	return ret;
 }
 
-static void mtk_smi_disable(const struct mtk_smi *smi)
+static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 {
 	clk_disable_unprepare(smi->clk_gals1);
 	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
-	pm_runtime_put_sync(smi->dev);
 }
 
 int mtk_smi_larb_get(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-	int ret;
+	int ret = pm_runtime_get_sync(larbdev);
 
-	/* Enable the smi-common's power and clocks */
-	ret = mtk_smi_enable(common);
-	if (ret)
-		return ret;
-
-	/* Enable the larb's power and clocks */
-	ret = mtk_smi_enable(&larb->smi);
-	if (ret) {
-		mtk_smi_disable(common);
-		return ret;
-	}
-
-	/* Configure the iommu info for this larb */
-	larb_gen->config_port(larbdev);
-
-	return 0;
+	return (ret < 0) ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
 
 void mtk_smi_larb_put(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-
-	/*
-	 * Don't de-configure the iommu info for this larb since there may be
-	 * several modules in this larb.
-	 * The iommu info will be reset after power off.
-	 */
-
-	mtk_smi_disable(&larb->smi);
-	mtk_smi_disable(common);
+	pm_runtime_put_sync(larbdev);
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
@@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	int ret;
+
+	/* Power on smi-common. */
+	ret = pm_runtime_get_sync(larb->smi_common_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
+		return ret;
+	}
+
+	ret = mtk_smi_clk_enable(&larb->smi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+		pm_runtime_put_sync(larb->smi_common_dev);
+		return ret;
+	}
+
+	/* Configure the basic setting for this larb */
+	larb_gen->config_port(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(&larb->smi);
+	pm_runtime_put_sync(larb->smi_common_dev);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_larb_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
 	.remove	= mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
+		.pm             = &smi_larb_pm_ops,
 	}
 };
 
@@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_common_resume(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mtk_smi_clk_enable(common);
+	if (ret) {
+		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(common);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_common_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
 	.remove = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
+		.pm             = &smi_common_pm_ops,
 	}
 };
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
