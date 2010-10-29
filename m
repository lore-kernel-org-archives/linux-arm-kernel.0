From: brian@murphy.dk (Brian Murphy)
Date: Fri, 29 Oct 2010 12:22:47 +0200
Subject: boot decompressor code error
Message-ID: <AANLkTimttsvuVYFpCNFU4iJHCjHZ1Xq5E3Gni-wOrTba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
There is a problem with the boot decompression code when the inflate
method is used on arm.
In fact two. The second of which is also a problem on all architectures.
The first, and more serious, is that static local variables seem not
to be supported, this means that
some tables initialized as static locals point to a place in ram where
the tables are not.
The function

static void zlib_fixedtables(struct inflate_state *state)

includes inffixed.h which contains two static tables and

int zlib_inflate(z_streamp strm, int flush)

contains a static local "order". The second seems not to have much
influence on decompression
but the first causes images (at least of a certain size) to fail
decompression. Somtimes this failure
is detectable in decompression and an error results, sometimes it is
not and the kernel just fails to
start.
The "new" decompress_inflate.c routines do not check the checksum or
image length fields encoded
in the gzipped image, even though they would have detected this error.
It may be that in some cases
even though the kernel is not properly decompressed that it can boot
and random unexplained errors
can occur later because of the decompression failure.

Moving the local static initialization to a file local static enables
the routines to work, i.e. moving the
static declarations out of the functions.

I am not sure how local statics work on arm but I am guessing that the
problem is to do with relocations
not being processed for the boot decompression code.

The second problem is with the output length declaration in gunzip in
decompress_inflate.c.

out_len = 0x7fffffff; /* no limit */

When the buffer start pointer is over 0x80000000 the computation of
the end pointer in inffast.c
wraps around and end ends up before out(the start pointer) causing the
main loop in

void inflate_fast(z_streamp strm, unsigned start)

to exit after one byte is processed at the very least causing
unnecessary overhead. The computation

end = out + (strm->avail_out - 257);

should check for overflow and be set to 0xffffffff when wrap would
occur. This must also be a problem(feature?)
for other architectures. It has probably not been fixed because the
decompression still works but is slower.

I am willing to make a patch for the second issue.
The right fix for the first issue is probably to fixup the references
to static locals in the boot decompress code
the easy fix is of course to remove all local static variables but
when this is general code, also used in the
kernel, it is probably not a acceptable fix? Perhaps with some ifdef
stuff? If this fix is acceptable I can also generate
a patch for that problem.

/Brian
