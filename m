From: alex.williamson@redhat.com (Alex Williamson)
Date: Fri, 14 Jul 2017 08:43:18 -0600
Subject: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
 <20170713151146.53e9644c@w520.home>
 <1499980882.2865.65.camel@kernel.crashing.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
Message-ID: <20170714084318.6042e8ad@w520.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jul 2017 12:26:05 +0000
Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:

> Hi Ben, Alex
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh at kernel.crashing.org]
> > Sent: 13 July 2017 22:21
> > To: Alex Williamson; Bjorn Helgaas
> > Cc: Gabriele Paoloni; Daniel Axtens; linux-pci at vger.kernel.org;
> > Liuxinliang (Matthew Liu); Rongrong Zou; Catalin Marinas; Will Deacon;
> > linux-arm-kernel at lists.infradead.org; David Airlie; Daniel Vetter
> > Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a
> > misbehaving HiSilicon bridge
> > 
> > On Thu, 2017-07-13 at 15:11 -0600, Alex Williamson wrote:  
> > > > > ????? */
> > > > > -???if (vga_default == NULL &&
> > > > > -?????? ((vgadev->owns & VGA_RSRC_LEGACY_MASK) ==  
> > VGA_RSRC_LEGACY_MASK)) {  
> > > > > +???if (vga_default == NULL) {
> > > > > ?????????????vgaarb_info(&pdev->dev, "setting as boot VGA  
> > device\n");  
> > > > > ?????????????vga_set_default_device(pdev);
> > > > > ?????}  
> > >
> > >
> > > "Legacy" is the breadcrumb we use to try to pick the same device for
> > > default VGA as the system firmware used as the boot VGA.? There can  
> > be  
> > > multiple VGA devices in the system, the change above would simply  
> > make  
> > > the first discovered device be the default VGA.? That would break  
> > many,  
> > > many systems.? If legacy VGA ranges mean nothing on ARM64, then  
> > follow  
> > > the powerpc lead and make an arch quirk that simply selects the first
> > > enabled VGA device as the default.? VGA routing is part of the PCI  
> > spec  
> > > though, so the default of selecting the device with routing enabled
> > > makes sense.? Thanks,  
> > 
> > "Legacy" there iirc also means that it has decoding enabled at boot. If
> > you pick the first one you may pick a device that doesn't and hasn't
> > been initialized by any driver (good old BIOS-initialized text mode).  
> 
> Right so effectively if there is a legacy dev we should pick that up;
> however what about the following code:
> 
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 92f1452..ab3ad9a 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -1424,6 +1424,14 @@ static int __init vga_arb_device_init(void)
>  
>  	list_for_each_entry(vgadev, &vga_list, list) {
>  		struct device *dev = &vgadev->pdev->dev;
> +
> +		/* if no legacy device has been set as default VGA
> +		 * device, just pick up the first one in the list */
> +		if (vga_default == NULL) {
> +			vgaarb_info(dev, "setting as boot VGA device\n");
> +			vga_set_default_device(vgadev->pdev);
> +		}
> +
>  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  		/*
>  		 * Override vga_arbiter_add_pci_device()'s I/O based detection 
> 
> Above after we have filled the list of VGA devices by iterating over all
> PCI devices we check if no legacy one has been set as default VGA device
> yet: therefore we set the first VGA device in the list as default one...
> 
> Do you think it would work?

I'd suggest at least looking for an enabled device as fixup_vga() does,
perhaps that would even be enough to remove that arch quirk.  Thanks,

Alex
