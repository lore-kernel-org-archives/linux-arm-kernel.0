From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 15:28:21 +0200
Subject: [PATCH 09/10] dts: versatile: add clock tree
In-Reply-To: <1400620176-7239-10-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-10-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdaBdNo=Nkoe62j9ZUspWZx7+cuisHT9EHVKR5aEdRWgBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> The versatile dts is missing any clock data. Add the clocks.
>
> It is not clear from the documentation where pclk comes from, so for
> now it is a dummy clock which is sufficient for things to work.

AFAICT (from experiments and measurements on some boards, during which
I destroyed some boards) that is actually just the 24MHz clock right off.

> Signed-off-by: Rob Herring <robh@kernel.org>

> +       core-module at 10000000 {
> +               compatible = "arm,core-module-versatile";
> +               reg = <0x10000000 0x200>;
> +
> +               osc24M: oscillator at 24M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <24000000>;
> +               };

Please follow the naming convention from the Integrator DTS, I am
pretty sure this is a chrystal:

        /* 24 MHz chrystal on the core module */
        xtal24mhz: xtal24mhz at 24M {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <24000000>;
        };


> +               /* OSC1 on AB, OSC4 on PB */
> +               osc1: cm_aux_osc at 24M {
> +                       #clock-cells = <0>;
> +                       compatible = "arm,versatile-cm-auxosc";
> +                       clocks = <&osc24M>;
> +               };

Name xtal, also: why is this inside the core module node?
You're explicitly saying it is on the PB (platform baseboard)
and *not* on the core module!

> +               /* The timer clock is the 24 MHz oscillator divided to 1MHz */
> +               timclk: timclk at 1M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <24>;
> +                       clock-mult = <1>;
> +                       clocks = <&osc24M>;
> +               };
> +
> +               /* Actually hclk ? */
> +               pclk: pclk at 0 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <0>;
> +               };

I strongly suspect it's like this:

        pclk: pclk at 0 {
                #clock-cells = <0>;
                compatible = "fixed-factor-clock";
                clock-div = <1>;
                clock-mult = <1>;
                clocks = <&xtal24mhz>;
        };


>                 timer at 101e2000 {
>                         compatible = "arm,sp804", "arm,primecell";
>                         reg = <0x101e2000 0x1000>;
>                         interrupts = <4>;
> +                       clocks = <&timclk>, <&pclk>;
> +                       clock-names = "tmrclk", "apb_pclk";
>                 };

We recently had some fight over the names of these clocks.
The DT bindings say they should be named "timer0" "timer1"
etc, see
Documentation/devicetree/bindings/timer/arm,sp804.txt

>                 timer at 101e3000 {
>                         compatible = "arm,sp804", "arm,primecell";
>                         reg = <0x101e3000 0x1000>;
>                         interrupts = <5>;
> +                       clocks = <&timclk>, <&pclk>;
> +                       clock-names = "tmrclk", "apb_pclk";

Dito.

>                 ssp at 101f4000 {
>                         compatible = "arm,pl022", "arm,primecell";
>                         reg = <0x101f4000 0x1000>;
>                         interrupts = <11>;
> +                       clocks = <&osc24M>, <&pclk>;
> +                       clock-names = "sspclk", "apb_pclk";

Should be SSPCLK all capitals.

Yours,
Linus Walleij
