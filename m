Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C209BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:37:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC6A20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BuooCP/f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f35sUKHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC6A20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VTtJjj5MuFtwn3ZaYfdUssqyOtH/4RigLFMg+FNIIo=; b=BuooCP/fI/UmHM
	b8TILAlTMhfcqbrGaVb06lae69Va/c1nOc3PCQ2qVN6GlNxnhD/hdbcMvUy7PehlS8ajEwGIIB/ZT
	NyexFwNFTvBpPSFdKcYLn+slB6tgeRiEvS5KKDngTxdNhPaILZof3PuO5Aqx0N/10/9vJFToxT8Rx
	yqS+EQdD5mwzjide5kJcGNzAahj8pCMX+md6n5f0YT4pibYwtQxdhk2BbgRabPswEvH2wY1ptalLe
	HDrJCibQkwMUcI+fCn0iAzXFKCWB1IJcyb5xnWnwRPmmhqGjCMBd254YOObmOjQQZXohMtPpjsKXk
	JtpyPUKaLyVMT0w010oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPdl-0005Af-ES; Fri, 01 Feb 2019 03:37:17 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPd6-0004Wl-GB
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:36:42 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53be9a0000>; Thu, 31 Jan 2019 19:35:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 19:36:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 19:36:35 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 03:36:35 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 03:36:35 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 03:36:35 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c53bec10000>; Thu, 31 Jan 2019 19:36:35 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: [PATCH V5 3/7] soc/tegra: default select TEGRA_TIMER for Tegra210
Date: Fri, 1 Feb 2019 11:36:17 +0800
Message-ID: <20190201033621.16814-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201033621.16814-1-josephl@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548992154; bh=rfKr9EUL2CgTAShMTwUd+t7fkfZnzmuoxS8xXiknlIQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=f35sUKHDxp42oyYQ3ltfin3TMQO8FgXbmvoX2cy+7W8QYh3lk0TjZJHByVfhytejN
 SHfHemecIPEb8bhbgdo+HgMbM2gMLEBHmX2xLkYjTOKsTYtW4k+9QLxBmuFYbuFdWY
 G86zRfB5s39HJ+HetbGpdnHI4wVKQJOdf3VD24SPERMmY9HnDFKxgbNL5O9WAIVUdf
 0RXycJrac8eMuRlgFIVhjdnn0Oh+Cpye192tcqYAJL52EJUIoSpj8LDWeRkjj1v05q
 +mLUeJYAXSUBe1mDQCwah5s2Htw1RIXDMKEsWLiS3GdetQbvs29ZaVzMQhCRLA4uIA
 RpQtwq4j2DTdQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_193637_085297_87D5FE7C 
X-CRM114-Status: UNSURE (   7.38  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The tegra timer is necessary for Tegra210 to support CPU idle power-down
state. So select it by default.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v5:
 * add ack tag from Thierry
v4:
 * new added in this version
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index fe4481676da6..a0b03443d8c1 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -76,6 +76,7 @@ config ARCH_TEGRA_210_SOC
 	select PINCTRL_TEGRA210
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select TEGRA_TIMER
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
 	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
