From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 12:20:13 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <5184912.mY2hCPH20k@wuerfel>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <6589717.GOLq1GlTCJ@wuerfel> <20140826090810.GH17263@ulmo>
 <5184912.mY2hCPH20k@wuerfel>
Message-ID: <20140826102011.GA31124@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:54:43AM +0200, Arnd Bergmann wrote:
> On Tuesday 26 August 2014 11:08:11 Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 10:09:25AM +0200, Arnd Bergmann wrote:
> > > On Tuesday 26 August 2014 09:50:25 Thierry Reding wrote:
> > > > On Tue, Aug 26, 2014 at 09:43:50AM +0200, Arnd Bergmann wrote:
> > > > > On Tuesday 26 August 2014 08:57:31 Thierry Reding wrote:
> > > > > > On Mon, Aug 25, 2014 at 01:01:52PM -0600, Stephen Warren wrote:
> > > > > > > On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> > > > > > [...]
> > > > > > > >+static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> > > > > > > 
> > > > > > > >+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > > > >+    if (!res)
> > > > > > > >+            return -ENODEV;
> > > > > > > 
> > > > > > > Should devm_request_mem_region() be called here to claim the region?
> > > > > > > 
> > > > > > > >+    mbox->regs = devm_ioremap_nocache(&pdev->dev, res->start,
> > > > > > > >+                                      resource_size(res));
> > > > > > > >+    if (!mbox->regs)
> > > > > > > >+            return -ENOMEM;
> > > > > > > 
> > > > > > > Is _nocache required? I don't see other drivers using it. I assume there's
> > > > > > > nothing special about the mbox registers.
> > > > > > 
> > > > > > Most drivers should be using devm_ioremap_resource() which will use the
> > > > > > _nocache variant of devm_ioremap() when appropriate. Usually the region
> > > > > > will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> > > > > > remapped uncached.
> > > > > > 
> > > > > 
> > > > > Note that ioremap() and ioremap_nocache() are the same. We really shouldn't
> > > > > ever call ioremap_nocache().
> > > > 
> > > > Perhaps we should remove ioremap_nocache() in that case. Or ioremap(),
> > > > really, and keep only those variants that do what they claim to do.
> > > 
> > > That would be good, but there are many instances of either one:
> > > 
> > > arnd at wuerfel:/git/arm-soc$ git grep -w ioremap | wc
> > >    2156   13402  183732
> > > arnd at wuerfel:/git/arm-soc$ git grep -w ioremap_nocache | wc
> > >     485    2529   42955
> > 
> > Ugh... nothing that I currently have time for. Perhaps this is a good
> > one for the Janitors? I'm not sure if the kernelnewbies.org TODO list is
> > still frequented since many pages seem to be very old. Is there some
> > other place where I could add this?
> 
> I'm not sure if it's really worth it. One thing we might do is just
> remove all definitions of ioremap_nocache and add a wrapper to
> include/linux/io.h, to make it more obvious what is going on.

Yes, I suppose that would work too. I still think there's an advantage
in being explicit and avoid aliases like this. Perhaps a __deprecated
annotation would help with that?

> > > > > devm_ioremap_resource() and pci_iomap() checking for IORESOURCE_CACHEABLE is
> > > > > rather silly, since it doesn't call ioremap_cache() in that case.
> > > > 
> > > > Then that should be fixed.
> > > 
> > > Yes. I'd suggest we just ignore that flag and always call ioremap here.
> > > 
> > > When I checked this before, IORESOURCE_CACHEABLE only ever gets set for
> > > PCI ROM BARs, which we don't map into the kernel.
> > 
> > There's still a few users of ioremap_cache() around and they are
> > potential candidates for a conversion to devm_ioremap_resource(), so I
> > think it'd still make sense to keep the check.
> 
> Possibly. Note that these are all in architecture-specific code, as
> evidenced by the fact that we have multiple names for this function:
> 
> ioremap_cache:    arm, arm64, x86, ia64, sh
> ioremap_cached:   metag, unicore32
> ioremap_cachable: mips
> 
> All other architectures have none of the above.
> 
> An alternative approach would be to kill off IORESOURCE_CACHEABLE
> and introduce a devm_ioremap_resource_cache() helper when the first
> driver wants it.

Looking briefly at the involved headers and structure there seems to be
quite a bit of potential for cleanup.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/88ee2aca/attachment.sig>
