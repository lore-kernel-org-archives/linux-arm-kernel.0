Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00AC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA5D2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CPU2uDUh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gGe3KpN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA5D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5uFieNeiFzh+kRJh1nCFUZxmfFytHj8PKdQX5HSf3zo=; b=CPU2uDUh2Zh0o1
	Q2dsAzm+rvw7MO0xPN+7QfENzSoLyd9WuAdmep4uLpdLE300AX75Y+vWDZHCUZbf8bv+KC10Vdf16
	MbIVCxBFrHObPaCFvbJK9y/V4+E/uIDKuGfFd70HjNP0Gp2vD9LuxFHRVubWUNavwGSHfuz7vxLBF
	s7c4wbdpiB78MdOgIqHwHLUTotySL22r/gl7gnPY4vRSEJ0qAL/Bq/0cdtRcDxW7ob4N202uccSBF
	tA89tI1tHIWfDKOeH4CXUfTuubVxlMtmrLG8OrCxmFCrk4RBS1rE7LW0DMzQ9PGZ/uAoRnq53cSwW
	TKUxaPkQoG5+JL5NTE9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyj5-00034f-BT; Tue, 05 Feb 2019 11:17:15 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyj1-000340-8J
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:17:13 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5970920000>; Tue, 05 Feb 2019 03:16:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 05 Feb 2019 03:17:04 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 03:17:04 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 11:17:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 5 Feb 2019 11:17:04 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c5970ad0014>; Tue, 05 Feb 2019 03:17:03 -0800
From: Sameer Pujar <spujar@nvidia.com>
To: <linux@armlinux.org.uk>, <jhogan@kernel.org>
Subject: [PATCH] ARM: tegra: enforce PM requirement
Date: Tue, 5 Feb 2019 16:46:58 +0530
Message-ID: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549365394; bh=upWYMJJj7VUHNj03N/Pj0XxtmbTt4ge25Lw5rdzXDSU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Type;
 b=gGe3KpN6AZbmVjPTksdRhpW3lBHlVaT1o9Zsw5IHx/XU7KKgV9lhpJYVjEhCM9nPI
 UDgHuE17tF8Gt+ZlsD5jFgErLC+v9U0M++WhJVGeADLxondhW8kZBBumKbzPTEL2lc
 pos2vTtcIqmX0kLSTeZfeGAv6J9VlAoIWqbc+JTsWbHcVsUYyTa6UKsp6Suq7p1NcK
 OfFQdVhs8dVvWVmXHxb8DFnmCJ1bvoziQsgfLm7S86PsHD/LGdyi/xjSYjIDI1+n9X
 GHmXrwb9UxJ7PCyo9cmtZcd9mEMCUIV2QnqEq3kNavKJnBE+1k2l8CpvFWTHZG+eO7
 +zTB6aPKU8BMw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_031711_302690_B6729F5B 
X-CRM114-Status: UNSURE (   7.62  )
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
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Drivers need to handle !PM case with work arounds for managing clocks
and power explicitly, which is not really necessary when PM support on
tegra is in good shape. In fact ARM 64-bit tegra platforms enforce PM
support and there is no reason why this cannot be done for 32-bit.

This patch selects PM unconditionally and drivers can rely on runtime
PM framework for clock and power management.

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
