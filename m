From: greg@kroah.com (Greg KH)
Date: Mon, 19 Dec 2011 22:07:06 -0800
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112181950.38993.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112181444.39812.heiko@sntech.de>
 <20111218144319.GU14542@n2100.arm.linux.org.uk>
 <201112181950.38993.heiko@sntech.de>
Message-ID: <20111220060706.GC25439@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 07:50:37PM +0100, Heiko St?bner wrote:
> Am Sonntag 18 Dezember 2011, 15:43:19 schrieb Russell King - ARM Linux:
> > On Sun, Dec 18, 2011 at 02:44:39PM +0100, Heiko St?bner wrote:
> > > Am Sonntag 18 Dezember 2011, 09:10:48 schrieb Russell King - ARM Linux:
> > > > On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> > > > > As the driver is also buildable as a module it should need
> > > > > a cleanup function for the removal of the module.
> > > > 
> > > > My guess is that this wasn't implemented because of the embedded struct
> > > > device lifetime rules for the gadget - to prevent the unbinding of the
> > > > driver.
> > > > 
> > > > Until the struct device lifetime gets fixed, you must not allow the
> > > > module nor the data structure containing the struct device to be
> > > > freed.
> > > 
> > > I understand where this problem comes from (the release method is
> > > potentially gone with the module before it is called) but after more
> > > reading, I have a hard time believing that a lot of the other gadget
> > > drivers would be wrong as well. Some of them since 2009 or possibly
> > > earlier.
> > > 
> > > Gadgets with embedded release methods: langwell_udc, goku_udc, fsl_qe_udc
> > > (and fsl_udc_core), amd5536udc, net2280, pch_udc, cil13xxx_udc,
> > > dummy_hcd, omap_udc, net2272, mc_udc_core
> > > 
> > > Gadgets which use the release method from its pdev->dev but also free the
> > > struct with the gadget in their remove method: r8a66597-udc, m66592-udc,
> > > fusb300_udc. (possibly before the release function is called)
> > > 
> > > On the other hand, the gets and puts of the udc->gadget.dev should be
> > > paired correctly and it's only an intermediate device between the udc
> > > and the gadget driver, so that the call to device_unregister in the
> > > remove method should put the refcount to 0 and thus init the cleanup
> > > (including the call to release) before the module is removed.
> > > 
> > > So, I am very confused :-).
> > 
> > Try this patch.  If your system oopses 5 seconds after you remove the
> > module, you have a lifetime bug.
> I didn't get this far. With your patch the Oopses already happen during the startup of
> the system / the loading of the modules.
> 
> A bit of the message spew I got during testing with linux-next-20111216:
> 
> pgd = c0004000
> [bf05b504] *pgd=379af811, *pte=00000000, *ppte=00000000
> Internal error: Oops: 7 [#1]
> Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core s3c_hsudc
> CPU: 0    Not tainted  (3.2.0-rc5-next-20111216+ #32)
> PC is at kobject_put+0x18/0x7c

You cut out the wording right before this.

And because of that, I get to publicly mock you for going directly
against how kobjects are supposed to work (see the documentation for
why.)

Go read the documentation, and don't try to "outsmart" the kernel, do
you really think I put that warning in there just for the fun of it?

greg k-h
