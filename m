From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 14 Jul 2017 12:14:01 +0000
Subject: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
In-Reply-To: <1499978726.2865.59.camel@kernel.crashing.org>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
 <1499978726.2865.59.camel@kernel.crashing.org>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B39943@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh at kernel.crashing.org]
> Sent: 13 July 2017 21:45
> To: Bjorn Helgaas; Gabriele Paoloni
> Cc: Daniel Axtens; linux-pci at vger.kernel.org; Liuxinliang (Matthew
> Liu); Rongrong Zou; Catalin Marinas; Will Deacon; linux-arm-
> kernel at lists.infradead.org; David Airlie; Daniel Vetter; Alex
> Williamson
> Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a
> misbehaving HiSilicon bridge
> 
> On Thu, 2017-07-13 at 06:29 -0500, Bjorn Helgaas wrote:
> > > Indeed our host controller depends on ARM64 so maybe it would make
> > > sense to move the quirk arch/arm64/kernel/pci.c; however regardless
> > > why is it strictly required for a VGA device to be legacy one in
> order
> > > to make it the default boot device?
> > > i.e. couldn't we have:
> > >
> > > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > > index 0f5b2dd..a6b606c 100644
> > > --- a/drivers/gpu/vga/vgaarb.c
> > > +++ b/drivers/gpu/vga/vgaarb.c
> > > @@ -667,8 +667,7 @@ static bool vga_arbiter_add_pci_device(struct
> pci_dev *pdev)
> > > ???????/* Deal with VGA default device. Use first enabled one
> > > ??????? * by default if arch doesn't have it's own hook
> > > ??????? */
> > > -?????if (vga_default == NULL &&
> > > -???????? ((vgadev->owns & VGA_RSRC_LEGACY_MASK) ==
> VGA_RSRC_LEGACY_MASK)) {
> > > +?????if (vga_default == NULL) {
> > > ???????????????vgaarb_info(&pdev->dev, "setting as boot VGA
> device\n");
> > > ???????????????vga_set_default_device(pdev);
> > > ???????}
> >
> > I don't know enough about the VGA arbiter to answer this.? This test
> was
> > part of the initial implementation: deb2d2ecd43d ("PCI/GPU: implement
> VGA
> > arbitration on Linux") by Ben.
> 
> The above simply uses the first device that has memory and IO enabled
> as the default device (you don't need to have a default device).
> 
> This is essentially picking up whatever device had been initialized
> by the BIOS/firmware as default. This is needed for example on x86
> where the BIOS tends to only initialize one device.
> 
> I'm not sure what problem you are trying to solve here ?

Well our host platform does not support legacy devices and therefore we find
ourselves without a default VGA device...

I was trying to understand why a default device has to be legacy...but I think
this was answered by both you and Alex in other follows-up...

Thanks
Gab 

> 
> Cheers,
> Ben.
