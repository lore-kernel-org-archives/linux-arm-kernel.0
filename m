Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DEDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEBE214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9QqIFdE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pl8LLHaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEBE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsodtjispAumxTL3YkskgPFMZbfEf34i82KqGR2dfLA=; b=X9QqIFdEZ88uNs
	WBtRqKTzc8Umj8uSXLRRv1M8KHrYY4/fzd2yTZXeFHPSTsdkPa60iONbbJIP3XISqSy8VeTbkFYY/
	s9C/385KLmMFjXraRk9w7EiqmMMHUrOGGYWtT/mnWiqet4hj2lrRe7it9j7kq7MXSi4PAHNxiK2GU
	/zSGOgdyxmJ2sCCHUGHgD8aC+E1ZWdaRvMeZiYFRxFJ7Yc+88mlrA3gRn7+f608V9rfFKCSLGBkaR
	hZRBm7HS/uF70A+akJr0hi9JpJ6kF/5ynsv4RruV1WKrctEQmXUcf/JWMyS7cIAMdlLrgsvRBJ2Iu
	/+Sexu0IntY/OJS9t72A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPiz-0000ZO-56; Tue, 29 Jan 2019 09:30:33 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPhB-0006Dd-A4
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:48 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501cad0000>; Tue, 29 Jan 2019 01:28:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:41 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:28:41 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:40 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:40 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cc70000>; Tue, 29 Jan 2019 01:28:40 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 6/6] arm64: dts: tegra210-smaug: Enable CPU idle support
Date: Tue, 29 Jan 2019 17:28:23 +0800
Message-ID: <20190129092823.24983-7-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092823.24983-1-josephl@nvidia.com>
References: <20190129092823.24983-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754093; bh=ucx/Wq2+RkSzazayCbx5zN62kLbbxsoDfjuHcGLWoGI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Pl8LLHaIH4tzJK8Ui7pcO6eCWeXPW7rw+WNPUewc7GsTBl9U5kM50XhiM0n+K23hY
 jK+ivYX8A2+5tFnLCy+2t6nisqLyjpcpssw8I9NGv1y0bv+WkP2DaCfVqe0PZylgS5
 a1a+jDONt+r72/a3fNYa+hTkEhiPgVkqY9urDZl9Mtp1hf5PE9gPoC8iqbvf46dP8D
 S5oD4BpRN6L3jjp3hxBrn8Svzd/A6agttEBXC3yOVfMjiQDuLcRhsnnp1sCPkcozg2
 WUfPOhlOK9iIlzVkJPHzXKvPM/jLMB4EBf88fvH5EoJd9BFpuTr7xbJLSNhaer1u7I
 0TWiw5x4ZiIhg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012842_291597_F82903E6 
X-CRM114-Status: UNSURE (   7.22  )
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

Enable CPU idle support for Smaug platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v3:
 * no change
v2:
 * no change
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 5a67890cfb7a..da0eb4530acf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1751,6 +1751,13 @@
 		cpu@3 {
 			enable-method = "psci";
 		};
+
+		idle-states {
+			c7 {
+				arm,psci-suspend-param = <0x00010007>;
+				status = "okay";
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
