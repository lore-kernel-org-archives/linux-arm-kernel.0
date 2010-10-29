From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Oct 2010 11:56:43 +0100
Subject: boot decompressor code error
In-Reply-To: <AANLkTimttsvuVYFpCNFU4iJHCjHZ1Xq5E3Gni-wOrTba@mail.gmail.com>
References: <AANLkTimttsvuVYFpCNFU4iJHCjHZ1Xq5E3Gni-wOrTba@mail.gmail.com>
Message-ID: <20101029105643.GB21103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 12:22:47PM +0200, Brian Murphy wrote:
> Hi,
> There is a problem with the boot decompression code when the inflate
> method is used on arm.
> In fact two. The second of which is also a problem on all architectures.
> The first, and more serious, is that static local variables seem not
> to be supported,

static local variables are no different from static global variables
except their scope.  static local variables can only be referenced
from within the block which they are defined and any child blocks,
whereas static global variables can be referenced by any code in the
same compilation unit.

Their storage and initialization in both cases is identical.

> this means that
> some tables initialized as static locals point to a place in ram where
> the tables are not.
> The function
> 
> static void zlib_fixedtables(struct inflate_state *state)
> 
> includes inffixed.h which contains two static tables and

Both these tables are 'const' which means they end up in the read-only
section, and ultimately the text section of the image, not the data
section.

> int zlib_inflate(z_streamp strm, int flush)
> 
> contains a static local "order". The second seems not to have much
> influence on decompression
> but the first causes images (at least of a certain size) to fail
> decompression.

Again, this is "static const unsigned short order[19] = ..." which
because of the const, ends up in the read-only section and therefore
the text section of the image.

This is what I see from arm-linux-nm -n arch/arm/boot/compressed/vmlinux:
...
000835f0 t order.0
00083618 t lenfix.1
00083e18 t distfix.2
...
which clearly shows these tables in the text section.  Also
arm-linux-objdump -t arch/arm/boot/compressed/decompress.o shows:
...
000000fc l     O .rodata        00000026 order.0
00000124 l     O .rodata        00000800 lenfix.1
00000924 l     O .rodata        00000080 distfix.2
...
which shows that these were placed into the .rodata section initially,
as I explained above.

Can you show your output from the above commands please?  Also show
the output of:

arm-linux-nm -n arch/arm/boot/compressed/vmlinux|grep '\<__bss_start\>\|\<_end\>'

arm-linux-objdump --section=.got -s arch/arm/boot/compressed/vmlinux

Also, are you using ZBOOT_ROM=y or =n ?

> The "new" decompress_inflate.c routines do not check the checksum or
> image length fields encoded
> in the gzipped image, even though they would have detected this error.
> It may be that in some cases
> even though the kernel is not properly decompressed that it can boot
> and random unexplained errors
> can occur later because of the decompression failure.

That problem should be reported to those who have worked on this code.

> The second problem is with the output length declaration in gunzip in
> decompress_inflate.c.
> 
> out_len = 0x7fffffff; /* no limit */
> 
> When the buffer start pointer is over 0x80000000 the computation of
> the end pointer in inffast.c
> wraps around and end ends up before out(the start pointer) causing the
> main loop in
> 
> void inflate_fast(z_streamp strm, unsigned start)
> 
> to exit after one byte is processed at the very least causing
> unnecessary overhead. The computation
> 
> end = out + (strm->avail_out - 257);
> 
> should check for overflow and be set to 0xffffffff when wrap would
> occur. This must also be a problem(feature?)
> for other architectures. It has probably not been fixed because the
> decompression still works but is slower.

Again, this needs to be discussed with those who have worked on zlib
previously, and by all means send them a patch for it.
