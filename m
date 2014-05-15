From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 11:19:40 +0200
Subject: [RFC PATCH 06/10] usb: xhci: Add Tegra XHCI host-controller driver
In-Reply-To: <15599140.PsD4j7x3tZ@wuerfel>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-7-git-send-email-abrestic@chromium.org>
 <15599140.PsD4j7x3tZ@wuerfel>
Message-ID: <20140515091938.GD6434@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:17:10AM +0200, Arnd Bergmann wrote:
> On Wednesday 14 May 2014 17:33:02 Andrew Bresticker wrote:
[...]
> > +	/* Create child xhci-plat device */
> > +	memset(xhci_resources, 0, sizeof(xhci_resources));
> > +	res = platform_get_resource(to_platform_device(dev), IORESOURCE_IRQ, 0);
> > +	if (!res) {
> > +		dev_err(dev, "Missing XHCI IRQ\n");
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +	xhci_resources[0].start = res->start;
> > +	xhci_resources[0].end = res->end;
> > +	xhci_resources[0].flags = res->flags;
> > +	xhci_resources[0].name = res->name;
> > +	res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "Missing XHCI registers\n");
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +	xhci_resources[1].start = res->start;
> > +	xhci_resources[1].end = res->end;
> > +	xhci_resources[1].flags = res->flags;
> > +	xhci_resources[1].name = res->name;
> > +
> > +	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> > +	if (!xhci) {
> > +		dev_err(dev, "Failed to allocate XHCI host\n");
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> 
> This does not feel appropriate at all: Rather than creating a child device,
> you should have a specific driver that hooks into functions exported
> by the xhci core. See Documentation/driver-model/design-patterns.txt

I don't think Documentation/driver-model/design-patterns.txt documents
this. Perhaps this is what you had in mind?

	http://lwn.net/Articles/336262/

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/559399b3/attachment-0001.sig>
