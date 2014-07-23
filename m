From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Jul 2014 15:26:53 +0100
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <CAOesGMgya9i=zc_AVO_mgrC_FjYz-RWxwXguNueVA=7gpq=5sA@mail.gmail.com>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
 <CAOesGMgya9i=zc_AVO_mgrC_FjYz-RWxwXguNueVA=7gpq=5sA@mail.gmail.com>
Message-ID: <1406125613.25343.140.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 20:46 +0100, Olof Johansson wrote:
> > @@ -946,12 +946,18 @@ int __init platform_bus_init(void)
> >
> >         early_platform_cleanup();
> >
> > -       error = device_register(&platform_bus);
> > +       dev_set_name(&platform_bus.dev, "%s", platform_bus.name);
> > +       error = device_register(&platform_bus.dev);
> >         if (error)
> >                 return error;
> >         error =  bus_register(&platform_bus_type);
> > -       if (error)
> > -               device_unregister(&platform_bus);
> > +       if (!error) {
> > +               platform_bus.dev.of_node = of_allnodes;
> 
> This breaks all non-OF platforms:
> 
> drivers/base/platform.c: In function 'platform_bus_init':
> drivers/base/platform.c:955:30: error: 'of_allnodes' undeclared (first
> use in this function)
>    platform_bus.dev.of_node = of_allnodes;

Right, of course, my bad. I can't see any other way of getting the tree
root, so an #ifdef it will be...

Thanks for pointing this out!

Pawe?
