From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jul 2011 10:09:42 +0200
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <20110706080942.GC26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 03:33:48PM +0200, J?rgen Lambrecht wrote:
> - Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
>   in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
>   Warning: The same solution needs to be applied to the boot loader and the
>   flash programmer.
> - Enable NAND support for the imx27pdk (3ds), and use BISWAP.
> 
> Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
> ---
>  arch/arm/mach-imx/Kconfig         |   30 ++++++++++++++++++++++++++++--
>  arch/arm/mach-imx/mach-mx27_3ds.c |   14 ++++++++++++++
>  drivers/mtd/nand/mxc_nand.c       |   29 +++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0519dd7..e8b16a9 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -274,7 +274,7 @@ config MACH_EUKREA_MBIMX27_BASEBOARD
>  endchoice
>  
>  config MACH_MX27_3DS
> -	bool "MX27PDK platform"
> +	bool "MX27PDK (3DS) platform"
>  	select SOC_IMX27
>  	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
> @@ -284,13 +284,39 @@ config MACH_MX27_3DS
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MXC_EHCI
>  	select IMX_HAVE_PLATFORM_MXC_MMC
> +	select IMX_HAVE_PLATFORM_MXC_NAND
>  	select IMX_HAVE_PLATFORM_SPI_IMX
>  	select MXC_DEBUG_BOARD
>  	select MXC_ULPI if USB_ULPI
>  	help
> -	  Include support for MX27PDK platform. This includes specific
> +	  Include support for MX27PDK (3DS) platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_MXC_NAND_USE_BBT
> +	bool "Make the MXC NAND driver use the in flash Bad Block Table"
> +	depends on MACH_MX27_3DS
> +	depends on MTD_NAND_MXC
> +	help
> +	  Enable this if you want that the MXC NAND driver uses the in flash
> +	  Bad Block Table to know what blocks are bad instead of scanning the
> +	  entire flash looking for bad block markers.

Besides the fact that we have too many kconfig options there's another
problem. We try to build kernels which run on as many boards as
possible. Adding options like this limit a kernel for a particular
usecase (bbt vs. scanning)

> +
> +config IMX_NFC_V1_BISWAP
> +	bool "Make the MXC 2kB-page NAND driver swap the Bad Block Indicator"
> +	depends on MACH_MX27_3DS
> +	depends on MTD_NAND_MXC
> +	help
> +	  Enable this if you want that the MXC NAND driver swaps the Bad Block
> +	  Indicator (BBI) byte. The IMX NFC v1 (present in IMX27 and IMX31)
> +	  contains a bug for 2kB-page flashes: the 2kB page is read out in
> +	  4x512B chunks, so also the spare area is read out in 4
> +	  chunks. Therefore the data area and the spare area becomes
> +	  mixed. This causes a problem for the factory programmed BBI: it
> +	  appears in the data area instead of the spare area, and is
> +	  overwritten. This patch swaps that byte to the "real" spare
> +	  area. WARNING: then also the bootloader and the flash programmer must
> +	  be patched!!

I don't like this approach. IMO some code should be run on a virgin
flash which is aware of this issue and creates a correct bad block
table. You run this once and forget about this afterwards and every
kernel/bootloader can run without patching. Otherwise if you accidently
or intentionally start an older (unpatched) kernel your Nand gets
corrupted.

Also, my comment above applies here too. You added a 'depends on the
board I care of', but usually my kernels have all available boards
compiled in. So I can select this option and it will change the
behaviour of all boards I might run the kernel on, not only the
ones you depend on above.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
