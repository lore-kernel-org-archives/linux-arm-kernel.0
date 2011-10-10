From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 17:26:24 +0530
Subject: [PATCH 2/3] ARM: plat-samsung: use Kconfig choice for debug UART
	selection
In-Reply-To: <1313530873-24961-2-git-send-email-will.deacon@arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313530873-24961-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAJuYYwRPwALAQcvsMPuz8XYsDicCmB52HzZehppUnKqv5itPEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 17 August 2011 03:11, Will Deacon <will.deacon@arm.com> wrote:
> Now that the DEBUG_LL UART can be selected by a Kconfig choice, convert
> the Samsung UART selection to use a set of bools rather than an int.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/Kconfig.debug ? ? ? ?| ? 45 ++++++++++++++++++++++++++++++-----------
> ?arch/arm/plat-samsung/Kconfig | ? ?7 ++++++
> ?2 files changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 11604c9..2f80564 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -94,6 +94,39 @@ choice
> ? ? ? ? ? ? ? ? ?Saying N will cause the debug messages to appear on the first
> ? ? ? ? ? ? ? ? ?serial port.
>
> + ? ? ? config DEBUG_S3C_UART0
> + ? ? ? ? ? ? ? depends on PLAT_SAMSUNG
> + ? ? ? ? ? ? ? bool "Use S3C UART 0 for low-level debug"
> + ? ? ? ? ? ? ? help
> + ? ? ? ? ? ? ? ? Say Y here if you want the debug print routines to direct
> + ? ? ? ? ? ? ? ? their output to UART 0. The port must have been initialised
> + ? ? ? ? ? ? ? ? by the boot-loader before use.
> +
> + ? ? ? ? ? ? ? ? The uncompressor code port configuration is now handled
> + ? ? ? ? ? ? ? ? by CONFIG_S3C_LOWLEVEL_UART_PORT.
> +
> + ? ? ? config DEBUG_S3C_UART1
> + ? ? ? ? ? ? ? depends on PLAT_SAMSUNG
> + ? ? ? ? ? ? ? bool "Use S3C UART 1 for low-level debug"
> + ? ? ? ? ? ? ? help
> + ? ? ? ? ? ? ? ? Say Y here if you want the debug print routines to direct
> + ? ? ? ? ? ? ? ? their output to UART 1. The port must have been initialised
> + ? ? ? ? ? ? ? ? by the boot-loader before use.
> +
> + ? ? ? ? ? ? ? ? The uncompressor code port configuration is now handled
> + ? ? ? ? ? ? ? ? by CONFIG_S3C_LOWLEVEL_UART_PORT.
> +
> + ? ? ? config DEBUG_S3C_UART2
> + ? ? ? ? ? ? ? depends on PLAT_SAMSUNG
> + ? ? ? ? ? ? ? bool "Use S3C UART 2 for low-level debug"
> + ? ? ? ? ? ? ? help
> + ? ? ? ? ? ? ? ? Say Y here if you want the debug print routines to direct
> + ? ? ? ? ? ? ? ? their output to UART 2. The port must have been initialised
> + ? ? ? ? ? ? ? ? by the boot-loader before use.
> +
> + ? ? ? ? ? ? ? ? The uncompressor code port configuration is now handled
> + ? ? ? ? ? ? ? ? by CONFIG_S3C_LOWLEVEL_UART_PORT.
> +
> ?endchoice
>
> ?config EARLY_PRINTK
> @@ -124,16 +157,4 @@ config OC_ETM
> ? ? ? ? ?buffer driver that will allow you to collect traces of the
> ? ? ? ? ?kernel code.
>
> -config DEBUG_S3C_UART
> - ? ? ? depends on PLAT_SAMSUNG
> - ? ? ? int "S3C UART to use for low-level debug"
> - ? ? ? default "0"
> - ? ? ? help
> - ? ? ? ? Choice for UART for kernel low-level using S3C UARTS,
> - ? ? ? ? should be between zero and two. The port must have been
> - ? ? ? ? initialised by the boot-loader before use.
> -
> - ? ? ? ? The uncompressor code port configuration is now handled
> - ? ? ? ? by CONFIG_S3C_LOWLEVEL_UART_PORT.
> -
> ?endmenu
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index b3e1065..49b14b1 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -367,4 +367,11 @@ config SAMSUNG_PD
> ? ? ? ?help
> ? ? ? ? ?Say Y here if you want to control Power Domain by Runtime PM.
>
> +config DEBUG_S3C_UART
> + ? ? ? depends on PLAT_SAMSUNG
> + ? ? ? int
> + ? ? ? default "0" if DEBUG_S3C_UART0
> + ? ? ? default "1" if DEBUG_S3C_UART1
> + ? ? ? default "2" if DEBUG_S3C_UART2
> +
> ?endif
> --
> 1.7.0.4


What is your opinion about the following diff instead of the above one?


diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 65cf8c6..035f5cd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -120,6 +120,15 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.

+	config DEBUG_SAMSUNG_UART
+		bool "Kernel low-level debugging messages via samsung serial port"
+		depends on PLAT_SAMSUNG
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port for Samsung platforms. Choose
+		  the uart port with the "S3C UART to use for low-level debug"
+		  config option.
+
 endchoice

 config EARLY_PRINTK
@@ -139,7 +148,7 @@ config OC_ETM
 	  kernel code.

 config DEBUG_S3C_UART
-	depends on PLAT_SAMSUNG
+	depends on DEBUG_SAMSUNG_UART
 	int "S3C UART to use for low-level debug"
 	default "0"
 	help


Thanks,
Thomas.
