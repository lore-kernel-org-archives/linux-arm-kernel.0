From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 16:29:28 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B8543B2.4030004@marcansoft.com>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
	<20100224084259.GA8068@pengutronix.de>
	<4B84F0F6.40902@marcansoft.com>
	<20100224110353.GA15105@n2100.arm.linux.org.uk>
	<4B8543B2.4030004@marcansoft.com>
Message-ID: <20100224162928.GA3888@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 04:20:18PM +0100, Hector Martin wrote:
> Russell King - ARM Linux wrote:
> > It does work with the previous version of the decompressor.
> 
> Sure, at this point in time. The broken code is still the loader, not
> the new decompressor. If a GCC update had been the culprit, it wouldn't
> be GCC's fault. The fact remains that the behavior is undefined and
> (with current GCC versions) requires carefully crafting the resulting C
> code in order to get reasonable behavior. I don't think you can
> reasonably require that a generic descompressor be maintained by others
> with care for compatibility with this hack; someone would have to police
> changes for potential issues, and you still have a decent chance of
> getting breakage if GCC decides to change its behavior some day. I'd say
> fixing the loader to not require this undefined behavior is a
> considerably better long-term solution.

For starters, do you actually understand how this stuff works, or are
you just viewing the "-Dstatic=" as a hack you don't like?

Let's examine what's going on.  If you build a file with -fpic, then
you're asking the compiler to generate position independent code - eg
for shared libraries.

How this is achieved depends on the architecture.  On ARM, it is achieved
as follows:

1. references to global data are indirected via the GOT since they can
   be placed anywhere - in the executable or in another shared library.
   This is well defined and the user environment relies upon this
   behaviour.

2. references to local 'static' data are private to the shared library,
   and are addressed relative to the position of the GOT using the
   address of the GOT and an offset from the GOT written into the code.
   This is well defined and the user environment relies upon this
   behaviour.

3. function references to local 'static' functions are made using
   standard branch instructions since these are already pc relative

4. function references to global functions are via the PLT.

Now, with the kernel decompressor, we don't care about (3) or (4) -
indeed, all functions could be static.

However, we do care about (1) vs (2).  For read-only static data, (2)
is entirely acceptable - static read-only data can be placed in the
.rodata section and move with the text segment.

However, for writable local data, even if we tell the linker to locate
the data segment in RAM, the relative offset between the data and text
is fixed at built time.  What this means is that if you try and relocate
the image, any read-write data using (2) will most probably end up
outside RAM.

In order to be able to relocate the data independently of the text
segment, we need the read-write data to be built with global visibility,
thereby causing (1) to be used.

We could investigate whether there's a better solution to "-Dstatic="
to ensure that we end up with (1) for all read/write data.

So, to sum up, contrary to your belief, the behaviour we're invoking
from the toolchain is not some spurious toolchain behaviour, but
well-defined behaviour which, if it changes, results in userspace
breakage.

What is the hack is defining 'static' as a way to get rid of all
local data, thereby avoiding writable data being addressed relative
to the GOT.
