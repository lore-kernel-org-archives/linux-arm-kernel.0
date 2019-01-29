Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D614C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EF520882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OggsJgHW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDUpzE1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EF520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=el1gqESXLUYjQFB43ayjaUrkGE3YR7yQ2mKPuudiDBg=; b=Ogg
	sJgHWdYiy+HT0Tl7eEORzUpLeAIXetJdD5xZKy+7zlpShch1ONpPdq9KsPW3kRuateZibiftjfCdb
	0cnUJalfujwF0z4ygoV3X5OGQJE0CaGRf2WiGt9V5vBc9KAjyR58Dk9NXaobJhUkcynLtcYHp5vKy
	bV0N3nRFpHOJmQlUSP2Fqk9y8nLrx+mCCeC4a0Qlp2xnlSK3hBYmcg3/FmdlQ1cZoam1Qa81MNBZe
	8GcXnvWF0ApgOB/xxwWSUDfsmzfrFbU+pWzR74brwxHru6LQqCapT2SkmiGJfgCagv9WcTgS203hi
	0exyNnQ0g8tZRu2pWvVHGovAMMN93Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRfo-0007jZ-6J; Tue, 29 Jan 2019 11:35:24 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRfl-0007it-1w
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:35:22 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so17442764wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=NFHpMSLlTtGiK00UH+qqUo8z2oUdMcYvkTVCpigpA7I=;
 b=HDUpzE1NgNKjdsPmb5TS0IZiPnerLAb3UiWYUn1v3YguBkEvphCGQ+bBSdaC4kgg9z
 0/VTw53yaztyQpPjbYR92LL9yR2Z5Ah6jhMuQ+UGfIz9iOC3VlCP4XdASXZBURIFlfze
 TRr/dgzPiP6OQOIPe8cFfIz7P17p/VEGckJ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NFHpMSLlTtGiK00UH+qqUo8z2oUdMcYvkTVCpigpA7I=;
 b=CVqaMHWaZEJN28uNcj1aqLjq+csehv4wNcAbaykhaVTP50uvfDNEsWYECZecPsRsgB
 InLMQG9muDbWce4jKEVJVLMEtGpdRBr5kEsixblf6FEPAxfxhjpRbN+i+1mkyNvA48eL
 j6IyTOKeRKRwJLikCfU+14T9PP3mlyvbCdJZ6q4amhob/PNuyuQI1SdtplOz7eWuw2Xi
 j+HjjUS6yuM4ZFcC4vXdYqlxg0uDO4W2NdxDEhMdXQEquFoU2ZFlPog8Wwz+cqfATOEU
 bcIHJK6YPukA5Gq1equ2TKnp43qFhAhJKWtwKwt1npNCeksydU+FprLCT4hlqWPP+k/r
 FuoA==
X-Gm-Message-State: AJcUukfKqAye7HYZhzymZXITuQBlvc4/88q15jKajdZ/uRkYN0HuCGkF
 EgWxoXjLWdEbqTEcFCVXEqR4hw==
X-Google-Smtp-Source: ALg8bN5QEnvmAi7Y1KyHyRmrB0L9BVh5IljLopTV18ZaYb4ehz4WJUqv5971II3qOUD/AJGytxFKCA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr20272610wmc.21.1548761719213; 
 Tue, 29 Jan 2019 03:35:19 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id i192sm1960129wmg.7.2019.01.29.03.35.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 03:35:18 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
 mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
 andy.gross@linaro.org, swboyd@chromium.org
Subject: [PATCH v2 0/2] USB SS PHY for Qualcomm's QCS404
Date: Tue, 29 Jan 2019 12:35:13 +0100
Message-Id: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_033521_114134_ACEAE0F5 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This set adds USB SS PHY support to Qualcomm's QCS404 SoC
The PHY is implemented using Synopsys SS PHY 1.0.0 IP

The code is losely based on Sriharsha Allenki's
<sallenki@codeaurora.org> original implementation.

v2:
  enable OTG mode detection
  move vdd voltage levels to driver
  use bulk_ control interfaces
  ss-phy-bindings [1]

[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings (or
 delete them) I  propose that we go ahead with the new separate
 bindings for HS and SS: if  not now - investigation  in progress- in
 the  future  it might be  possible to have again a common phy driver
 for  which these old  bindings would be the binding agreement. 
    
Jorge Ramirez-Ortiz (2):
  dt-bindings: Add Qualcomm USB Super-Speed PHY bindings
  phy: qualcomm: usb: Add Super-Speed PHY driver

 .../devicetree/bindings/usb/qcom,usb-ssphy.txt     |  73 +++++
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c             | 347 +++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
