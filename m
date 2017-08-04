From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 4 Aug 2017 14:34:30 +0200
Subject: [PATCH v2] mtd: nand: mxc: Fix mxc_v1 ooblayout
In-Reply-To: <1480069952-14989-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480069952-14989-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170804143430.5dbde945@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Nov 2016 11:32:32 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Commit a894cf6c5a82 ("mtd: nand: mxc: switch to mtd_ooblayout_ops")
> introduced a bug in the OOB layout description. Even if the driver claims
> that 3 ECC bytes are reserved to protect 512 bytes of data, it's actually
> 5 ECC bytes to protect 512+6 bytes of data (some OOB bytes are also
> protected using extra ECC bytes).
> 
> Fix the mxc_v1_ooblayout_{free,ecc}() functions to reflect this behavior.

Applied.

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: a894cf6c5a82 ("mtd: nand: mxc: switch to mtd_ooblayout_ops")
> Cc: <stable@vger.kernel.org>
> ---
> Changes in v2:
> - Use a macro for the number of ECC bytes
> ---
>  drivers/mtd/nand/mxc_nand.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 61ca020c5272..d929111b5ebe 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -877,6 +877,8 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
>  	}
>  }
>  
> +#define MXC_V1_ECCBYTES		5
> +
>  static int mxc_v1_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				struct mtd_oob_region *oobregion)
>  {
> @@ -886,7 +888,7 @@ static int mxc_v1_ooblayout_ecc(struct mtd_info *mtd, int section,
>  		return -ERANGE;
>  
>  	oobregion->offset = (section * 16) + 6;
> -	oobregion->length = nand_chip->ecc.bytes;
> +	oobregion->length = MXC_V1_ECCBYTES;
>  
>  	return 0;
>  }
> @@ -908,8 +910,7 @@ static int mxc_v1_ooblayout_free(struct mtd_info *mtd, int section,
>  			oobregion->length = 4;
>  		}
>  	} else {
> -		oobregion->offset = ((section - 1) * 16) +
> -				    nand_chip->ecc.bytes + 6;
> +		oobregion->offset = ((section - 1) * 16) + MXC_V1_ECCBYTES + 6;
>  		if (section < nand_chip->ecc.steps)
>  			oobregion->length = (section * 16) + 6 -
>  					    oobregion->offset;
