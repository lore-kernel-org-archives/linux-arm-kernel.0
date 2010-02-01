From: gdavis@mvista.com (George G. Davis)
Date: Sun, 31 Jan 2010 20:24:25 -0500
Subject: defining ZRELADDR as PHYS_OFFSET + TEXT_OFFSET
In-Reply-To: <20100128001523.GA608@n2100.arm.linux.org.uk>
References: <20100127101228.GA17421@pengutronix.de>
	<20100128001523.GA608@n2100.arm.linux.org.uk>
Message-ID: <20100201012425.GD2582@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 28, 2010 at 12:15:23AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2010 at 11:12:28AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > currently all platforms need to define zreladdr-y in
> > arch/arm/mach-$mach/Makefile.boot and PHYS_OFFSET (in
> > arch/arm/mach-$mach/include/mach/memory.h).
> > 
> > Constraints for these are:
> > 
> >  TEXTADDR = PAGE_OFFSET + TEXT_OFFSET
> >  __virt_to_phys(virt) = virt - PAGE_OFFSET + PHYS_OFFSET (at least for
> > 	"small" virtual addresses)
> >  ZRELADDR = __virt_to_phys(TEXTADDR)
> > 
> > (The equallity for __virt_to_phys only holds "normaly" according to
> > http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html.
> > In practice it holds for addresses of the first bank of RAM which is
> > enough for the purposes of this mail.)
> > 
> > So we can deduce ZRELADDR = PHYS_OFFSET + TEXT_OFFSET.
> > 
> > Is there something I missed or is it possible to get rid of zreladdr-y
> > in .../Makefile.boot and define it according to the equation above?
> 
> You'd need to find some way to get PHYS_OFFSET out of the C code
> into the makefile.  With all sorts of stuff going on in various
> platforms memory.h files, that doesn't look simple.

How about this?:

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..b79050e 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -21,7 +21,7 @@ endif
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
-ZRELADDR    := $(zreladdr-y)
+ZRELADDR    := $(shell printf "0x%08x" $$[`echo PHYS_OFFSET + $(TEXT_OFFSET)  | $(CPP) $(CPP_FLAGS) -D__ASSEMBLY__ -xc -include arch/arm/include/asm/memory.h - | tail -n 1`])
 PARAMS_PHYS := $(params_phys-y)
 INITRD_PHYS := $(initrd_phys-y)
 

Since params_phys-y is (always?) constant relative to zreladdr-y, it can
also be calculated in a similar fashion, e.g.

PARAMS_PHYS := $(shell printf "0x%08x" $$[$(ZRELADDR) - 0x7f00])

--
Regards,
George
