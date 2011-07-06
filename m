From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jul 2011 10:06:20 +0300
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <1309935985.3149.81.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2011-07-05 at 15:33 +0200, J?rgen Lambrecht wrote:
> - Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
>   in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
>   Warning: The same solution needs to be applied to the boot loader and the
>   flash programmer.
> - Enable NAND support for the imx27pdk (3ds), and use BISWAP.

Sounds like 2 independent changes in one patch - please, split on 2
patches.

> +config MACH_MXC_NAND_USE_BBT
> +	bool "Make the MXC NAND driver use the in flash Bad Block Table"
> +	depends on MACH_MX27_3DS
> +	depends on MTD_NAND_MXC
> +	help
> +	  Enable this if you want that the MXC NAND driver uses the in flash
> +	  Bad Block Table to know what blocks are bad instead of scanning the
> +	  entire flash looking for bad block markers.

Sorry, but we have tons of NAND drivers, and if each driver will have a
config option for "BBT or scanning", our configuration menu will blow
up :-)

Really, it does not make sense to make this a config option - the BBT
should be detected automatically, and if it is present and correct -
scanning should not be done, otherwise, we should fall back to scanning.
And this should be a feature of the NAND base support. Please, look at
this and change the NAND base support if needed.

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

Sorry, but again, things like this should be automatically detected -
check the versions and some other magic ids and decide dynamically
whether to swap or not. If it is impossible, then this information
should be taken from the device tree (which does not exist yet, but
people are working on this).

In any case, the rule of thumb is to think twice before adding a kenel
config option - we have too many of them already.

-- 
Best Regards,
Artem Bityutskiy
