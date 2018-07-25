From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Jul 2018 18:42:44 +0900
Subject: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
In-Reply-To: <20180720151527.16038-5-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-5-miquel.raynal@bootlin.com>
Message-ID: <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


2018-07-21 0:14 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/denali.c | 138 +++++++++++++++++++++++-------------------
>  1 file changed, 77 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 4d53f41ada08..2fa92c297a66 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1205,62 +1205,12 @@ static int denali_multidev_fixup(struct denali_nand_info *denali)
>         return 0;
>  }
>
> -int denali_init(struct denali_nand_info *denali)
> +static int denali_attach_chip(struct nand_chip *chip)
>  {
> -       struct nand_chip *chip = &denali->nand;
>         struct mtd_info *mtd = nand_to_mtd(chip);
> -       u32 features = ioread32(denali->reg + FEATURES);
> +       struct denali_nand_info *denali = mtd_to_denali(mtd);
>         int ret;
>
> -       mtd->dev.parent = denali->dev;
> -       denali_hw_init(denali);
> -
> -       init_completion(&denali->complete);
> -       spin_lock_init(&denali->irq_lock);
> -
> -       denali_clear_irq_all(denali);
> -
> -       ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
> -                              IRQF_SHARED, DENALI_NAND_NAME, denali);
> -       if (ret) {
> -               dev_err(denali->dev, "Unable to request IRQ\n");
> -               return ret;
> -       }
> -
> -       denali_enable_irq(denali);
> -       denali_reset_banks(denali);
> -
> -       denali->active_bank = DENALI_INVALID_BANK;
> -
> -       nand_set_flash_node(chip, denali->dev->of_node);
> -       /* Fallback to the default name if DT did not give "label" property */
> -       if (!mtd->name)
> -               mtd->name = "denali-nand";
> -
> -       chip->select_chip = denali_select_chip;
> -       chip->read_byte = denali_read_byte;
> -       chip->write_byte = denali_write_byte;
> -       chip->read_word = denali_read_word;
> -       chip->cmd_ctrl = denali_cmd_ctrl;
> -       chip->dev_ready = denali_dev_ready;
> -       chip->waitfunc = denali_waitfunc;
> -
> -       if (features & FEATURES__INDEX_ADDR) {
> -               denali->host_read = denali_indexed_read;
> -               denali->host_write = denali_indexed_write;
> -       } else {
> -               denali->host_read = denali_direct_read;
> -               denali->host_write = denali_direct_write;
> -       }
> -
> -       /* clk rate info is needed for setup_data_interface */
> -       if (denali->clk_rate && denali->clk_x_rate)
> -               chip->setup_data_interface = denali_setup_data_interface;
> -
> -       ret = nand_scan_ident(mtd, denali->max_banks, NULL);
> -       if (ret)
> -               goto disable_irq;
> -
>         if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
>                 denali->dma_avail = 1;
>
> @@ -1293,7 +1243,7 @@ int denali_init(struct denali_nand_info *denali)
>                                    mtd->oobsize - denali->oob_skip_bytes);
>         if (ret) {
>                 dev_err(denali->dev, "Failed to setup ECC settings.\n");
> -               goto disable_irq;
> +               return ret;
>         }
>
>         dev_dbg(denali->dev,
> @@ -1337,7 +1287,7 @@ int denali_init(struct denali_nand_info *denali)
>
>         ret = denali_multidev_fixup(denali);
>         if (ret)
> -               goto disable_irq;
> +               return ret;
>
>         /*
>          * This buffer is DMA-mapped by denali_{read,write}_page_raw.  Do not
> @@ -1345,26 +1295,92 @@ int denali_init(struct denali_nand_info *denali)
>          * guarantee DMA-safe alignment.
>          */
>         denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
> -       if (!denali->buf) {
> -               ret = -ENOMEM;
> -               goto disable_irq;
> +       if (!denali->buf)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void denali_detach_chip(struct nand_chip *chip)
> +{
> +       struct mtd_info *mtd = nand_to_mtd(chip);
> +       struct denali_nand_info *denali = mtd_to_denali(mtd);
> +
> +       kfree(denali->buf);
> +}
> +
> +static const struct nand_controller_ops denali_controller_ops = {
> +       .attach_chip = denali_attach_chip,
> +       .detach_chip = denali_detach_chip,
> +};
> +
> +int denali_init(struct denali_nand_info *denali)
> +{
> +       struct nand_chip *chip = &denali->nand;
> +       struct mtd_info *mtd = nand_to_mtd(chip);
> +       u32 features = ioread32(denali->reg + FEATURES);
> +       int ret;
> +
> +       mtd->dev.parent = denali->dev;
> +       denali_hw_init(denali);
> +
> +       init_completion(&denali->complete);
> +       spin_lock_init(&denali->irq_lock);
> +
> +       denali_clear_irq_all(denali);
> +
> +       ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
> +                              IRQF_SHARED, DENALI_NAND_NAME, denali);
> +       if (ret) {
> +               dev_err(denali->dev, "Unable to request IRQ\n");
> +               return ret;
> +       }
> +
> +       denali_enable_irq(denali);
> +       denali_reset_banks(denali);
> +
> +       denali->active_bank = DENALI_INVALID_BANK;
> +
> +       nand_set_flash_node(chip, denali->dev->of_node);
> +       /* Fallback to the default name if DT did not give "label" property */
> +       if (!mtd->name)
> +               mtd->name = "denali-nand";
> +
> +       chip->select_chip = denali_select_chip;
> +       chip->read_byte = denali_read_byte;
> +       chip->write_byte = denali_write_byte;
> +       chip->read_word = denali_read_word;
> +       chip->cmd_ctrl = denali_cmd_ctrl;
> +       chip->dev_ready = denali_dev_ready;
> +       chip->waitfunc = denali_waitfunc;
> +
> +       if (features & FEATURES__INDEX_ADDR) {
> +               denali->host_read = denali_indexed_read;
> +               denali->host_write = denali_indexed_write;
> +       } else {
> +               denali->host_read = denali_direct_read;
> +               denali->host_write = denali_direct_write;
>         }
>
> -       ret = nand_scan_tail(mtd);
> +       /* clk rate info is needed for setup_data_interface */
> +       if (denali->clk_rate && denali->clk_x_rate)
> +               chip->setup_data_interface = denali_setup_data_interface;
> +
> +       chip->dummy_controller.ops = &denali_controller_ops;
> +       ret = nand_scan(mtd, denali->max_banks);
>         if (ret)
> -               goto free_buf;
> +               goto disable_irq;
>
>         ret = mtd_device_register(mtd, NULL, 0);
>         if (ret) {
>                 dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
>                 goto cleanup_nand;
>         }
> +
>         return 0;
>
>  cleanup_nand:
>         nand_cleanup(chip);
> -free_buf:
> -       kfree(denali->buf);
>  disable_irq:
>         denali_disable_irq(denali);
>
> --
> 2.14.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/





You need to remove kfree(denali->buf)
from denali_remove(), right?



void denali_remove(struct denali_nand_info *denali)
{
        struct mtd_info *mtd = nand_to_mtd(&denali->nand);

        nand_release(mtd);
        kfree(denali->buf);       <---- REMOVE !!
        denali_disable_irq(denali);
}




Otherwise, denali_remove() will free denali->buf twice
because kfree(denali->buf) is called from denali_detach_chip().






-- 
Best Regards
Masahiro Yamada
