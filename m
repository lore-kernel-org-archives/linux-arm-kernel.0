Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09338C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB507218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nN2LYKHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB507218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TP4+nGybiwmq4NvVGw7/J50lQuPw8etOFB2djpIwPEg=; b=nN2LYKHQ07KKZWfJ2F/i9MIpNo
	X0EKv+/U+zDWMTrtMFK0dnN4VdvIHgABNtmqhithM6E9cMnetlZo2eoHjzuDa6hu0j9wToeh42xcC
	/uyFY+YsejL9TNA24WSAhP4NDxU8Q4NuyJBCXbh6AQYep9/rHeiIESJd8eygMCcthLyg8ZLb9pKys
	2Bsnr4LyOaNCWk8z283CldYGhBE2nvLMPYI/M1qNCFC2kvBhW4fduzHuTfifZWbe1Y82b2EDFJDRG
	8bfqMA5GMGCLBDHzfQR9sOsiexbr96jHXFdbsi2CNLd/DoMK0HU553LqhMnB2ZbwEGAmOvsxEMU02
	cT9iEh2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2Fq-00023M-3i; Fri, 25 Jan 2019 14:14:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2FM-0001YX-Ps
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:14:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9353DEBD;
 Fri, 25 Jan 2019 06:14:11 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB8E63F589;
 Fri, 25 Jan 2019 06:14:10 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: mps2-uart: move to dynamic port allocation
Date: Fri, 25 Jan 2019 14:13:16 +0000
Message-Id: <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_061417_179780_72A70D8C 
X-CRM114-Status: GOOD (  15.04  )
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

Some designs, like MPS3, expose number of virtual serial ports which
already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
would have negative impact (in terms of memory consumption) on tiny
MPS2 platform which, in fact, has only one physically populated UART.

Start with converting existent static port array to idr. As a bonus it
make driver not to fail in case when no alias was specified in device
tree.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 9f8f637..6da0633 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/tty_flip.h>
 #include <linux/types.h>
+#include <linux/idr.h>
 
 #define SERIAL_NAME	"ttyMPS"
 #define DRIVER_NAME	"mps2-uart"
@@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
 	.verify_port = mps2_uart_verify_port,
 };
 
-static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
+static DEFINE_IDR(ports_idr);
 
 #ifdef CONFIG_SERIAL_MPS2_UART_CONSOLE
 static void mps2_uart_console_putchar(struct uart_port *port, int ch)
@@ -410,7 +411,8 @@ static void mps2_uart_console_putchar(struct uart_port *port, int ch)
 
 static void mps2_uart_console_write(struct console *co, const char *s, unsigned int cnt)
 {
-	struct uart_port *port = &mps2_uart_ports[co->index].port;
+	struct mps2_uart_port *mps_port = idr_find(&ports_idr, co->index);
+	struct uart_port *port = &mps_port->port;
 
 	uart_console_write(port, s, cnt, mps2_uart_console_putchar);
 }
@@ -426,7 +428,10 @@ static int mps2_uart_console_setup(struct console *co, char *options)
 	if (co->index < 0 || co->index >= MPS2_MAX_PORTS)
 		return -ENODEV;
 
-	mps_port = &mps2_uart_ports[co->index];
+	mps_port = idr_find(&ports_idr, co->index);
+
+	if (!mps_port)
+		return -ENODEV;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -487,27 +492,32 @@ static struct uart_driver mps2_uart_driver = {
 	.cons = MPS2_SERIAL_CONSOLE,
 };
 
-static struct mps2_uart_port *mps2_of_get_port(struct platform_device *pdev)
+static int mps2_of_get_port(struct platform_device *pdev,
+			    struct mps2_uart_port *mps_port)
 {
 	struct device_node *np = pdev->dev.of_node;
 	int id;
 
 	if (!np)
-		return NULL;
+		return -ENODEV;
 
 	id = of_alias_get_id(np, "serial");
+
+	if (id < 0)
+		id = idr_alloc_cyclic(&ports_idr, (void *)mps_port, 0, MPS2_MAX_PORTS, GFP_KERNEL);
+	else
+		id = idr_alloc(&ports_idr, (void *)mps_port, id, MPS2_MAX_PORTS, GFP_KERNEL);
+
 	if (id < 0)
-		id = 0;
+		return id;
 
-	if (WARN_ON(id >= MPS2_MAX_PORTS))
-		return NULL;
+	mps_port->port.line = id;
 
-	mps2_uart_ports[id].port.line = id;
-	return &mps2_uart_ports[id];
+	return 0;
 }
 
-static int mps2_init_port(struct mps2_uart_port *mps_port,
-			  struct platform_device *pdev)
+static int mps2_init_port(struct platform_device *pdev,
+			  struct mps2_uart_port *mps_port)
 {
 	struct resource *res;
 	int ret;
@@ -550,11 +560,16 @@ static int mps2_serial_probe(struct platform_device *pdev)
 	struct mps2_uart_port *mps_port;
 	int ret;
 
-	mps_port = mps2_of_get_port(pdev);
-	if (!mps_port)
-		return -ENODEV;
+	mps_port = devm_kzalloc(&pdev->dev, sizeof(struct mps2_uart_port), GFP_KERNEL);
+
+        if (!mps_port)
+                return -ENOMEM;
+
+	ret = mps2_of_get_port(pdev, mps_port);
+	if (ret)
+		return ret;
 
-	ret = mps2_init_port(mps_port, pdev);
+	ret = mps2_init_port(pdev, mps_port);
 	if (ret)
 		return ret;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
