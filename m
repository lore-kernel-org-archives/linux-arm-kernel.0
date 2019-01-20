Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC3C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:00:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A40A2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MUuddyB0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="gDLKuQar";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="gDLKuQar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A40A2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hBos4b/clYIxTpPMNwal5bfKplyBQZ1Z0IT2iK9eUbI=; b=MUuddyB08S5XVign5oawkBtitM
	MUtQzZTdqYuJ2G7YMSr/Os/7tIXer3OsvTE4k+MgsdyO87auE22hTz9m+kLcXbfeRpkcKRxwLvIbT
	p9A9H72PGHzHJCf6KLwt/iv6MO6rq+yf/EJcwBkk8uT7xbSmkOQQ+JM4yfwT2SAjKBdPEaVnWwBtN
	7kdmi3d0JDxzQW2ClfhWO7Olt4sL7E1o49GIUAhDc8fNFCpLAHTw8gmAb2SJaKEYyyRQa3RcoL8sZ
	b9HRpwqEncE7W63ry4Z96EVPoMsy6kGvwDX/Dhp0qJj2IDLG2TK+OTmJ7bN5hSjLDNZTIqboa+R9p
	nnLoWoiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2Ox-0008DV-Hq; Sun, 20 Jan 2019 01:59:55 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2OB-0007Wo-9m
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 01:59:10 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 8A1244E204E;
 Sun, 20 Jan 2019 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949543; bh=JfVOWgR5QuG6tpKoIHNNbXibSECl7RMA1pHlN2DEzyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gDLKuQarzZ3TIRJsr40nKxkhOmoMFbbIQZvaVqg10UNmuhUA5Vn7HGVZQaKcezFuS
 fLLX/fmaNlYULes0zS3pURJZkGQ0KVQ4E6TVrXTX1rFJRQg9YUYiMDrIbjNJRPjX2v
 ryOx31lAo19tslYj+QRJ61kU66/Nbbaj30Z84gc8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tWVVph7veH1K; Sun, 20 Jan 2019 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id BF9704E204D;
 Sun, 20 Jan 2019 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949543; bh=JfVOWgR5QuG6tpKoIHNNbXibSECl7RMA1pHlN2DEzyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gDLKuQarzZ3TIRJsr40nKxkhOmoMFbbIQZvaVqg10UNmuhUA5Vn7HGVZQaKcezFuS
 fLLX/fmaNlYULes0zS3pURJZkGQ0KVQ4E6TVrXTX1rFJRQg9YUYiMDrIbjNJRPjX2v
 ryOx31lAo19tslYj+QRJ61kU66/Nbbaj30Z84gc8=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH 3/3] imx8mq.dtsi: add the sdma nodes
Date: Sat, 19 Jan 2019 18:58:51 -0700
Message-Id: <20190120015851.11797-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120015851.11797-1-angus@akkea.ca>
References: <20190120015851.11797-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_175907_348754_CD1146CF 
X-CRM114-Status: UNSURE (   9.63  )
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
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the sdma nodes to the base devicetree for the imx8mq

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c0402375e7c1..0b9a9b5ae7b7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -336,6 +336,19 @@
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
+				fsl,ratio-1-1;
+				status = "disabled";
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
@@ -370,6 +383,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
 				         <&clk IMX8MQ_CLK_UART3_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -381,6 +396,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
 				         <&clk IMX8MQ_CLK_UART2_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -432,6 +449,8 @@
 				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
 				         <&clk IMX8MQ_CLK_UART4_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -465,6 +484,18 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					<&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+				status = "disabled";
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
