From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 7 Jul 2015 14:49:06 +0200 (CEST)
Subject: [RFC PATCH v6 3/3] drivers: nvmem: Add Vybrid OCOTP support
In-Reply-To: <20150707051953.GA3712@Sanchayan-Arch.toradex.int>
References: <cover.1435574288.git.maitysanchayan@gmail.com>
 <9593ca1f925aff20a6671262efd2f45e256ea676.1435574288.git.maitysanchayan@gmail.com>
 <1877493336.206622.1436177794342.JavaMail.open-xchange@oxbsltgw01.schlund.de>
 <20150707051953.GA3712@Sanchayan-Arch.toradex.int>
Message-ID: <1488361449.258303.1436273347081.JavaMail.open-xchange@oxbsltgw01.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

> maitysanchayan at gmail.com hat am 7. Juli 2015 um 07:19 geschrieben:
>
>
> [...]
> > > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > > index 17f1a57..84c830d 100644
> > > --- a/drivers/nvmem/Kconfig
> > > +++ b/drivers/nvmem/Kconfig
> > > @@ -33,4 +33,14 @@ config NVMEM_SUNXI_SID
> > > This driver can also be built as a module. If so, the module
> > > will be called eeprom-sunxi-sid.
> > >
> > > +config NVMEM_VF610_OCOTP
> > > + tristate "VF610 SoCs OCOTP support"
> > > + depends on SOC_VF610
> > > + help
> > > + This is a driver for the 'OCOTP' available on various Vybrid
> > > + devices.
> >
> > I don't know much about Vybrid. But this driver is specific for VF610, isn't
> > it?
>
> Sorry. I only checked on VF50 and VF61. Will check if is it available with the
> other Vybrid devices and change if it is not so.

no problem. If you spend time in testing your driver with different devices, you
could mention
this in your patch description. The naming VF610 suggests that the driver is
very specific.
That confuses me a little bit.

>
> >
> > > +
> > > +
> > > +static int vf610_ocotp_write(void *context, const void *data, size_t
> > > count)
> > > +{
> > > + return 0;
> > > +}
> > > +
> > > +static int vf610_ocotp_read(void *context,
> > > + const void *offset, size_t reg_size,
> > > + void *val, size_t val_size)
> > > +{
> > > + void __iomem *ocotp_base = context;
> > > + u32 *buf = val;
> > > + u32 reg;
> > > + int ret;
> > > + int i;
> > > +
> > > + for (i = 0; i < ARRAY_SIZE(valid_fuse_addr); i++) {
> > > + vf610_ocotp_set_timing(ocotp_base, ocotp_timing);
> > > + ret = vf610_ocotp_wait_busy(ocotp_base + OCOTP_CTRL_REG);
> > > + if (ret)
> > > + return ret;
> >
> > Is it really necessary to set the timing in the loop, instead before?
>
> I will test it once. From my understanding of 35.3.1.5 I thought the timing
> needs to explicitly programmed on every read. Perhaps I took it too literally.

It was only a question. If barebox does the same, it should be okay.

>
> >
> > > +
> > > + reg = readl(ocotp_base + OCOTP_CTRL_REG);
> > > + reg &= ~OCOTP_CTRL_ADDR_MASK;
> > > + reg &= ~OCOTP_CTRL_WR_UNLOCK_MASK;
> > > + reg |= BF(valid_fuse_addr[i], OCOTP_CTRL_ADDR);
> > > + writel(reg, ocotp_base + OCOTP_CTRL_REG);
> > > +
> > > + writel(OCOTP_READ_CTRL_READ_FUSE,
> > > + ocotp_base + OCOTP_READ_CTRL_REG);
> > > + ret = vf610_ocotp_wait_busy(ocotp_base + OCOTP_CTRL_REG);
> > > + if (ret)
> > > + return ret;
> > > +
> > > + if (readl(ocotp_base) & OCOTP_CTRL_ERROR) {
> > > + pr_err("Error reading from fuse address %d\n",
> > > + valid_fuse_addr[i]);
> >
> > You could use dev_err() when storing vf610_ocotp_dev in the context.
>
> Ok.
>
> >
> > > + writel(OCOTP_CTRL_ERROR, ocotp_base + OCOTP_CTRL_CLR);
> >
> > Shouldn't the function abort here?
>
> I am not sure about what usage I should follow here. I went for an
> explicit error message and since 0xBADABADA is expected to be returned
> on a read locked shadow register, the user would get the above for this
> particular fuse address and the rest can still be valid since the TRM
> mentions "subsequent reads to unlocked shadow locations will still work
> successfully." So I did not abort on the error. Should I?

In case you don't want to abort, a comment about the 0xBADABADA behavior would
be helpful.

>
> >
> > > +
> > > +
> > > +static int vf610_ocotp_probe(struct platform_device *pdev)
> > > +{
> > > + struct vf610_ocotp_dev *ocotp_dev;
> > > +
> > > + ocotp_dev = devm_kzalloc(&pdev->dev,
> > > + sizeof(struct vf610_ocotp_dev), GFP_KERNEL);
> > > + if (!ocotp_dev)
> > > + return -ENOMEM;
> > > +
> > > + ocotp_dev->dev = &pdev->dev;
> > > +
> > > + ocotp_dev->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > + ocotp_dev->base = devm_ioremap_resource(ocotp_dev->dev, ocotp_dev->res);
> > > + if (IS_ERR(ocotp_dev->base))
> > > + return PTR_ERR(ocotp_dev->base);
> > > +
> > > + ocotp_dev->clk = devm_clk_get(ocotp_dev->dev, "ocotp");
> > > + if (IS_ERR(ocotp_dev->clk)) {
> > > + dev_err(ocotp_dev->dev, "failed getting clock, err = %ld\n",
> > > + PTR_ERR(ocotp_dev->clk));
> > > + return PTR_ERR(ocotp_dev->clk);
> > > + }
> > > +
> > > + ocotp_regmap_config.max_register = resource_size(ocotp_dev->res) - 1;
> >
> > Looking at valid_fuse_addr shows me 0x3F as last valid register. So the rest
> > of the buffer ( 0xD00 - sizeof(valid_fuse_addr) ) in case of raw access
> > could be
> > uninitializied.
>
> Sorry I did not exactly get you here. The intention behind using the
> valid_fuse_addr
> is to allow reading only from valid fuse addresses and avoid reading from all
> other
> locations as per the Fuse map address table 35-1.

Yes, i got your intention. But from my unterstand the read function should fill
up
the complete buffer with defined values. My MXS OCOTP driver have the same
problem
and fill up the invalid registers with zero.

Regards
Stefan

>
> Thanks for the review.
>
> Regards,
> Sanchayan.
