From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 11:08:11 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <6589717.GOLq1GlTCJ@wuerfel>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <3804028.YQzQ4uAVsf@wuerfel> <20140826075023.GB17263@ulmo>
 <6589717.GOLq1GlTCJ@wuerfel>
Message-ID: <20140826090810.GH17263@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 10:09:25AM +0200, Arnd Bergmann wrote:
> On Tuesday 26 August 2014 09:50:25 Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 09:43:50AM +0200, Arnd Bergmann wrote:
> > > On Tuesday 26 August 2014 08:57:31 Thierry Reding wrote:
> > > > On Mon, Aug 25, 2014 at 01:01:52PM -0600, Stephen Warren wrote:
> > > > > On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> > > > [...]
> > > > > >+static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> > > > > 
> > > > > >+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > >+    if (!res)
> > > > > >+            return -ENODEV;
> > > > > 
> > > > > Should devm_request_mem_region() be called here to claim the region?
> > > > > 
> > > > > >+    mbox->regs = devm_ioremap_nocache(&pdev->dev, res->start,
> > > > > >+                                      resource_size(res));
> > > > > >+    if (!mbox->regs)
> > > > > >+            return -ENOMEM;
> > > > > 
> > > > > Is _nocache required? I don't see other drivers using it. I assume there's
> > > > > nothing special about the mbox registers.
> > > > 
> > > > Most drivers should be using devm_ioremap_resource() which will use the
> > > > _nocache variant of devm_ioremap() when appropriate. Usually the region
> > > > will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> > > > remapped uncached.
> > > > 
> > > 
> > > Note that ioremap() and ioremap_nocache() are the same. We really shouldn't
> > > ever call ioremap_nocache().
> > 
> > Perhaps we should remove ioremap_nocache() in that case. Or ioremap(),
> > really, and keep only those variants that do what they claim to do.
> 
> That would be good, but there are many instances of either one:
> 
> arnd at wuerfel:/git/arm-soc$ git grep -w ioremap | wc
>    2156   13402  183732
> arnd at wuerfel:/git/arm-soc$ git grep -w ioremap_nocache | wc
>     485    2529   42955

Ugh... nothing that I currently have time for. Perhaps this is a good
one for the Janitors? I'm not sure if the kernelnewbies.org TODO list is
still frequented since many pages seem to be very old. Is there some
other place where I could add this?

> > > devm_ioremap_resource() and pci_iomap() checking for IORESOURCE_CACHEABLE is
> > > rather silly, since it doesn't call ioremap_cache() in that case.
> > 
> > Then that should be fixed.
> 
> Yes. I'd suggest we just ignore that flag and always call ioremap here.
> 
> When I checked this before, IORESOURCE_CACHEABLE only ever gets set for
> PCI ROM BARs, which we don't map into the kernel.

There's still a few users of ioremap_cache() around and they are
potential candidates for a conversion to devm_ioremap_resource(), so I
think it'd still make sense to keep the check.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/ec08b2e6/attachment-0001.sig>
