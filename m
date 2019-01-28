Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD9C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:20:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268F02087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IA6ykzh8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N8NQn02I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268F02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=523ku7Zic/BecgKalhvmHqAsoy7upT4zUJIfQ4I9vqA=; b=IA6ykzh8ehYxrA
	l8CJh6p0Jjmb/6wdZ9XS9utd4tCnJX86R9ARkBUcogl5MUahh2t8TXoPJ9d9aOh8xegEV7jxhTECl
	YU72DagpIC6qZSnwNNPZCzd/iuqNb5GjjJPiwp3cbv9hVoll7RNO6Nkke8s1l1IEZHAHdmmjrayHi
	L+ck2jgliQiWYVkbKx0qVg5fPAIPhneMvKrv2du8+giRR2pwyLnVycHA+BbTRAFyDtedBu4OVNFPx
	YFJhaap8oMNb5FekPkxsVnhhQbSAlK6Yrym/u4DzyFs7FHf97DpCMpkvOHHq/M2drwYAHZUyxr/NO
	TzH85dDYSaDrkJcSJhig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go35K-0006oS-45; Mon, 28 Jan 2019 09:20:06 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go33p-0005bo-Sk
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:18:43 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4ec8ce0000>; Mon, 28 Jan 2019 01:18:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 28 Jan 2019 01:18:33 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 01:18:33 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 09:18:32 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 09:18:32 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Jan 2019 09:18:32 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c4ec8e70002>; Mon, 28 Jan 2019 01:18:32 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V2 4/6] arm64: dts: tegra210: add CPU idle states properties
Date: Mon, 28 Jan 2019 17:18:13 +0800
Message-ID: <20190128091815.7040-5-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128091815.7040-1-josephl@nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548667086; bh=TfJ1VyPIxIzF/UE5Xgka82poXzjaXbhFtL8pwS//EQE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=N8NQn02IvtRMYeS3MPcXOyJ0KllFiHZMgoOFQ4Z4R+yWx67PziabKL/Gw/UMvE0Zw
 gLWRBk8n/P/Ubrlcbf1YYxY5Gd2EhaY9GPb9wF0IMy+WL3ircNRlNvhQCC5UL5hzFk
 uUZE2sy/ZPzn+N9TLEJ4Nkz1F9LpCKRafFTYdodX926aXW5nlfSyERWZncGpcUVksc
 AP/RCInMXzMU0B/cegw7k0TuOxm9+bsPRfn6YTDVF19MYzDlziyYh/47blAUFwI/qM
 kd/iaQhsMcFX/Gc4KpvK5IfFdlpVrPGTMKCKqBVEcZJvLke6J++GvdGuvSprQALu0j
 qjdey2bcFLQIw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_011834_413595_8FAC630F 
X-CRM114-Status: UNSURE (   7.24  )
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

Add idle states properties for generic ARM CPU idle driver. This
includes a C7 state which is the power down state of CPU cores.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v2:
 * add entry-latency-us and exit-latency-us properties

Note:
This dt patch depends on the DT changes in below series.
http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2b387364afc3..75534692604c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1318,24 +1318,43 @@
 				 <&dfll>;
 			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 			clock-latency = <300000>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <1>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <2>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <3>;
+			cpu-idle-states = <&C7>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			C7: c7 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000007>;
+				entry-latency-us = <250>;
+				exit-latency-us = <100>;
+				min-residency-us = <1000>;
+				wakeup-latency-us = <130>;
+				idle-state-name = "c7-cpu-powergated";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
