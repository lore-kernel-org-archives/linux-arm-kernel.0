Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA45217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qZmQJNTs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iMNorDT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA45217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MtuT4+NFmrtha61XyXBct6rdo1393BRsp7zUj5n7Wb8=; b=qZmQJNTsEqEm/B
	TOpL7KI+0g4RtxvMeCr+MeBvdBNgjnADAwoTVp35Soum1S7xxe6OCppPhV7B9+xMSff/DC8sFrPnJ
	+WprMrosPNu9mPKsf0kTabXEQPIsAjgAd/CTOofh5SKG1PGcHBYk1dDBxLBQGbzBDiRdSBdSsvVXG
	ah4+UaIx2H+jAJsRt29JluYM8s4U6XTtGgpyH5z9S6k7CJkxjQO8P9wFeFVO/140Q7jmJKS7i4pJB
	0BIVYQfvRkB4Kh8jEVouj1x/RME8JYeXq6EbWGpTpZeZCoqN/rZvCG5rikx+R8WqdHK6ULaTgzijJ
	851EYDah2WoiLs9FEYUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go33l-0005X1-GO; Mon, 28 Jan 2019 09:18:29 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go33h-0005Vt-Ki
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:18:26 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4ec8c50002>; Mon, 28 Jan 2019 01:17:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 28 Jan 2019 01:18:24 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 01:18:24 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 09:18:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Jan 2019 09:18:23 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c4ec8df0000>; Mon, 28 Jan 2019 01:18:23 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V2 0/6] Add CPUidle support for Tegra210
Date: Mon, 28 Jan 2019 17:18:09 +0800
Message-ID: <20190128091815.7040-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548667077; bh=jjBqBROmMvccAz0tG3TPFP7qkxQu1oJd/WqoNYCXZ6A=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=iMNorDT2WKmdEslfxl0xXnbBgAWnF/+uynTlKH3KiGLi4RLshLqQBnellQeWdoSBU
 Y8SeF7jUhzE9ffApXVkAxuQ7Ip130zPuF/gjRshz6drmhxym6mVrvq8MbwlsU9MBfT
 /jQ3W2olaJaoHvSjkvK7uJRp0Cl7xvq6kPqozb5ndvxjRfRmLeC+GxfqNrFvzqggri
 U8lxj92dDbBHeIIJUcFDVSVLz+tLRO6ddRFyS7EN0CKyJ+CQ4rhSJwkfz2s/plu5VY
 3bh5N4PYjeA23vLDAQ3VHSp6Hv3h1rQZyMVzMqwOkYtH5dJ8ZKd7lMpVX0nOayAMbW
 l7jzbnBZCnzag==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_011825_687267_DA9CDD44 
X-CRM114-Status: UNSURE (   8.74  )
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

This patch series adds CPUidle support for Tegra210, which supports
power-down state (C7) for CPU cores. And due to arch timer cannot work
across CPU core power-down and power on reset signal event. We introduce
Tegra210 timer driver to work as clock event device. So it can be the
wake-up source of CPU cores when they idled in the power-down state.

Fixed in V2:
 * list all the timer IRQs in the binding doc and dts file
 * add error clean-up code in timer driver
 * add entry-latency-us and exit-latency-us properties for idle-states
   DT node

Joseph Lo (6):
  dt-bindings: timer: add Tegra210 timer
  clocksource: tegra: add Tegra210 timer driver
  arm64: dts: tegra210: fix timer node
  arm64: dts: tegra210: add CPU idle states properties
  arm64: dts: tegra210-p2180: Enable CPU idle support
  arm64: dts: tegra210-smaug: Enable CPU idle support

 .../bindings/timer/nvidia,tegra210-timer.txt  |  36 +++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  33 ++-
 drivers/clocksource/Kconfig                   |   3 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra210.c          | 268 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 352 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 create mode 100644 drivers/clocksource/timer-tegra210.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
