From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 6 Jul 2018 10:53:22 +0200
Subject: [PATCH/RFC] ARM: dts: r8a7791: Move enable-method to CPU nodes
In-Reply-To: <CAMuHMdV2VwoD3Le=T4-+Ek2E9tL+hmiR0r4cXxG9EH4GXV-uTw@mail.gmail.com>
References: <1526995765-29693-1-git-send-email-geert+renesas@glider.be>
 <20180523083746.f4nkz4uhjwfgw7yz@verge.net.au>
 <CAMuHMdV2VwoD3Le=T4-+Ek2E9tL+hmiR0r4cXxG9EH4GXV-uTw@mail.gmail.com>
Message-ID: <CAMuHMdV8McM-V5zME1DKE0nsdtVLU25mk9QQCNwNL74V9c2Cag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 10:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, May 23, 2018 at 10:37 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, May 22, 2018 at 03:29:25PM +0200, Geert Uytterhoeven wrote:
> >> According to Documentation/devicetree/bindings/arm/cpus.txt, the
> >> "enable-method" property should be a property of the individual CPU
> >> nodes, not of the parent "cpus" node.  However, on R-Car M2-W (and on
> >> several other arm32 SoCs), the property is tied to the "cpus" node
> >> instead.
> >>
> >> Secondary CPU bringup and CPU hot (un)plug work regardless, as
> >> arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.
> >>
> >> The cpuidle code does not have such a fallback, so it does not detect
> >> the enable-method.  Note that cpuidle does not support the
> >> "renesas,apmu" enable-method yet, so for now this does not make any
> >> difference.
> >
> > Is the implication that if we keep the current binding for cpu nodes
> > then at some point we will need to update the cpuidle binding?
>
> If we keep the current binding for cpu nodes, we indeed have to update
> (common) Documentation/devicetree/bindings/arm/cpus.txt.
>
> In addition, if we want to add renesas,apmu-based cpuidle support later,
> we will have to update the common cpuidle code to look in /cpus, too.

Any comments from the DT/ARM people?
Thanks!

> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> Arm64 and powerpc do not have such a fallback, but SH has, like arm32.
> >>
> >> This is marked RFC, as the alternative is to update the DT bindings to
> >> keep the status quo.
> >> ---
> >>  arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> >> index d568bd22d6cbd855..b214cb8f52e47109 100644
> >> --- a/arch/arm/boot/dts/r8a7791.dtsi
> >> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> >> @@ -71,7 +71,6 @@
> >>       cpus {
> >>               #address-cells = <1>;
> >>               #size-cells = <0>;
> >> -             enable-method = "renesas,apmu";
> >>
> >>               cpu0: cpu at 0 {
> >>                       device_type = "cpu";
> >> @@ -83,6 +82,7 @@
> >>                       clock-latency = <300000>; /* 300 us */
> >>                       power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
> >>                       next-level-cache = <&L2_CA15>;
> >> +                     enable-method = "renesas,apmu";
> >>
> >>                       /* kHz - uV - OPPs unknown yet */
> >>                       operating-points = <1500000 1000000>,
> >> @@ -101,6 +101,7 @@
> >>                       clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
> >>                       power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
> >>                       next-level-cache = <&L2_CA15>;
> >> +                     enable-method = "renesas,apmu";
> >>               };
> >>
> >>               L2_CA15: cache-controller-0 {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
