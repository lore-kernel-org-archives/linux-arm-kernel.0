From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 4 Sep 2017 18:26:02 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add an option to force 3byte adressing
 mode
In-Reply-To: <1503954854-30963-2-git-send-email-mw@semihalf.com>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
 <1503954854-30963-2-git-send-email-mw@semihalf.com>
Message-ID: <20170904162602.GC21849@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> index 1413828..029c87d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2002,7 +2002,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
>  		    info->flags & SPI_NOR_4B_OPCODES)
>  			spi_nor_set_4byte_opcodes(nor, info);
> -		else
> +		else if (of_property_read_bool(np, "spi-3byte-addressing")) {
> +			/*
> +			 * Do not enter 4byte mode in order to prevent
> +			 * the early bootloader to come up on non-default
> +			 * SPI NOR memory during boot. Limit accessible
> +			 * size to 16MiB.
> +			 */
> +			nor->addr_width = 3;
> +			mtd->size = 0x1000000;
> +			dev_info(dev, "Force 3B addressing mode\n");

I'd append "limiting access to first 16MiB" .. because otherwise
people will wonder where their flash went.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/88a55ffc/attachment.sig>
