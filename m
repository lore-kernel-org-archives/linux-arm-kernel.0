From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jun 2012 00:41:33 -0700
Subject: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
In-Reply-To: <20120611071301.GC6845@arwen.pp.htv.fi>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
 <20120611071301.GC6845@arwen.pp.htv.fi>
Message-ID: <20120611074133.GZ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120611 00:19]:
> On Sun, Jun 10, 2012 at 11:34:17PM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > Similar comments to the asess patch on this one below.
> > 
> > * Paul Walmsley <paul@pwsan.com> [120610 17:57]:
> > > --- /dev/null
> > > +++ b/include/linux/platform_data/fsusb.h
> > 
> > This would be better as include/linux/platform_data/omap-usb.h.
> > 
> > > +#include <plat/omap_hwmod.h>
> > 
> > This include should not be needed here if the hwmod function is
> > a static function in the some hwmod*.c file.
> > 
> > > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> > > +#define HCCOMMANDSTATUS			0x0008
> > > +
> > > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> > > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
> > 
> > I think these already have standard defines in some OHCI header?
> > Felipe may be able to comment more on this?
> 
> Well, yeah... but it's defined on drivers/usb/host/ohci.h and it's
> actually a structure:

OK I guess then the define is OK.

> > This should be "static inline int fsusb_reset_host_controller" as it's
> > in a header.
> 
> why is it even in a header ? Only hwmod_fsusb_preprogram() will use it
> anyway.

Well ideally it would be something that any OHCI driver can use for
it's reset, and whatever bus code can also call to reset and idle
for the unused devices that don't have the driver compiled in. Got
any better suggestions where to place it? I could be a generic
ohci_reset function in some header?

I don't want to have driver specific code under arch/arm/*omap*/* as
the bus level code should not need to know anything about the driver
specific registers.

Regards,

Tony
