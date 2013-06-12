From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 14:24:41 +0100
Subject: [PATCH 2/2] ARM: nomadik: add the new clocks to the device tree
In-Reply-To: <CACRpkdZNZ4_FzjEsstUm0bn8hE7FPTN1y_QnXtWUvGUzCNynBg@mail.gmail.com>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
 <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
 <201306091621.02506.arnd@arndb.de>
 <CACRpkdZNZ4_FzjEsstUm0bn8hE7FPTN1y_QnXtWUvGUzCNynBg@mail.gmail.com>
Message-ID: <20130612132441.637B23E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013 09:43:30 +0200, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jun 9, 2013 at 4:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 09 June 2013, Linus Walleij wrote:
> >> +               /*
> >> +                * IP AMBA bus clocks, driving the bus side of the
> >> +                * peripheral clocking, clock gates.
> >> +                */
> >> +
> >> +               hclkdma0: hclkdma0 at 48M {
> >> +                       #clock-cells = <0>;
> >> +                       compatible = "st,nomadik-src-clock";
> >> +                       clock-id = <0>;
> >> +                       clocks = <&hclk>;
> >> +               };
> >> +               hclksmc: hclksmc at 48M {
> >> +                       #clock-cells = <0>;
> >> +                       compatible = "st,nomadik-src-clock";
> >> +                       clock-id = <1>;
> >> +                       clocks = <&hclk>;
> >> +               };
> >> +               hclksdram: hclksdram at 48M {
> >> +                       #clock-cells = <0>;
> >> +                       compatible = "st,nomadik-src-clock";
> >> +                       clock-id = <2>;
> >> +                       clocks = <&hclk>;
> >> +               };
> >> +               hclkdma1: hclkdma1 at 48M {
> >> +                       #clock-cells = <0>;
> >> +                       compatible = "st,nomadik-src-clock";
> >> +                       clock-id = <3>;
> >> +                       clocks = <&hclk>;
> >> +               };
> >
> > Sorry if I'm being slow to understand how the clock bindings work, but if
> > you have 63 identical clocks that only differ in ther clock-id, can't you
> > just have a single DT node for them instead with #clock-cells=1 to pass the
> > number from the device using it?
> 
> I first had exactly that implementation but it didn't work. This is explained
> in the commit message on patch 1/1:
> 
>   The gated clocks are implemented with zero cells and
>   given the clock ID as a property of each node, so every
>   gate need to have its own node in the device tree.
>   This is because the gate registers contain both HCLK
>   gates and PCLK gates, where the latter has HCLK as
>   parent. As can be seen from the register layout, this
>   is a complete mixup, which means all these gates need
>   their own node to properly model parent/child relations
>   for PCLKs apart from the HCLKs.
> 
> Basically the "shortcoming" in device tree is that modelling this with
> clock-cells = 1 requires them all to have one and the same parent,
> but they don't.

Are you prevented from increasing the number of clock-cells used here?

It is a lot of identical data being added.

g.
