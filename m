Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:16:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5B72064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dB/wV0Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5B72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=swtfADPNbNTd6c9sMEPmXmNAAzE/0eHVg8V/9nuIZCA=; b=dB/wV0AxrJF78P
	yjvyBxZZriP6/QxeVwZdYD6s8cjhLkepy8VYr4VMxhzDM/UKuXeQ6vBtD9QtGRq+6AGDAAAd2p1Dm
	3qgDix4rrmaoakxNnLo/gTFDSdD447OoziW7tfn6qhuyk8Co17cUiLqtVat8D6ora9I9U3b4Gl6cL
	Mw4nYA0Osxvzw0TLRnZ+hOhR0fydjCA0k47czDyeYxS7zSZ5LOdPBV61R9o1W/YX5NZ0YGOYd565Y
	5UTIvJHJZ3THbhyGgtdWYzzYl6a8b1GQ55aw9tjgQq5N6Ypc6XAMEULo3MdLDbsJWdaZQ/EQE8uqJ
	zuzoXDScFcWGTe53KBAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj9bJ-0006ta-5R; Mon, 14 Jan 2019 21:16:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj9bF-0006sZ-Fk
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 21:16:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5454820955; Mon, 14 Jan 2019 22:16:41 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr
 [86.248.186.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 21E9620784;
 Mon, 14 Jan 2019 22:16:31 +0100 (CET)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: [PATCH] ARM: lpc32xx: debug: add low-level debug support on hsuart
Date: Mon, 14 Jan 2019 22:16:23 +0100
Message-Id: <20190114211623.6069-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_131649_803453_E8A1DCF7 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The lpc32xx has UARTs that are not 8250 compatible. Add support for low
level debugging on those high speed UARTs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/Kconfig.debug                  | 18 +++++++++++++++---
 arch/arm/include/debug/lpc32xx_hsuart.S | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/lpc32xx_hsuart.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6d6e0330930b..0d4d64f5d3b7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -530,7 +530,16 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on NXP LPC32xx based platforms.
+		  on NXP LPC32xx based platforms using an INS16Cx50 compatible
+		  UART.
+
+	config DEBUG_LPC32XX_HSUART
+		bool "Kernel low-level debugging messages via NXP LPC32xx High Speed  UART"
+		depends on ARCH_LPC32XX
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on NXP LPC32xx based platforms using an high speed (14-clock)
+		  UART.
 
 	config DEBUG_MESON_UARTAO
 		bool "Kernel low-level debugging via Meson6 UARTAO"
@@ -1541,6 +1550,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6UL_UART || \
 				 DEBUG_IMX7D_UART
 	default "debug/ks8695.S" if DEBUG_KS8695_UART
+	default "debug/lpc32xx_hsuart.S" if DEBUG_LPC32XX_HSUART
 	default "debug/msm.S" if DEBUG_QCOM_UARTDM
 	default "debug/netx.S" if DEBUG_NETX_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
@@ -1622,6 +1632,7 @@ config DEBUG_UART_PHYS
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40014000 if DEBUG_LPC32XX_HSUART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
@@ -1716,7 +1727,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1741,6 +1752,7 @@ config DEBUG_UART_VIRT
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
+	default 0xf4014000 if DEBUG_LPC32XX_HSUART
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
 	default 0xf6200000 if DEBUG_PXA_UART1
@@ -1832,7 +1844,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LPC32XX_HSUART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/lpc32xx_hsuart.S b/arch/arm/include/debug/lpc32xx_hsuart.S
new file mode 100644
index 000000000000..e0205368c6ff
--- /dev/null
+++ b/arch/arm/include/debug/lpc32xx_hsuart.S
@@ -0,0 +1,22 @@
+#define LPC_HSU_TX		(0x0)
+#define LPC_HSU_LEVEL		(0x4)
+#define LPC_HSU_LEVEL_TX	0xFF00
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #(LPC_HSU_TX)]
+	.endm
+
+	.macro	waituart,rd,rx
+	.endm
+
+	.macro	busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #(LPC_HSU_LEVEL)]
+	ands	\rd, \rd, LPC_HSU_LEVEL_TX
+	bne	1001b
+	.endm
+
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
