Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F361B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="agB1vbJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F361B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=J0rE/hFDP8TrILhJ1+wCSNvKPZbWCa6U3Q9aqb3S/tI=; b=agB1vbJeJSRwidkxYt+1BH4tKU
	j5xrSi6VVWpkl0cfM99zQ8OvRsrme6axcoAHEtHolFNg4+zpm4KAwJh01am1Qitxftva5h8Z7y7n3
	w2IP0SOuy0t87KVnUQQTyPlMaTE++xYspIMDEap7YSmAgd9h6DeCZMVquU/PYJrZIY98eCrbA77Si
	GgdIEUyBvVut5HdZkXlfo6Nzju/WqlMYnqFjO3zrr1rs0DC7n43mbW00zRftMGC6pdh/pEJhDANVI
	Jyq5xDWvpPzvrV1vzRy1kBuIDlAvASiBHZxLmUPwKv8CqZtubCdY6oWTQmJUk4nlLzK5vHr2OiP6n
	mwzzYeGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gombT-00071V-B5; Wed, 30 Jan 2019 09:56:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomaq-0006NR-Bt
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:55:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39AEBA78;
 Wed, 30 Jan 2019 01:55:40 -0800 (PST)
Received: from bc-d3-1-12.euhpc.arm.com. (bc-d3-1-12.euhpc.arm.com
 [10.6.16.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44DD33F557;
 Wed, 30 Jan 2019 01:55:39 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] serial: mps2-uart: support combined irq
Date: Wed, 30 Jan 2019 09:55:15 +0000
Message-Id: <1548842115-14782-3-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
References: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_015540_415435_63FDB2EF 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: greg@kroah.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that some designs went for implementing only combined
interrupt for rx, tx and overrun, which is currently not supported
by the driver.  Support of combined irq is built on top of existent
irq handlers and activated automatically if only single irq was
specified in device tree.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
Changelog
	v1 -> v2
	   - overrun interrupt also combined with rx and tx
	   - count number of irqs provided via dt to detect
	     use of combined irq.

 drivers/tty/serial/mps2-uart.c | 91 ++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 6da0633..4404eb7 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -66,11 +66,14 @@
 
 #define MPS2_MAX_PORTS		3
 
+#define UART_PORT_COMBINED_IRQ	BIT(0)
+
 struct mps2_uart_port {
 	struct uart_port port;
 	struct clk *clk;
 	unsigned int tx_irq;
 	unsigned int rx_irq;
+	unsigned int flags;
 };
 
 static inline struct mps2_uart_port *to_mps2_port(struct uart_port *port)
@@ -265,6 +268,20 @@ static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 	return handled;
 }
 
+static irqreturn_t mps2_uart_combinedirq(int irq, void *data)
+{
+	if (mps2_uart_rxirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	if (mps2_uart_txirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	if (mps2_uart_oerrirq(irq, data) == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
 static int mps2_uart_startup(struct uart_port *port)
 {
 	struct mps2_uart_port *mps_port = to_mps2_port(port);
@@ -275,26 +292,37 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
-			  MAKE_NAME(-rx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
-		return ret;
-	}
+	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		ret = request_irq(port->irq, mps2_uart_combinedirq, 0,
+				  MAKE_NAME(-combined), mps_port);
 
-	ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
-			  MAKE_NAME(-tx), mps_port);
-	if (ret) {
-		dev_err(port->dev, "failed to register txirq (%d)\n", ret);
-		goto err_free_rxirq;
-	}
+		if (ret) {
+			dev_err(port->dev, "failed to register combinedirq (%d)\n", ret);
+			return ret;
+		}
+	} else {
+		ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
+				  MAKE_NAME(-overrun), mps_port);
+
+		if (ret) {
+			dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
+			return ret;
+		}
 
-	ret = request_irq(port->irq, mps2_uart_oerrirq, IRQF_SHARED,
-			  MAKE_NAME(-overrun), mps_port);
+		ret = request_irq(mps_port->rx_irq, mps2_uart_rxirq, 0,
+				  MAKE_NAME(-rx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register rxirq (%d)\n", ret);
+			goto err_free_oerrirq;
+		}
+
+		ret = request_irq(mps_port->tx_irq, mps2_uart_txirq, 0,
+				  MAKE_NAME(-tx), mps_port);
+		if (ret) {
+			dev_err(port->dev, "failed to register txirq (%d)\n", ret);
+			goto err_free_rxirq;
+		}
 
-	if (ret) {
-		dev_err(port->dev, "failed to register oerrirq (%d)\n", ret);
-		goto err_free_txirq;
 	}
 
 	control |= UARTn_CTRL_RX_GRP | UARTn_CTRL_TX_GRP;
@@ -303,10 +331,10 @@ static int mps2_uart_startup(struct uart_port *port)
 
 	return 0;
 
-err_free_txirq:
-	free_irq(mps_port->tx_irq, mps_port);
 err_free_rxirq:
 	free_irq(mps_port->rx_irq, mps_port);
+err_free_oerrirq:
+	free_irq(port->irq, mps_port);
 
 	return ret;
 }
@@ -320,8 +348,11 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	free_irq(mps_port->rx_irq, mps_port);
-	free_irq(mps_port->tx_irq, mps_port);
+	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		free_irq(mps_port->rx_irq, mps_port);
+		free_irq(mps_port->tx_irq, mps_port);
+	}
+
 	free_irq(port->irq, mps_port);
 }
 
@@ -511,6 +542,10 @@ static int mps2_of_get_port(struct platform_device *pdev,
 	if (id < 0)
 		return id;
 
+	/* Only combined irq is presesnt */
+	if (platform_irq_count(pdev) == 1)
+		mps_port->flags |= UART_PORT_COMBINED_IRQ;
+
 	mps_port->port.line = id;
 
 	return 0;
@@ -529,11 +564,6 @@ static int mps2_init_port(struct platform_device *pdev,
 
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
@@ -552,6 +582,15 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	clk_disable_unprepare(mps_port->clk);
 
+
+	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
+		mps_port->port.irq = platform_get_irq(pdev, 0);
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
