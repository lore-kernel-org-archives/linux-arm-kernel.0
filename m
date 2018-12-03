Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03857C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A338820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Om26zFKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A338820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6E2SsDU4ao1O2Pi6SrQ9ABkuPWhuwfyQIqEXpt+VqxE=; b=Om26zFKPSlTmRl
	6bm0JzP1s6wfhjWSQ2nG+X7X63Xc7E3WM9tmDNbob5cGIWtwUQvjOOHJXa/u+dUX0s41gfOoYCSSU
	5KFQdEyxdEz6k7VwlAJEtdiGDwG2cq4dSNRLsWtqlLFgmcyBxiZq0yuvCWYdJ5wZiIA/1fVqpa4cT
	DOVd6uK2w53lPVzSCR7Bn3aeVhror+i00JT0M58H+ObpRSfujm33K/QdIjVpWlaj4edpvi1xsifDA
	70dy166mWRwZUJT0kGnG96EJHMwxng2DrXx8MfzErF9W7YRtR4a/V6ajn9wwTTnEt2f5Jg6gBgjPv
	jmeFyzquXsgPLLFfK3gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpgm-0006SC-JA; Mon, 03 Dec 2018 14:59:12 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpgI-0005ve-QE
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:58:45 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 354B15FD54; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
Date: Mon,  3 Dec 2018 22:58:11 +0800
Message-Id: <20181203145825.20511-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065843_112456_AC85DF74 
X-CRM114-Status: GOOD (  19.22  )
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This is v2 of my rtc-sun6i clean-up series.

Changes since v1:

  - Collected tags
  - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
    output"; already merged
  - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
    overlooked
  - Only export IOSC clock for A64/H3/H5

Original cover letter, with patch numbers corrected, follows:

This series was started as part of enabling Bluetooth on various
Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
clock fed to it to correctly detect the frequency of its main oscillator.
This clock signal is provided by the RTC, either directly from a special
pin on the SoC, or some clock output function from the clock controllers.
I found that the clock-related properties of the RTC on later SoCs were
incorrect or missing.

This series reworks the compatible strings and clock parts of the device
tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
the same sun6i-rtc variant, when in fact they do not. The differences
that matter with regards to clocks are a) the A31 does not have an extra
external output for the RTC 32K clock, while most of the others do;
b) the clock frequency of the internal RC oscillator is different on
some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
feeds the system HOSC. The last difference, and by extension the H6, are
not covered in this series.

Patch 1 cleans up the clock-related section of the RTC device tree
binding. This would make it easier to read and easier to add additional
clocks.

Patch 2 adds compatible strings for all identified variants introduced
prior to the H6.

Patch 3 deprecates the external clock output for the A31. The A31 does
not have this output, so it's introduction and usage was an error.

Patch 4 adds a clock output for the RTC's internal oscillator to the
device tree binding. This feeds the PRCM in some SoCs.

Patch 5 adds a default clock name for the LOSC to the RTC driver.

Patch 6 adds support for different hardware variants to the RTC driver.

Patch 7 adds support for all known pre-H6 variants.

Patch 8 exposes the RTC's internal oscillator through the device tree.

Patch 9 through 14 adds an RTC node or fixes up the RTC device node
address ranges, clock properties, names of existing clocks, and adds
accuracy properties for the external fixed oscillators.

The clock names require fixing because the sunxi clock driver implicitly
depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
"fixes" to the clock hierarchy introduced in this series means the names
must also be shuffled around or the in kernel representation would be
incorrect. This has been the case since the sunxi-ng drivers were
introduced. There are plans to address this, but the code is still in its
early stages.

Please have a look.

Thanks
ChenYu

Chen-Yu Tsai (14):
  dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
  dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
    variants
  dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
  dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
  rtc: sun6i: Add default clock name for LOSC
  rtc: sun6i: Add support for different variants
  rtc: sun6i: Add support for all known pre-H6 variants
  rtc: sun6i: Expose internal oscillator through device tree
  ARM: dts: sun8i: a23/a33: Fix up RTC device node
  ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
  ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
  ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
  ARM: dts: sun8i: r40: Add RTC device node
  arm64: dts: allwinner: a64: Fix up RTC device node and clock
    references

 .../devicetree/bindings/rtc/sun6i-rtc.txt     |  31 ++++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   6 +-
 arch/arm/boot/dts/sun8i-h3.dtsi               |   4 +
 arch/arm/boot/dts/sun8i-r40.dtsi              |  18 ++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  28 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  22 +---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   4 +
 drivers/rtc/rtc-sun6i.c                       | 121 ++++++++++++++++--
 8 files changed, 182 insertions(+), 52 deletions(-)

-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
