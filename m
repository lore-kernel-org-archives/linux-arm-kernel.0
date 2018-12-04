Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6246C20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CTgnkQ5A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nORrykIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6246C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6YAoJvVKPf+5L1b9TeAS2xljI8YG39jBbyXxVIbarag=; b=CTgnkQ5AGBurc9
	LBVlSowQRB61VHy/bLqYLG0k1yr4lTMf57J7bD0lpA/DeImXDIYqbUpSUDONQiAw8elFFqMpMdKAK
	NhDeg1oR7tw+MnGHumYwZtFbR/toPWiH2TYu8gB0N73g/wDkYeqtpXn4CkUq+GCuE6NtBNzVJsZbu
	ACHDZYtrvasUW5Ra8ZblwJrnjiOda5FYeGmWw88euxW3VsFsEaY6UEOTTOMwEp4PH/pMoe6iu0HFL
	UFDnBPFz90idnfXXn78k/vhO4zzuIZJfPF9qJIJIuc4+KyjX4Ii36P2ICOXIYGJOxiUcDlzUTdjld
	nloXXdH7jMIQZsdCUhTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU702-0001Nl-Dg; Tue, 04 Dec 2018 09:28:14 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yu-00008W-Av
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:37 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648660004>; Tue, 04 Dec 2018 01:27:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:02 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:02 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:02 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648640000>; Tue, 04 Dec 2018 01:27:02 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 12/19] cpufreq: tegra124: extend to support Tegra210
Date: Tue, 4 Dec 2018 17:25:41 +0800
Message-ID: <20181204092548.3038-13-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915622; bh=PUqZqvwOmEG3dp1ozyzqvKGj8MSy9Znu2Zs9DfS61YA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=nORrykIbh3S1kzNHkMcqeOitwXoRZDCfzA4yWirWamhbCsAPLRYsByMcx54rdGDXi
 jTbjxzlth/rl09mM3kEUfRf8xVVf0rtMd7ed5mGuQ/2l8DULq1Ymf7jcFYldln1Ps3
 qvQjmM6gG6LufbjMpkGgpgVej9UkgpXrACH2WBHVf1G7zSrGgm9GDyMATE+RzyCXQQ
 2EyjZFIncLj4WVL9RYf40xSUrukz7OrQ5WduaGM08AKnpICIKAnvCi7T0ieqq6mtlJ
 4zsbzvzSIu6PbvO9pEBp7OvjkvUeDyggBesQR92Q2VPVTYVr+PHu3mMEOVGjdIPeMs
 SdhDZCROmygGg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012704_988946_EA64E2E9 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tegra210 uses the same methodology as Tegra124 for CPUFreq controlling
that based on DFLL clock. So extending this driver to support Tegra210.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 448d00763d00..1af955fb715c 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -159,7 +159,8 @@ static int __init tegra_cpufreq_init(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (!of_machine_is_compatible("nvidia,tegra124"))
+	if (!(of_machine_is_compatible("nvidia,tegra124") ||
+		of_machine_is_compatible("nvidia,tegra210")))
 		return -ENODEV;
 
 	/*
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
