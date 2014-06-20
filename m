From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jun 2014 11:32:07 +0100
Subject: [PATCHv3 3/4] arm64: Update the Image header
In-Reply-To: <20140620085543.GH25104@arm.com>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
 <1403174963-10730-4-git-send-email-mark.rutland@arm.com>
 <20140620085543.GH25104@arm.com>
Message-ID: <20140620103206.GF30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 09:55:43AM +0100, Will Deacon wrote:
> On Thu, Jun 19, 2014 at 11:49:22AM +0100, Mark Rutland wrote:
> > Currently the kernel Image is stripped of everything past the initial
> > stack, and at runtime the memory is initialised and used by the kernel.
> > This makes the effective minimum memory footprint of the kernel larger
> > than the size of the loaded binary, though bootloaders have no mechanism
> > to identify how large this minimum memory footprint is. This makes it
> > difficult to choose safe locations to place both the kernel and other
> > binaries required at boot (DTB, initrd, etc), such that the kernel won't
> > clobber said binaries or other reserved memory during initialisation.
> 
> [...]
> 
> > +/*
> > + * There aren't any ELF relocations we can use to endian-swap values known only
> > + * at link time (e.g. the subtraction of two symbol addresses), so we must get
> > + * the linker to endian-swap certain values before emitting them.
> > + */
> > +#ifdef CONFIG_CPU_BIG_ENDIAN
> > +#define DATA_LE64(data)					\
> > +	((((data) & 0x00000000000000ff) << 56) |	\
> > +	 (((data) & 0x000000000000ff00) << 40) |	\
> 
> Are you sure that these shifts are valid without a UL prefix on the first
> constant operand? I don't think the leading zeroes promote the mask to a
> 64-bit type, so you end up shifting greater than the width of the type.

A key point to bear in mind is that this is in ld, not gas or gcc, which
is why I needed a new macro in the first place. See the error on #ifndef
LINKER_SCRIPT at the top of the file.

As far as I can tell these are valid within ld. The GNU ld documentation
says expressions should be evaluated as 64-bit values (given that
aarch64 is 64-bit) [1].

The kernel header looks correct when inspected with a hex editor, for
both LE and BE.

> I guess the compiler doesn't allocate (data & 0xff) into a w register?

I would guess it wouldn't allocate anything given it is not involved :)

Mark.

[1] https://sourceware.org/binutils/docs/ld/Expressions.html#Expressions
