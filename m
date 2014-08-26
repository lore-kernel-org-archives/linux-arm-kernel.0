From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Aug 2014 10:09:25 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <20140826075023.GB17263@ulmo>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <3804028.YQzQ4uAVsf@wuerfel> <20140826075023.GB17263@ulmo>
Message-ID: <6589717.GOLq1GlTCJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 09:50:25 Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 09:43:50AM +0200, Arnd Bergmann wrote:
> > On Tuesday 26 August 2014 08:57:31 Thierry Reding wrote:
> > > On Mon, Aug 25, 2014 at 01:01:52PM -0600, Stephen Warren wrote:
> > > > On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> > > [...]
> > > > >+static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> > > > 
> > > > >+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > >+    if (!res)
> > > > >+            return -ENODEV;
> > > > 
> > > > Should devm_request_mem_region() be called here to claim the region?
> > > > 
> > > > >+    mbox->regs = devm_ioremap_nocache(&pdev->dev, res->start,
> > > > >+                                      resource_size(res));
> > > > >+    if (!mbox->regs)
> > > > >+            return -ENOMEM;
> > > > 
> > > > Is _nocache required? I don't see other drivers using it. I assume there's
> > > > nothing special about the mbox registers.
> > > 
> > > Most drivers should be using devm_ioremap_resource() which will use the
> > > _nocache variant of devm_ioremap() when appropriate. Usually the region
> > > will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> > > remapped uncached.
> > > 
> > 
> > Note that ioremap() and ioremap_nocache() are the same. We really shouldn't
> > ever call ioremap_nocache().
> 
> Perhaps we should remove ioremap_nocache() in that case. Or ioremap(),
> really, and keep only those variants that do what they claim to do.

That would be good, but there are many instances of either one:

arnd at wuerfel:/git/arm-soc$ git grep -w ioremap | wc
   2156   13402  183732
arnd at wuerfel:/git/arm-soc$ git grep -w ioremap_nocache | wc
    485    2529   42955

FWIW, I just looked through all architectures and found three on
which ioremap and ioremap_nocache are not the same, and ioremap
defaults to cacheable:

- OpenRISC so far only supports running in a simulator, so this
  is likely to be a bug that will get hit on actual hardware with
  MMIO. Jonas should probably look into this.

- mn10300 has no MMU and doesn't really use ioremap, but it should
  still be fixed for PCI drivers using it on the one board that
  supports PCI.

- cris seems to have been broken forever.

> > devm_ioremap_resource() and pci_iomap() checking for IORESOURCE_CACHEABLE is
> > rather silly, since it doesn't call ioremap_cache() in that case.
> 
> Then that should be fixed.

Yes. I'd suggest we just ignore that flag and always call ioremap here.

When I checked this before, IORESOURCE_CACHEABLE only ever gets set for
PCI ROM BARs, which we don't map into the kernel.

	Arnd
