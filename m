From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Sep 2015 08:42:34 +0100
Subject: [PATCH 4/6] hwrng: st: Add support for ST's HW Random Number
 Generator
In-Reply-To: <CAOMZO5CWywFHd1HE2=G-KEvQZpu_rJibmJL4fL5yCWRsnpi05Q@mail.gmail.com>
References: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
 <1442002110-28733-5-git-send-email-lee.jones@linaro.org>
 <CAOMZO5CWywFHd1HE2=G-KEvQZpu_rJibmJL4fL5yCWRsnpi05Q@mail.gmail.com>
Message-ID: <20150914074234.GC27591@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Sep 2015, Fabio Estevam wrote:

> On Fri, Sep 11, 2015 at 5:08 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
> > +
> > +       clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (!clk)
> > +               return -EINVAL;
> 
> This should be:
> 
>     if (IS_ERR(clk))
>         return PTR_ERR(clk);

You're right.  Will fix.

> > +
> > +       clk_prepare_enable(clk);
> 
> This may fail, so better check its return value and propagate it on error.

Looks like the jury is out on this one.

$ git grep clk_prepare_enable | grep '= clk\|if (' | wc -l
659
$ git grep clk_prepare_enable | grep -v '= clk\|if (' | wc -l
569

... but it's not a problem to fix up.  Will do.

> > +       ddata->ops.priv = (unsigned long)ddata;
> > +       ddata->ops.read = st_rng_read;
> > +       ddata->ops.name = pdev->name;
> > +       ddata->base     = base;
> > +       ddata->clk      = clk;
> > +
> > +       dev_set_drvdata(&pdev->dev, ddata);
> > +
> > +       ret = hwrng_register(&ddata->ops);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Failed to register HW RNG\n");
> > +               return ret;
> > +       }
> > +
> > +       dev_info(&pdev->dev, "Successfully registered HW RNG\n");
> 
> No need to put this info.

Ah, you caught me!

I know these types of prints are usually deemed not useful; however,
unless there is a failure both this driver and the core driver are
silent, so the user doesn't know that 1 or more of these devices are
available.  I personally like to see an entry in the bootlog for this
kind of functionality.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
