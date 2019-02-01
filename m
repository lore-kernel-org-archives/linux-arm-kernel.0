Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8AC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DA8204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PfN8mtLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DA8204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N2Ojz6MsLqClf4jbNx+VLVM6bWNZ81Y2pbEWLvyCqqI=; b=PfN8mtLGm6HhOm
	cH9JpKTPEXTfnPKD/g45xfrle0UAriQm+mwkBdaQPar7qQX9NqI4m56TsC4DGwXvOyR+Iq/WQI2/Z
	2HxDY0WKb8KN1959IxZWFpKHvtY2VMaDTGhHR4395AO6lrezGZb6AgwMbIDfyEAVFLHK1Do/ZjBse
	deCYwOwKNc4tIiQ5MwXfkK8u0iuX0dY694SpbB0z00o7ZP8w9uJBduVwl2EPwPoMXzeaSRdwznIjQ
	MPE7xWh3LXl/blLc9/Byub+O2IVBiPkYb35efRNnldVhuCQ9oIXMvik5gDMfQIBVv5Rt6s4lf3XVT
	pcEJFBRlA75naihvrCCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTPR-0005gW-Ih; Fri, 01 Feb 2019 07:38:45 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTP8-0005ON-Ny; Fri, 01 Feb 2019 07:38:28 +0000
X-UUID: 860bcba33d984ae5a534a0428e03e5ba-20190131
X-UUID: 860bcba33d984ae5a534a0428e03e5ba-20190131
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1254194421; Thu, 31 Jan 2019 23:38:20 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 23:38:19 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 15:38:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 15:38:15 +0800
From: <michael.kao@mediatek.com>
To: =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, 
 =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring
 <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>, =Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: [PATCH 5/7] thermal: mediatek: add flag for bank selection
Date: Fri, 1 Feb 2019 15:38:11 +0800
Message-ID: <1549006693-11659-6-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 027EB64FBB3869FDCF181AFF62097238AF185DCA77FCC315B65135C61F187A8B2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_233826_803227_F267E023 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Kao <michael.kao@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michael Kao <michael.kao@mediatek.com>

For past ic designs, the thermal controller should select banks before
reading the thermal sensor.
And the new ic design architecture removes this mechanism.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e5cf3f4..3e97638 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -213,6 +213,7 @@ struct mtk_thermal_data {
 	const int cali_val;
 	const int num_controller;
 	const int *controller_offset;
+	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[];
 };
 
@@ -327,6 +328,7 @@ struct mtk_thermal {
 	.cali_val = MT8173_CALIBRATION,
 	.num_controller = MT8173_NUM_CONTROLLER,
 	.controller_offset = mt8173_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -365,6 +367,7 @@ struct mtk_thermal {
 	.cali_val = MT2701_CALIBRATION,
 	.num_controller = MT2701_NUM_CONTROLLER,
 	.controller_offset = mt2701_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -394,6 +397,7 @@ struct mtk_thermal {
 	.cali_val = MT2712_CALIBRATION,
 	.num_controller = MT2712_NUM_CONTROLLER,
 	.controller_offset = mt2712_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -417,6 +421,7 @@ struct mtk_thermal {
 	.cali_val = MT7622_CALIBRATION,
 	.num_controller = MT7622_NUM_CONTROLLER,
 	.controller_offset = mt7622_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -463,12 +468,14 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
 	struct mtk_thermal *mt = bank->mt;
 	u32 val;
 
-	mutex_lock(&mt->lock);
+	if (mt->conf->need_switch_bank) {
+		mutex_lock(&mt->lock);
 
-	val = readl(mt->thermal_base + PTPCORESEL);
-	val &= ~0xf;
-	val |= bank->id;
-	writel(val, mt->thermal_base + PTPCORESEL);
+		val = readl(mt->thermal_base + PTPCORESEL);
+		val &= ~0xf;
+		val |= bank->id;
+		writel(val, mt->thermal_base + PTPCORESEL);
+	}
 }
 
 /**
@@ -481,7 +488,8 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
 
-	mutex_unlock(&mt->lock);
+	if (mt->conf->need_switch_bank)
+		mutex_unlock(&mt->lock);
 }
 
 /**
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
