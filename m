From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jun 2012 09:47:46 +0100
Subject: [RFC 1/6] From: Domenico Andreoli
 <domenico.andreoli@linux.com> ARM: Inject the Earlycon drivers into
 the decompressor
In-Reply-To: <20120530224043.582229064@gmail.com>
References: <20120530224043.240221676@gmail.com>
 <20120530224043.582229064@gmail.com>
Message-ID: <20120604084746.GA8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 12:40:44AM +0200, Domenico Andreoli wrote:
> This linker voodoo clones the Earlycon drivers from the kernel into
> the decompressor, selecting everything in the designated ELF sections
> (.text.earlycon.info and .init.earlycon.info).

No, the debug stuff in the main kernel and the decompressor stuff can
(and is in some cases) different.  There's a reason we have the two
implementations separate.

Moreover, these two things operate in two different address spaces; the
debug stuff in the kernel has to cope with the MMU being either on or
off, and use the kernel v:p mappings when the MMU is on.  The decompressor
on the other hand has a 1:1 v:p mapping when the MMU is on - so it
would not be able to tell the difference if you just cloned the exact
same code.

One example of this would be RiscPC, where the decompressor writes to
the framebuffer, but the debug stuff writes to the serial port.

The preference is for the decompressor to write to the normal user visible
interface when possible, and the debug stuff to a serial port.
