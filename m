From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 17 Feb 2013 00:54:57 +0200
Subject: [PATCHv3 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201302162221.32799.arnd@arndb.de>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <201302161400.29064.arnd@arndb.de>
 <CAHp75VfL0cQJenHB7A_A1d2eam2dj3k+4yWRE8pC+_gP2j_k2Q@mail.gmail.com>
 <201302162221.32799.arnd@arndb.de>
Message-ID: <CAHp75VeCic+5_zyzFdtpw5dLxRaajD9zv6ZvSoDcHAD1EF=GSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The original device tree binding for this driver, from Viresh Kumar
> unfortunately conflicted with the generic DMA binding, and did not allow
> to completely seperate slave device configuration from the controller.
>
> This is an attempt to replace it with an implementation of the generic
> binding, but it is currently completely untested, because I do not have
> any hardware with this particular controller.
>
> The patch applies on top of the slave-dma tree, which contains both the base
> support for the generic DMA binding, as well as the earlier attempt from
> Viresh. Both of these are currently not merged upstream however.
>
> This version incorporates feedback from Viresh Kumar, Andy Shevchenko
> and Russell King.

Sorry, few comments below.
After addressing them take my Acked-by: Andy Shevchenko
<andriy.shevchenko@linux.intel.com>

> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c


> @@ -1836,6 +1825,12 @@ static int dw_probe(struct platform_device *pdev)
>
>         dma_async_device_register(&dw->dma);
>
> +       if (pdev->dev.of_node)
> +               err = of_dma_controller_register(pdev->dev.of_node,
> +                                                dw_dma_xlate, dw);
> +       if (err && err != -ENODEV)
> +               dev_err(&pdev->dev, "could not register of_dma_controller\n");

I believe we may make it as
 if (...of_node) {
  err = ...register();
  if (err...)
    dev_err();
 }

> --- a/drivers/dma/dw_dmac_regs.h
> +++ b/drivers/dma/dw_dmac_regs.h

> @@ -211,9 +212,15 @@ struct dw_dma_chan {
>         /* hardware configuration */
>         unsigned int            block_size;
>         bool                    nollp;
> +       unsigned int            request_line;
> +       struct dw_dma_slave     slave;
> +

Do we really need an extra empty line here?

>
>         /* configuration passed via DMA_SLAVE_CONFIG */
>         struct dma_slave_config dma_sconfig;
> +
> +       /* backlink to dw_dma */
> +       struct dw_dma           *dw;

Seems it's not needed and came from rebase?

-- 
With Best Regards,
Andy Shevchenko
