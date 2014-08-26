From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 09:50:25 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <3804028.YQzQ4uAVsf@wuerfel>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <53FB8820.4010202@wwwdotorg.org> <20140826065729.GC15573@ulmo>
 <3804028.YQzQ4uAVsf@wuerfel>
Message-ID: <20140826075023.GB17263@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 09:43:50AM +0200, Arnd Bergmann wrote:
> On Tuesday 26 August 2014 08:57:31 Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 01:01:52PM -0600, Stephen Warren wrote:
> > > On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> > [...]
> > > >+static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> > > 
> > > >+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >+    if (!res)
> > > >+            return -ENODEV;
> > > 
> > > Should devm_request_mem_region() be called here to claim the region?
> > > 
> > > >+    mbox->regs = devm_ioremap_nocache(&pdev->dev, res->start,
> > > >+                                      resource_size(res));
> > > >+    if (!mbox->regs)
> > > >+            return -ENOMEM;
> > > 
> > > Is _nocache required? I don't see other drivers using it. I assume there's
> > > nothing special about the mbox registers.
> > 
> > Most drivers should be using devm_ioremap_resource() which will use the
> > _nocache variant of devm_ioremap() when appropriate. Usually the region
> > will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> > remapped uncached.
> > 
> 
> Note that ioremap() and ioremap_nocache() are the same. We really shouldn't
> ever call ioremap_nocache().

Perhaps we should remove ioremap_nocache() in that case. Or ioremap(),
really, and keep only those variants that do what they claim to do.

> devm_ioremap_resource() and pci_iomap() checking for IORESOURCE_CACHEABLE is
> rather silly, since it doesn't call ioremap_cache() in that case.

Then that should be fixed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/a91ef206/attachment.sig>
