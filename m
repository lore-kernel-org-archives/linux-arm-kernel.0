From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 15:30:06 +0200
Subject: [RFC PATCH 06/10] usb: xhci: Add Tegra XHCI host-controller driver
In-Reply-To: <20140515091938.GD6434@ulmo>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <15599140.PsD4j7x3tZ@wuerfel> <20140515091938.GD6434@ulmo>
Message-ID: <11038777.juA2AddEko@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 11:19:40 Thierry Reding wrote:
> > > +
> > > +   xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> > > +   if (!xhci) {
> > > +           dev_err(dev, "Failed to allocate XHCI host\n");
> > > +           ret = -ENOMEM;
> > > +           goto out;
> > > +   }
> > 
> > This does not feel appropriate at all: Rather than creating a child device,
> > you should have a specific driver that hooks into functions exported
> > by the xhci core. See Documentation/driver-model/design-patterns.txt
> 
> I don't think Documentation/driver-model/design-patterns.txt documents
> this. Perhaps this is what you had in mind?
> 
>         http://lwn.net/Articles/336262/

No, I did mean Documentation/driver-model/design-patterns.txt.

The pattern used in the proposed driver is to create the generic platform_device
as the child of the more specific platform_device.

The normal pattern is to have only one device and embed the generic structure
inside of the more specific structure and use container_of to cast between
the two as needed.

	Arnd
