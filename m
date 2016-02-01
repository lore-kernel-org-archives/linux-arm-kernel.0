From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 09:59:48 +0900
Subject: [PATCH 4/6] ARM: s3c24xx: don't select RFKILL if CONFIG_NET is
 disabled
In-Reply-To: <1454079040-3567945-5-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-5-git-send-email-arnd@arndb.de>
Message-ID: <56AEAE04.6030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> Bluetooth is only supported when network support is part of the kernel,
> so it is a bit pointless to build the hi1940-bt support without networking.
> If we try anyway, we get a Kconfig warning:
> 
> warning: (TOSA_BT && H1940BT) selects RFKILL which has unmet direct dependencies (NET)
> 
> This adds a dependency on CONFIG_NET to avoid that case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 5884bbb7952e..bf66c8334822 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -227,7 +227,7 @@ config ARCH_H1940
>  
>  config H1940BT
>  	tristate "Control the state of H1940 bluetooth chip"
> -	depends on ARCH_H1940
> +	depends on ARCH_H1940 && NET
>  	select RFKILL
>  	help
>  	  This is a simple driver that is able to control

I think there shouldn't be a reverse dependency for RFKILL but instead just:
	depends on ARCH_H1940 && RFKILL
This makes it simpler and RFKILL is a user-visible symbol.

Best regards,
Krzysztof
