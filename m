From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 29 Sep 2015 13:55:48 -0700
Subject: [PATCH v12 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <CALW4P+LDwFnCjOorh7iCr8TrUnync7a_zkdZ4Hp_91=60AtUQw@mail.gmail.com>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
 <1441242397-870-2-git-send-email-stefan@agner.ch>
 <CALW4P+LDwFnCjOorh7iCr8TrUnync7a_zkdZ4Hp_91=60AtUQw@mail.gmail.com>
Message-ID: <20150929205548.GO31505@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 07:10:10AM +0300, Alexey Klimov wrote:
> On Thu, Sep 3, 2015 at 4:06 AM, Stefan Agner <stefan@agner.ch> wrote:
> > --- /dev/null
> > +++ b/drivers/mtd/nand/vf610_nfc.c

> > +static int vf610_nfc_probe(struct platform_device *pdev)
> > +{
> > +       struct vf610_nfc *nfc;
> > +       struct resource *res;
> > +       struct mtd_info *mtd;
> > +       struct nand_chip *chip;
> > +       struct device_node *child;
> > +       const struct of_device_id *of_id;
> > +       int err = 0;
> 
> According to usage you don't need to initialize err to zero here.

Fixed this one.

> > +       int irq;
> > +
> > +       nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
> > +       if (!nfc)
> > +               return -ENOMEM;
> > +
> > +       nfc->dev = &pdev->dev;
> > +       mtd = &nfc->mtd;
> > +       chip = &nfc->chip;
> > +
> > +       mtd->priv = chip;
> > +       mtd->owner = THIS_MODULE;
> > +       mtd->dev.parent = nfc->dev;
> > +       mtd->name = DRV_NAME;
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq <= 0)
> > +               return -EINVAL;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       nfc->regs = devm_ioremap_resource(nfc->dev, res);
> > +       if (IS_ERR(nfc->regs))
> > +               return PTR_ERR(nfc->regs);
> > +
> > +       nfc->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(nfc->clk))
> > +               return PTR_ERR(nfc->clk);
> > +
> > +       err = clk_prepare_enable(nfc->clk);
> > +       if (err) {
> > +               dev_err(nfc->dev, "Unable to enable clock!\n");
> > +               return err;
> > +       }
> 
> After fixing that feel free to use:
> 
> Reviewed-by: Alexey Klimov <klimov.linux@gmail.com>

Also, fixed up the nand_chip field name change (from 'dn' to
'flash_node'), and pushed to l2-mtd.git

Thanks,
Brian
