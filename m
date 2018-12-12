Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D402C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEC920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSkmrjtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEC920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ng8LgbFiWdiJ5XZkdaLtU3G2pxeK+as/gn7KsrpKDxg=; b=tSkmrjtm/JpF7T
	0QkCxq0XZr2a9GKBBqW1+YW8s8GGOf4YfSWdfm0C5RcFtXUnF4JFwIPf15fxPihi5POiymU9XVs9G
	sNxz+MIZUjjsYO/0eGxs1zD8qyZY2lSsBZd4yUxauiItFUNcRDEcbX/fPsMm64HY8xU3j0FfRtKAi
	8QJQghfHzJ8hYzGl8XT1F2+MOkQmMpXtUNzikwCvPr2jqMrwt12jS7littQZ/WrRjT8cq/eP3QRc6
	eA+XTUWtHKOcyLmcnt5brWnksg9SUOqNuWAwDpCAEOorbFUxvB3PfaLAbBRWC8BV3g/XDNVL81XRJ
	rbGRMnpGImXcoIXBKhrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXEIV-0000Mh-03; Wed, 12 Dec 2018 23:52:11 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEIR-0000Jb-RZ; Wed, 12 Dec 2018 23:52:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id F355610A1D8D;
 Wed, 12 Dec 2018 15:52:00 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 08fLAr93OSi3; Wed, 12 Dec 2018 15:51:59 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 38D7D10A1D97;
 Wed, 12 Dec 2018 15:51:52 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 45CA32FE36F1; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Lee Jones <lee.jones@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 5/5] ARM: bcm283x: Switch V3D over to using the PM driver
 instead of firmware.
Date: Wed, 12 Dec 2018 15:51:50 -0800
Message-Id: <20181212235150.6491-6-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
References: <20181212235150.6491-1-eric@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_155207_919212_43C003A2 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GRAFX domain only contains V3D, and this driver should be the only
accessor of V3D (firmware usage gets disabled when V3D is in the DT),
so we can safely make Linux control the GRAFX and GRAFX_V3D power
domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v4: no change

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ----
 arch/arm/boot/dts/bcm283x.dtsi     | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index cb2d6d78a7fb..21a930148709 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -87,10 +87,6 @@
 	power-domains = <&power RPI_POWER_DOMAIN_USB>;
 };
 
-&v3d {
-	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
-};
-
 &hdmi {
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 20ed8b1da11b..9777644c6c2b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/clock/bcm2835-aux.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/soc/bcm2835-pm.h>
 
 /* firmware-provided startup stubs live here, where the secondary CPUs are
  * spinning.
@@ -120,7 +121,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		watchdog@7e100000 {
+		pm: watchdog@7e100000 {
 			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
@@ -638,6 +639,7 @@
 			compatible = "brcm,bcm2835-v3d";
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
+			power-domains = <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
 		};
 
 		vc4: gpu {
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
