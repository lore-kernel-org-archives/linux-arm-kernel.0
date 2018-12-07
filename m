Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F096720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQf9RBKq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZDeE0r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F096720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=G0TAjMj0zcaDbJ1HdJ9xamTTBYNB6a5Hyycuu7ZqjEI=; b=NQf
	9RBKqJX1NgBm6V5oX3Pt00EoMljwtyHVjzBXO3TAbc93knDi8ufkljja+0EerOEUtkIVwRscykzA6
	GvjPjk6KcBbG+Ky9Ee+6ry6OYNJh+ZOzCBRuUivJ1CrG8SNWeaA+kG20LS0qo17r4vJoEpx0PB06l
	xvz/MiM0Z7FHpdGRJYKek2fDG20DcuWOdIga6LnmoC0V98Wckuuk2YZYhCUXjEcvk7s1TkWLfXUK3
	UnnWuZv77xIDeaNsDQdt0nlgXnxJubuPTCMSKGO36BnqSdHBbGXoAAzBmXVVUAomigMaQ/sTZJlKN
	4f2orhqgQhtyV9zKfHLbD22V1XwAZjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKwf-0006lQ-Gd; Fri, 07 Dec 2018 18:33:49 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKwb-0006i3-F9
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:33:46 +0000
Received: by mail-oi1-x244.google.com with SMTP id a77so4145340oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Z+OkHCisvBxZsy+X3UyHjH66uf807Am4vdaT+ezHLBc=;
 b=WZDeE0r2bMeq7H+bvXDnDGm1O/EAF9s/lBFinFk7K+ZMYs1JfKHPgZwQW1O6bQqNou
 QXWrreex56FZgDyqjWodPVFxMEMHFxz1vcXis52T1ReIcbsEZqm5Q9WHgaQIHmkxd1oB
 eS+5HYvN9P6Mkb98JzsjhyI9Kjll7PEISG/Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Z+OkHCisvBxZsy+X3UyHjH66uf807Am4vdaT+ezHLBc=;
 b=saFDv3q90IzFrJdV26BUxmD07qsXidZBasaAsaGWqHT1ixfefVR6ftRtkqANkt5cdV
 l97daK+QcCQdHSQUmJvlU2qUnhRew5ownpVHJGqHFOGI4lIPz+5y/EUtK9yfY8hLa2lx
 BLDwPKmz0+ki0Bli6CavK+d6ueCRO1vBXCZ4ITdA/+3mDKSK3XlN2jQ5x6VfmWnp2w+Q
 t4EJ6kEvo8lZ3EVfiSyS7GoT80snTcUHuRZacIS/OhBr4G0gEura+sWNMl47pufDf7tL
 q4zPiYxJfYrBmPva+IDnz81zAbsTEebpg08GorDqSz9hn0mV7e0xXjL0k3N+vAfZsxIx
 2kBQ==
X-Gm-Message-State: AA+aEWZc2XTZAq+gozFUwGcHy9un7UvtZmY3LUfNa0h9dUgl4MYpEDZj
 Lp991FJJMQDmCsPsVyyVbSdzKA==
X-Google-Smtp-Source: AFSGD/W3Wa9/tgV7SB/hTeJ7SKk4Bcc8ga6HOShq+UNdNfelAuwq+LLiH2zJG5osMkxreXZIgt9ehA==
X-Received: by 2002:aca:aad8:: with SMTP id t207mr1753818oie.90.1544207613349; 
 Fri, 07 Dec 2018 10:33:33 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
 by smtp.gmail.com with ESMTPSA id v3sm6136295oib.57.2018.12.07.10.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:33:32 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm: dts: qcom: msm8998: Fixup clock to use xo_board
Date: Fri,  7 Dec 2018 12:33:25 -0600
Message-Id: <1544207605-23901-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_103345_516943_29492555 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch sets the msm8998 xo clock name back to xo_board.  Recent
clock tree changes fixed the clock tree and the change to the xo name
is causing issues.  Let's change it back and leave the xo label on it.

Fixes: 634da3307b08 (arm64: dts: qcom: msm8998: correct xo clock name)
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 49f0fee..c2423c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -54,7 +54,7 @@
 	};
 
 	clocks {
-		xo: xo {
+		xo: xo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
