Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59E321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qkifegbs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lpGa0Grw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59E321872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:
	References:Date:Subject:To:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=a6M/xNycioX79R9wyPD4KMdTAIBYDQEpfUgaym1vOLc=; b=QkifegbsFQmuET
	6nAvRtC9JN+fkW100nl02monZbSBIzzY7hXfJxrRg6fediKKJlrrEb394B0mmkbnTyBRccr5625yK
	aPq93tusee6nHAkKs2TkTAgj7S/oClA+iblHYCApHv3HwUeQcXJS/8m7vXP74hTz6Be9MmHmQzo0B
	tRfM7SPH9Uoeovm+xA4lN+Ly13R9xxZNjlp7ETuuIueR3noYSDX+jIM/JRGerKS1iMBx7STzSFR8G
	PbP6m6IyUTBbKJ63Tq3nggWXT6k/mqyeSQPEL+D+kTEXJcLC9rwrgF0IiyY1H1IGhlVN2p1oxmyho
	QS/wRcRoyXTqG58U4wIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhph-0005DS-3u; Thu, 07 Feb 2019 11:27:05 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhpd-0005CZ-Gw
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:27:03 +0000
Received: by mail-ed1-x541.google.com with SMTP id b17so4534923eds.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
 bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
 b=lpGa0Grw3h/abtMaXn8NhnwSyAc4gkosLOJN3rQecVmu/PUkG6561GanDZRktd8Nca
 SmSdGAm7PK7OLr+TV0dpGPi2QnPfRciLmalt04YeQub95QaqfKMzO5nMopKi6EA51LaA
 HHqzvMmE6uovrowLcZJf0bK4COmQu/hZ+bfPRRyVE9vJ8tJkjSc/LYeRHaFXueQ5Pfov
 MMFTeIH4v1IvyDhmAIWOIqikUDlDabQZvovVAWtgJ8/qAynFQH1PCB6a7bbSIrfjKWVf
 7v2rQY2Z66S9UFvsAue90atnXEAbwYSrw/JY08p1V/2cCbKHOUWq4l0DVZqZdXHKM66c
 gKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
 :message-id:mime-version;
 bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
 b=Wt7CYVF0kpmiPWw26MVzox0bAB9Wo4LoD/R7+CDvxhkMdC57RhaKEU6OMSsThUhDt6
 7Nxj16d8UJMpmKSidBqdZHzWCfHTeEhEUuDlAIHSg5ixd3yG0RdT172vi7eaFV0ks3Ob
 X9QTnoRtuQnJU1i3iamZMzpSX2TdOxLEZY5id/crEsLauXD1boL10KF88nOdLrYICO+F
 Qlss01mBjvBDPFUfGi/TSRkupzBporzVijO7GbCW7zXiJtjZuAjg5I3oO+jrPMaydwJ3
 YjDeNmu/zmVLVcphtd2elOTgQAL2bRvFcGJzxBMlhAtu0u/dgwobar90SPWQqiHtPcSm
 CjHw==
X-Gm-Message-State: AHQUAuZ5oaPE6EgZuedxKk57yfj6eA2TAxPa6vQoh5aDCB+4ddIJLdsE
 1IAfe+iDqeqL/eIO6QzvxL8U5w==
X-Google-Smtp-Source: AHgI3IaacZRmJNMHtyYLIrXWsYmX+kBY4nCl0BEnTm3g+kmpaGvMP3TR483tFqfu5leYPUmmyCMgkg==
X-Received: by 2002:aa7:c0c8:: with SMTP id j8mr4962862edp.94.1549538818755;
 Thu, 07 Feb 2019 03:26:58 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
 by smtp.gmail.com with ESMTPSA id e26sm3239012eja.9.2019.02.07.03.26.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 03:26:58 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] tty: serial: meson_uart: Add support for kernel debugger
Date: Thu,  7 Feb 2019 12:26:16 +0100
References: <86h8dfx2jv.fsf@gmail.com>
Message-ID: <86ftszx2im.fsf@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_032701_720091_C4A122AA 
X-CRM114-Status: GOOD (  11.68  )
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
Reply-To: 86h8dfx2jv.fsf@gmail.com
Cc: Julien Masson <jmasson@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..49b20da 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context (i.e. kgdb).
+ */
+
+static int meson_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
+		c = NO_POLL_CHAR;
+	else
+		c = readl(port->membase + AML_UART_RFIFO);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return c;
+}
+
+static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +483,10 @@ static const struct uart_ops meson_uart_ops = {
 	.request_port	= meson_uart_request_port,
 	.release_port	= meson_uart_release_port,
 	.verify_port	= meson_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= meson_uart_poll_get_char,
+	.poll_put_char	= meson_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
