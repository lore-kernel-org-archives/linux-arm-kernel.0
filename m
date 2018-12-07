Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB19C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C87820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIEhHMhL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8vNRBaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C87820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bHxDzOrQyZn2nC4cwVeIewqgKjzNe7mWaS/xgbhvuc0=; b=nIE
	hHMhLgINyfCaeQHOvPIDpFKCu5sKNe1v41erEtBdyPNnzlFh6DONgtWxcfEeCB9fZHRvGo1GHSii/
	RU4hmJ3wN27UBXJQHXUcJsmQLtQJelu1n68vDGZySrTtp8Q/rRXYWAfV96uZMBnBCiOmxF6vbjREh
	0PHm347xjnUabTslR/j8Is1o/dz43gqehem1/q1yBqXPFla6cXIPTjAQXDdLBRVp6rqJFbaNzuh0W
	1I7MD/BM9PUzYJvVTx9ravESxbx3f4v2I0YGfbWnTX5f4rCFLK7EfIngFWPqJeFJ/f2nIb3mZwK0h
	R4Y6i3P6QhPb5eLP5w4YA8UA7u4yRtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKIX-0001Go-N2; Fri, 07 Dec 2018 17:52:21 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKIU-0001Fg-83
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:52:19 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so2132523ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=3WQAUIWwUS1Bi+GyB1a39vYL4U81m6zfnOqbkyrmYM4=;
 b=c8vNRBaXjU+nTt1dy64HSdflwfCcb/7/CI93XPiSxxeN0wwDnh5T+C/pWo+izwQYED
 MM4xk0KVxUsqGI+VLVA8ES6HRZ+2G6YnByL0LJvqRkPTNNzHwTizFlG+Og+pc+ueytc1
 iYJC+fP5evG7Eo7x5MNP7vuvQhQ3It50skNfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3WQAUIWwUS1Bi+GyB1a39vYL4U81m6zfnOqbkyrmYM4=;
 b=Pc+QK6nJ+B3lbRNv+MDboStwznWZhHURGlmImyEI37nqJwLpt84WG6S9ioHERs84ed
 UDP3vceqS2M485kyZw4iRsuZT4jz/YBOz1i7wpDTac3JlyoMoLV6a9n0Kb7kHuKticNe
 A2tSRPM2t9tzunL1SuqDdmwP2baqrvqx02azcjvCFFgw8+/CB3YPGqxSh/HJEwUfN+r5
 S4fby+bWK7TeLZkyq78aG07qhvh/UnXZSRnzXhixVi7yNhAgjghm4mKK+aDZkzTa/frH
 J4ymK2ulksaTFdFR7CghoNglsZ2LK6ptAvyne4ALVgeg1jb8KBDuMjFL/7fW/4gI0XLd
 TiSQ==
X-Gm-Message-State: AA+aEWYwMckNEqAi81elcHbrWMerBexLTqEPByAUWuvjeH3Kg5EhQd5B
 3hxQC2Z9/hO9hCfu9JV2diOYHElasg==
X-Google-Smtp-Source: AFSGD/VjGp3axjCnM/yLlxi03ddcZY3uZimIKJTQpHfyXy19ua6WzuNnxEq/VCyW02B2/nQjU6XgYA==
X-Received: by 2002:a17:902:47aa:: with SMTP id
 r39mr2981150pld.219.1544205126619; 
 Fri, 07 Dec 2018 09:52:06 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
 by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.51.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 09:52:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH 0/3] Add UFS controller support for HI3670 SoC
Date: Fri,  7 Dec 2018 23:21:48 +0530
Message-Id: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_095218_287957_04D36CF1 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds UFS controller support for HiSilicon HI3670 SoC.
HI3760 SoC is very similar to HI3660 SoC with almost same IPs, hence
the same driver is extended to provide UFS support. Only major difference
is the PHY. HI3670 has 10nm PHY, hence that parameter is used to
distinguish the difference between two in driver.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: ufs: Add HI3670 UFS controller binding
  arm64: dts: hisilicon: hi3670: Add UFS controller support
  scsi: ufs: Add HI3670 SoC UFS driver support

 .../devicetree/bindings/ufs/ufs-hisi.txt      |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  18 +++
 drivers/scsi/ufs/ufs-hisi.c                   | 127 +++++++++++++++---
 drivers/scsi/ufs/ufs-hisi.h                   |   4 +
 4 files changed, 130 insertions(+), 23 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
