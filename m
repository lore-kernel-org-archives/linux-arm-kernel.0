From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 23:18:13 +0200
Subject: [RFC PATCH 06/10] usb: xhci: Add Tegra XHCI host-controller driver
In-Reply-To: <CAL1qeaHm7U2NVDeVZS-Tiz5ntkk4c13RR_1ws9MTYGGoGCOB5A@mail.gmail.com>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-7-git-send-email-abrestic@chromium.org>
 <15599140.PsD4j7x3tZ@wuerfel>
 <CAL1qeaHm7U2NVDeVZS-Tiz5ntkk4c13RR_1ws9MTYGGoGCOB5A@mail.gmail.com>
Message-ID: <20140515211812.GC7136@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 01:18:22PM -0700, Andrew Bresticker wrote:
> Arnd,
> 
> On Thu, May 15, 2014 at 1:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 14 May 2014 17:33:02 Andrew Bresticker wrote:
> >> +
> >> +int tegra_xhci_register_mbox_notifier(struct notifier_block *nb)
> >> +{
> >> +     int ret;
> >> +
> >> +     mutex_lock(&tegra_xhci_mbox_lock);
> >> +     ret = raw_notifier_chain_register(&tegra_xhci_mbox_notifiers, nb);
> >> +     mutex_unlock(&tegra_xhci_mbox_lock);
> >> +
> >> +     return ret;
> >> +}
> >> +EXPORT_SYMBOL(tegra_xhci_register_mbox_notifier);
> >> +
> >> +void tegra_xhci_unregister_mbox_notifier(struct notifier_block *nb)
> >> +{
> >> +     mutex_lock(&tegra_xhci_mbox_lock);
> >> +     raw_notifier_chain_unregister(&tegra_xhci_mbox_notifiers, nb);
> >> +     mutex_unlock(&tegra_xhci_mbox_lock);
> >> +}
> >> +EXPORT_SYMBOL(tegra_xhci_unregister_mbox_notifier);
> >
> > What driver would use these?
> 
> It's used by just this driver (the host) and the PHY driver (next
> patch in series).
> 
> > My feeling is that if you have a mailbox that is used by multiple
> > drivers, you should use a proper mailbox driver to operate them,
> > and have the drivers register with that API instead of a custom one.
> 
> Ok, will do.
> 
> >> +     /* Create child xhci-plat device */
> >> +     memset(xhci_resources, 0, sizeof(xhci_resources));
> >> +     res = platform_get_resource(to_platform_device(dev), IORESOURCE_IRQ, 0);
> >> +     if (!res) {
> >> +             dev_err(dev, "Missing XHCI IRQ\n");
> >> +             ret = -ENODEV;
> >> +             goto out;
> >> +     }
> >> +     xhci_resources[0].start = res->start;
> >> +     xhci_resources[0].end = res->end;
> >> +     xhci_resources[0].flags = res->flags;
> >> +     xhci_resources[0].name = res->name;
> >> +     res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 0);
> >> +     if (!res) {
> >> +             dev_err(dev, "Missing XHCI registers\n");
> >> +             ret = -ENODEV;
> >> +             goto out;
> >> +     }
> >> +     xhci_resources[1].start = res->start;
> >> +     xhci_resources[1].end = res->end;
> >> +     xhci_resources[1].flags = res->flags;
> >> +     xhci_resources[1].name = res->name;
> >> +
> >> +     xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> >> +     if (!xhci) {
> >> +             dev_err(dev, "Failed to allocate XHCI host\n");
> >> +             ret = -ENOMEM;
> >> +             goto out;
> >> +     }
> >
> > This does not feel appropriate at all: Rather than creating a child device,
> > you should have a specific driver that hooks into functions exported
> > by the xhci core. See Documentation/driver-model/design-patterns.txt
> 
> This is how DWC3, currently the only in-tree non-PCI XHCI host driver,
> is structured - see drivers/usb/dwc3/host.c.  The recently proposed
> Armada XHCI driver [1] just adds clock support and a hook in
> xhci-plat's probe() to do the platform-specific initialization.

Ugh... that very much sounds like the midlayer mistake. Doing that is
not going to scale in the long run. Everybody will just keep adding
quirks to the initialization until it's become a huge mess.

> Tegra's XHCI driver initialization is quite a bit more complicated,
> mainly due to the need for external firmware and specific ordering
> (e.g. firmware messages should only be enabled after the HCD is
> created).  I could do away with the xhci-plat sub-device and just
> create a Tegra hc_driver, but it seems silly to have three XHCI
> platform drivers structured in three different ways.  USB folks, do
> you have an opinion on how this should be done?

The tendency in other subsystems (and I think this is also true to some
degree for USB, though I'm less familiar with it) is to make common
functions available as a library of helpers so that other drivers can
use them (either directly or by wrapping them in platform-specific
implementations). That allows you to keep the platform-specific code
where it belongs: in the platform-specific driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/74e7a8e1/attachment.sig>
