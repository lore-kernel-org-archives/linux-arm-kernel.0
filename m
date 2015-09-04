From: klimov.linux@gmail.com (Alexey Klimov)
Date: Fri, 4 Sep 2015 07:10:10 +0300
Subject: [PATCH v12 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1441242397-870-2-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
 <1441242397-870-2-git-send-email-stefan@agner.ch>
Message-ID: <CALW4P+LDwFnCjOorh7iCr8TrUnync7a_zkdZ4Hp_91=60AtUQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

just few very small comments.

On Thu, Sep 3, 2015 at 4:06 AM, Stefan Agner <stefan@agner.ch> wrote:

[..]

> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c

[..]

> +static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
> +{
> +       return readl(nfc->regs + reg);
> +}
> +
> +static inline void vf610_nfc_write(struct vf610_nfc *nfc, uint reg, u32 val)
> +{
> +       writel(val, nfc->regs + reg);
> +}
> +
> +static inline void vf610_nfc_set(struct vf610_nfc *nfc, uint reg, u32 bits)
> +{
> +       vf610_nfc_write(nfc, reg, vf610_nfc_read(nfc, reg) | bits);
> +}
> +
> +static inline void vf610_nfc_clear(struct vf610_nfc *nfc, uint reg, u32 bits)
> +{
> +       vf610_nfc_write(nfc, reg, vf610_nfc_read(nfc, reg) & ~bits);
> +}
> +
> +static inline void vf610_nfc_set_field(struct vf610_nfc *nfc, u32 reg,
> +                                      u32 mask, u32 shift, u32 val)
> +{
> +       vf610_nfc_write(nfc, reg,
> +                       (vf610_nfc_read(nfc, reg) & (~mask)) | val << shift);
> +}
> +
> +static inline void vf610_nfc_memcpy(void *dst, const void __iomem *src,
> +                                   size_t n)
> +{
> +       /*
> +        * Use this accessor for the internal SRAM buffers. On the ARM
> +        * Freescale Vybrid SoC it's known that the driver can treat
> +        * the SRAM buffer as if it's memory. Other platform might need
> +        * to treat the buffers differently.
> +        *
> +        * For the time being, use memcpy
> +        */
> +       memcpy(dst, src, n);
> +}
> +
> +/* Clear flags for upcoming command */
> +static inline void vf610_nfc_clear_status(struct vf610_nfc *nfc)
> +{
> +       u32 tmp = vf610_nfc_read(nfc, NFC_IRQ_STATUS);
> +
> +       tmp |= CMD_DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
> +       vf610_nfc_write(nfc, NFC_IRQ_STATUS, tmp);
> +}

There is general intention on maillists that I see sometimes is to
make people get rid of
'inline' for static functions in *.c files and let compiler decide how
to optimize that.


> +static int vf610_nfc_probe(struct platform_device *pdev)
> +{
> +       struct vf610_nfc *nfc;
> +       struct resource *res;
> +       struct mtd_info *mtd;
> +       struct nand_chip *chip;
> +       struct device_node *child;
> +       const struct of_device_id *of_id;
> +       int err = 0;

According to usage you don't need to initialize err to zero here.

> +       int irq;
> +
> +       nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
> +       if (!nfc)
> +               return -ENOMEM;
> +
> +       nfc->dev = &pdev->dev;
> +       mtd = &nfc->mtd;
> +       chip = &nfc->chip;
> +
> +       mtd->priv = chip;
> +       mtd->owner = THIS_MODULE;
> +       mtd->dev.parent = nfc->dev;
> +       mtd->name = DRV_NAME;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq <= 0)
> +               return -EINVAL;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       nfc->regs = devm_ioremap_resource(nfc->dev, res);
> +       if (IS_ERR(nfc->regs))
> +               return PTR_ERR(nfc->regs);
> +
> +       nfc->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(nfc->clk))
> +               return PTR_ERR(nfc->clk);
> +
> +       err = clk_prepare_enable(nfc->clk);
> +       if (err) {
> +               dev_err(nfc->dev, "Unable to enable clock!\n");
> +               return err;
> +       }

After fixing that feel free to use:

Reviewed-by: Alexey Klimov <klimov.linux@gmail.com>

Thanks,
Alexey Klimov
