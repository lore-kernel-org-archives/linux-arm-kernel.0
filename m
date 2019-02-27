Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF54C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C216218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H6Rnn9/A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kNeU+0VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C216218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lJOERASjVsSjKBqcpQM5BaepHN23GU5C+0WUWo6ItVQ=; b=H6Rnn9/ASonvo7
	vPTUn8iJ0WdmYhDG0uA4dWuKaGvopl4DP1hbQsISbbfF8MjMxeRsOtxGVJClgmBWq6N+8OKLmdizg
	ZBq6yBeXqwQvKAP2X4zTAotfyhVmvBSrGiGBnJgJJCb/4VEBniXBEzWwVtrXzbFO7acTH3ZSY2Hb0
	hLiVDSVC+oQzHT8b14Kw3bS/IlSUpdz3bgB1Kn1aY+7rnaraRbmKEuL44dx0/9cmEJHbt0VU4Teb1
	9RO0zFpS67X7CnISYoqZ3ma+kFEd4ouht57pZGNrejitfGKMXpoQDHMSHma33KGnVsudIUErik4m9
	o44zcYY97uiK8LeqeGew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyuSH-0005ul-MI; Wed, 27 Feb 2019 08:20:41 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyuSE-0005u7-Ra
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 08:20:40 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c7648550000>; Wed, 27 Feb 2019 00:20:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 27 Feb 2019 00:20:37 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 27 Feb 2019 00:20:37 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 08:20:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Wed, 27 Feb 2019 08:20:37 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c7648510005>; Wed, 27 Feb 2019 00:20:35 -0800
From: Sameer Pujar <spujar@nvidia.com>
To: <linux@armlinux.org.uk>, <digetx@gmail.com>, <jhogan@kernel.org>
Subject: [PATCH v3] ARM: tegra: enforce PM requirement
Date: Wed, 27 Feb 2019 13:50:28 +0530
Message-ID: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1551255637; bh=x6H2AxFJ0i25RIq9MZQtQbZMIqlFRbYHxx3C9hhyTHY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Type;
 b=kNeU+0VRLYvIu9ruRu6T+6gRBtpvUNK/VNqJJwY7j30mouML/Q1FHLwgZRxwheJ9t
 MvbtlFXia2A+Z0i+6t0+kubWFFGuifnIhqNflBLL+l81USscEhAwPkYfD+eMwZolrg
 3a0NXSkgCgAjTT01R/Vh+MNxc0+Sh615+FZvW02XYHvP5YHFtDKk0I3dHp8behirkV
 FI6Pvc+S2Abio1oHaBce4+i1Kpi3PPv3Ia/RQidj+R9a+6TV87dc/vwh46/kzqEwMz
 Ok5MC1I7Ic6t2Y95MOIlsc2LzvOjrcWF28fHtBYcthrUagkRVQPiLJLrrVGppfkUBR
 Vka9dypv1nZyg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_002038_897353_44F02862 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently runtime PM is enabled for Tegra HDA driver. One of the concern
raised was about handling !PM case in HDA driver. In this case, there is
a need to manage clocks and power explicitly in the driver and reviewers
were not really convinced about this. The consensus at the end was to
enforce PM requirement to keep things simple, rather driver mentioning a
dependency on PM. This is how it is done for ARM 64-bit Tegra platforms
and the same can be done for 32-bit Tegra platforms too.

Finally the objective is to remove dependency on PM availability for all
Tegra drivers. The detailed discussion can be found in following patch,
https://patchwork.ozlabs.org/patch/1031007/

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 7f3b83e..51a8fa3 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select PM
 	select PM_OPP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
