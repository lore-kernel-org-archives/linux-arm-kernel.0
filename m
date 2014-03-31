From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 31 Mar 2014 13:39:52 +0200
Subject: [RFC PATCH v2 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140325225446.5762.15937@quantum>
References: <1393870533-20845-1-git-send-email-s.nawrocki@samsung.com>
 <1393870975-21020-1-git-send-email-s.nawrocki@samsung.com>
 <5331664E.2050008@samsung.com> <20140325225446.5762.15937@quantum>
Message-ID: <53395408.9020709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 25/03/14 23:54, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2014-03-25 04:19:42)
>> > On 03/03/14 19:22, Sylwester Nawrocki wrote:
[...]
>>> > > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt 
>>> > > b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > > index 7c52c29..eb8d547 100644
>>> > > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > > @@ -115,3 +115,26 @@ clock signal, and a UART.
>>> > >    ("pll" and "pll-switched").
>>> > >  * The UART has its baud clock connected the external oscillator and its
>>> > >    register clock connected to the PLL clock (the "pll-switched" signal)
>>> > > +
>>> > > +==Assigned clock parents and rates==
>>> > > +
>>> > > +Some platforms require static configuration of (parts of) the clock controller
>>> > > +often determined by the board design. Such a configuration can be specified in
>>> > > +a clock consumer node through clock-parents and clock-rates DT properties.
>>> > > +The former should contain list of parent clocks in form of phandle and clock
>>> > > +specifier pairs, the latter the list of assigned clock frequency values
>>> > > +(one cell each).
>>> > > +
>>> > > +    uart at a000 {
>>> > > +        compatible = "fsl,imx-uart";
>>> > > +        reg = <0xa000 0x1000>;
>>> > > +        ...
>>> > > +        clocks = <&clkcon 0>, <&clkcon 3>;
>>> > > +        clock-names = "baud", "mux";
>>> > > +
>>> > > +        clock-parents = <0>, <&pll 1>;
>> > 
>> > I have some doubts here, i.e. the order in which clocks are being 
>> > configured may be important in some cases. Should the binding then be
>> > specifying that the clocks will be configured in a sequence exactly 
>> > as listed in the clock-parents property ?
>
> That's a good point, and I think we should re-examine the role of a DT
> binding for this purpose. From my limited experience with DT, it seems
> to be really bad at anything involving sequencing. It doesn't give us
> function pointers/callbacks in the way that the old board files used to.
>
> So I think the binding you proposed is still a good idea, but only for
> the very simple case. If your platform has some detailed integration
> requirements that have corner cases like you describe below, then this
> DT binding might not be a good place to put the info.
> 
> A platform that provides its own pm runtime backend could neatly manage
> this by having a call to pm_runtime_get deal with these integration
> details such that the driver does not have to be aware of them. (caveat:
> that assumes in the example below that the only thing you want to do is
> set up your clocks once and then never touch them again)

This sounds reasonable, my impression was also that devicetree might be 
not the best place to put such a sequencing information.

We would just provide a one-time configuration data, without an indication 
of how the configuration should be performed when there are multiple 
clocks listed. As an usual DT practice the order of configuration wouldn't
be defined by the binding.

--
Regards,
Sylwester
