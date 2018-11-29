Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C634C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C1D20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tm1w2meD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA4K1Rqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C1D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XQjTrKpPcd4aoAz2EaUwbq4qGn+8+OEwlF4A/XUa+yg=; b=tm1
	w2meDH3GCglLZ1ollXtawOqt/bWdTiz0MdA/BfPWzu2d3EKztpxK4VTxYGJ1Kv2C1LP6NbChys5pY
	vAtPU6Z9EX1KBpukxEAEHsGRsFz0yDBlXTcMxuBXRIkcx872heEShDGbKMQcy7mbVtfrpug62j6be
	rQEI3j5mPyi++XB0/RX6tSOJxflHzw2pZYUHyo8u9IUOcNZEIJF4BcyDTULjs/rml+K2aeq8S/emg
	RLCu52i6o8VnrmFUbWe5CShnsqJAr4eLhquLo5qW4FKRtTl4ZiQTxfEZVJee4UDWXchZ1A7rwGDO7
	JVHgPuMFsDFcuuYuyp8HsxwFBtG4jdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUqH-0001fF-86; Thu, 29 Nov 2018 22:31:29 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUqE-0001eW-US
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:31:28 +0000
Received: by mail-ot1-x344.google.com with SMTP id t5so3378012otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6rPh/rh1j/B5PJ7a0qP/YC8Qynn+4nZWm4wlGneDPew=;
 b=SA4K1Rqjmg548jntNTLRoJWTKq3auGH3O0bbUEwFmLjcdGOikv0ZlUnK5Kz3EL6PQx
 ZDTB0lEmh9TCpBCuH9RsDxWA+m2XTjwBOlo8/DplSvwQO69dCeIzD6uD9Osj+syzXh5r
 7yAbjv9rp9u8Hd7jvGWNyYgkz347Pv4en9oa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6rPh/rh1j/B5PJ7a0qP/YC8Qynn+4nZWm4wlGneDPew=;
 b=otyZA4fuFVSnzY49ahaXeDwabp0MfryOsXjz1jY943kMvu93TcErWI5X0MXF8gPNHR
 x16bh/rveV83JzSS58YyMxcOAWi6p8G60p/oa+dIiuOl1vm6h8J1mIYjDpI34JC539HS
 FogewrxK5QHtvNEOZX55sV5qYCn1tMi6HHvFGgiIJcv4vwpeGoAEqMUa2VDDTIxP31dH
 5ymmoQxgWTFWUmqmVU2Ugd9/7EvAwTS0GnR8QQt6hlKXlMaCFwxcFiwDX7LpEIO/NdOX
 1xLhiIo1U90wkfx3Av1oE04+7NTN09LagdJ5F7VEPPTxi3NZ8w7OVMTb/4kB1bOByhdg
 dq9A==
X-Gm-Message-State: AA+aEWbHAC/o+O7a0Ra1twdK79JKtkn8f+wqvzl+rnmnLyjvcGjsuv+T
 lky+Qb3TcwP5Dc6FrntKaE2gow==
X-Google-Smtp-Source: AFSGD/XaifEk7OzJSHf+bDrVKQP6AM6h20i33Wtmg+FN6+ty/puE1hKccobrja/fPGPA+KouGwMjLw==
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr1917023otp.17.1543530675368;
 Thu, 29 Nov 2018 14:31:15 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
 by smtp.gmail.com with ESMTPSA id l20sm1057777otp.47.2018.11.29.14.31.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 14:31:14 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [PATCH] MAINTAINERS: Remove unused Qualcomm SoC mailing list
Date: Thu, 29 Nov 2018 16:31:06 -0600
Message-Id: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_143126_984846_1567226E 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch removes the linux-soc mailing list from the Qualcomm SoC
entry.  We use the linux-msm and there is no need to have the second
one and this clears the list for use by others.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..be25ffe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1922,7 +1922,6 @@ ARM/QUALCOMM SUPPORT
 M:	Andy Gross <andy.gross@linaro.org>
 M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
-L:	linux-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom-*.dts
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
