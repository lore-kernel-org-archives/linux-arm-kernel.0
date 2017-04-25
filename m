From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 25 Apr 2017 18:27:04 +0200
Subject: [PATCH/RFC 0/2] clk / soc: renesas: Rework Kconfig and Makefile logic
Message-ID: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This RFC patch series reworks the Kconfig and Makefile logic for the
Renesas clock and SoC drivers. It was sparked by a discussion with Olof
about the Renesas clock driver dependencies.

The goals are to:
  - Allow precise control over and automatic selection of which
    (sub)drivers are used for which SoC (which may change in the
    future),
  - Allow adding support for new SoCs easily,
  - Allow compile-testing of all (sub)drivers,
  - Keep driver selection logic in the subsystem-specific Kconfig
    independent from the architecture-specific Kconfig (i.e. no "select"
    from arch/arm64/Kconfig.platforms), to avoid dependencies.

The series can't be applied as-is, because compile-testing all drivers
depends on independent fixes, some in other subsystems.

More details are provided in the individual patch descriptions.

For testing, this patch series, plus several fixes to allow more
compile-testing, are available in the
topic/clk-soc-renesas-Kconfig-rework branch of my renesas-drivers git
repository at 
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

This has been tested on R-Car Gen2 and Gen3, and compile-tested for
various other configurations.

Thanks for your comments!

Geert Uytterhoeven (2):
  [RFC] clk: renesas: Rework Kconfig and Makefile logic
  [RFC] soc: renesas: Rework Kconfig and Makefile logic

 drivers/clk/Makefile                   |   2 +-
 drivers/clk/renesas/Kconfig            | 129 ++++++++++++++++++++++++++++-----
 drivers/clk/renesas/Makefile           |  37 +++++-----
 drivers/clk/renesas/renesas-cpg-mssr.c |   8 +-
 drivers/soc/Kconfig                    |   1 +
 drivers/soc/Makefile                   |   2 +-
 drivers/soc/renesas/Kconfig            |  63 ++++++++++++++++
 drivers/soc/renesas/Makefile           |  31 ++++----
 drivers/soc/renesas/rcar-sysc.c        |  24 +++---
 include/linux/soc/renesas/rcar-rst.h   |   3 +-
 10 files changed, 229 insertions(+), 71 deletions(-)
 create mode 100644 drivers/soc/renesas/Kconfig

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
