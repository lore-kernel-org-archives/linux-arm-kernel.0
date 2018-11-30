Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826FAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506292086B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZjxV48/C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3ccBmkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5U9smZgZDwclmj8hoV8T5KA3xxGFJOSLACZoMzDOv10=; b=Zjx
	V48/ChIdBKv8GM8GNHjnHsUneTEoAKwnaLGXL+5HbbyzNHAiQSPkteKDVdjWrCTZOjPD2rmX6/nwy
	fMQhaxHj1I6tAB3XkBpoX4Vbckrkigi4/A0nXhppyj16aOQZjxOY+fdKwAeXUnQHuLbm3v6GObPWr
	HX+DUG46cFjLSUGsw5i6KD5C1i73So78Qy2mAzq+9YPKcnpO9Ey90k4S1kiRQMiANO7ohXFLBPfhr
	vHD9dLLRQmn9MEHdYBNhjpCQe/ZyCyFhAlAeSzESPZncAboFrAwRe3IgBVtKPA2iwIG2PnS2X82a0
	K4X0SP+ph/1Y1C6UfaStUe3vzqRY1kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXVt-0005AB-Ua; Fri, 30 Nov 2018 01:22:37 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXVp-000597-UK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 01:22:35 +0000
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so4152403wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 17:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=tO8nw6FUwpyV/om1q12v1m6KplW0p0N/EvdXjasG7+s=;
 b=W3ccBmkHBn//eyInWmkdCk9AwLo+K/WAuzaIt3meyD/Uuj7UD8fPwfkMvhoIqW3j/0
 E/UUmj4Vv+E0IhTKgGmix2A5do0K4trlZjTui35QKpKyGzkwyW0H/zfw1pgyFaSo71yD
 E3pGS8nOMWeijVL/hDyXQKYJPorA01ozicfq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tO8nw6FUwpyV/om1q12v1m6KplW0p0N/EvdXjasG7+s=;
 b=qLHCOs1YeKGpTCUSrE++uAs/T9gaWlY2C8KQwzCOp/c/LcmogldXkrVXemj0Bxe0F5
 f0SQr4EDI2hcxc5p9tdJIJV4IS9cF8Ih/eJPvb/PZYRE10frtnWR5AZJpOx1omYtAxUq
 XZw4jhvfYay9Q/v7DliTRN00fkY9f2ialFZh5maul4y9UNxJRgdFnb8z/N/DXWZEi7bT
 vWOwZNbKEZ586Uy6lnbXFlrVol3lM+JDCRDil+M6VWn9eKMrGXP2pUk6P1Nqtb1+SQ3Y
 98ICavDBTpEU/epUrsf342g9rJHwmFrvgCVYrnBjPaejkrGobi0cIQZ6jHXy2jVT/ICf
 BXbg==
X-Gm-Message-State: AA+aEWYE4qLSCFGhxMcX82YPp0Xec/fYKrxAELOe+eMEoByzaYrJDsci
 qmMbqAEojVFbEFlz5UGsU+ur0g==
X-Google-Smtp-Source: AFSGD/XhUfwNpUDCjB6gJX/mzKJvBXxRzoQEUJpVum3eZNAipV6IGQDQeKO3kLKJ0MsPGJnPPgPQIw==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr3592117wmc.34.1543540939762; 
 Thu, 29 Nov 2018 17:22:19 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id s9sm2521154wrw.26.2018.11.29.17.22.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 29 Nov 2018 17:22:18 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
Date: Fri, 30 Nov 2018 09:22:04 +0800
Message-Id: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_172233_976976_7102932D 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460..e8819d7 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
