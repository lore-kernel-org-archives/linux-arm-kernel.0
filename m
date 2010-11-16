From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 20:35:20 +0000
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <alpine.LFD.2.00.1011161517260.6448@xanadu.home>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<20101116182643.GC21926@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011161517260.6448@xanadu.home>
Message-ID: <20101116203520.GE21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 03:28:44PM -0500, Nicolas Pitre wrote:
> On Tue, 16 Nov 2010, Russell King - ARM Linux wrote:
> > Not used anymore - it's practically zero (and unused) for most cases
> > now anyway.
> 
> I think it is worth preserving this layout regardless.  First of all 
> this is really cheap to do, and if whatever bootloader out there is 
> relying on it, at least the magic number, then better not break it 
> freely.

It's already broken by the relocatable format - which has zero as the
start address.  That's been in for a few years now, and no one even
noticed that this header ended up with zero as the entry address.
Therefore, I suggest that no one at all is using it.

> On the other hand... we could simply decide _not_ to fix it on the 
> basis that this will create a different header for a pure Thumb2 
> image.
> 
> Maybe it is a better idea to preserve the current header as is with the 
> ARM mode nops and perform the switch to Thumb mode using the branch 
> instruction after those 8 nops.  This way the kernel image format will 
> remain compatible with existing bootloaders without a need for 
> bootloaders to know if the image is ARM or Thumb mode.

That is definitely worth doing, and sounds like a better idea.
