From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2016 23:42:28 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
Message-ID: <20160615224228.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 03:20:05PM -0700, Kees Cook wrote:
> On Wed, Jun 15, 2016 at 2:13 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Jun 14, 2016 at 11:05:23AM -0700, Kees Cook wrote:
> >> I'm much less familiar with the ARM decompression stub, but is there a
> >> boot image header (like x86 has)? If not, perhaps we can invent one,
> >> and it can carry all the details needed for a bootloader to do the
> >> right things.
> >
> > With a bit of tinkering around, I now have this:
> >
> > 00000000 <.data>:
> >        0:       e1a00000        nop                     ; (mov r0, r0)
> >        4:       e1a00000        nop                     ; (mov r0, r0)
> >        8:       e1a00000        nop                     ; (mov r0, r0)
> >        c:       e1a00000        nop                     ; (mov r0, r0)
> >       10:       e1a00000        nop                     ; (mov r0, r0)
> >       14:       e1a00000        nop                     ; (mov r0, r0)
> >       18:       e1a00000        nop                     ; (mov r0, r0)
> >       1c:       e1a00000        nop                     ; (mov r0, r0)
> >       20:       ea00000f        b       0x64
> >
> > Then follows the existing "header" which we've had there for years:
> >
> >       24:       016f2818        ; LE magic number
> >       28:       00000000        ; LE zImage start address (always zero now)
> >       2c:       00431fe0        ; LE zImage _edata
> >       30:       04030201        ; endian flag
> >
> > And now comes the new header:
> >
> >       34:       016f2818        ; LE magic number
> 
> Should this be a different magic from the existing header's magic?

What use would a different number be?  It's not something you scan for,
because this block is always at 0x24 bytes into the zImage for a binary
zImage.

> >       38:       00000001        ; LE version number (v1)
> 
> Should a "size" follow the version number instead of the explicit 64
> bytes of zeros?

I don't see the use of a size field.  If we have a size field, then
we need to validate the version number (which tells us the format of
the data) against the size, and it all gets really messy - what if
we have a version number which indicates that we have more data than
the size field indicates?

> >       3c:       01287000        ; LE total space required for decompressor
> >       40:       00e54000        ; LE uncompressed image size
> >
> > Up to 64 bytes available here for future expansion, currently filled
> > with zeros.
> >         ...
> >
> > Remainder of the zImage code:
> >       64:       e10f9000        mrs     r9, CPSR
> >
> > I'm rather on the fence whether we need to give the uncompressed image
> > size - the important thing is the size of memory that's required for
> > the decompressor to run, which is sizeof(uncompressed kernel) rounded
> > up to 256 bytes, and the relocated decompressor image size.
> 
> I think it's important information since it allows a boot loader to
> figure out if there's room in a given range for the result. While
> there's no relocation support yet, if we gain it on ARM and we want to
> support KASLR, it will be very handy to have the uncompressed size
> available.

It's really not useful for that purpose.  The size of the uncompressed
image doesn't tell you that you can touch the next few bytes after the
image.  In fact, you can't, because that's where the decompressor
potentially relocates itself to.

The one which is of importance to the boot environment layout is the
"total space required for decompressor", which is the one which must
be respected.

In fact, the apparent confusion over this reinforces my belief that we
should _not_ give the size of the uncompressed image at all.

The boot environment must be setup such that there is room for the
uncompressed image (aligned currently to 256 bytes) followed by the
size of the compressed image, with any appended DTBs included.
Anything which is located below that is likely to get trampled by
the decompressor.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
