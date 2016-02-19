From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2016 16:43:44 +0000
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <14272873.q312Ii8Axy@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <14272873.q312Ii8Axy@wuerfel>
Message-ID: <20160219164344.GY19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 04:34:51PM +0100, Arnd Bergmann wrote:
> On Friday 19 February 2016 14:29:00 Chris Brandt wrote:
> > On 19 Feb 2016, Arnd Bergmann wrote:
> > 
> > > On Thursday 18 February 2016 11:02:33 Nicolas Pitre wrote:
> > > > 
> > > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > > 
> > > > Is there a way to provide a default for defaults?
> > > 
> > > We could have something like
> > > 
> > > config PHYS_OFFSET_0
> > > 	bool
> > > 
> > > config PHYS_OFFSET_1
> > > 	bool
> > > 
> > > config PHYS_OFFSET_2
> > > 	bool
> > > 
> > > ... (we need 8 of the 16 possible addresses)
> > > 
> > > 
> > > config PHYS_OFFSET
> > > 	hex "Physical address of main memory" if MMU
> > > 	default DRAM_BASE if !MMU
> > > 	default 0x00000000 if PHYS_OFFSET_0
> > > 	default 0x10000000 if PHYS_OFFSET_1
> > > 	default 0x20000000 if PHYS_OFFSET_2
> > > 	default 0x30000000 if PHYS_OFFSET_3
> > > 	default 0x70000000 if PHYS_OFFSET_7
> > > 	default 0x80000000 if PHYS_OFFSET_8
> > > 	default 0xa0000000 if PHYS_OFFSET_A
> > > 	default 0xc0000000 if PHYS_OFFSET_C
> > > 
> > > 
> > > and then select one of the bool symbols from each platform.
> > > Would that address your question?
> > 
> > 
> > Here's a question:
> > 
> > Can we just get rid of PHYS_OFFSET???
> > 
> > If it's only used at boot for XIP systems, we could:
> > 
> > A) pass it in via an unused register like atags and DT
> >  or
> > B) just assume that atags or DT is in RAM, so round down to the nearest section and assume that is the start of your RAM
> > 
> > If it is needed after initial boot, then on first boot we save what was passed in from the boot loader for later use.
> 
> Hmm, you mean making phys_offset a runtime variable instead
> of patching it at early boot time in the instructions?
> 
> I have no idea if that works, how much effort it would be,
> or how much it would enlarge the kernel image size, but
> you can definitely try.
> 
> Of course we must not break existing platforms using XIP_KERNEL
> already, but the installed base among systems that are upgrading
> to modern kernels is very small now, given how all modern platforms
> don't support XIP_KERNEL today, or have no MMU to start with.

You're all barking up the wrong tree, because you don't understand
why it exists.

ARM_PATCH_PHYS_VIRT exists to support an init-time decided phys offset,
and it supports this by modifying each location that the phys offset
is used.  It determines this by looking at the location that the early
init code is executing, and masking the PC with a value that has been
carefully crafted to fit 99% of the existing platforms.

One of the side effects of ARM_PATCH_PHYS_VIRT is that we hide the
translation from the compiler, so the compiler is unable to optimise
things like virt_to_phys(phys_to_virt(x)) to just 'x' (and yes, such
things do happen.)

PHYS_OFFSET exists to cater for the case where ARM_PATCH_PHYS_VIRT is
disabled, because either ARM_PATCH_PHYS_VIRT does not work for the
platform, or the platform has special requirements and/or requires
better performance.  It switches back to the pre-ARM_PATCH_PHYS_VIRT
situation where the PHYS_OFFSET is a compile time constant.

Obviously, making PHYS_OFFSET a runtime variable is basically what
ARM_PATCH_PHYS_VIRT is doing.  That does not help these cases though,
because the problem cases are not whether it's a runtime variable or
not, it's how to arrive at the value for it in the first place.

Using the DTB location on XIP platforms is a no-goer - the flattened
DTB information can be fixed, so on an XIP platform it makes sense
for this to also be in flash, not in RAM (the whole point of XIP is
to remove constant data from RAM after all, so why would you want to
copy the FDT to RAM?)

Passing it in a register to the kernel image is also not possible:
we've been out of spare registers for some time now for passing
additional information into the kernel.  It wouldn't be a problem
had folk not had this "eww, I don't like ATAGs, lets get rid of them
and use DT instead" attitude: had we kept ATAGs, then we'd have an
in-memory format to pass this kind of information to the kernel.
That would solve soo many problems today it's untrue: stuff like
where a debugging UART is located and the type of it...

When DT was being proposed, my opinion was that's how it should've
been done, but I assumed that the DT folk knew better, and Grant was
very much of the opinion that ATAGs should be completely dropped (I
did touch on it with Grant.)  I regret now not having a discussion
about it and pressing strongly for it.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
