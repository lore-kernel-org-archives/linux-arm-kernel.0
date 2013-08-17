From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Aug 2013 15:19:38 +0100
Subject: Start symbol for an compressed kernel
In-Reply-To: <1376748724.761782391@f272.i.mail.ru>
References: <CANEcUBUg++5UcKPKy+uUfJkfZRqt3C-52gCTV0ov76=GSH2fYg@mail.gmail.com>
 <20130817135751.GL23006@n2100.arm.linux.org.uk>
 <1376748724.761782391@f272.i.mail.ru>
Message-ID: <20130817141938.GN23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 06:12:04PM +0400, Alexander Shiyan wrote:
> > 2013/8/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > > On Sat, Aug 17, 2013 at 09:56:14PM +0800, zhaobin xv wrote:
> > >> 2013/8/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > >> > On Sat, Aug 17, 2013 at 07:39:46PM +0800, zhaobin xv wrote:
> > >> >> how to find Start symbol for an compressed kernel for arm
> > >> >
> > >> > The start address of a compressed kernel is the first byte of the image.
> > >> >
> > >> > Symbolically, that is 'start', which is a non-global symbol.  However,
> > >> > this symbol is useless since it normally is zero, because the entire
> > >> > image is relocatable and therefore built for address zero.
> > >> >
> > >> > However, it is normal to load the image not at address zero.
> > >>
> > >> why do U define ENTRY(_start)?
> > >> Is _start the Start symbol?
> > >> how to explain _start
> > >
> > > There is no _start symbol in the compressed kernel.
> > 
> > But there is ENTRY(_start) and _start in
> > linux-2.6.22.6\arch\arm\boot\compressed/head.S
> 
> I always thought that the "start" is necessary for the compiler to tell it
> what is at the beginning of the program. So, on my opinion this is just
> a way to tell to gcc where we should place initial kernel data.

There is a _start symbol in arch/arm/boot/compressed/vmlinux.lds.in which
is used to define the entry point for linker purposes (and used to also
be used for some calculations in head.S).  It's never been defined in
head.S though.

As I've already pointed out, the symbol is practically meaningless - all
the symbols in the compressed image are merely offsets from the address
you load the image at because it is position independent code.

If you load the image at 0x8000, you call it at 0x8000.  If you load the
image at 0x12345678, then you call it at 0x12345678 and not where this
_start symbol says you should.
