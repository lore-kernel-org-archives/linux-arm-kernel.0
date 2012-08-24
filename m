From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 24 Aug 2012 15:28:08 +0300
Subject: [PATCH v2] mxc_nand : allow swapping the Bad block Indicator
 for NFC v1.
In-Reply-To: <1345035872-11314-1-git-send-email-gcembed@gmail.com>
References: <1345035872-11314-1-git-send-email-gcembed@gmail.com>
Message-ID: <1345811288.2848.308.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2012-08-15 at 15:04 +0200, Ga?tan Carlier wrote:
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 3f94e1f..7f5847a 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -682,6 +682,26 @@ static int mxc_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
>  	return 0;
>  }
>  
> +/*
> + * Swap the BI-byte on position 0x7D0 with a data byte at 0x835.
> + * To fix a bug in NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
> + * Warning: The same solution needs to be applied to the boot loader and the
> + * flash programmer.
> + */
> +static void imx_bi_swap(struct mtd_info *mtd)

Could you please name the function 'nfcv1_bi_swap_quirk()' or something
like this, to make it clear that this is a work-around.

> +{
> +	struct nand_chip *nand_chip = mtd->priv;
> +	struct mxc_nand_host *host = nand_chip->priv;
> +	unsigned short temp1, temp2, new_temp1;
> +
> +	temp1 = *((volatile unsigned short*)(host->main_area0 + 0x7D0));
> +	temp2 = *((volatile unsigned short*)(host->main_area0 + 0x834));
> +	new_temp1 = (temp1 & 0xFF00) | (temp2 >> 8);
> +	temp2 = (temp2 & 0x00FF) | (temp1 << 8);
> +	*((volatile unsigned short*)(host->main_area0 + 0x7D0)) = new_temp1;
> +	*((volatile unsigned short*)(host->main_area0 + 0x834)) = temp2;

Within the linux kernel all the I/O memory accesses should be done using
accessor functions, not directly.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120824/722593db/attachment.sig>
