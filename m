From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 16:09:43 +0100
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <20171027152743.GJ20805@n2100.armlinux.org.uk>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a0_-YOvPUqZTb+LoU+wCBhy=zCxmk4HProPJY+udbri9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 5:27 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

>
> There's three things wrong, all of which I have patches to address:
>
> 1. The decompressor code reading the image data sometimes issues unaligned
>    reads.  Some compilers get this wrong and cause an abort.  Arnds patch
>    addresses this.
>
> 2. Additional sections can appear in the zImage binary which adds extra
>    bytes on the end of the image.  Concatenating the zImage with the
>    extra bytes onto a DTB is the same thing as doing this:
>
>         cat zImage extrabytes foo.dtb > image
>
>    and the decompressor tolerates no additional bytes between the
>    _official_ end of the zImage and the DTB.  I've added a patch which
>    detects this situation and fails the kernel build when it happens.
>
> 3. Ard's patch "efi/libstub: arm: omit sorting of the UEFI memory map"
>    gets rid of the additional sections that (a) change the alignment
>    of the compressed data, and (b) add additional unexpected bytes on
>    the end of zImage.

It's possible that we still need yet another patch to address the gcc bug that
Alex Graf found, i.e. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82445

Without the latest gcc, we might still get into a situation in which we get
an unaligned strd when compiling for armv5te or armv6 with gcc-7.[012].
As someone mentioned in the bug report, that problem doesn't seem
to happen with gcc-6 or -mtune=xscale, or with gcc-7 -march=armv7-a.

       Arnd
