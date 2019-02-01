Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADEC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0A320B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+Ybe5Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0A320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MvJkE8S9rQ5dJ8tbRdQXlh9oDfPwdIHmW3Wd6tNX3A=; b=C+Ybe5ZiDU3L2U
	iXQwBbjLJ3bqKkqMx/ntWJV1qmeZmtQsZYUhXJpamSWsXCz1D4hAyy4FZfnlLnGz58qQgMs0LeL25
	2MRVAHoO8U2n/kHBmtupWYitH3jTabSJcm7w5tI+twrLFlNy6CwWJ4jpRadpoza8jQ9vcAcvuEYP/
	43QOp4gj7w94jQcZUZA9PfTlKrxbOloo8Lkf9dnfbbMRu6ndNzps2trYyBX7IDOln9MYa+VYzsnbO
	hGPa6Y0QlrTeVu/HZ3Y9YJfN1ya2eb/kKcpU9d9oWFjydQU5DglV3VbYktjop1FB/2w5qD/DL7uJb
	KschjuMFOLpd61ZHyKqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTPE-0005Rs-7I; Fri, 01 Feb 2019 07:38:32 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTP8-0005Nk-JP; Fri, 01 Feb 2019 07:38:28 +0000
X-UUID: 95ca6b377f694542a1e0a9794e0a8e7c-20190131
X-UUID: 95ca6b377f694542a1e0a9794e0a8e7c-20190131
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2023442866; Thu, 31 Jan 2019 23:38:19 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 23:38:17 -0800
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
Subject: [PATCH 1/7] thermal: mediatek: fix register index error
Date: Fri, 1 Feb 2019 15:38:07 +0800
Message-ID: <1549006693-11659-2-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3D1BE058A890CEF57825F23700AE1479721020C6CFD79D515C8126FA6F2F4F9E2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_233826_640826_7956E590 
X-CRM114-Status: GOOD (  10.17  )
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

The index of msr and adcpnp should match the sensor
which belongs to the selected bank in the for loop.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0691f26..f646436 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -431,7 +431,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	u32 raw;
 
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
+		raw = readl(mt->thermal_base +
+			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
 
 		temp = raw_to_mcelsius(mt,
 				       conf->bank_data[bank->id].sensors[i],
@@ -568,7 +569,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
 		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
-		       mt->thermal_base + conf->adcpnp[i]);
+		       mt->thermal_base +
+		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
 
 	writel((1 << conf->bank_data[num].num_sensors) - 1,
 	       mt->thermal_base + TEMP_MONCTL0);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
