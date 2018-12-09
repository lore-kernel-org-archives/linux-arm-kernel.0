Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528A320661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cecR/WtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528A320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fUyHJNbu7lFnCujWnuIDoXb7p/Peklv39X2BQplTXyA=; b=cecR/WtRNs9wlGDuHklReeqyu6
	C3KYYmYFwlXkbVF+YVoIMD73z+qrD/k4bQZ9G5FYYMrnqAG2bP5JohT9epJywV5fZQl7MFWU4D8o4
	++l0Vs/Ko+zztO395m5ctJX3xWUlwQ/gtoqHRBoiXA9CNrJGGn7atKmY1zvdDYFCg+hXpAmj18Gwh
	bAGnOEvMPdgG/5da41kpLKw/HCcLPi9AdrtzVtzXRzcsOxWHMJgGP5tLhG3kXc7xwxZrP5e2EcV2/
	4o+T1Bv3rQcT7vBEMrPmzQPYUVCgxmeqxyYjNFako5lB1vkTvXHQOFr/UJSTOLMPD8PN+Q46fdaGU
	wa/qmcQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW6zA-0004OY-HI; Sun, 09 Dec 2018 21:51:36 +0000
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW6z4-0004NU-PW
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 21:51:33 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43CfzR5Jf3z1qxKM;
 Sun,  9 Dec 2018 22:51:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43CfzR3Rm4z1qqkb;
 Sun,  9 Dec 2018 22:51:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id wAEq4KOGGl7A; Sun,  9 Dec 2018 22:51:14 +0100 (CET)
X-Auth-Info: 2r071s4YWjbLjLETqj+qetzUebsurUkfWEi2o9hiP2k=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun,  9 Dec 2018 22:51:13 +0100 (CET)
From: Lukasz Majewski <lukma@denx.de>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] ARM: dts: vf610-bk4: Provide support for reading ID code
 from MVB device
Date: Sun,  9 Dec 2018 22:50:56 +0100
Message-Id: <20181209215056.22027-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181113121213.14296-1-lukma@denx.de>
References: <20181113121213.14296-1-lukma@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_135130_982275_F587360C 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 Lukasz Majewski <lukma@denx.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The procedure to read this ID value is as follows:

rmmod spi_fsl_dspi
insmod spi-gpio.ko

echo 504 > /sys/class/gpio/export
cat /sys/class/gpio/gpio504/value
...
echo 511 > /sys/class/gpio/export
cat /sys/class/gpio/gpio511/value

rmmod spi-gpio.ko
insmod spi_fsl_dspi

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Add 'vf610-bk4:' to mail topic
- Change spi_gpio -> spi-gpio node name
- Change '72xx165' -> 'gpio' as described in
Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
---
 arch/arm/boot/dts/vf610-bk4.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index cab95714c058..c59a8922ccd5 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -59,6 +59,29 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	spi-gpio {
+		compatible = "spi-gpio";
+		pinctrl-0 = <&pinctrl_gpio_spi>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* PTD12 ->RPIO[91] */
+		sck-gpios  = <&gpio2 27 GPIO_ACTIVE_LOW>;
+		/* PTD10 ->RPIO[89] */
+		miso-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <0>;
+
+		gpio@0 {
+			compatible = "pisosr-gpio";
+			reg = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* PTB18 -> RGPIO[40] */
+			load-gpios  = <&gpio1 8 GPIO_ACTIVE_LOW>;
+			spi-max-frequency = <100000>;
+		};
+	};
 };
 
 &adc0 {
@@ -430,6 +453,14 @@
 		>;
 	};
 
+	pinctrl_gpio_spi: pinctrl-gpio-spi {
+		fsl,pins = <
+			VF610_PAD_PTB18__GPIO_40        0x1183
+			VF610_PAD_PTD10__GPIO_89        0x1183
+			VF610_PAD_PTD12__GPIO_91        0x1183
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			VF610_PAD_PTA22__I2C2_SCL               0x34df
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
