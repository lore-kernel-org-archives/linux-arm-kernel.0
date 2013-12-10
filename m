From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Dec 2013 10:19:59 +0000
Subject: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 05:10:01AM +0000, Li.Xiubo at freescale.com wrote:
> Hi Mark, Therry,
>
> Is this series of patches ok about endianess fix?
>
> Here I add one boolen big-endian property.

[...]

> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > +             const void __iomem *addr)
> > +{
> > +     if (likely(fpc->big_endian))
> > +             return ioread32be(addr);
> > +     else
> > +             return readl(addr);
> > +}

It looks a little odd to to have two different accessors here.

Could these not be unified somehow?

> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> > +             u32 val, void __iomem *addr)
> > +{
> > +     if (likely(fpc->big_endian))
> > +             iowrite32be(val, addr);
> > +     else
> > +             writel(val, addr);
> > +}

Likewise.

[...]

> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +     int ret;
> > +     struct fsl_pwm_chip *fpc;
> > +     struct resource *res;
> > +     struct device_node *np = pdev->dev.of_node;
> > +
> > +     fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> > +     if (!fpc)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&fpc->lock);
> > +
> > +     fpc->chip.dev = &pdev->dev;
> > +
> > +     if (of_get_property(np, "big-endian", NULL))
> > +             fpc->big_endian = 1;

You can use of_property_read_bool:

fpc->big_endian = of_property_read_bool(np, "big-endian");

Otherwise, the DT stuff looks fine.

Mark.
