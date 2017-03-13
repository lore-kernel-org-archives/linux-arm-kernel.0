From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 13 Mar 2017 18:12:29 +0100
Subject: [PATCH v2 0/4] clk: renesas: Add support for R-Car H3 ES2.0
Message-ID: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Mike, Stephen,

This patch series adds clock support for R-Car H3 ES2.0, which differs
from ES1.x in several areas.

The goal is twofold:
  1. Support both the ES1.x and ES2.0 SoC revisions in a single binary
     for now,
  2. Make it clear which code supports ES1.x, so it can easily be
     identified and removed later, when production SoCs are deemed
     ubiquitous.

This is achieved by:
  - Updating the clock tables for the latest revision (ES2.0), but not
    removing clocks that only exist on earlier revisions (ES1.x),
  - Detecting the SoC revision at runtime using the new
    soc_device_match() API, and fixing up the clocks tables to match the
    actual SoC revision, by:
      - NULLifying core and module clocks of modules that do not exist,
      - Reparenting module clocks that have a different parent on ES1.x.

Changes compared to v1:
  - Update of various module clocks as per datasheet update,
  - Add support for RCLK on R-Car H3 ES2.0.

For testers, this series and its dependencies are available in the
topic/r8a7795es2-clk-v2 branch of my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
An integration branch for testing on the R-Car H3 ES2.0 based Salvator-X
development board is provided as topic/r8a7795es2-integration.

This has been tested on Salvator-X with R-Car H3 ES1.0, ES1.1, and ES2.0
SoCs.

I plan to queue this up in clk-renesas-for-v4.12.

Thanks for your comments!

Geert Uytterhoeven (4):
  clk: renesas: cpg-mssr: Add support for fixing up clock tables
  clk: renesas: Add r8a7795 ES2.0 CPG Core Clock Definitions
  clk: renesas: r8a7795: Add support for R-Car H3 ES2.0
  clk: renesas: rcar-gen3-cpg: Add support for RCLK on R-Car H3 ES2.0

 drivers/clk/renesas/r8a7795-cpg-mssr.c       | 201 ++++++++++++++++++++-------
 drivers/clk/renesas/rcar-gen3-cpg.c          |  38 +++--
 drivers/clk/renesas/renesas-cpg-mssr.c       |  50 +++++++
 drivers/clk/renesas/renesas-cpg-mssr.h       |  22 +++
 include/dt-bindings/clock/r8a7795-cpg-mssr.h |   7 +
 5 files changed, 257 insertions(+), 61 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
