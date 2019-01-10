Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BFAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54886214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9Nkrox/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm+oEOjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54886214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wUSQefgyHpP3blZwltxcEMuOn7WYZdZJrz5RLFgsBVw=; b=g9N
	krox/ZhG2KTGbnsxefRedwWbp84ge3T0rpJ0W09AWfdligIZPWJZBb0NP3LZkcVRRj3/Trk+hQXJe
	5YzytSBDDeKTj13BmPOjvGzcXaFWzLLuqbkvmwdcal6lCApI4U5P769jBgBM9nMxFrEtfma2pFVuI
	cYn3tyNvl32xvtznnPx+rGePRvH8eA+FIr5DX7lu2JD0Lve00LIVZ6B2WoCuVa+2n8+F6zgulsCAa
	D8JPltCvAVm+OHbL1tpeRbLuL44bF2pK++jNd3H+t6hcyuTnOkecOVb/8lUEP0/I25HaE7J8aaSdJ
	n2G885vqAMv99IcX5aNQAmBLYp/pKrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZP2-0003TK-1l; Thu, 10 Jan 2019 12:25:40 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZOy-0003Ss-I0
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:25:38 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so5234917pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=R7KG4RNn7WVmbQvqhKvIJ9jxw1xMvMrqX83v0AiI99E=;
 b=Jm+oEOjxcIAQjx1tUKVDs25RELoi8XQNj66KQbW7bZ6I1VGpeD+sJbQB2MrfeNx2x4
 ajyGaGnixLAgvSPNbCeYb0L42WP7nm6P5Z0kaM/1Upd/SJH0XuUWHtZAwCy3kLvQkI2T
 3OMwb23DjpUrcou3VaaYUVIllhteN7ew/ttd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=R7KG4RNn7WVmbQvqhKvIJ9jxw1xMvMrqX83v0AiI99E=;
 b=KJabE2OzXn9m20vCQFlZHiBaInbO7LH3M/XMJKmkHiLp3Mp6fFYhrXN6+laBfpf7lq
 DMN0xQHSVJ0uw6vvZ3Q2EAY+EL3S8twkh15Jz4z7r2vgdymSX7BDaqsyPUJj9XpLEl+9
 zyNT/5R96Wmqgz+FojfBeArwbuhjdS2IfltLSnV4W6YAN8g/OQ4fWp5Ky/fsTjweyWF0
 IoAZmIdg5UJcZ4bnvx0zewE3Arr/6EBMmp/9dnD2IIjrvF/ir30FwWxkqZiEIeT2sJqP
 /yS/VVw5UaNN2V9zpJTIQYusBBaTsEfEUbI4BCe+YAbJLQWXZqXOjo6wcnCPQpiWdJnw
 zirA==
X-Gm-Message-State: AJcUukfy7LBXwJBbTlJ6BG9wz79DUNnhpPQsPvE3LqwYJNZ0Z7FMbQLA
 MyP1srBV16JOWqApilfgBPWda2fA8hk=
X-Google-Smtp-Source: ALg8bN6rrtAAJfc6Yg2JWHg+PFTuRZ/QgQnMnERKMd1OnlfkW49EduF+AkjYZYjYBTPtiJEjjiORlA==
X-Received: by 2002:a62:528e:: with SMTP id
 g136mr10491873pfb.111.1547123134975; 
 Thu, 10 Jan 2019 04:25:34 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.25.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 04:25:34 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 0/4] Introduce TEE bus driver framework
Date: Thu, 10 Jan 2019 17:54:53 +0530
Message-Id: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042536_618450_20DFCD54 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: mark.rutland@arm.com, Sumit Garg <sumit.garg@linaro.org>,
 daniel.thompson@linaro.org, herbert@gondor.apana.org.au, arnd@arndb.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, bhsharma@redhat.com,
 linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, robh+dt@kernel.org,
 mpm@selenic.com, jens.wiklander@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series introduces a generic TEE bus driver concept for TEE based
kernel drivers which would like to communicate with TEE based devices/
services.

Patch #1 adds TEE bus concept where devices/services are identified via
Universally Unique Identifier (UUID) and drivers register a table of
device UUIDs which they can support. This concept also allows for device
enumeration to be specific to corresponding TEE implementation like
OP-TEE etc.

Patch #2 adds TEE bus device enumeration support for OP-TEE. OP-TEE
provides a pseudo TA to enumerate TAs which can act as devices/services
for TEE bus.

Patch #3 adds supp_nowait flag for non-blocking requests arising via
TEE internal client interface.

Patch #4 adds OP-TEE based hwrng driver which act as TEE bus driver.
On ARM SoC's with TrustZone enabled, peripherals like entropy sources
might not be accessible to normal world (linux in this case) and rather
accessible to secure world (OP-TEE in this case) only. So this driver
aims to provides a generic interface to OP-TEE based random number
generator service.

Example case is Developerbox based on Socionext's Synquacer SoC [1]
which provides 7 thermal sensors accessible from secure world only which
could be used as entropy sources (thermal/measurement noise).

[1] https://www.96boards.org/product/developerbox/

Changes in v2:

Based on review comments, the scope of this series has increased as
follows:

1. Added TEE bus driver framework.
2. Added OP-TEE based device enumeration.
3. Register optee-rng driver as TEE bus driver.
4. Removed DT dependency for optee-rng device UUID.
5. Added supp_nowait flag.

Sumit Garg (4):
  tee: add bus driver framework for TEE based devices
  tee: optee: add TEE bus device enumeration support
  tee: add supp_nowait flag in tee_context struct
  hwrng: add OP-TEE based rng driver

 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 272 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 150 ++++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  43 +++++-
 include/linux/tee_drv.h            |  42 ++++++
 11 files changed, 542 insertions(+), 4 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
