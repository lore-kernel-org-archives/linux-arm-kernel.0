From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Aug 2014 09:43:50 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <20140826065729.GC15573@ulmo>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <53FB8820.4010202@wwwdotorg.org> <20140826065729.GC15573@ulmo>
Message-ID: <3804028.YQzQ4uAVsf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 08:57:31 Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 01:01:52PM -0600, Stephen Warren wrote:
> > On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> [...]
> > >+static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> > 
> > >+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >+    if (!res)
> > >+            return -ENODEV;
> > 
> > Should devm_request_mem_region() be called here to claim the region?
> > 
> > >+    mbox->regs = devm_ioremap_nocache(&pdev->dev, res->start,
> > >+                                      resource_size(res));
> > >+    if (!mbox->regs)
> > >+            return -ENOMEM;
> > 
> > Is _nocache required? I don't see other drivers using it. I assume there's
> > nothing special about the mbox registers.
> 
> Most drivers should be using devm_ioremap_resource() which will use the
> _nocache variant of devm_ioremap() when appropriate. Usually the region
> will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> remapped uncached.
> 

Note that ioremap() and ioremap_nocache() are the same. We really shouldn't
ever call ioremap_nocache().

devm_ioremap_resource() and pci_iomap() checking for IORESOURCE_CACHEABLE is
rather silly, since it doesn't call ioremap_cache() in that case.

	Arnd
