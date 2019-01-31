Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FEC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A08B20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4mxG9F2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ex9j43a3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A08B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JeR/4WefLKMPB+8xW50euwdU04EpCatkmKcTd9pHoq8=; b=i4mxG9F2/sQUeS
	AWXQcvOB+zJqBkMKkcWdberTAYwZZvxU2sTZAA6fuqBpozIVdt2SDVpkV38ZgkgfsJKtjUDnfmlo9
	EpVsB6Z7YLWHoSjSKOrMLpjmWkVOf+iuUhAqGPDSHASnm2dtTc34Bt/6CEn5ddJxX8r0rGGoOUyhW
	MMOF8urnXW4V6/lOiGUczx0WfzE71ivDIDNhpzZbIgjvYCeKjzmPRzLxg9HJValfkvzaNO3Syd9q9
	6W4HbaRt2JdqhASkebnagzI6wvmhBjTIbnx5lhEgcfsG6OWBK8iurfTe1wiwXX8IEmvtx5R83SvfX
	jzJZGP1CDTU3HYpbMA4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8ab-00050n-2H; Thu, 31 Jan 2019 09:24:53 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8a8-0004ct-By
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:24:32 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c52beca0001>; Thu, 31 Jan 2019 01:24:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 01:24:23 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 01:24:23 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:24:23 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:24:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Thu, 31 Jan 2019 09:24:23 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c52bec60004>; Thu, 31 Jan 2019 01:24:23 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V4 3/7] soc/tegra: default select TEGRA_TIMER for Tegra210
Date: Thu, 31 Jan 2019 17:24:06 +0800
Message-ID: <20190131092410.28222-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131092410.28222-1-josephl@nvidia.com>
References: <20190131092410.28222-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548926666; bh=sJd0OeUKpFPmKAqsO9Navgj1VES2CAtQEJzcOuxI/hY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Ex9j43a3JAXNnsWFnrCdCTPa0sfmaJ74SRRNEpUUHwb4JcXkcpqe/iN9CHU1J3zT7
 fNla5W7LygfLfWDCboGLgLc74symyNGi/Kq2f1cqalZwUMMPEuO0LvUvUCAHVshDFq
 swOw+J1mFxv9q/xUlvXYGX0jxbjDpKED1ke/SPNsmMB2APUNtpsgoJx9i2lvZRL5of
 q3NtrRH5VlwWisk3QdBgkBbwzlfUKMIDpBh+BEoPwOHus69wiUI7swsSS6dEKB9/0Q
 M89wqxQ+t9SUguDaVN3Y0Io3CgUE/XSMHyC+65TvACLJCWf3995h+Y4oxF67tRxAsA
 BAZcMfOd/lGew==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_012424_928790_4698F9BF 
X-CRM114-Status: UNSURE (   7.09  )
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

The tegra timer is necessary for Tegra210 to support CPU idle power-down
state. So select it by default.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
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
