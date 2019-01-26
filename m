Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66143C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387B0218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sgAMD/uw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlW6Zrj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387B0218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=P+so7dYo8HW0d0adD94XR8bzLsaDgWjbnqrXYCkIhbI=; b=sgA
	MD/uw8X4THA1vF2yr2y1jwo33T9+BYSOB/ggfbV3zWeXij+NJ/B4xEdfmoSmz0JZDHKwImQ3LAxgp
	WSZlySQqQMp+amhn2eSXa17OZrNwihc6lkRPgtKWpo01qL6aZBZ4RXQaJvqBqfZmw5w9PxHwOCvfP
	TZ8wMC+kWSli8BoWqpLl1e2/CAIqPoyorxbcFKpnRGZz+0bBnMEr40QOqscVMdPfmzwF4PxAgX5s3
	xeID22lHgLLBcXmVe799zNh9mCrPjg1FvDEhPFaGkDmOz6PZjQvpGl9YcqFw9K7lx1uKJDX5SbnV1
	oiqXJNVBjSfd8vuQhfNM8/ETQMaaiTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFJE-000367-NT; Sat, 26 Jan 2019 04:11:08 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFJB-00035I-Fs
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:11:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id t13so5426688ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=7/KChodqzOwOxKMahivIffCjoPXtO7yajVZ/FiXpfUE=;
 b=YlW6Zrj8L9/F4Uspc2nfzT8hGU7jQfXLyges7YZ5DvMFHtD+aKBclwW0MejxUq3bL9
 0r1yYG22fYnhid2Z89ZPEBa0J36XfOAwgNPPisYnFSahkO3f9eon+XIO2I9p/as4lCHF
 gxGv8plh8akl74lHSuqQRQvZ3F5nDk/+gyVsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7/KChodqzOwOxKMahivIffCjoPXtO7yajVZ/FiXpfUE=;
 b=ZWJ9ZMZLPv+5llchq7+LpYZlX6RjrMNxpczE46i6SZUJJxYHg6LXmkPgl0Nywgpzw0
 2xaPtzLSen22a7WT7Wrfp7daKS7mOUshGYYMgJgKAkAIy/qQaBpbLlkM/BJo+YCZ9c7W
 MXBbcQ9zP1bRnUR+6O8TIXrOjRLyHarFp8qsUW5H1Ri11v56wghkzbitCZUpynOdjQXM
 8KIZiDk5qSfzz3b/rY04j4BzhA/Tg5gio/tFk8x4vYwgxTJQ3ozJyb6hxsqH5QaWAizH
 +dRORKaJcmxyv9s09cK+WkdbzeiJdB3NO0VHK8VdY+WqK2OLuvNFx30cbEOpdUbepwfu
 VxTA==
X-Gm-Message-State: AJcUukfEemXB5yuRNuV13GdSMwZDj0nfzdJIjKv/Cx6cYPNggU/E5iML
 LtP/Aqm3ksN1NWUDPZny/cza
X-Google-Smtp-Source: ALg8bN4FU4X+LK5zVbWA4ZLCNLUYdSa72FtS6xk34+GnVD9YlZaEvToAbFr0tT5WVeLPEAi41coulQ==
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr13679490plb.238.1548475860608; 
 Fri, 25 Jan 2019 20:11:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.10.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:10:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Date: Sat, 26 Jan 2019 09:40:36 +0530
Message-Id: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_201105_542711_65F6623C 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, darren.tsao@bitmain.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 haitao.suo@bitmain.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds initial support for Bitmain BM1880 SoC and Sophon
Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
processor subsystem, a single core RISC-V subsystem and a Tensor
Processor subsystem. This patchset adds support for only ARM Cortex
A53 Application processor subsystem with UART, which enables the board to
boot into initramfs with 2 CPUs.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: arm: Document Bitmain BM1880 SoC
  arm64: Add ARCH_BITMAIN platform
  arm64: dts: bitmain: Add BM1880 SoC support
  arm64: dts: bitmain: Add Sophon Egde board support
  MAINTAINERS: Add entry for Bitmain SoC platform

 .../devicetree/bindings/arm/bitmain.yaml      |  18 +++
 MAINTAINERS                                   |   7 ++
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/bitmain/Makefile          |   3 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |  50 ++++++++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       | 119 ++++++++++++++++++
 7 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml
 create mode 100644 arch/arm64/boot/dts/bitmain/Makefile
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880.dtsi

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
