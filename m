From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Feb 2010 23:06:55 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B85BCE0.7000903@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002242232190.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> Russell King - ARM Linux wrote:
> > On Wed, Feb 24, 2010 at 06:34:49PM -0500, Nicolas Pitre wrote:
> >> What about simply not compiling the decompressor with -fPIC when using 
> >> ZBOOT_ROM=y?  That would certainly solve the problem with the only 
> >> restriction that such kernel images won't be bootable from RAM which is 
> >> probably an acceptable compromize.
> > 
> > Unfortunately, that doesn't solve the stack-bashing with ZBOOT_ROM=n.
> 
> Yes it does, that's exactly what my first version of the patch did. Once
> you get rid of the partial relocation used for ROM builds (with split
> text/bss) you don't need -Dstatic=, and once you get rid of that you
> solve the stack-bashing. The ROM build becomes a bog standard
> non-relocatable ROM image (with the usual LMA/VMA linker script stuff to
> copy initialized data to RAM), and the RAM build becomes a bog standard
> relocatable image (a single contiguous blob including
> text/rodata/data/bss) that doesn't suffer from any issues when you move
> it around.

OK...  Well, just to put things in perspective: the CONFIG_ZBOOT_ROM 
was invented by myself almost 12 years ago.  No split LMA/VMA was needed 
because the code didn't use any writable global variable.  The idea is 
to have the boot loader branch directly to the decompressor stored in 
flash (those were the days when NOR flash was more popular than NAND) 
and then the decompressor simply get the deflated data directly from ROM 
and stores the inflated kernel directly in RAM at its final address.  No 
copy what so ever was involved, and with the CPU I and D caches enabled 
and burst mode properly configured in the flash you get the fastest boot 
possible.  At least until I added support to do eXecute-In-Place from 
flash with the kernel that is (yes, I'm guilty for that as well).  So 
that has to continue working otherwise it is a regression.

Then, Russell added the ability for the decompressor to be PIC.  And he 
even managed for a ZBOOT_ROM kernel to just work if you decided to load 
it in RAM and execute it from there.  But for that to work the -Dstatic 
hack was needed.  Admitedly, this hack and the ability to run a 
ZBOOT_ROM kernel from anywhere in RAM is nice but not strictly needed.  
But no one could argue that this didn't work.  Claiming that this is an 
abuse of the compiler is beside the point: it has worked for years and 
now _you_ are the one who wants to change the rules, not the GCC people.

Now I apparently missed something in the thread... What is this stack 
bashing about?  Admitedly I didn't look at any of the patches (yet).


Nicolas
