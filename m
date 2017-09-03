From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 3 Sep 2017 19:58:39 +0200
Subject: [PATCH v2 1/4] ARM: ep93xx: switch to SPARSEMEM
In-Reply-To: <20170903174347.6148-2-f.fainelli@gmail.com>
References: <20170903174347.6148-1-f.fainelli@gmail.com>
 <20170903174347.6148-2-f.fainelli@gmail.com>
Message-ID: <7637d9e1-6e0a-7933-e3da-902267f907f1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/09/17 19:43, Florian Fainelli wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> The EP93xx has four chip selects that can be used for the SDRAM memory.
> These chip selects are decoded to specify an address domain:
> 
>   SDCS3  0x00000000-0x0fffffff with Boot Option ASDO=1
>   SDCS0  0xc0000000-0xcfffffff
>   SDCS1  0xd0000000-0xdfffffff
>   SDCS2  0xe0000000-x0efffffff
>   SDCS3  0xf0000000-0xffffffff with Boot Option ASDO=0
> 
> Because of the row/column/bank architecture of SDRAM, the mapping of
> these memories into the processor's memory space is discontiguous.
> 
> Most ep93xx systems only use one of the chip selects. For these systems,
> ARCH_HAS_HOLES_MEMORYMODEL has worked fine to handle the discontiguous
> memory.
> 
> But, some of the TS-72xx boards use multiple chip selects. The TS-7300 in
> particular uses SDCS3 (with ASDO=1) and SDCS2. On that system with
> ARCH_HAS_HOLES_MEMORYMODEL the SDCS2 memory does not get handled correctly
> and results in the system not booting.
> 
> Change the EP93xx to ARCH_SPARSEMEM_ENABLE. This handles the discontiguous
> memory for all configurations.
> 
> This has been tested on the following ep93xx platforms:
> 
> EDB9307A with 64 MiB on SDCS0
> Vision EP9307 with 64 MiB on SDCS0
> TS-7300 with 64 MiB on SDCS3 (with ASDO=1) and 64 MiB on SDCS2
> sim.one with 64 MiB on SDCS0
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>

As I've tested this patch back in 4.12 times,
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a208bfe367b5..87a6b09067c2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -378,7 +378,7 @@ config ARCH_EBSA110
>  
>  config ARCH_EP93XX
>  	bool "EP93xx-based"
> -	select ARCH_HAS_HOLES_MEMORYMODEL
> +	select ARCH_SPARSEMEM_ENABLE
>  	select ARM_AMBA
>  	select ARM_PATCH_PHYS_VIRT
>  	select ARM_VIC
