From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Mar 2018 10:52:16 +0100
Subject: [PATCH 2/2] arm: rzn1: Add basic support for RZN1D-DB Board
In-Reply-To: <1519647518-15579-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
 <1519647518-15579-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdVdXh428vfLW5has3THUWq5x6iA-6CLL+uQudOGOJfTrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Mon, Feb 26, 2018 at 1:18 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> Only enables the uart0 for now, and also relies on the bootloader
> for setting up the clocks and pinctrl.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

This should be split in two parts:

>  Documentation/devicetree/bindings/arm/shmobile.txt |  2 ++

1. DT bindings

>  arch/arm/boot/dts/rzn1d400-db.dts                  | 25 ++++++++++++++++++++++

2. Board DTS + (missing) arch/arm/boot/dts/Makefile update.

> --- /dev/null
> +++ b/arch/arm/boot/dts/rzn1d400-db.dts

Why the 400? 400-pin package?

Please follow <SoC>-<board>.dts naming convention, i.e.
r9a06g032-rzn1d-db.dts

> @@ -0,0 +1,25 @@
> +/*
> + * Device Tree Source for the RZN1D-DB Board
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +/dts-v1/;
> +
> +#include "rzn1.dtsi"
> +
> +/ {
> +       model = "RZN1D-DB Board";
> +       compatible = "renesas,rzn1d-db", "renesas,r9a06g032";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200";

"console=" is not needed, as it is handled by stdout-path these days,
so you can remove bootargs for now.

> +               stdout-path = &uart0;

stdout-path = "serial0:115200n8";

Please move the serial0 alias definition to the board DTS, as labeling
of serial ports
is board-specific.

> +               linux,stdout-path = &uart0;

linux,stdout-path is deprecated, please remove it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
