From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 20:28:31 +0100
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <503FB9E6.7020102@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk> <503F845C.10406@gmail.com>
 <20120830164551.GY18957@n2100.arm.linux.org.uk> <503FB9E6.7020102@gmail.com>
Message-ID: <20120830192831.GD18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 02:07:18PM -0500, Rob Herring wrote:
> On 08/30/2012 11:45 AM, Russell King - ARM Linux wrote:
> > That also means we can start to think about moving the mach/debug-macros.S
> > header elsewhere, remembering that this facility is shared between the
> > decompressor for debugging and the kernel.
> 
> I was thinking we could convert the phys and virt addresses to config
> values and then the DEBUG_LL choices could just be "Use PL01x uart" and
> "Use 8250 uart". This would cut down the number of debug-macro.S files
> and choices.
> 
> Using a fixed virtual address for all platforms might also help simplify
> DEBUG_LL.

No it won't, that comment says you totally don't understand the feature
you're playing with to me.

It's not only about virtual addresses, it's about physical addresses too,
and we can't dictate that all hardware exposes a UART at any particular
physical address.

Remember that the code provided by DEBUG_LL is used in the early kernel
bring up to set up the phys:virt mapping for the UART, it's also used by
the early kernel code to access the UART at the physical address, and by
the decompressor to also access the UART at the physical address.

So playing around with fixing it at a specific virtual address is total
poppycock, and is completely worthless.

I think what we need is arch/arm/include/debug, move the platform specific
debug-macros headers into there, named using platform specific file names.
Then we have the config system define a string-based config:

config DEBUG_LL_INCLUDE
	string
	default "<debug/icedcc.S>" if DEBUG_ICEDCC
	default "<debug/msm.S>" if DEBUG_MSM_UART1 || DEBUG_MSM_UART2 || DEBUG_MSM_UART3
... etc ...
	default "mach/debug-macros.S"

And then we can have the various assembly codes do:

#include CONFIG_DEBUG_LL_INCLUDE

Not only does this give a migration path, but it also gives folk a reason
to move to the 'new way' if they want to be part of a multi-platform
kernel - and it's a trivial thing to do.  Just move the include file,
add an entry to the DEBUG_LL_INCLUDE entry and the "Kernel low-level
debugging port" choice statement, and job done for both non-multi-platform
and multi-platform kernels.

What's even nicer about this approach is it doesn't require everyone to
change simultaneously - it can be done progressively as required.
