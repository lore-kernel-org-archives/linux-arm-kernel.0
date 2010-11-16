From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 16 Nov 2010 15:28:44 -0500 (EST)
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header layout
	for CONFIG_THUMB2_KERNEL
In-Reply-To: <20101116182643.GC21926@n2100.arm.linux.org.uk>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<20101116182643.GC21926@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011161517260.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Nov 2010, Russell King - ARM Linux wrote:

> On Tue, Nov 16, 2010 at 01:14:37PM +0000, Dave Martin wrote:
> > This gets messed up with with CONFIG_THUMB2_KERNEL:
> > 
> >     * The NOPs making up the vector table become halfword-
> >       sized.
> 
> Doesn't matter.
> 
> >     * The magic number and absolute entry point occur too early
> >       and become misaligned.
> 
> Not used anymore - it's practically zero (and unused) for most cases
> now anyway.

I think it is worth preserving this layout regardless.  First of all 
this is really cheap to do, and if whatever bootloader out there is 
relying on it, at least the magic number, then better not break it 
freely.

> >     * The absolute entry point fails to indicate that the entry
> >       point is Thumb code, which will cause incorrect execution
> >       if the bootloader uses this to enter the kernel.
> 
> And as such...

On the other hand... we could simply decide _not_ to fix it on the 
basis that this will create a different header for a pure Thumb2 
image.

Maybe it is a better idea to preserve the current header as is with the 
ARM mode nops and perform the switch to Thumb mode using the branch 
instruction after those 8 nops.  This way the kernel image format will 
remain compatible with existing bootloaders without a need for 
bootloaders to know if the image is ARM or Thumb mode.


Nicolas
