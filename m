From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Dec 2017 20:49:28 +0900
Subject: [PATCH v2 3/3] mtd: nand: squash struct nand_buffers into struct
 nand_chip
In-Reply-To: <1512463636-28934-3-git-send-email-yamada.masahiro@socionext.com>
References: <1512463636-28934-1-git-send-email-yamada.masahiro@socionext.com>
 <1512463636-28934-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATKBO=eNHdL_P2MOh7+uRcCjkq+v8+O3DXC5UF3-NGh2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-05 17:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> struct nand_buffers is malloc'ed in nand_scan_tail() just for
> containing three pointers.  Squash this struct into nand_chip.
>
> Move and rename as follows:
>
>   chip->buffers->ecccalc   ->  chip->ecc.calc_buf
>   chip->buffers->ecccode   ->  chip->ecc.code_buf
>   chip->buffers->databuf   ->  chip->data_buf
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>




> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index dad438c..7870cb1 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1530,7 +1530,7 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>                                const uint8_t *buf, int oob_required, int page)
>  {
>         int ret;
> -       uint8_t *ecc_calc = chip->buffers->ecccalc;
> +       uint8_t *ecc_calc = chip->ecccalc;
>
>         /* Enable GPMC ecc engine */
>         chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
> @@ -1568,7 +1568,7 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
>                                   u32 data_len, const u8 *buf,
>                                   int oob_required, int page)
>  {
> -       u8 *ecc_calc = chip->buffers->ecccalc;
> +       u8 *ecc_calc = chip->ecccalc;
>         int ecc_size      = chip->ecc.size;
>         int ecc_bytes     = chip->ecc.bytes;
>         int ecc_steps     = chip->ecc.steps;
> @@ -1605,7 +1605,7 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
>
>         /* copy calculated ECC for whole page to chip->buffer->oob */
>         /* this include masked-value(0xFF) for unwritten subpages */
> -       ecc_calc = chip->buffers->ecccalc;
> +       ecc_calc = chip->ecccalc;
>         ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
>                                          chip->ecc.total);
>         if (ret)
> @@ -1635,8 +1635,8 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
>  static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>                                 uint8_t *buf, int oob_required, int page)
>  {
> -       uint8_t *ecc_calc = chip->buffers->ecccalc;
> -       uint8_t *ecc_code = chip->buffers->ecccode;
> +       uint8_t *ecc_calc = chip->ecccalc;
> +       uint8_t *ecc_code = chip->ecccode;
>         int stat, ret;
>         unsigned int max_bitflips = 0;
>



Sorry, I missed to update omap2.c

I will send v3.
