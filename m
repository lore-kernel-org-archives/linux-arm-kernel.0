Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624322145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CuPUpZ0v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PV/PyozU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwRLqOCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624322145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QtAQoObwiG87BeDwTvJAMWQ8XjoAFi8aTC3Y48FIlyY=; b=CuP
	UpZ0vujfnZYsAydm56GKcoDERTAnhPFUXg8yceSGKKL+QQuUKuwCdJYGpSHD0+6sbH/mGBNpaByZV
	HLOGdevgP5dN8NlBHS6Wy9z7F7hE4ibJifcMzEF1Go4doVafXO9E2VRSuc6kwG6Kz/kZbSgubTzRv
	ovI3ENZ1dxFKxas6cr4hm6WxpC77gNiHm1hbTI8IOHGiIOFWfJqoy4/3xj9BmJPN0c9FcdbfeTVtE
	4q++TvvLlV2TrPsalvx158XeDsXKSuBIuU3Y15lxUjOb1bOumB8a5eZGgrjx9jxlYeVYLwM0oMl24
	f0PkrpRFKGC41bNLxkyGNKTO61f76nA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSckL-0001MD-IO; Fri, 30 Nov 2018 06:57:53 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScjr-0001KL-9x
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 06:57:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LF71b13fgHPUHtTaiyfpFN0HFsoifOk7GMClP6Pim6M=; b=PV/PyozUwGcrUdUtzhOI3zxuN
 UEOQhEZbK21Pcu5AxMbXtYPRxJ2eIITRrRJx3v3y1dNfK5Cs67o1nsyQwA4SOozq+L224Ggxki0CU
 ugV9vy+XHuLeYEavUufIrfu1ngTd0BRKDGQ4dGYCk7+ewKx5huLAl9SXhTAMMu5wQnUOUzt6Cjo9G
 7y6Dd3QY50J5IEMccd3af9vbSLPa55ySd56xvu4+4Uaph81EtZT5/FZCQNgi8iUojbW+ISPlqH8N9
 qNZ49xZdD6hw+SBAfh4HnCVFB2qLmWganNwVVnQ22M+hkOhV0EoS4cDQlDUKONBNGxdNBoIknd3pS
 Z1uWziJlg==;
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScjo-0001HX-A4
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 06:57:21 +0000
Received: by mail-pl1-x644.google.com with SMTP id p8so2345310plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=LF71b13fgHPUHtTaiyfpFN0HFsoifOk7GMClP6Pim6M=;
 b=DwRLqOCfpAVYJps1zp8SYE8f89V3+uASAxRMngDArrSPT7Yupa8PVK+ZwhA2lQ4qvz
 2yAoWZVXpmgLyJgttOdozstTiy4Trnmav5JVPe0Ubld/KT1m/PGWD+12RpjKSGv6ofrW
 hYSzsNtMwGpA243VGnSpL5xZ87XNpYO3i6KNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LF71b13fgHPUHtTaiyfpFN0HFsoifOk7GMClP6Pim6M=;
 b=iqtv7hwzcGZwq19zGsVX9wM4/tENWVf9v3c25d57DSxNG1f27ltM9rmuwT6OEnQdFs
 1Wor8y6QbQuF3c3CfBkRKMi2tlWi350iW7P7UYuISm1deSwq3APVNMOD/2nzmTTY+V+O
 dA/ixKnDaLa1NzZECk6gIBU/6ZNm5vl7vhY3yUAWQWCSeZPJerP+juJc32rlGIaPnWif
 jUyjfEzuV5FOkmwfURbgyjLHR7OkBf8FDVyoeS36Q04vMgP9RSVnoIL3cwoKJbU+Uc6w
 rNeB4RZ2D1bnnNE/8kt5SSFSShgabGDq/sWSWB4M0mm1r+aGAOGnytAVng7EPqr5/eVO
 g1EA==
X-Gm-Message-State: AA+aEWYwb3/md+dgCvIU7h/SozeTUmVWBGUdvabK3UjWqHcZfyL+sshe
 ATQ/dphOAeE+K50+8S/WUQ5kow==
X-Google-Smtp-Source: AFSGD/X4EFFyZzm9grDUXkAYDjUiKAgWI6uYWzBLaWgwgC9B48+GkYcy9lKT57pK1H/e3eiSg+vmJA==
X-Received: by 2002:a17:902:5ac7:: with SMTP id
 g7mr4616497plm.212.1543561024868; 
 Thu, 29 Nov 2018 22:57:04 -0800 (PST)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id m3sm3950596pgl.69.2018.11.29.22.57.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 22:57:04 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH] arm64: defconfig: Enable GCC and PINCTRL for MSM8998
Date: Thu, 29 Nov 2018 22:54:56 -0800
Message-Id: <20181130065456.26605-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_015720_368839_EB0CAEB2 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: linux-arm-msm@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 linux-arm-kernel@lists.infradead.org, Amit Kucheria <amit.kucheria@linaro.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the GCC and PINCTRL for MSM8998 to make upstream boot to console.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f1f4eab89df..206f50d121ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -348,6 +348,7 @@ CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
+CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_MT7622=y
@@ -605,6 +606,7 @@ CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
+CONFIG_MSM_GCC_8998=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
