Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DFCC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBC82173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtZ2SMR8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHrRpM+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBC82173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=yEbi1pMVZCQoarqaFyh7HRdAHQIiV1ZHyO6TCZFWcyM=; b=XtZ
	2SMR8bBGuGN6F/Gk9rM2j83bPvJgYwsAHi4i+FCCJze3qVoIXoyGQmdVa4P7qRBTPhzrYxRVWlb0x
	hn5GrzDvTl0XjyyceuXOYGEBSP7XbgT0pSjOezsA8Ql+dTsJxW4BGaetkS4Wq7jjvOI1wOp+hc65v
	b/GrkhCsLcrcQKv5RxkBupmyLqkYkGofTWGBEwKyVDc1+XyazvII0o7NJc80RENxhy//b3UFblp1s
	bRgazr3eMz0Ng2O+ugvQUzoH1lxnPo0L828PgHnlQ7HY7BYXx2b+U2oLTwLkb7SFvExwyQBlgoSe8
	oDlgXxdfnm8rWuKCUitoKGP5rEa8KfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIAe-00071Y-T0; Wed, 09 Jan 2019 18:01:40 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIAc-000717-3n
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:01:39 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so8654397wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=aa7DBW2jefMqiPG5SEMBLPrEapaMRoLwEi0UQnoTFU8=;
 b=kHrRpM+tjApF6eo1Zoxeiztl2FiwR3WBHD4oQFYwP0nnI8i7B0paOQaj4rtScDvFqy
 skEhNcLQEuVf86pFN4mklZeUyvysvXZzxr+h69qncZgJeLNS/e+e9QiVJ/QVK+9dxj8o
 VdlLATOi4nSqcan2ERN7GSK0BlnsPJgu6fWkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aa7DBW2jefMqiPG5SEMBLPrEapaMRoLwEi0UQnoTFU8=;
 b=pTTvdFtvLuTZmqqGK2bTGKz8RVHxa1Ax4jsDRDMDPgw6849n3fleaUMPj6JgRx1zoV
 Mjtimkg6UwtMRWjwL+OK02CIl1ayixTOf8dcFy6R8zqGBhbdrJDxMbjQu85OT3UmvFAm
 IvA5wHqjFPIADz+oS1jzk61WP4o/pZjvqOl/kEcHLZs696BLBcoPDGRobPA1/C34MhPE
 V9RBep6AaPn8D62WL7FTI/6Bs7YN4gNiK5QCUTnofX1/Z/tdmFb/cDjEKXwNjfiNRaUM
 ocSVebK+I0bGYJrFmQA1gyA7mprm/GO/NnRhepKnaqmWwBKCSuF4EHH5zv0ctMxHYXYK
 C2gg==
X-Gm-Message-State: AJcUukfYj39U7BWVrX1J4lhLMDWpRcXW2VIFi71iYj2A94mI9eQZV9Os
 qBbAwk+iJKbnYgIoiKYCogxpQA==
X-Google-Smtp-Source: ALg8bN5SuHaTfBgMv2bRDbK7T0AdBtnmzz8BQkudCteudChJPwuuOgeSXVXiyjbeDRrtjlC2w1JKvA==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr6265762wrv.188.1547056896228; 
 Wed, 09 Jan 2019 10:01:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:1811:b2bc:9000:4c9])
 by smtp.gmail.com with ESMTPSA id m193sm14880509wmb.26.2019.01.09.10.01.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 09 Jan 2019 10:01:35 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH] arm64/hisilicon: fix SDcard detection
Date: Wed,  9 Jan 2019 19:01:32 +0100
Message-Id: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_100138_162606_94FBEDE2 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.

Since this change, hikey960 SDcard is not detected anymore because flags
are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
of high, fixes the problem.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 4643546..4ef1642 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -582,7 +582,7 @@
 	sd-uhs-sdr104;
 	disable-wp;
 	cd-inverted;
-	cd-gpios = <&gpio25 3 0>;
+	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
