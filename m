From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 08:58:39 +0000
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <CAMj5Bkh6XBBR1f99X4oKS5kbF2y7Lxpgp2jYB-6vv2q_8ej5Lg@mail.gmail.com>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <201207250601.06866.arnd@arndb.de>
 <CAMj5Bkh6XBBR1f99X4oKS5kbF2y7Lxpgp2jYB-6vv2q_8ej5Lg@mail.gmail.com>
Message-ID: <201207250858.39420.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, zhangfei gao wrote:

> > Ah, so it is the request line. Now the current plan for this is to go
> > into the "dmas" property of the child device using the dma engine binding.
> >
> > That way, the driver will end up asking for a channel that matches what
> > is specified for the device, e.g.
> >
> >         nand {
> >                 ...
> >                 dmas = <&pdma 3 0x1184>;
> >         };
> >
> > I believe this is normally set through the filter function when asking
> > for a channel on other drivers, not through slave_config.
> 
> It is great that the request line is already been considered.
> Still want to double confirm, it is dmaengine.c will parse out "the
> request line",
> Dma-engine driver will get request line from dmaengine.c, right?
> So there is dependence.
> Or dmaengine driver parse the request line itself from client driver?
> 
> Some client may require more than one dma channel,
> such as camera, YUV three channels are required.
> 
> camera {
>         ...
>                 dmas = <&pdma 1 0x1110 /* Y */
>                 &pdma 1 0x1114 /* U */
>                 &pmaa 1 0x1118>; /* V */
>          };
> 
> Besides, we also have to consider how to parse "request line" if using pdata.

The current plan is to allow an arbitrary number of channels in the client,
which can all go to the same or different dmaengine drivers. You can also
specify multiple channels that can be used as alternatives, by adding a
dma-names property and naming them the same. Further, the number of fields
required for specifying the request line is determined by the dmac driver.
The first two cells of each specifier are parsed by the dmaengine common
code and all following ones are parsed handed to the dmac specific driver.

A complex example would be

                 dmas = <&pdma 1 0x1110   /* Y on pdma */
			&tdma 1 0x100 32  /* Y on tdma */
                 	&pdma 1 0x1114    /* U */ 
                 	&tdma 1 0x200 32  /* U */ 
                 	&pmaa 1 0x1118    /* V */
                 	&tdma 1 0x300 32>; /* V */ 
		dma-names = "Y", "Y", "U", "U", "V", "V";

In this case the pdma node would set #dma-cells=<3> and the tdma node would
set #dma-cells=<4> in order to pass two separate arguments. Through the
dma-names property, the common code can identify which channels belong
together and the driver just needs to ask for a channel like

	chan_y = of_dma_request_named_channel(pdev, "Y");

> >> >> +static struct of_device_id mmp_pdma_dt_ids[] = {
> >> >> +     { .compatible = "mrvl,mmp-pdma", .data = (void *)MMP_PDMA},
> >> >> +     {}
> >> >> +};
> >> >> +MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
> >> >
> >> > You don't actually use the data field afaict, so that can be removed.
> >>
> >> We keep .data as type, for easy extension, in case future soc register
> >> may be different.
> >> It is fine to remove the data field, as well as mmp_pdma_id_table.
> >
> > Ok. Note that in many cases it's actually easier to point the .data
> > field to a data structure rather than an integer, it's valid either
> > way. Unfortunately the type is different between of_device_id and
> > platform_device_id, but a pointer also works for both.
> 
> Yes, also find .data is different between of_device_id and platform_device_id.
> So using strong conversion for simplification.
> Will change to data structure if you think it is more professional.

Just do whatever your fits your needs, I'm just noting that in a lot of
drivers, using a structure ends up being easier.

> > If you think that you will see different kinds of pdma that you need
> > to distinguish here, I would recommend that you use a more specific
> > "compatible" identifier, like
> >
> >         { .compatible = "marvell,pxa168-pdma", };
> >
> mmp-tdma.c have to take this, since register difference in pxa910 and pxa688.
> mmp-pdma.c register keeps same since pxa3xx, we will remove the type.

In the pdma case, I would suggest that you also specify the name of the soc
there, but in the device tree list the device as compatible with the older
one, e.g. for pxa930:

	compatible = "marvell,pxa930-pdma", "marvell,pxa300-pdma";

This way the driver needs to know about only one, but is ready for future
extensions, e.g. if a future pxa985 is slightly different.

	Arnd
