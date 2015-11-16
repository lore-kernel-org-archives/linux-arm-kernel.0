From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Nov 2015 16:47:12 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015, Chris Brandt wrote:

> >> For an XIP build, _edata_loc, not _etext, represents the end of the 
> >> binary image that will be programmed into ROM and mapped into the 
> >> MODULES_VADDR area.
> >
> > This statement is wrong.  The kernel data is copied to RAM before the
> > MMU is turned on and that's the copy that the kernel must use.  There
> > is no reason having anything past _etext accessible from ROM.
> 
> If I remember correctly, when I first ran into an issue was my
> initramfs got cut off because it spanned the 1MB boundary after
> _etext.

If you are convinced that you need kernel XIP, then you normally would 
want _not_ to use initramfs at all.

> Also, your init code resides after _etext, so that get cut off
> too.

/me looks at the linker script and cry

Forget it.  XIP kernel is simply completely broken at the moment.  

There used to be conditional placement of .init.text that was located in 
the .text section when XIP_KERNEL was selected, or in the .init section 
otherwise.  This particular section was abstracted away into an 
INIT_TEXT_SECTION macro defined in include/asm-generic/vmlinux.lds.h and 
the XIP conditional placement got lost.  New sections (lots of them) 
were added as well since the introduction of XIP kernel with no 
consideration for XIP usage.

The old method with conditional placement in the linker script is broken 
beyond repair.  There is simply way too much stuff these days to do this 
sanely.  I think the only way to fix it properly is to have a separate 
linker script for XIP usage with proper (and obvious) section placement.


Nicolas
