From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Sun, 3 Jan 2016 22:53:05 +0100
Subject: [PATCH v2 8/8] ARM: bcm2835: Add Kconfig support for bcm2836
In-Reply-To: <1450310115-22163-9-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <1450310115-22163-9-git-send-email-eric@anholt.net>
Message-ID: <56899841.1@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 17.12.2015 00:55, skrev Eric Anholt:
> This should be a complete port of bcm2835 functionality to bcm2836
> (Raspberry Pi 2).
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Implement Arnd's feedback to not split to ARCH_BCM2836, and
>      instead use more conditionals in ARCH_BCM2835.  Also reduce diff
>      between 2835 and 2836.
>
>   arch/arm/Kconfig.debug     | 10 ++++++++--
>   arch/arm/boot/dts/Makefile |  3 ++-
>   arch/arm/mach-bcm/Kconfig  |  8 ++++----
>   3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 259c0ca..957b876 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -143,7 +143,12 @@ choice
>   
>   	config DEBUG_BCM2835
>   		bool "Kernel low-level debugging on BCM2835 PL011 UART"
> -		depends on ARCH_BCM2835
> +		depends on ARCH_BCM2835 && ARCH_MULTI_V6
> +		select DEBUG_UART_PL01X
> +
> +	config DEBUG_BCM2836
> +		bool "Kernel low-level debugging on BCM2836 PL011 UART"
> +		depends on ARCH_BCM2835 && ARCH_MULTI_V7
>   		select DEBUG_UART_PL01X
>   
>   	config DEBUG_BCM_5301X
> @@ -1402,6 +1407,7 @@ config DEBUG_UART_PHYS
>   	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
>   	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
>   	default 0x20201000 if DEBUG_BCM2835
> +	default 0x3f201000 if DEBUG_BCM2836
>   	default 0x3e000000 if DEBUG_BCM_KONA_UART
>   	default 0x4000e400 if DEBUG_LL_UART_EFM32
>   	default 0x40081000 if DEBUG_LPC18XX_UART0
> @@ -1485,7 +1491,7 @@ config DEBUG_UART_VIRT
>   	default 0xf0000be0 if ARCH_EBSA110
>   	default 0xf0010000 if DEBUG_ASM9260_UART
>   	default 0xf01fb000 if DEBUG_NOMADIK_UART
> -	default 0xf0201000 if DEBUG_BCM2835
> +	default 0xf0201000 if DEBUG_BCM2835 || DEBUG_BCM2836

This results in a BUG on Pi2 (bcm2836) because the address ends up in the
8MB VMALLOC_OFFSET "hole" between lowmem and vmalloc:

BUG: mapping for 0x3f201000 at 0xf0201000 out of vmalloc space
...
     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)

Moving the address a bit should work for both (tested on 2836):
         default 0xf1201000 if DEBUG_BCM2835 || DEBUG_BCM2836

For reference this is the default memory configuration on Pi1 (bcm2835):
     vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
     lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)


Noralf.
