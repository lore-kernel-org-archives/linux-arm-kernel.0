From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 15:59:56 +0200
Subject: [PATCH] VFIO: platform: AMD xgbe reset module
In-Reply-To: <20151015121228.GA965@cbox>
References: <1444836792-2405-1-git-send-email-eric.auger@linaro.org>
 <7287273.XGFpHqQ9fN@wuerfel> <20151015121228.GA965@cbox>
Message-ID: <5270338.MbsQ1bGczu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 14:12:28 Christoffer Dall wrote:
> > 
> > enum vfio_platform_op {
> >       VFIO_PLATFORM_BIND,
> >       VFIO_PLATFORM_UNBIND,
> >       VFIO_PLATFORM_RESET,
> > };
> > 
> > struct platform_driver {
> >         int (*probe)(struct platform_device *);
> >         int (*remove)(struct platform_device *);
> >       ...
> >       int (*vfio_manage)(struct platform_device *, enum vfio_platform_op);
> >         struct device_driver driver;
> > };
> > 
> > This would integrate much more closely into the platform driver framework,
> > just like the regular vfio driver integrates into the PCI framework.
> > Unlike PCI however, you can't just use the generic driver framework to
> > unbind the driver, because you still need device specific code.
> > 
> Thanks for these suggestions, really helpful.
> 
> What I don't understand in the latter example is how VFIO knows which
> struct platform_driver to interact with?

This would assume that the driver remains bound to the device, so VFIO
gets a pointer to the device from somewhere (as it does today) and then
follows the dev->driver pointer to get to the platform_driver.
 
> Also, just so I'm sure I understand correctly, VFIO_PLATFORM_UNBIND is
> then called by VFIO before the VFIO driver unbinds from the device
> (unbinding the platform driver from the device being a completely
> separate thing)?

This is where we'd need a little more changes for this approach. Instead
of unbinding the device from its driver, the idea would be that the
driver remains bound as far as the driver model is concerned, but
it would be in a quiescent state where no other subsystem interacts with
it (i.e. it gets unregistered from networking core or whichever it uses).

	Arnd
