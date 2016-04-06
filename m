From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Apr 2016 15:11:37 +0200
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CAMuHMdUtPhBT0_+hSk_t5osHC8TssyGMFo+YOWetTGBkbpB4PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC Mike, Stephen, linux-clk (this time with the new Mike)

On Wed, Apr 6, 2016 at 2:52 PM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> clk_get on a disabled clock node will return EPROBE_DEFER, which can
> cause drivers to be deferred forever if such clocks are referenced in
> their clocks property.

Is this a side effect of commit 3e5dd6f6e690048d ("clk: Ignore disabled DT
clock providers")?

> Update the various disabled external clock nodes to default to a
> frequency of 0, but don't disable them to prevent this.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>
> ---
>
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
>  arch/arm/boot/dts/r8a7791-porter.dts  | 1 +
>  arch/arm/boot/dts/r8a7791.dtsi        | 5 +----
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 1adf877..da59c28 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -660,6 +660,7 @@
>  };
>
>  &pcie_bus_clk {
> +       clock-frequency = <100000000>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
> index 9554d13..19b257e 100644
> --- a/arch/arm/boot/dts/r8a7791-porter.dts
> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
> @@ -413,6 +413,7 @@
>  };
>
>  &pcie_bus_clk {
> +       clock-frequency = <100000000>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 8693888..676df63 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1104,8 +1104,7 @@
>                 pcie_bus_clk: pcie_bus {
>                         compatible = "fixed-clock";
>                         #clock-cells = <0>;
> -                       clock-frequency = <100000000>;
> -                       status = "disabled";
> +                       clock-frequency = <0>;
>                 };
>
>                 /* External SCIF clock */
> @@ -1114,7 +1113,6 @@
>                         #clock-cells = <0>;
>                         /* This value must be overridden by the board. */
>                         clock-frequency = <0>;
> -                       status = "disabled";
>                 };
>
>                 /* External USB clock - can be overridden by the board */
> @@ -1130,7 +1128,6 @@
>                         #clock-cells = <0>;
>                         /* This value must be overridden by the board. */
>                         clock-frequency = <0>;
> -                       status = "disabled";
>                 };
>
>                 /* Special CPG clocks */
> --
> 2.8.0.rc3

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
