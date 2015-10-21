From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Oct 2015 15:34:39 +0200
Subject: [PATCH v11 1/8] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <20151015105820.GF8825@leverpostej>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
 <20151015105820.GF8825@leverpostej>
Message-ID: <CAMuHMdU00wJcrb7EsFjkKMw-gy04tXdGoyzPRNL-cjYZH8zneA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Oct 15, 2015 at 12:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > +           gic: interrupt-controller at 0xf1010000 {
>> +                     compatible = "arm,gic-400";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
>> +                     interrupt-controller;
>> +                     reg = <0x0 0xf1010000 0 0x1000>,
>> +                           <0x0 0xf1020000 0 0x2000>;
>> +                     interrupts = <GIC_PPI 9
>> +                                     (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>> +             };
>
> No GICH and GICV?

These seem to be defined in the "arm,gic-v3" DT bindings only, while this is
an "arm,gic-400" (GICD_IIDR 0x0200043b)?

I did notice hi6220.dtsi does have GICH and GICV, while it also claims
to be an "arm,gic-400"...

> Which exception level do CPUs boot at?

No idea.

>> +             clock {
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     #clock-cells = <1>;
>> +                     ranges;
>> +
>> +                     cpg_clocks: cpg_clocks at e6150000 {
>> +                             compatible = "renesas,r8a7795-cpg-clocks",
>> +                                          "renesas,rcar-gen3-cpg-clocks";
>> +                             reg = <0 0xe6150000 0 0x1000>;
>> +                             clocks = <&extal_clk>;
>> +                             clock-indices = <
>> +                                     R8A7795_CLK_MAIN R8A7795_CLK_PLL0
>> +                                     R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
>> +                                     R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
>> +                             >;
>> +                             clock-output-names = "main", "pll0", "pll1",
>> +                                                  "pll2", "pll3", "pll4";
>> +                             #power-domain-cells = <0>;
>> +                     };
>> +             };
>
> This clock node makes no sense. It's not compatible with anything and
> doesn't provide clocks itself, so #clock-cells is meaningless, and
> nothing underneath it is guaranteed to be probed.
>
> Please get rid of the clock node. It is a cargo-culted piece of magic
> that shouldn't exist.

The "clock" node is planned to be removed.

> Also, cpg_clocks node is missing #clock-cells, given it has
> clock-output-names I assume it is itself a clock provider, and
> presumably should have #clock-cells = <1>.

Indeed.

Note that the final CPG node will be the one from "[PATCH/RFC v4 0/5] clk:
shmobile: Add new Renesas CPG/MSSR DT bindings", cfr. the example in
https://patchwork.ozlabs.org/patch/531300/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
