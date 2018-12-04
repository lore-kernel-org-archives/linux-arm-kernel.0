Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA293C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA6B20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQBbYBq6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oNpzOIiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA6B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ho6rLd4TOHsLe6lWbkjMKsOLepZqFoweR3mcY0LWURU=; b=mQBbYBq6xryq70
	ktL9/PB/VSoYuolcMiSMrk3UOdjCpRfI84GufJ9/cF7s7yAN9lJBWK9zaP3jwCdc49ZfcsOufg24k
	hjBGJztafrHgkTWWzKL0NkYh+74HMQhJJn2vORbc5unNIlLm/yyrMPsaBKkiuVMjjQp91O02CZHPj
	8vWW50PUapo0dwPnuKWaM/tRQymhFUqgmdGymVXSsjpE9EnOX743SR8wBjEQlRLIzFYladw2V0iNy
	W0j2wEiaRzBvJccKahPdpMhQbSlXK6Ub7bZi2Xg7GiQ8LbkTE4G1fMqjBx+S8f7LjpCI+imc6jOaF
	ffeW0Zolb2xRQPGMDFvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTzeV-0004Gl-MN; Tue, 04 Dec 2018 01:37:31 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTze6-0003mR-Gm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:37:15 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c05da3e0002>; Mon, 03 Dec 2018 17:37:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 03 Dec 2018 17:37:03 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 17:37:03 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:37:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 01:37:02 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c05da3e000a>; Mon, 03 Dec 2018 17:37:02 -0800
From: Krishna Reddy <vdumpa@nvidia.com>
To: <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
Subject: [PATCH v3 5/6] arm64: defconfig: Enable ARM_SMMU_TEGRA
Date: Mon, 3 Dec 2018 17:36:53 -0800
Message-ID: <1543887414-18209-6-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543887422; bh=J/o0R9zVlmi0W2ef9WvO+7XujrgcpT7YYO5K6e/OwQs=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=oNpzOIiNXlC/vP6Q+zw9a5AXOVhzEgvnZN7SGU5JxKzUjNzsOv4VtARnmQ/ATyUmA
 a2UKJSehGtJDoBYRwFglGLKvV8ypv1jxNL8b7di/RnrrzuR03yKo4i5ljSpEy+H3Ii
 c6ECJ43DCUAf1MA/TvFOPh3kiYap3iTIIA+6pyNWW+gaBB9Xqu/VUgxq4lB1+3y/XK
 xAEDSoLAc19GSJTx7p+uwMuvjgnOtDwIBlgZLIVib5XaoQgjkdsHHUKLbdzb0AH6VV
 Zuwro4Y6Xje8hOGhqhe9Cvqt8vd+QM9FO9vooGQ1Vv9A2+rLWjV+plOkBeSoyhOtZz
 TopWd31hLrDOA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_173707_416554_5A854195 
X-CRM114-Status: UNSURE (   8.07  )
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
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
 mperttunen@nvidia.com, praithatha@nvidia.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, talho@nvidia.com, olof@lixom.net,
 yhsu@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enabling CONFIG_ARM_SMMU_TEGRA that is used
by Tegra194 SOC.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c2b1f6..e5ea13b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -625,6 +625,7 @@ CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
+CONFIG_ARM_SMMU_TEGRA=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=m
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
