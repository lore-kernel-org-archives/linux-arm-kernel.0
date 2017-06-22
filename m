From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Jun 2017 10:59:00 +0100
Subject: [PATCH] ARM: always enable AEABI for ARMv6+
In-Reply-To: <E1dNyAB-00065m-3A@rmk-PC.armlinux.org.uk>
References: <E1dNyAB-00065m-3A@rmk-PC.armlinux.org.uk>
Message-ID: <aefc742d-1664-4f92-b8a4-f05a211b163c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/17 10:12, Russell King wrote:
> Always enable AEABI for ARMv6+, as these use the double-word exclusives
> which must be passed an even register to avoid errors such as:
> 
> /tmp/ccG2rCwe.s:905: Error: even register required -- `ldrexd r5,r6,[r7]'
> /tmp/ccG2rCwe.s:909: Error: even register required -- `strexd sl,r3,r4,[r7]'
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 270ab2549def..78e42f691270 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1542,7 +1542,6 @@ config THUMB2_KERNEL
>  	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
>  	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
>  	default y if CPU_THUMBONLY
> -	select AEABI
>  	select ARM_ASM_UNIFIED
>  	select ARM_UNWIND
>  	help
> @@ -1605,7 +1604,8 @@ config ARM_PATCH_IDIV
>  	  code to do integer division.
>  
>  config AEABI
> -	bool "Use the ARM EABI to compile the kernel"
> +	bool "Use the ARM EABI to compile the kernel" if !THUMB2_KERNEL && !CPU_V7 && !CPU_V7M && !CPU_V6 && !CPU_V6K

Isn't !THUMB2_KERNEL already a strict subset of !CPU_V7 && !CPU_V7M?

Robin.

> +	default THUMB2_KERNEL || CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K
>  	help
>  	  This option allows for the kernel to be compiled using the latest
>  	  ARM ABI (aka EABI).  This is only useful if you are using a user
> 
