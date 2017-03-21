From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Mar 2017 15:52:51 +0000
Subject: [PATCH] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <CAKv+Gu9oLVWY4QOf=eONT6a8v1+m8BKUUR79LUamysKZhbb2CQ@mail.gmail.com>
References: <1490048037-1850-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170321115447.GA3667@red-moon>
 <CAKv+Gu9oLVWY4QOf=eONT6a8v1+m8BKUUR79LUamysKZhbb2CQ@mail.gmail.com>
Message-ID: <20170321155251.GB4799@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 11:59:16AM +0000, Ard Biesheuvel wrote:

[...]

> >> +static void efifb_fixup_resources(struct pci_dev *dev)
> >> +{
> >> +     u64 fb_base = screen_info.lfb_base;
> >> +     u64 fb_size = screen_info.lfb_size;
> >> +     int i;
> >> +
> >> +     if (resource_found || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >> +             return;
> >> +
> >> +     if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> >> +             fb_base |= (u64)screen_info.ext_lfb_base << 32;
> >> +
> >> +     if (!fb_base)
> >> +             return;
> >> +
> >> +     for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
> >> +             struct resource *res = &dev->resource[i];
> >> +
> >> +             if (!(res->flags & IORESOURCE_MEM))
> >> +                     continue;
> >> +
> >> +             if (res->start <= fb_base && res->end >= fb_base + fb_size) {
> >
> > You are checking for a live resource here right (ie PCI device should be
> > enabled) ? I am not sure that just checking the resource range is safe
> > (I mean it would be most certainly a FW bug to have a PCI disabled
> > device with memory BAR programmed with the FB addresses but thought it
> > was worth mentioning).
> >
> 
> It is implied that the device is enabled. The GOP protocol exposes a
> live framebuffer base/size with some metadata regarding the pixel
> format/color depth etc. It contains no annotations as to whether the
> device is PCI or simply a framebuffer mapped in system memory, and so
> we can only assume that the device is enabled.

That's why I think you should actually check that the device memory
cycles are enabled to prevent setting a fixed resource for the wrong
PCI device (we could argue that would be a FW bug - better play it
safe though).

Thanks,
Lorenzo
