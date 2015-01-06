From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  6 Jan 2015 20:17:37 +0100
Subject: [PATCH v2 0/2] ARM: shmobile: kzm9g: Declare the full 512 MiB of RAM
Message-ID: <1420571859-11655-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series prepares kzm9g and kzm9g-reference dts for booting a
multi-platform kernel.

Traditionally, the first 16 MiB of RAM was reserved for the RT
processor.  However, this is incompatible with CONFIG_AUTO_ZRELADDR=y,
which requires that the start address of physical memory is a multiple
of 128 MiB.

As CONFIG_AUTO_ZRELADDR=y is enabled for multi-platform kernels, declare
RAM to start at 0x40000000.

While at it, reclaim the last 8 MiB of RAM, too, so the full 512 MiB is
available. We don't know the exact reason why the last 8 MiB of RAM
was reserved, but thanks to Simon we know it is not used for a U-Boot
splash screen.  Note that kzm9g_defconfig still has
CONFIG_MEMORY_START=0x41000000 and CONFIG_MEMORY_SIZE=0x1f000000, so
before the advent of DT we scribbled over the last 8 MiB, too.

This is an alternative solution for "[PATCH v2 01/05] ARM: shmobile:
kzm9g-reference: 0x48008000 load address"
(http://www.spinics.net/lists/linux-sh/msg38385.html), which
(a) doesn't loose 112 MiB of RAM, and
(b) doesn't force to switch from zImage to uImage.

Thanks for applying!

Geert Uytterhoeven (2):
  ARM: shmobile: kzm9g dts: Declare the full 512 MiB of RAM
  ARM: shmobile: kzm9g-reference dts: Declare the full 512 MiB of RAM

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
