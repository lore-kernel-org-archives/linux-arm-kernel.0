From: ydroneaud@opteya.com (Yann Droneaud)
Date: Mon, 27 Jan 2014 21:25:31 +0100
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <20140127181836.GH26766@pengutronix.de>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127181836.GH26766@pengutronix.de>
Message-ID: <1390854331.23180.22.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le lundi 27 janvier 2014 ? 19:18 +0100, Uwe Kleine-K?nig a ?crit :
> On Mon, Jan 27, 2014 at 09:52:57AM -0800, Laura Abbott wrote:
> > The dma_mask for a device structure is a pointer. This pointer
> > needs to be set up before the dma mask can actually be set. Most
> > frameworks in the kernel take care of setting this up properly but
> > platform devices that don't follow a regular bus structure may not
> > ever have this set. As a result, checks such as dma_capable will
> > always return false on a raw platform device and dma_set_mask will
> > always return -EIO. Fix this by adding a dma_mask in the
> > platform_device archdata and setting it to be the dma_mask. Devices
> > used in other frameworks can change this as needed.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Suggested-by: Kumar Gala <galak@codeaurora.org>
> > Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> Hello,
> 
> there is another non-platform dependant approach available, that might
> be worth to evaluate:
> 
> 	http://mid.gmane.org/1390817152-30898-1-git-send-email-ydroneaud at opteya.com
> 

ARM, even AAAAARGH64 [1], doesn't need a special treatement regarding
the infamous dma_mask pointer. So perhaps my solution is better.

This solution (adding dma_mask in pdev_archdata) is already in use in
powerpc architecture. See arch/powerpc/kernel/setup-common.c

The advantage of this solution is that it makes a dma_mask placeholder
available to statically allocated platform_device struct, while mine
only address the problem for platform_device struct allocated with
platform_device_alloc().

A possible drawback of adding dma_mask in pdev_archdata and setting the
pointer in arch_setup_pdev_archdata() may be that a dma_mask setup prior
calling platform_device_register() got overwritten.
For example at91rm9200_usbh_device in
arch/arm/mach-at91/at91rm9200_devices.c (it's the first occurence
returned by cscope).

So I guess there's not yet a perfect solution (add dma_mask to struct
platform_device instead of hidding it either in struct pdev_archdata or
struct platform_object ?).

BTW, I've started to convert some drivers just to try my first option.

I'm also considering using dma_set_mask_and_coherent() in
platform_device_register_full() and drivers using
platform_device_alloc(). But I'm not sure about it : will it break
something with the additionals check on the mask, just as the failure
reported in the message ("dma_set_mask will always return -EIO.") ?

[1]
http://lkml.kernel.org/r/20140124154002.GF31570 at twins.programming.kicks-ass.net

Regards.

-- 
Yann Droneaud
OPTEYA
