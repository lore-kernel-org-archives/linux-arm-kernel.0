From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Feb 2010 18:34:49 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100224223418.GB25587@n2100.arm.linux.org.uk>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1002241824520.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2010, Russell King - ARM Linux wrote:

> On Wed, Feb 24, 2010 at 03:23:37AM +0100, Hector Martin wrote:
> > Instead, clean up the stub loader and unify it. The loader is now
> > exactly the same regardless of whether you've enabled CONFIG_ZBOOT_ROM
> > or not, and runs from RAM in PIC mode. CONFIG_ZBOOT_ROM simply enables
> > an extra section of stub code that lets the zImage boot from ROM by
> > copying itself to RAM first.
> 
> Unacceptable.
> 
> The point of putting the decompressor in ROM is to save the time spent
> copying it to RAM first.  Boot loaders are already perfectly capable
> of copying the image into RAM and calling it there.
> 
> Getting the decompressor to do that step first just moves the copy from
> the boot loader into the decompressor.  It doesn't eliminate it, which
> is what ROM-based decompression is all about.
> 
> Basically, this patch makes the feature entirely pointless.

What about simply not compiling the decompressor with -fPIC when using 
ZBOOT_ROM=y?  That would certainly solve the problem with the only 
restriction that such kernel images won't be bootable from RAM which is 
probably an acceptable compromize.

The idea with ZBOOT_ROM is also to have an empty .data section so there 
is no data segment to copy. This is achieved by not having any writable 
global variable nor static local variables (unless they're marked const 
of course).  We probably should add an assert statement in the linker 
script to ensure this is the case.


Nicolas
