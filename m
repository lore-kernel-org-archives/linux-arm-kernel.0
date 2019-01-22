Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC42C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2101C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HJEbCytS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I92I6Oav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2101C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=yIY7rtDYeA5NM4nJ5J2KRl4nMNT+r2994kKh+zpsojE=; b=HJE
	bCytSVAZoE9BWQXREZDjrQcNMf5XClSnJolaCtDoekgPZQ073yEBPf5KWSVgkd0DJGdP7O5RjlBnY
	EqMU50HIpcKg1tRfmoHtDpTSnN30QhGHlnLZKIb75IFJWykv3VOkhQJFZGB4/qmQhac7T2PE9K5yf
	ULVxI6e4LWqzNTx37WFWafEtWFp2SnQ3YTvVTluxHfDCzYfhnoQRRa6ocL6SBVBhpLOO/+I1IOq8Z
	Gk8JklXd2QAGA5ohlvT/yYY5goIlqBwS5gnTX2U2yoYdHzmRWQ+mol8U5eBb5P1MZYKv2ddToVa1s
	9Lqve154J1eL1uXW88s6Yy4t9HcPgbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glnZb-0000zQ-ES; Tue, 22 Jan 2019 04:22:03 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnZX-0000z3-GY
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:22:02 +0000
Received: by mail-pl1-x643.google.com with SMTP id g9so10811172plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=YXvkxSWI9j7PH0XLfIk7l4OYwr3HALayuS+GuaRQtDA=;
 b=I92I6OavRkseVq6UgzadkRcCAFJqwXyWpfd7gTHODjdJrmBQVQUO63UcisumFR9v3L
 F6rJxjJWYvT8gu7mndjRGueKI4Y99rWws7RDuxSXJQqM/2xkBPh5j/X8v4isn2V1Dk9l
 /pq6R2tNo/Big+HUyDxtEhQapDUfBedfiBQmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YXvkxSWI9j7PH0XLfIk7l4OYwr3HALayuS+GuaRQtDA=;
 b=LOYXto8A6lCEige3SaNEv+Dgd4MnOvmyU+IelSWeasXClMXxJpBKwplX1jThyQjLX2
 Nrie1oxnSEBI6j9YWfjtlHOyJu4Y/sUYBk8c9PMyRJQjKo74eBOkKflhVZpJLcuYeZpv
 VyiD9igbE+TmIe8HnCx5KSA6yEJWsdNuwRmDBLd4FKX7rBnM4aLGP6UycbUXB2lwSFDv
 +vuBEv6J+X6s2QzChrr/jgGM+xpvRBYw4hTlrGm5lbxZ+tEBSbXw8eof8TtFyOkTgqcL
 6pVRSu8vE+IFtlwc8+FUtjX7bgQLFu66UXDHUJRaZpAaJ9Lb+o0WWNd8ydRV+xxLfY+7
 4aNA==
X-Gm-Message-State: AJcUuke3qrFFn3gzh+jgEhk++5OYY6QfqF+WRfiGq3Cc67wMJ8IurbK7
 3spHTFnPbqHopw6BhfLU59g6
X-Google-Smtp-Source: ALg8bN7j+tSgVz4MKoqY8moyFNHw2w5gs9ueo65QTBhc3v9SH5i3Yx8KDr0ZahVXcKftDS2Dc5PTiw==
X-Received: by 2002:a17:902:4:: with SMTP id 4mr32930147pla.20.1548130918456; 
 Mon, 21 Jan 2019 20:21:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.21.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 20:21:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v3 0/5] Add Oxalis board support
Date: Tue, 22 Jan 2019 09:51:42 +0530
Message-Id: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_202201_014043_A5791B68 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds Oxalis board support. This board is one of the
96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Thanks,
Mani

Changes in v3:

* Fixed LS1012A and LS1021A bindings
* Added missing devicetree compatibles for LS1021A based boards
* Added Rob's Reviewed-by tag for Vendor prefix patch

Changes in v2:

As per Rob's review:

* Adopted the Oxalis board binding to JSON format.
* Sorted the EBS-SYSTART vendor prefix alphabetically.
* Used the generic node name for audio codec.

Manivannan Sadhasivam (5):
  dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
    boards
  ARM: dts: Add devicetree compatibles for LS1021A based boards
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 .../devicetree/bindings/arm/fsl.yaml          | 11 ++-
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |  1 +
 arch/arm/boot/dts/ls1021a-qds.dts             |  1 +
 arch/arm/boot/dts/ls1021a-twr.dts             |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 7 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
