Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80318C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7C7214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpH0oi6R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hk0+metL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7C7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RQj5PeEoWajJ9usDsvXRtkRuyJduKulSkDF5p16bJNc=; b=TpH0oi6Rx7RMTe
	biR5puQOnwir6/Z3aaR+B9vSCWF3n5MBrl9gAp7GEUo+C5vfQz7d6KquRxFc7u50EMIJtdhZ2++CB
	YZkTyD68qlBwjA+dVqfOIozVIWyRErXCWBwtV+7JxtlIqdJfAo6chBGYelyJxl1bhPbFoQtrP6NSP
	rxKmTkJ1a965/2xbFNpBTciYV5JEVR97taulhOjnvGRjq1vnHO/8jZlvcime1egwS5mS4OMXpnlW9
	UCk8OOwu7vLN6lzU9ov1lcuJAc+HOTL0fe4HFUu8nFp9pTM+r2A0BLQO+UlbhqZX/tHuKIvdH7P8D
	JBZzMvvsTVz67/8zGwLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPhq-0006gB-QU; Tue, 29 Jan 2019 09:29:22 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPh4-00066q-KD
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:38 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501ca70000>; Tue, 29 Jan 2019 01:28:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:34 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 01:28:34 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:34 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:33 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cc00002>; Tue, 29 Jan 2019 01:28:33 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 3/6] arm64: dts: tegra210: fix timer node
Date: Tue, 29 Jan 2019 17:28:20 +0800
Message-ID: <20190129092823.24983-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092823.24983-1-josephl@nvidia.com>
References: <20190129092823.24983-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754087; bh=rMAiDCtuKFvurls0E9sakhrSvI9VMFGiBokai4pMOUU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=hk0+metL6BrVh4H39Q3dsm9iWAfJgfJvEFQvvgN4Q7sFdhdf6abPujLjzWvVPZpqO
 8G7gLWhFCjcEnFamvGQ2PZD8fP10cz5+CmuFM6nGP3IMQBDM2nKsxgLLMqOQi6M0C4
 e+/r2DcolaCNoZT+GIdYvB1SZGGBNWUVCLdFM7uy1AMnVBRcOxxCbYAcCET+fiAv3P
 g1GfEemiMtUS1GXa6a1MScho1KoIGThF+l/azjeiK1bER9FNKq1r62jiVeY7VxL1h8
 sOHue2BYGyhXDfnXlNG0pbl8HQNVQsHUrRZIcb4nSfRiAagAPXL+BLq5xidvgrwN2i
 HcC1FMpWmzybg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012834_987077_BD6FBE32 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix timer node to make it work with Tegra210 timer driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v3:
 * no change
v2:
 * list all the IRQs per each timer channels 0 through 13
 * remove compatible string of "nvidia,tegra30-timer"
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index b5858b5ea052..2b387364afc3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -384,14 +384,22 @@
 	};
 
 	timer@60005000 {
-		compatible = "nvidia,tegra210-timer", "nvidia,tegra20-timer";
+		compatible = "nvidia,tegra210-timer";
 		reg = <0x0 0x60005000 0x0 0x400>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_TIMER>;
 		clock-names = "timer";
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
