Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B7CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:53:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3470A20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irVCjZub";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="StgdgazW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3470A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C7M+SN2OdbCBqeLR6cxrQZP4UEvL+gftsgYNoPitRf0=; b=irVCjZubslm98r
	hdy4Ig7idarrGw/f3h+YsrEsXig2veQdHy1P8Lp18XWWmwQfNQaKpeqBQ8nt++iYVZx0pA6sQND6w
	XIPb4gLgo/MgVNHnOSw23+bVDdsJ3MSgu76WlwREFrFWWEwIlC1WkLg/KnKdQpwDVvbrQfr7NzBEB
	+qoblxjCJ8Nxnal9TrHKKVEPi4YjMbkI76heabqSOAKFf1p8KClNwVFLUZZGvvG9L1e4ZHAnB2jI4
	OLxBv0/zXDrQF/UHbWVbPIXlcNXclbv2z+Vm7QpQgRNdnXRcnXCng9hR82sDHUAG7U8WeexwRsh23
	IgtPnwXo591jpjFQL1zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1Wm-0004nh-EU; Wed, 27 Feb 2019 15:53:48 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1Wj-0004n2-FI
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 15:53:47 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c76b2870000>; Wed, 27 Feb 2019 07:53:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 27 Feb 2019 07:53:44 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 27 Feb 2019 07:53:44 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 15:53:43 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 15:53:43 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Wed, 27 Feb 2019 15:53:43 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c76b2860004>; Wed, 27 Feb 2019 07:53:43 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Thierry Reding <treding@nvidia.com>
Subject: [PATCH] arm64: defconfig: Add PWM Fan support
Date: Wed, 27 Feb 2019 15:53:39 +0000
Message-ID: <1551282819-27274-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1551282824; bh=wyHnJV0nAQ2B10Z205EgNJ/ZWZkPhR4hsJqlUYpD7T8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=StgdgazW5bhNIxXOeag0pfbgVVulRR+5LBPSxOSBqC1LAZYfeWIpaqZUuIx6UMdU0
 XmVrU3furu2j10BtOJeFzH7B/r2L4DcfdYCf2nwh5y7+Vz/Ghw7vkXV7VF8FipYQPy
 ehf7ct56SEa+9+UFyMGoh+uihCvUCBtOUeChfBwuj/En60ISrhWYWWyVoPuKBigwuG
 a5n1DMMs9rPjEFxnFZyjSAuo20SKqIpTCwxMDNFgTzqTL38SsHUt1uAtciHP0kr2cK
 mpKKSv5RFfI0NCZomyHchLnCZmRQO5znK4eg1YtoP2PbULHw1qFL+uHxV/fj72dX2R
 pcQLadDliiz3g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_075345_520269_9B3F60CC 
X-CRM114-Status: UNSURE (   9.23  )
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
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Tegra194 Jetson AGX Xavier board includes a PWM based fan. Enable
PWM fan support in the ARM64 defconfig to support the fan on this board.
Please note that the device-tree PWM fan node is already present for
this board.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..1fbbfbb5d9d1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -408,6 +408,7 @@ CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
+CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
