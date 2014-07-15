From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jul 2014 12:32:09 +0200
Subject: [PATCH v7 0/4] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <4527083.RFD2neZ6Bp@wuerfel>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
 <53C39D5F.6050901@linaro.org> <4527083.RFD2neZ6Bp@wuerfel>
Message-ID: <4736066.znnQ63vBqX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 July 2014 17:27:49 Arnd Bergmann wrote:
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 8f90595069a1..0f89d1b84524 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -200,6 +200,14 @@ choice
>  		  Say Y here if you want the debug print routines to direct
>  		  their output to the serial port in the DC21285 (Footbridge).
>  
> +	config DEBUG_EP93XX
> +		bool "Kernel low-level debugging messages via ep93xx UART"
> +		depends on ARCH_EP93XX
> +		select DEBUG_UART_PL01X
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Cirrus Logic EP93xx based platforms.
> +

FWIW, this part was broken, fixup below. The problem is that the decompress.h
for ep93xx uses CONFIG_DEBUG_UART_PHYS even when DEBUG_LL is disabled.

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 362d764cd358..a99b28029983 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1139,7 +1139,7 @@ config DEBUG_UART_PHYS
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
-	default 0x808c0000 if DEBUG_EP93XX
+	default 0x808c0000 if DEBUG_EP93XX || ARCH_EP93XX
 	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xa9a00000 if DEBUG_MSM_UART
 	default 0xb0090000 if DEBUG_VEXPRESS_UART0_CRX
@@ -1166,7 +1166,8 @@ config DEBUG_UART_PHYS
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
-		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
+		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
+		ARCH_EP93XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
