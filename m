From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 29 Sep 2014 08:32:08 +0200
Subject: [PATCH 1/3 V2] CNS3xxx: Fix debug UART.
In-Reply-To: <m3d2av3lgt.fsf@t19.piap.pl>
References: <m3d2av3lgt.fsf@t19.piap.pl>
Message-ID: <m3oatzaqdz.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTs on CNS3xxx are 8250-compatible, not AMBA.
The base address for UART0 is 0x78000000 (physical)
and 0xfb002000 (virtual).

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..6a5b496 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -147,7 +147,7 @@ choice
 	config DEBUG_CNS3XXX
 		bool "Kernel Kernel low-level debugging on Cavium Networks CNS3xxx"
 		depends on ARCH_CNS3XXX
-		select DEBUG_UART_PL01X
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
                   their output to the CNS3xxx UART0.
@@ -1068,7 +1068,7 @@ config DEBUG_UART_PHYS
 	default 0x02530c00 if DEBUG_KEYSTONE_UART0
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
-	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || DEBUG_CNS3XXX || \
+	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0x10124000 if DEBUG_RK3X_UART0
@@ -1094,6 +1094,7 @@ config DEBUG_UART_PHYS
 	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
+	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if FOOTBRIDGE
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
@@ -1133,7 +1134,6 @@ config DEBUG_UART_VIRT
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xe1000000 if DEBUG_MSM_UART
 	default 0xf0000be0 if ARCH_EBSA110
-	default 0xf0009000 if DEBUG_CNS3XXX
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
 	default 0xf1000300 if DEBUG_BCM_5301X
@@ -1155,6 +1155,7 @@ config DEBUG_UART_VIRT
 	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
+	default 0xfb002000 if DEBUG_CNS3XXX
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
