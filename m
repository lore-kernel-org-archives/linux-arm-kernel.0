From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 10:32:57 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110622081141.GN23234@n2100.arm.linux.org.uk>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110622075615.GJ6069@pengutronix.de>
	<20110622081141.GN23234@n2100.arm.linux.org.uk>
Message-ID: <20110622083257.GK6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 09:11:41AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 22, 2011 at 09:56:15AM +0200, Sascha Hauer wrote:
> > Coming back to this topic after a longer time, here is an updated
> > patch doing exactly this.
> 
> I'm not sure that this is actually correct.  Whether ARM_PATCH_PHYS_VIRT
> is enabled or not only affects the Image and not the zImage - provided
> the mach-* provides the zreladdr in their Makefile.boot, you can build
> a uImage with ARM_PATCH_PHYS_VIRT.
> 
> Where things become sticky is when AUTO_ZRELADDR is enabled - this is where
> the ZRELADDR may be omitted, and therefore there is no load/start address
> which can be provided to uboot.
> 
> >  $(obj)/uImage: STARTADDR=$(LOADADDR)
> >  
> > +ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
> 
> So maybe this wants to be ifeq ($(LOADADDR),) or CONFIG_AUTO_ZRELADDR?

LOADADDR is always set. Given the following in Makefile.boot:

zreladdr-$(CONFIG_ARCH_MX1)     := 0x08008000
zreladdr-$(CONFIG_MACH_MX21)    := 0xC0008000
zreladdr-$(CONFIG_ARCH_MX25)    := 0x80008000
zreladdr-$(CONFIG_MACH_MX27)    := 0xA0008000

LOADADDR ends up being 0xA0008000 when all of the above are enabled.
Another idea I had was to replace the := with += so that we can
count the words in zreladdr-y and bail out if we have multiple
zreladdrs. I haven't really followed this approach as it means adjusting
all Makefile.boot.

CONFIG_AUTO_ZRELADDR=y also does not necessarily mean that the resulting
uImage will not work. In the above example the image will work on i.MX27


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
