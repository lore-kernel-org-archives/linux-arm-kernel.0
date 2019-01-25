Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1165C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51AC217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQhICHWX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8TV1liq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8TV1liq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AC217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UILPJ6Gy21QMiF/jrH0141guCxMn+V7whVvS5OK7d3M=; b=EQhICHWXZv6sRHNCZn+PYJQHh4
	HWYeS5loq5dknhDG+jsfv4asfm94tcX7alOM5XdY/X1Uvt2j3mf/LzUz8OcEayzF78+wwEDweDpw4
	Nx4SWWSzLUcrCn+Hs0KlQCCggxK5m9gvRdwbybyRHRA81KQ8QteQHDIlgsYjFSsuhvq9/5jn8B6zc
	lkOP0RngXrb0hImEBLdfUnnfa8V5uAXdtp5GZ2CzumR3nwGsjahmRAPddevWVhzo37yqr4kP+ny4V
	ieNW9H+bwxlFoj/THclt4cB1vM8quan9JJtlehqC3jKMmPk9au13YSYpIBWCXM6d+i+uevvAHSO/N
	WzCWtPHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrgG-0006rQ-Qm; Fri, 25 Jan 2019 02:57:20 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmree-0005bG-IX
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:55:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 73B934E204E;
 Fri, 25 Jan 2019 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384940; bh=ixvNVeF1Cz3AKqfX15lAQdMhkXdlfdPWW1FxryLNR5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b8TV1liqTwL8ktdK6mmTzXnWJdLb2cWPWGTwkNEkuNTpxGwj2qXv9qw2Q4XN/DpJw
 eqEd6mzk0Y9Y+ZGG76Rld3ebdL0Fg4zbEnWb0X3Hm0E+ZseEDNkB4H65k34JBqI0ot
 nJgU701tthu6yRbmKKxlNSgQzfGJBtHo1HlTyK4I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqoVl4IQzJnH; Fri, 25 Jan 2019 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 83D214E204B;
 Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384940; bh=ixvNVeF1Cz3AKqfX15lAQdMhkXdlfdPWW1FxryLNR5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b8TV1liqTwL8ktdK6mmTzXnWJdLb2cWPWGTwkNEkuNTpxGwj2qXv9qw2Q4XN/DpJw
 eqEd6mzk0Y9Y+ZGG76Rld3ebdL0Fg4zbEnWb0X3Hm0E+ZseEDNkB4H65k34JBqI0ot
 nJgU701tthu6yRbmKKxlNSgQzfGJBtHo1HlTyK4I=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v4 5/5] imx8mq.dtsi: add the sdma nodes
Date: Thu, 24 Jan 2019 19:55:28 -0700
Message-Id: <20190125025528.15645-6-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185540_620876_5098CA74 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the sdma nodes to the base devicetree for the imx8mq

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c0402375e7c1..f0cd3675ead0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -336,6 +336,17 @@
 				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
 				status = "disabled";
 			};
+
+			sdma2: sdma@302c0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x302c0000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					<&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
@@ -370,6 +381,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
 				         <&clk IMX8MQ_CLK_UART3_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -381,6 +394,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
 				         <&clk IMX8MQ_CLK_UART2_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -432,6 +447,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
 				         <&clk IMX8MQ_CLK_UART4_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -465,6 +482,17 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					<&clk IMX8MQ_CLK_AHB>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
