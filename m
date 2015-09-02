From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 2 Sep 2015 14:43:27 +0200
Subject: [PATCH v2] nand: sunxi: fix write to USER_DATA reg
In-Reply-To: <1441180621-29708-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1441180621-29708-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150902144327.08efeba1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Wed,  2 Sep 2015 09:57:01 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> The USER_DATA register cannot be accessed using byte accessors on A13
> SoCs, thus triggering a bug when using memcpy_toio on this register.
> Declare an NFC_USER_DATA() macro to convert the OOB buffer content into
> a suitable u32 value which can then be programmed with writel().
> 
> Also drop the oob_required contidion, since ->oob_pio already contains
> FFs when oob_required is false.

Please ignore this version. I just figured I would need a macro to
convert a USER_DATA value into an u8 buffer.
I'll send a v3 adding two macros (NFC_BUF_TO_USER_DATA() and
NFC_USER_DATA_TO_BUF()) instead of the NFC_USER_DATA() one.

Best Regards,

Boris

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> ---
> Changes since v1:
> - drop the !oob_required conditional path
> - replace endianness conversions by a macro relying on byte shifting
>   operations
> ---
>  drivers/mtd/nand/sunxi_nand.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 6f93b29..0c29f6c 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -138,6 +138,10 @@
>  #define NFC_ECC_MODE		GENMASK(15, 12)
>  #define NFC_RANDOM_SEED		GENMASK(30, 16)
>  
> +/* NFC_USER_DATA helper macro */
> +#define NFC_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
> +				 ((buf)[2] << 16) | ((buf)[3] << 24))
> +
>  #define NFC_DEFAULT_TIMEOUT_MS	1000
>  
>  #define NFC_SRAM_SIZE		1024
> @@ -632,15 +636,9 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
>  		offset = layout->eccpos[i * ecc->bytes] - 4 + mtd->writesize;
>  
>  		/* Fill OOB data in */
> -		if (oob_required) {
> -			tmp = 0xffffffff;
> -			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
> -				    4);
> -		} else {
> -			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE,
> -				    chip->oob_poi + offset - mtd->writesize,
> -				    4);
> -		}
> +		writel(NFC_USER_DATA(chip->oob_poi +
> +				     layout->oobfree[i].offset),
> +		       nfc->regs + NFC_REG_USER_DATA_BASE);
>  
>  		chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
>  
> @@ -770,14 +768,7 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
>  		offset += ecc->size;
>  
>  		/* Fill OOB data in */
> -		if (oob_required) {
> -			tmp = 0xffffffff;
> -			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
> -				    4);
> -		} else {
> -			memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, oob,
> -				    4);
> -		}
> +		writel(NFC_USER_DATA(oob), nfc->regs + NFC_REG_USER_DATA_BASE);
>  
>  		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
>  		      (1 << 30);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
