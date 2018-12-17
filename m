Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F86C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531372086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N6Yo9L9P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="et20Z1Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531372086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WyiWvCg7XXbkjgbplWkS3RPaam2aE0PYHt3KIf2EoUw=; b=N6Yo9L9PyqeNbiSgXL8bpc7xGA
	P0Kj9iU5ji4CX4V4pQRDOdwYmatiPMjdURKIZ5ZxN3zxDh/FpDPIiOEsH2sJy/Zg4FTU5qAdxbFyn
	K3ZeL1r3irATSsCgpe3s7iak9iNW2QPSlg3yR9ocUMSF67/kj+Vfxmhp3tBoIa5BnvaF30llo/2bq
	NOV8CVcQdLyNIA+OqTDpL8l5+ERFK16COA95VTC8/ZS7NNAHiYozrHenEgM6uLL5xSXHD39emjdq+
	AJSW+nNU1y3L6EtwfsfV3IXZtUX7OBMIJQ2uZ0traXrQIQuu/0y4EGC0x6GMEexWSZItCdsWAcF78
	63yO4PbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpWh-0008SX-J0; Mon, 17 Dec 2018 09:49:27 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUQ-0005yS-LY
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so10567036wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=frYLNG9WBBqiLZuXMzbyk9zPbudi5BcqFSN9a29J878=;
 b=et20Z1Nvhy4cU7BaSDu0Rr0o8eprDB52wxTtNTCZZIeVJB+REqsCz5LohKL6+c4bHc
 BBu8BsOZf02tVrTWV/4iNqxH5Xrryxvc8gCF4HXIhoB0FggKGUUPonfUccV/BjaAqgJ8
 V3bJfXiHcaCkhPVmE/5R33wu/PxiebX04HaEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=frYLNG9WBBqiLZuXMzbyk9zPbudi5BcqFSN9a29J878=;
 b=PF4RA0cXw0Yv1OGK7Tix5JKqUK6iSxeSbHsEsRR9vf7ptFXDb2ahkU4h84ZwIubaie
 u42hXX7AnDdoS+gEU0JUhYIf9Z3XkRPUjkg9vEXQwOR7uLiK5Z3do3WLzHnc9OhuyuEu
 8YW3bejDohxOxKB6t1nJYfWttw8Gzibu9p2xsbvLzCxujS+CiBTPOjKV+lQLb6tqgcLi
 fo/lz9x83h5B/2uLfDij4mkuDG7sWsj64t5DlaQm3Qz1sUjdROFnttT1oegRr3mpnotY
 uWepnysdEaB8dObMKbd3/mvcfTRbIcG2VwrYrQw8hdRhHgfvLvRZzxfo0JWip435XCAw
 QHhg==
X-Gm-Message-State: AA+aEWa/pvDPZaFQhevkPM1zoPmUSEyq5efsaiuUYPOXTLOAAcCXpIFE
 xZ8O1tljsMyJb8zkcNQ1TSH1NQ==
X-Google-Smtp-Source: AFSGD/Wm89lY5AWabPhjL97+zfhBn8ec4Izasd9Vo+Ys9CWY1kITyl9TwTkkjUL9dy/zq4p2/3eK4w==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr10609352wrq.182.1545040015164; 
 Mon, 17 Dec 2018 01:46:55 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:54 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
Date: Mon, 17 Dec 2018 10:46:27 +0100
Message-Id: <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014707_035709_80BA8EB5 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4594fea7..ec3f6c7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -375,6 +375,15 @@
 			#mbox-cells = <1>;
 		};
 
+		apcs_hfpll: clock-controller@0b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
