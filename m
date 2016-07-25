From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 15:41:38 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <CALw8SCU5s8BAg6B8dT=QokY-D-CcokmMEkYqz1GJWHkX-XWpRQ@mail.gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
 <20160725111443.GB21170@ulmo.ba.sec>
 <CALw8SCU5s8BAg6B8dT=QokY-D-CcokmMEkYqz1GJWHkX-XWpRQ@mail.gmail.com>
Message-ID: <20160725134138.GL21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 02:17:11PM +0200, Mirza Krak wrote:
> 2016-07-25 13:14 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Tue, Jul 19, 2016 at 03:36:37PM +0200, Mirza Krak wrote:
[...]
> >> +
> >> +     if (of_get_child_count(of_node))
> >> +             ret = of_platform_populate(of_node,
> >> +                                of_default_bus_match_table,
> >> +                                NULL, &pdev->dev);
> >
> > Why the extra check? of_platform_populate() is almost a no-op if there
> > aren't any children anyway. What it will do is set the OF_POPULATED_BUS
> > flag, but I think we want that irrespective of whether or not there are
> > any children.
> >
> > Was there any problem with calling it unconditionally that made you opt
> > for the extra check?
> 
> I have not tested calling it unconditionally. Used another driver as
> reference and they had that condition (drivers/bus/imx-weim.c), that
> driver does not mention why the condition is there. But will test
> removing the condition and see what happens.

If that works fine for Tegra, it might be a good idea to get rid of the
call in the imx-weim.c driver, too.

> >> +static struct platform_driver nor_driver = {
> >> +     .driver = {
> >> +             .name           = "tegra-nor",
> >> +             .of_match_table = nor_id_table,
> >> +     },
> >> +};
> >> +module_platform_driver_probe(nor_driver, nor_probe);
> >> +
> >> +MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
> >> +MODULE_DESCRIPTION("NVIDIA Tegra NOR Bus Driver");
> >> +MODULE_LICENSE("GPL");
> >
> > You're header comment says GPL version 2, which means that the
> > MODULE_LICENSE needs to be "GPL v2". "GPL" means "version 2 or later".
> 
> Ok, I do not really mind it being GPL version 2 or later so will
> change the header comment instead if that is ok.

I think "GPL v2" is traditionally more common in kernel code, but as the
author the decision is obviously yours.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/daba8235/attachment.sig>
