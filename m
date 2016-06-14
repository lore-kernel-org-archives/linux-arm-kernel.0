From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jun 2016 18:59:20 +0100
Subject: kexec failures with DEBUG_RODATA
Message-ID: <20160614175920.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Having added Keystone2 support to kexec, and asking TI to validate
linux-next with mainline kexec-tools, I received two reports from
them.

The first was a report of success, but was kexecing a 4.4 kernel
from linux-next.

The second was a failure report, kexecing current linux-next from
linux-next on this platform.  However, my local tests (using my
4.7-rc3 derived kernel) showed there to be no problem.

Building my 4.7-rc3 derived kernel with TI's configuration they
were using with linux-next similarly failed.  So, it came down to
a configuration difference.

After trialling several configurations, it turns out that the
failure is, in part, caused by CONFIG_DEBUG_RODATA being enabled
on TI's kernel but not mine.  Why should this make any difference?

Well, CONFIG_DEBUG_RODATA has the side effect that the kernel
contains a lot of additional padding - we pad out to section size
(1MB) the ELF sections with differing attributes.  This should not
normally be a problem, except kexec contains this assumption:

                /* Otherwise, assume the maximum kernel compression ratio
                 * is 4, and just to be safe, place ramdisk after that */
                initrd_base = base + _ALIGN(len * 4, getpagesize());

Now, first things first.  Don't get misled by the comment - it's
totally false.  That may be what's desired, but that is far from
what actually happens in reality.

"base" is _not_ the address of the start of the kernel image, but
is the base address of the start of the region that the kernel is
to be loaded into - remember that the kernel is normally loaded
32k higher than the start of memory.  This 32k offset is _not_
included in either "base" nor "len".  So, even if we did want to
assume that there was a maximum compression ratio of 4, the above
always calculates 32k short of that value.

The other invalid thing here is this whole "maximum kernel compression
ratio" assumption.  Consider this non-DEBUG_RODATA kernel image:

   text    data     bss     dec     hex filename
6583513 2273816  215344 9072673  8a7021 ../build/ks2/vmlinux

This results in an image and zimage of:
-rwxrwxr-x 1 rmk rmk 8871936 Jun 14 18:02 ../build/ks2/arch/arm/boot/Image
-rwxrwxr-x 1 rmk rmk 4381592 Jun 14 18:02 ../build/ks2/arch/arm/boot/zImage

which is a ratio of about a 49%.  On entry to the decompressor, the
compressed image will be relocated above the expected resulting
kernel size.  So, let's say that it's relocated to 9MB.  This means
the zImage will occupy around 9MB-14MB above the start of memory.
Going by the 4x ratio, we place the other images at 16.7MB.  This
leaves around 2.7MB free.  So that's probably fine... but think
about this.  We assumed a ratio of 4x, but really we're in a rather
tight squeeze - we actually have only about 50% of the compressed
image size spare.

Now let's look at the DEBUG_RODATA case:

   text    data     bss     dec     hex filename
6585305 2273952  215344 9074601  8a77a9 ../build/ks2/vmlinux

And the resulting sizes:
-rwxrwxr-x 1 rmk rmk 15024128 Jun 14 18:49 ../build/ks2/arch/arm/boot/Image
-rwxrwxr-x 1 rmk rmk  4399040 Jun 14 18:49 ../build/ks2/arch/arm/boot/zImage

That's a compression ratio of about 29%.  Still within the 4x limit,
but going through the same calculation above shows that we end up
totally overflowing the available space this time.

That's exactly the same kernel configuration except for
CONFIG_DEBUG_RODATA - enabling this has almost _doubled_ the
decompressed image size without affecting the compressed size.

We've known for some time that this ratio of 4x doesn't work - we
used to use the same assumption in the decompressor when self-
relocating, and we found that there are images which achieve a
better compression ratio and make this invalid.  Yet, the 4x thing
has persisted in kexec code... and buggily too.

Since the kernel now has CONFIG_DEBUG_RODATA by default, this means
that these kinds of ratio-based assumptions are even more invalid
than they have been.

Right now, a zImage doesn't advertise the size of its uncompressed
image, but I think with things like CONFIG_DEBUG_RODATA, we can no
longer make assumptions like we have done in the past, and we need
the zImage to provide this information so that the boot environment
can be setup sanely by boot loaders/kexec rather than relying on
broken heuristics like this.

Thoughts?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
