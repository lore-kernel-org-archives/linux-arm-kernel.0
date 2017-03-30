From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Mar 2017 15:08:15 +0200
Subject: [PATCH v2 0/4] pinctrl: sh-pfc: Add support for R-Car H3 ES2.0
In-Reply-To: <1489425167-22711-1-git-send-email-geert+renesas@glider.be>
References: <1489425167-22711-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdXEJhs97_F70BfBkbLusMT_qnVVYn_iQq8oB4B1pjf1Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 6:12 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series adds pinctrl support for R-Car H3 ES2.0, which differs
> from ES1.x in several areas.
>
> The goal is twofold:
>   1. Support both the ES1.x and ES2.0 SoC revisions in a single binary
>      for now,
>   2. Make it clear which code supports ES1.x, so it can easily be
>      identified and removed later, when production SoCs are deemed
>      ubiquitous.
>
> This is achieved by:
>   1. Extracting the support for R-Car H3 ES1.x into a separate file, as
>      the differences are quite large,
>   2. Adding code for detecting the SoC revision at runtime using the new
>      soc_device_match() API, and selecting pinctrl tables for the actual
>      SoC revision,
>   3. Replacing the core register and bitfield definitions, and pins,
>      groups, and functions for basic devices by their counterparts for
>      R-Car H3 ES2.0.
>
> Changes compared to v1:
>   - Print correct subdriver name,
>   - Extend Proof-of-Concept to basic support (SCIF serial port).
>
> The addition of pins, groups, and functions for other on-chip devices is
> left to subsequent patches.
>
> For testers, this series and its dependencies are available in the
> topic/r8a7795es2-pfc-v2 branch of my renesas-drivers git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> An integration branch for testing on the R-Car H3 ES2.0 based Salvator-X
> development board is provided as topic/r8a7795es2-integration.
>
> This has been tested on Salvator-X with R-Car H3 ES1.0, ES1.1, and ES2.0
> SoCs.
>
> I plan to queue this up in sh-pfc-for-v4.12.

In the mean time:
  - I renamed pfc-r8a7795es1.c to pfc-r8a7795-es1.c for compatibility with
    the BSP, but I'm not gonna spam everybody with a v3 for such a trivial
    change.
  - I verified all physical pins against the R-Car H3 pin function rev0.551
    and the R-Car H3SiP pin arrangement rev1.53 documents. No updates needed.

So I've queued the remainder (patches 2-4) up in sh-pfc-for-v4.12.

> Geert Uytterhoeven (4):
>   pinctrl: sh-pfc: Update info pointer after SoC-specific init
>   pinctrl: sh-pfc: r8a7795: Add support for R-Car H3 ES2.0
>   pinctrl: sh-pfc: r8a7795: Add SCIF support
>   pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support
>
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    3 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c               | 4217 ++++----------------
>  .../sh-pfc/{pfc-r8a7795.c => pfc-r8a7795es1.c}     |   25 +-
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
>  5 files changed, 782 insertions(+), 3465 deletions(-)
>  copy drivers/pinctrl/sh-pfc/{pfc-r8a7795.c => pfc-r8a7795es1.c} (99%)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
