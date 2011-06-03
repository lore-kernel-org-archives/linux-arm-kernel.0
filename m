From: adrian.wenl@gmail.com (Lei Wen)
Date: Fri, 3 Jun 2011 23:11:54 +0800
Subject: [PATCH] MTD: pxa3xx_nand: fix nand detection issue
In-Reply-To: <1305865207-7869-1-git-send-email-leiwen@marvell.com>
References: <BANLkTimos3-Ds4Y8FDfDZegqAhH7nSS4PA@mail.gmail.com>
	<1305865207-7869-1-git-send-email-leiwen@marvell.com>
Message-ID: <BANLkTinuqQmp43K4H0iPDbb-H-rDA_nL9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Daniel Mack <zonque@gmail.com>

Also cc to MTD maillist and stable kernel.

On Fri, May 20, 2011 at 12:20 PM, Lei Wen <leiwen@marvell.com> wrote:
> When keep_config is set, the detection would goes different routine.
> That the driver would read out the setting which is set previously
> by bootloader. While most bootloader keep the irq mask as off, and
> current driver need all irq default open, keep_config behavior would
> lead to no irq at all.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
> ?drivers/mtd/nand/pxa3xx_nand.c | ? 12 +++++++-----
> ?1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index ff07012..9896aef 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -813,7 +813,7 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
> ? ? ? ?info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
> ? ? ? ?/* set info fields needed to read id */
> ? ? ? ?info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
> - ? ? ? info->reg_ndcr = ndcr;
> + ? ? ? info->reg_ndcr = ndcr & ~NDCR_INT_MASK;
> ? ? ? ?info->cmdset = &default_cmdset;
>
> ? ? ? ?info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
> @@ -882,7 +882,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
> ? ? ? ?struct pxa3xx_nand_info *info = mtd->priv;
> ? ? ? ?struct platform_device *pdev = info->pdev;
> ? ? ? ?struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
> - ? ? ? struct nand_flash_dev pxa3xx_flash_ids[2] = { {NULL,}, {NULL,} };
> + ? ? ? struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
> ? ? ? ?const struct pxa3xx_nand_flash *f = NULL;
> ? ? ? ?struct nand_chip *chip = mtd->priv;
> ? ? ? ?uint32_t id = -1;
> @@ -942,8 +942,10 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
> ? ? ? ?pxa3xx_flash_ids[0].erasesize = f->page_size * f->page_per_block;
> ? ? ? ?if (f->flash_width == 16)
> ? ? ? ? ? ? ? ?pxa3xx_flash_ids[0].options = NAND_BUSWIDTH_16;
> + ? ? ? pxa3xx_flash_ids[1].name = NULL;
> + ? ? ? def = pxa3xx_flash_ids;
> ?KEEP_CONFIG:
> - ? ? ? if (nand_scan_ident(mtd, 1, pxa3xx_flash_ids))
> + ? ? ? if (nand_scan_ident(mtd, 1, def))
> ? ? ? ? ? ? ? ?return -ENODEV;
> ? ? ? ?/* calculate addressing information */
> ? ? ? ?info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
> @@ -954,9 +956,9 @@ KEEP_CONFIG:
> ? ? ? ? ? ? ? ?info->row_addr_cycles = 2;
> ? ? ? ?mtd->name = mtd_names[0];
> ? ? ? ?chip->ecc.mode = NAND_ECC_HW;
> - ? ? ? chip->ecc.size = f->page_size;
> + ? ? ? chip->ecc.size = info->page_size;
>
> - ? ? ? chip->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16 : 0;
> + ? ? ? chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16 : 0;
> ? ? ? ?chip->options |= NAND_NO_AUTOINCR;
> ? ? ? ?chip->options |= NAND_NO_READRDY;
>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
