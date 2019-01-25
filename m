Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0912085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zs+Bmmwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0912085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2apXxHi2LADZSMZLB+ILp8ZYQT6wAAs18Mjb56swRbg=; b=Zs+BmmwfPe38I06jKT0uRiC/zI
	jGaOH/30mrM09Pfjm1C9wHhuICMWKGlJMwt76+d9PcuCp25Cyfolkj2VW1dRL5PoCBBfBBdlUJPtW
	jijFv0egfCLbAx2iABSMdztKaZWLpFZ9NcsEauh4l2f0sYXpotkux5KCbQr+BMsIU00HbXGcHvJUI
	JG7RKNdwm2u54E5vIqKa/2MrAtni+XXEe2ObAOzVfOIzVjXClGbjbN+907WobPrEgBypHgBnybwL9
	isdr/e4VuRl+6o45yDVUdM39UH/qIHjgtG3dvOkpKgV5GIgrMS5t3OlRv7A3ljUHS6VOpM/w5+vPG
	te2HUvIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2Fd-0001pj-Ak; Fri, 25 Jan 2019 14:14:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2FJ-0001Yo-WA
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:14:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11C51650;
 Fri, 25 Jan 2019 06:14:12 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D01893F589;
 Fri, 25 Jan 2019 06:14:11 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: mps2-uart: support combined tx and rx irq
Date: Fri, 25 Jan 2019 14:13:17 +0000
Message-Id: <1548425597-38175-3-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_061414_045349_8310FAA7 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that some designs went for implementing only combined tx
and rx interrupt, which is currently not supported by the driver.
Support of combined irq is built on top of existent irq handlers and
activated by the hint form device tree.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/tty/serial/mps2-uart.c | 89 ++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 6da0633..e5fe764 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -66,11 +66,17 @@
 
 #define MPS2_MAX_PORTS		3
 
+#define UART_PORT_COMBINED_IRQS	BIT(0)
+
 struct mps2_uart_port {
 	struct uart_port port;
 	struct clk *clk;
-	unsigned int tx_irq;
+	union {
+		unsigned int combined_irq;
+		unsigned int tx_irq;
+	};
 	unsigned int rx_irq;
+	unsigned int flags;
 };
 
 static inline struct mps2_uart_port *to_mps2_port(struct uart_port *port)
@@ -232,6 +238,17 @@ static irqreturn_t mps2_uart_txirq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t mps2_uart_combinedirq(int irq, void *data)
+{
+	if (mps2_uart_rxirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	if (mps2_uart_txirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
 static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 {
 	irqreturn_t handled = IRQ_NONE;
@@ -275,26 +292,35 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
-			  MAKE_NAME(-rx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
-		return ret;
-	}
-
-	ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
-			  MAKE_NAME(-tx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register txirq (%d)\n", ret);
-		goto err_free_rxirq;
-	}
-
 	ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
 			  MAKE_NAME(-overrun), mps_port);
 
 	if (ret) {
 		dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
-		goto err_free_txirq;
+		return ret;
+	}
+
+	if (mps_port->flags & UART_PORT_COMBINED_IRQS) {
+		ret = request_irq(mps_port->combined_irq, mps2_uart_combinedirq, 0,
+				  MAKE_NAME(-combined), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register combinedirq (%d)\n", ret);
+			goto err_free_oerrirq;
+		}
+	} else {
+		ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
+			  MAKE_NAME(-rx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
+			goto err_free_oerrirq;
+		}
+
+		ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
+			  MAKE_NAME(-tx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register txirq (%d)\n", ret);
+			goto err_free_rxirq;
+		}
 	}
 
 	control |= UARTn_CTRL_RX_GRP | UARTn_CTRL_TX_GRP;
@@ -303,10 +329,10 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	return 0;
 
-err_free_txirq:
-	free_irq(mps_port->tx_irq, mps_port);
 err_free_rxirq:
 	free_irq(mps_port->rx_irq, mps_port);
+err_free_oerrirq:
+	free_irq(port->irq, mps_port);
 
 	return ret;
 }
@@ -320,8 +346,13 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	free_irq(mps_port->rx_irq, mps_port);
-	free_irq(mps_port->tx_irq, mps_port);
+	if (mps_port->flags & UART_PORT_COMBINED_IRQS) {
+		free_irq(mps_port->combined_irq, mps_port);
+	} else {
+		free_irq(mps_port->rx_irq, mps_port);
+		free_irq(mps_port->tx_irq, mps_port);
+	}
+
 	free_irq(port->irq, mps_port);
 }
 
@@ -511,6 +542,9 @@ static int mps2_of_get_port(struct platform_device *pdev,
 	if (id < 0)
 		return id;
 
+	if (of_property_read_bool(np, "arm,mps2-combined-irq-only"))
+		mps_port->flags |= UART_PORT_COMBINED_IRQS;
+
 	mps_port->port.line = id;
 
 	return 0;
@@ -529,11 +563,6 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	mps_port->port.mapbase = res->start;
 	mps_port->port.mapsize = resource_size(res);
-
-	mps_port->rx_irq = platform_get_irq(pdev, 0);
-	mps_port->tx_irq = platform_get_irq(pdev, 1);
-	mps_port->port.irq = platform_get_irq(pdev, 2);
-
 	mps_port->port.iotype = UPIO_MEM;
 	mps_port->port.flags = UPF_BOOT_AUTOCONF;
 	mps_port->port.fifosize = 1;
@@ -552,6 +581,16 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	clk_disable_unprepare(mps_port->clk);
 
+
+	if (mps_port->flags & UART_PORT_COMBINED_IRQS) {
+		mps_port->combined_irq = platform_get_irq(pdev, 0);
+		mps_port->port.irq = platform_get_irq(pdev, 1);
+	} else {
+		mps_port->rx_irq = platform_get_irq(pdev, 0);
+		mps_port->tx_irq = platform_get_irq(pdev, 1);
+		mps_port->port.irq = platform_get_irq(pdev, 2);
+	}
+
 	return ret;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
