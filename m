From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Mar 2016 11:17:09 +0100
Subject: [PATCH 02/13] ARM: dts: r8a73a4: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-3-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
 <1458610840-15194-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW1D7QSitKPKDLettRmik-NvvfQNLLY-tjXp+ZPHFfdRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 2:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Fixed rate and fixed factor clocks do not require an
>   clock-output-names property.
> * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
>   optional") Renesas div6 clocks do not require a clock-output-names
>   property.
>
> In the above cases there is only one clock output and its name is taken
> from that of the clock node.
>
> Accordingly, remove the unnecessary clock-output-names properties and as
> necessary update the node names. The zb_clk is excluded from this rename
> as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
> named zb_clk for the r8a73a4 and sh73a0 SoCs.

Yeah, that was a bit hacky, but I didn't see a better solution with the MSTP
driver. CPG/MSSR would solve that differently.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 76 ++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 6583a1dfca1f..6eb23221cf2d 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi

> @@ -538,173 +533,152 @@
>                         clocks = <&pll1_div2_clk>, <0>,
>                                  <&cpg_clocks R8A73A4_CLK_PLL2S>, <0>;
>                         #clock-cells = <0>;
> -                       clock-output-names = "zb";

I'm wondering whether we should keep this one for now?
Dropping it changes the clock name from "zb_clk" to "zb".

Nothing should rely on that, though, but keeping "zb" would allow us to e.g.
change the MSTP driver to match on clock name instead of node name, and drop
clock-output-names and rename the clock node later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
