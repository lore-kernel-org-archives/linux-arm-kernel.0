Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E167620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a1ZD1JiJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUtYRSZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E167620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=usHZzW9Yd47IjPgPs9dh0XYv6CVix2S8KETBrCnLJEU=; b=a1Z
	D1JiJDJ5ysQD+gTvO1v3ejXd+29VNo6mxfwgvEbiEC+6MxeZxDOKVZYyx4B+HnFXH0EImZ24mQqKv
	q8PBb/Aq38Q49CnFhkMzaNjAN/EuO3La84NQV7vcc0+ebiRrP6lCw3mlaBhIJL3ysqE8x3Mtusd7T
	so9zF9QmtAigbRKo6k2qSsFAy5MV9NzUlBivUAqOdPvykAmLLE5oLrlyEM1D9fF4sCQNqqL9kldwe
	4a1ho51luvXtL4LVcWwqQQ1MbcjPR3DJs+NxCSpRqwGpePV7dh4sLX947RswbK2aMW7w2QfXeqwyD
	ASjbSGOHrDZSnKUigpOP0hgVl0IqQUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gixY6-0001FZ-Jc; Mon, 14 Jan 2019 08:24:46 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gixY2-0001Ba-QJ
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 08:24:44 +0000
Received: by mail-wm1-x344.google.com with SMTP id m22so7882789wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 00:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=YkPn1xL2oiOArne/N0Ongdrcw7L7vib32IvSe9FF2Fc=;
 b=XUtYRSZy6SQeX2YpwgO/tK6iru2s/vfHaxM8c9QHOhdzWcpDi2pGL3qW8aBP7ah9Un
 MuC4eVNPZNmZw9euyORY+vlCZh713DQEIloLteThOJHFozL0eUMb25yE7OCAaw1oghqg
 zpLXVaWmeilM+jNaH9Zq8YsXk/KmFaABuUWDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YkPn1xL2oiOArne/N0Ongdrcw7L7vib32IvSe9FF2Fc=;
 b=o+BusRza9mFFza56nCi0NDRr1OPWQXyXNGyTEU3HqWnXfOOAmjt32zdm3KOJoiMwxT
 7xnjbWKTL4xnUwGPYEAaAFT8ddJZn2Yldl2Xr+W+Wcijk6FnJaesmTtPlEefP6OAtoFH
 YAwm4lPiPGwE7UO54sH2ns0WPs2aa8Qg/vzegWDcpRxfQiFO4IN22/H+qHz0XDSxNphE
 iLDY2YaWrgS5Bm+6SoyaBok5hiO8MIKbbi4aFueZPM+oaZxnJIDB3oa/5NOoGW+FW6j0
 pniFdLSjVK3utcIfX25TsKXAQYjsyBolfL58t5AQulOY8uEbneEkfDaobWwPpLX2G28Z
 QWQA==
X-Gm-Message-State: AJcUukdn7kwbThRZlErW4LCkOAxkUfIdFE9tsZ2vpvwHKbtJokxyqbVx
 TivUs51PmRj+VVZE1LBYTqNGkQ==
X-Google-Smtp-Source: ALg8bN4kQ/ZCwNziATs04XAyBFhYbz3xUAWh/PEVfSuMG4i4awWaMeCzNWuDpbk4lrMqAPyVyyYElg==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr10685396wmj.14.1547454277799; 
 Mon, 14 Jan 2019 00:24:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39ec:3900:1e09:314e])
 by smtp.gmail.com with ESMTPSA id i192sm28546146wmg.7.2019.01.14.00.24.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Jan 2019 00:24:37 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH v2] arm64/hisilicon: fix SDcard detection
Date: Mon, 14 Jan 2019 09:24:34 +0100
Message-Id: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_002442_858268_BE473D81 
X-CRM114-Status: GOOD (  12.64  )
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

The SDcard detection of hikey960 is active low so cd-inverted is wrong.
Instead of adding cd-inverted, we should better set correctly cd-gpios
to use GPIO_ACTIVE_LOW.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

SD card detection was not working on v5.0-rc1 but patch
https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
Nevertheles, latest changes in of_mmc_detection makes possible to have 
a correct DT config.

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 71bfe41..dc314e7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -665,8 +665,7 @@
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
 	disable-wp;
-	cd-inverted;
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
