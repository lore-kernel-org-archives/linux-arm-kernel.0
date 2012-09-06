From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 6 Sep 2012 15:03:09 +0200
Subject: [PATCH 1/1] mxc_nand : allow swapping the Bad block Indicator for
 NFC v1.
In-Reply-To: <1345825064-9147-1-git-send-email-gcembed@gmail.com>
References: <1345811288.2848.308.camel@sauron.fi.intel.com>
 <1345825064-9147-1-git-send-email-gcembed@gmail.com>
Message-ID: <201209061503.09923.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ga?tan Carlier wrote:
> Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
> in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
> Warning: The same solution needs to be applied to the boot loader and the
> flash programmer.
>
> This is a modified version of patch sent by J?rgen Lambrecht :
> [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block Indicator,
> and use for imx27pdk nand support.
>
>  v3: - use accessor function for I/O memory accesses as suggested by Artem
>        Bityutskiy
>      - rename function name as suggested by Artem Bityutskiy
>
>  v2: - Use a flag in a mxc_nand_platform structure instead of adding option
>        in Kconfig
>
>  v1: - Original patch "Add 'config IMX_NFC_V1_BISWAP'" by J?rgen Lambrecht
>
> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>

One additional note: If a user intend to boot from NAND (aka "external boot") 
there is one drawback with this patch: the very first page of the NAND will 
be read in hardware to load the bootstrap code. But the hardware doesn't know 
anything about swapping bytes!
So, when writing the very first page of the NAND the swap *must* be omitted 
(which also means the factory bad block marker of the first block in the NAND 
has to be interpreted differently).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
