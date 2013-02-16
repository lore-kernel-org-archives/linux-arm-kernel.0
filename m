From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 16 Feb 2013 16:53:08 +0200
Subject: [PATCH 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201302161400.29064.arnd@arndb.de>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <1360952512-971558-3-git-send-email-arnd@arndb.de>
 <CAHp75VfyO5wep-shvZ_mkwLmL2_Fa2jgq63AvE2t8=TPLZn6yg@mail.gmail.com>
 <201302161400.29064.arnd@arndb.de>
Message-ID: <CAHp75VfL0cQJenHB7A_A1d2eam2dj3k+4yWRE8pC+_gP2j_k2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 4:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 16 February 2013, Andy Shevchenko wrote:
>> On Fri, Feb 15, 2013 at 8:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> > +       if (WARN_ON(fargs.req >= 16 || fargs.src >= 2 || fargs.dst >= 2))
>> > +               return NULL;
>>
>> 16 here is a magic number for me. I would like to see something like
>> #define DW_MAX_REQUEST_LINES 16 in the dw_dmac_regs.h.
>
> Ok.
>
>> Besides of that, what 2 does come from?
>
> I thought that Viresh had commented that there could only be two masters.
> It's probably best to compare against dw->nr_masters here.

Right.

>> > @@ -1765,6 +1751,10 @@ static int dw_probe(struct platform_device *pdev)
>> >
>> >         dma_async_device_register(&dw->dma);
>> >
>> > +       err = of_dma_controller_register(pdev->dev.of_node, dw_dma_xlate, dw);
>> > +       if (err)
>> > +               dev_err(&pdev->dev, "could not register of_dma_controller\n");
>>
>> It's not an error, dev_dbg. Consider case when !CONFIG_OF.
>
> Ah right. I expected of_dma_controller_register to return 0 in that case, but
> it returns -ENODEV. How about I change this to this?
>
>         if (pdev->dev.of_node)
>                 err = of_dma_controller_register(pdev->dev.of_node, dw_dma_xlate, dw);
>         if (err && err != -ENODEV)
>                 dev_err(&pdev->dev, "could not register of_dma_controller\n");
>
> That would warn only when we have a dw_dmac device that was registered from
> device tree but does not follow the binding or gets an -ENOMEM.

I'm okay with it.

> Thanks for your review!

Thanks for the patch!

-- 
With Best Regards,
Andy Shevchenko
