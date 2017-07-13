From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 14 Jul 2017 07:21:22 +1000
Subject: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
In-Reply-To: <20170713151146.53e9644c@w520.home>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
 <20170713151146.53e9644c@w520.home>
Message-ID: <1499980882.2865.65.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-07-13 at 15:11 -0600, Alex Williamson wrote:
> > > ????? */
> > > -???if (vga_default == NULL &&
> > > -?????? ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> > > +???if (vga_default == NULL) {
> > > ?????????????vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
> > > ?????????????vga_set_default_device(pdev);
> > > ?????}? 
> 
> 
> "Legacy" is the breadcrumb we use to try to pick the same device for
> default VGA as the system firmware used as the boot VGA.? There can be
> multiple VGA devices in the system, the change above would simply make
> the first discovered device be the default VGA.? That would break many,
> many systems.? If legacy VGA ranges mean nothing on ARM64, then follow
> the powerpc lead and make an arch quirk that simply selects the first
> enabled VGA device as the default.? VGA routing is part of the PCI spec
> though, so the default of selecting the device with routing enabled
> makes sense.? Thanks,

"Legacy" there iirc also means that it has decoding enabled at boot. If
you pick the first one you may pick a device that doesn't and hasn't
been initialized by any driver (good old BIOS-initialized text mode).

Cheers,
Ben.
