Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8FC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517AF20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l88ivGRi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAAxp8Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517AF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WZoMqe6o6AIvo7JssPRwe8IKHH3o1gOyuJwdQFlfDII=; b=l88
	ivGRiyzKhKYrbBF88+S8rUFHw7rGVI4T0ip9HXPG/agXldc5XOLPrRqvDoDHjpg/0gBrkTc+OEFZs
	OgLhtDjlDUYUJ36MQ/xmxVuDzuWzMhKvN3C3PxOioc+ZoujhRTatAmgS04srVYjhaTEk8O0yKAc1T
	2Z+gfwPwhVRj/VyIwD7Ig0hE9rWUkTW0KlxI8iVl6ax8Og0UHSGw3lJwxjrDM9PVllWVYgBC6ScIA
	zuLusyH5zS/bpaeIvOyB/iIuad4u0h6k+xhH8Y2KBOqTYxdQakjVk+U/nb53SQZXhqGfWbfe3NBZb
	4FG+pB7R2ptOcsWE6CAaf5gQuno6doA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWs7Y-0000LK-Uj; Wed, 12 Dec 2018 00:11:24 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWs7V-0000KR-DV
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 00:11:23 +0000
Received: by mail-pl1-x643.google.com with SMTP id k8so7681187pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=zURcSulZ3bk3CM6s/TkG7szyZKknfdO5/AOWCy6FGe8=;
 b=XAAxp8Bno13Pb6LEHQ2MLfT3PDqPF6okkdSfO15WDSfy8Ns9myQsvBISrryXB8IYUL
 IeKJkoks8Ymxbrqj0dHgXkxVOIi6ofvOHP5PLoi/iAXptJoVpkOOem19ULedYJg3m6D4
 WJzFOT5w6VYY1ZRdUzK5+L0c02WyAw85P6x/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zURcSulZ3bk3CM6s/TkG7szyZKknfdO5/AOWCy6FGe8=;
 b=kOapv3LfgvN3jwXepDga6u8HLgVm0EmVLVAcbfUzJ4giB32hHbvOKUNllGHlTV3hOs
 Fi67pSWDLUtNTFyOIw4U/nA1N5g6hjzvG77ZOVn7csDoa9q29mdahZX5DAGm9z1yujyq
 lYY3AnuX6pNmRJglfsihQ8jmx2F+OGJjSNE8fTNxn3dSNbla+DnWfjRJpdlOaoNtMQPd
 SYD+TbIor0pOdX9cDX6WVnJWLWe0v1dHjSuTPHvo6Hyh72oCrQ8FnkRPjrJaGmu5awth
 i5X2JhdLKvDHbCfnS5iCM86VFklV/sDi8QsC0DyHRFwgd5DdYkwkBfk3mWrLqDrteEFZ
 jJVw==
X-Gm-Message-State: AA+aEWbKDkJcX22FSmGH45R4j7DiRUDMS+RnPMVCwoyPP9FbEnuVpwo9
 vWUqm3f6aogTafJiTEV65sho3g==
X-Google-Smtp-Source: AFSGD/XvCjDscH5ByJSyC1jMS7b4mHycs5351lEnuq37djH1TqVJcM80CCXLGUgwLjy4MhEzb+8hZg==
X-Received: by 2002:a17:902:31a4:: with SMTP id
 x33mr17583636plb.41.1544573469271; 
 Tue, 11 Dec 2018 16:11:09 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 u186sm22821188pfu.51.2018.12.11.16.11.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 11 Dec 2018 16:11:08 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date: Tue, 11 Dec 2018 16:11:05 -0800
Message-Id: <1544573465-32314-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_161121_457356_93040F0E 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add dma0 references for bluetooth uart to enable dma
for bt transfers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I85d36cc492a5f392cde214b144b19469e951585a
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 97d5bf2..c3b17dd 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -319,6 +319,8 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
+			dmas = <&dma0 8 &dma0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
