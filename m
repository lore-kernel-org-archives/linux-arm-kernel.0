Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC074C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C92C20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9wsmhnI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qQG4Bt7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C92C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CncwaKQhCe8tnVnQfjrt8hXzB47HIPBDDvOwC6H6ofQ=; b=b9wsmhnIGWHGHJ
	soJS4LhyHrRpHrrEKvUqT//emWRP29RMiPkx6eobcUIIVpBgwp8jytN1FTC3NldeXAwYI2uWE287g
	a7eyQKrQ7pSeFKc1Onw4Dp0Syu7y3d/QVBNQDHwobCSnjJqTL+i+g0xbEmL6dGLfkxzRpqg/hoqJx
	nMZJO32WLR8UpAG371vt3BMCGEWCEZi+9a/LZvupS2ACrJ1WaFF2tAq5lA809L9WTJaqCcKHcb8Pm
	/o9cc3X824HbTjUXZSP08tMhD7zXfQG3wL9Amy+zm5Ocjeu+MDYVs+X58HVLsSTWXb1dRR4Ce9mwb
	koNkhLOvS4XfFgCuj8pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwigC-0005gz-NE; Thu, 21 Feb 2019 07:22:00 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwig9-0005gN-Cs
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:21:58 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6e519b0000>; Wed, 20 Feb 2019 23:22:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 20 Feb 2019 23:21:55 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 23:21:55 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:21:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 07:21:54 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6e51910004>; Wed, 20 Feb 2019 23:21:54 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 0/8] Add CPUidle support for Tegra210
Date: Thu, 21 Feb 2019 15:21:42 +0800
Message-ID: <20190221072150.4395-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550733723; bh=st7nuvHajE224HVxf7ADaWWardkDkTUas6YE9wNoIK8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=qQG4Bt7Inb4l++iGuYA7hqFWCZ+7kMCtiH4zU+PIzovpZMIbRTSs9zZ3Ql8YTibyY
 hqrrOnbGjkeePg2OUZoNRwledE5xYkQEB6VGYYI8clxOXtQeZnjZvKJA8T4CLtOSLm
 +aNnB3Rt1MegUSlXlq2mr5dMO5wz6HdMAu0sG7NzS25PWEbzkTtKA0SfVZlp+D7/YF
 i5O2cdvC3kT/pDx15qE1XDq3mg/Bvfw0y48XeNVZwZJzrHQ8rTMjU3dB6dBK9QER2b
 ZDqlDh2SMeDQJx5j7+lIGKyvbIKzD92b8rGlrZY9IP156UjlUstSLKZgtX3/whoLaa
 aj9nnT/z6s7wQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232157_449742_4DC5F868 
X-CRM114-Status: GOOD (  11.62  )
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
cpu-sleep state for CPU cores. And due to arch timer cannot work
across CPU core power-down and power on reset signal event. We introduce
Tegra210 timer driver to work as clock event device. So it can be the
wake-up source of CPU cores when they idled in the power-down state.

Fix in V7:
 * kconfig fix for 'depends on ARM || ARM64'
 * move suspend/resume to clkevt
 * refine the usage of the macro of TIMER_OF_DECLARE
 * update the 'entry/exit-latency-us' properties in the idle-states node
 * add one patch for Shield platform support

Fix in V6:
 * refine the timer defines in the timer driver (PATCH 2)
 * add ack tags from Jon Hunter.

Fixed in V5:
 * Just resend this whole series again with timer and Tegra maintainers
   included

Fixed in V4:
 * merge timer-tegra210.c into timer-tegra20.c
 * add a new patch to select TEGRA_TIMER by default for Tegra210

Fixed in V3:
 * use timer-of API for Tegra210 timer driver

Fixed in V2:
 * list all the timer IRQs in the binding doc and dts file
 * add error clean-up code in timer driver
 * add entry-latency-us and exit-latency-us properties for idle-states
   DT node

Joseph Lo (7):
  dt-bindings: timer: add Tegra210 timer
  clocksource: tegra: add Tegra210 timer support
  soc/tegra: default select TEGRA_TIMER for Tegra210
  arm64: tegra: fix timer node for Tegra210
  arm64: tegra: add CPU idle states properties for Tegra210
  arm64: tegra: Enable CPU idle support for Jetson TX1
  arm64: tegra: Enable CPU idle support for Smaug
  arm64: tegra: Enable CPU idle support for Shield

 .../bindings/timer/nvidia,tegra210-timer.txt  |  36 ++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
 .../arm64/boot/dts/nvidia/tegra210-p2894.dtsi |   6 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  33 +-
 drivers/clocksource/Kconfig                   |   3 +-
 drivers/clocksource/timer-tegra20.c           | 370 ++++++++++++------
 drivers/soc/tegra/Kconfig                     |   1 +
 include/linux/cpuhotplug.h                    |   1 +
 9 files changed, 348 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
