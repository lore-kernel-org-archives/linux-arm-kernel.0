From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 31 Jul 2018 18:08:51 +0200
Subject: [PATCH/RFC 0/4] ARM: shmobile: Enable ARM_GLOBAL_TIMER on Cortex-A9
 MPCore
Message-ID: <20180731160855.6758-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

SH-Mobile AG5 and R-Car H1 SoCs are based on the Cortex-A9 MPCore, which
includes an ARM global timer.

Enable use of the global timer on these SoCs for scheduling and delay
loops, with the following impact:
  - Scheduler accuracy is increased from 10 ms to a few ns,
  - Calls to shmobile_init_delay() to preset loops-per-jiffies can be
    removed.
    Note that when using an old DTB lacking the global timer, the kernel
    will still work, but the delay loop will need to be calibrated
    during boot.
  - This also seems to get rid of lockdep warnings related to the sh_cmt
    driver.

We still need shmobile_init_delay() to setup loops-per-jiffies for other
SoCs lacking an architectured or global timer:
  - emev2: Cortex-A9 (MPCore version and global timer not documented),
  - r7s72100: single-core Cortex-A9 MPCore r3p0 (global timer not
    documented),
  - r7s9210: single-core Cortex-A9 MPCore r4p1 (global timer not
    documented),
  - r8a7740: single-core Cortex-A9 r2p4,
  - r8a7778: single-core Cortex-A9 r2p2-00rel0.

This has been tested on KZM-A9-GT (SH-Mobile AG5) and Marzen (R-Car H1).

Thanks for your comments!

Geert Uytterhoeven (4):
  ARM: dts: sh73a0: Rename twd clock to periph clock
  ARM: dts: sh73a0: Add device node for ARM global timer
  ARM: dts: r8a7779: Add device node for ARM global timer
  [WIP] ARM: shmobile: Enable ARM_GLOBAL_TIMER on Cortex-A9 MPCore SoCs

 arch/arm/boot/dts/r8a7779.dtsi         |  8 ++++++++
 arch/arm/boot/dts/sh73a0.dtsi          | 11 +++++++++--
 arch/arm/mach-shmobile/Kconfig         |  2 ++
 arch/arm/mach-shmobile/setup-r8a7779.c |  1 -
 arch/arm/mach-shmobile/setup-sh73a0.c  |  1 -
 5 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
