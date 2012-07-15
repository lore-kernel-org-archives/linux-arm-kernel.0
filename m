From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 15 Jul 2012 04:44:08 +0200
Subject: [RFC PATCH 00/12] ARM: Decompressor multiplatform support
Message-ID: <20120715024408.747946928@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

  here is a new edition of my work in the decompressor area.
  
My intent is to get rid of uncompress.h and prepare the decompressor
to dynamically select the various machine specific decompressor init
steps, included the selection of the appropriate console driver.

Currently the mainline kernel defines these steps statically and indeed
has some trouble to boot on different boards with the same binary.

What this patch does is allowing the four functions (arch_decomp_setup,
arch_error, putc and flush) currently used to define such static steps
to be packed in quantity and to be selected/executed by the decompressor
accordingly to the machid or DT passed by the boot loader.

I forgot to say that all this code and data is relocated from the kernel
image to the decompressor during the build. So some pointer arithmetic
is required on the decompressor side. This unfortunately brings in also
some limitations in the code/data to be relocated.

The patchset is of course far from being ready for anything but
development and testing. I really looked into only three SoCs but I
know that aside from a kind of graphic adapter somewhere all the other
are a variation of these three players.

I'm able to test it on a out-of-tree bcm4760 board and a Samsung
S5P6450. I also build tested a dozen of other random samsung and ti/omap
defconfigs, sometimes nailing down problems. I've also my qq2440 ;)

The patchset also applies on top of Arnd's multiplatform tree and the
resulting binary boots on the bcm4760 board. In that configuration I
get the most fat relocation of code and data, with an amazing number
of four drivers and don't known how many console tags. I had also some
fun efficiently packing all that stuff :)

That said, thank you for the comments :)

cheers,
Domenico
