From: gdavis@mvista.com (George G. Davis)
Date: Fri, 5 Feb 2010 09:14:45 -0500
Subject: defining ZRELADDR as PHYS_OFFSET + TEXT_OFFSET
In-Reply-To: <20100205091042.GA14059@pengutronix.de>
References: <20100127101228.GA17421@pengutronix.de>
	<20100128001523.GA608@n2100.arm.linux.org.uk>
	<20100201012425.GD2582@mvista.com>
	<20100201084906.GA5983@pengutronix.de>
	<20100205082652.GE21979@mvista.com>
	<20100205091042.GA14059@pengutronix.de>
Message-ID: <20100205141445.GF21979@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 05, 2010 at 10:10:42AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Feb 05, 2010 at 03:26:52AM -0500, George G. Davis wrote:
> > Hi,
> > 
> > On Mon, Feb 01, 2010 at 09:49:07AM +0100, Uwe Kleine-K?nig wrote:
> > > Hallo George,
> > > 
> > > On Sun, Jan 31, 2010 at 08:24:25PM -0500, George G. Davis wrote:
> > > > On Thu, Jan 28, 2010 at 12:15:23AM +0000, Russell King - ARM Linux wrote:
> > > > > On Wed, Jan 27, 2010 at 11:12:28AM +0100, Uwe Kleine-K?nig wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > currently all platforms need to define zreladdr-y in
> > > > > > arch/arm/mach-$mach/Makefile.boot and PHYS_OFFSET (in
> > > > > > arch/arm/mach-$mach/include/mach/memory.h).
> > > > > > 
> > > > > > Constraints for these are:
> > > > > > 
> > > > > >  TEXTADDR = PAGE_OFFSET + TEXT_OFFSET
> > > > > >  __virt_to_phys(virt) = virt - PAGE_OFFSET + PHYS_OFFSET (at least for
> > > > > > 	"small" virtual addresses)
> > > > > >  ZRELADDR = __virt_to_phys(TEXTADDR)
> > > > > > 
> > > > > > (The equallity for __virt_to_phys only holds "normaly" according to
> > > > > > http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html.
> > > > > > In practice it holds for addresses of the first bank of RAM which is
> > > > > > enough for the purposes of this mail.)
> > > > > > 
> > > > > > So we can deduce ZRELADDR = PHYS_OFFSET + TEXT_OFFSET.
> > > > > > 
> > > > > > Is there something I missed or is it possible to get rid of zreladdr-y
> > > > > > in .../Makefile.boot and define it according to the equation above?
> > > > > 
> > > > > You'd need to find some way to get PHYS_OFFSET out of the C code
> > > > > into the makefile.  With all sorts of stuff going on in various
> > > > > platforms memory.h files, that doesn't look simple.
> > > > 
> > > > How about this?:
> > > > 
> > > > diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> > > > index 4a590f4..b79050e 100644
> > > > --- a/arch/arm/boot/Makefile
> > > > +++ b/arch/arm/boot/Makefile
> > > > @@ -21,7 +21,7 @@ endif
> > > >  #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
> > > >  #   PARAMS_PHYS must be within 4MB of ZRELADDR
> > > >  #   INITRD_PHYS must be in RAM
> > > > -ZRELADDR    := $(zreladdr-y)
> > > > +ZRELADDR    := $(shell printf "0x%08x" $$[`echo PHYS_OFFSET + $(TEXT_OFFSET)  | $(CPP) $(CPP_FLAGS) -D__ASSEMBLY__ -xc -include arch/arm/include/asm/memory.h - | tail -n 1`])
> > > >  PARAMS_PHYS := $(params_phys-y)
> > > >  INITRD_PHYS := $(initrd_phys-y)
> > > hui!  Is this really robust?
> > 
> > Apologies for the delay, busy...
> no problem.
>  
> > It can be but it is admittedly rather tricky to get the syntax right.  I've
> > no idea how the above worked the first time I tried but it didn't upon
> > further inspection.  I came up with this variation on the theme:
> > 
> > ZRELADDR     = $(shell $(CONFIG_SHELL) -c 'printf "0x%08x" $$[`echo PHYS_OFFSET + $(TEXT_OFFSET) | $(CPP) $(cpp_flags) -D__ASSEMBLY__ -xc -imacros asm/memory.h - 2>/dev/null | tail -1`]')
> bash(1) has:
> 
> 	*Arithmetic Expansion*
> 		[...] The format for arithmetic expansion is:
> 
> 			$((expression))
> 	
> 		The old format $[expression] is  deprecated  and  will
> 		be  removed  upcoming versions of bash.

Ah, thanks!  I noticed there are a number of other cases of the
deprecated $[expression] form in Linux kernel build scripts.


> Anyhow I think this yields more trouble than it's worth.

You're right.


> Maybe better move PHYS_OFFSET into Makefile.boot or arch/arm/Makefile?

Agreed.

> Or live with the redundancy?  Maybe some time in the future we don't
> need ZRELADDR any more as it is calculated by zImage based on
> PHYS_OFFSET.

That would be better.

Thanks!

--
Regards,
George

>  
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                              | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                    | http://www.pengutronix.de/  |
