From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 16:48:26 -0800
Subject: [PATCH RFC v1 3/3] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <53072C9D.5040303@samsung.com>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
 <1392829124-25705-4-git-send-email-s.nawrocki@samsung.com>
 <20140220140928.27132C4050F@trevor.secretlab.ca>
 <53072C9D.5040303@samsung.com>
Message-ID: <20140224004826.22529.87768@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-02-21 02:38:21)
> On 20/02/14 15:09, Grant Likely wrote:
> [...]
> >> > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> > index 7c52c29..d618498 100644
> >> > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> > @@ -115,3 +115,27 @@ clock signal, and a UART.
> >> >    ("pll" and "pll-switched").
> >> >  * The UART has its baud clock connected the external oscillator and its
> >> >    register clock connected to the PLL clock (the "pll-switched" signal)
> >> > +
> >> > +==Static initial configuration of clock parent and clock frequency==
> >> > +
> >> > +Some platforms require static configuration of (parts of) the clock controller
> >> > +often determined by the board design. Such a configuration can be specified in
> >> > +a clock consumer node through [clk-name]-clk-parent and [clk-name]-clk-rate DT
> >> > +properties. The former should contain phandle and clock specifier of the parent
> >> > +clock, the latter the required clock's frequency value (one cell). "clk-name"
> >> > +should be listed in the clock-names property and a phandle and a clock specifier
> >> > +pair corresponding to it should be present in the clocks property.
> >> > +
> >> > +    uart at a000 {
> >> > +        compatible = "fsl,imx-uart";
> >> > +        reg = <0xa000 0x1000>;
> >> > +  ...
> >> > +        clocks = <&clkcon 0>, <&clkcon 3>;
> >> > +        clock-names = "baud", "mux";
> >> > +
> >> > +  mux-clk-parent = <&pll 1>;
> >> > +  baud-clk-rate = <460800>;
> >
> > This mixes patterns for references to clocks. Plus it requires composing
> > property names which is a little painful. I'd rather see a list of
> > tuples to match the existing pattern already in use
> > 
> >       clocks = <&clkcon 0>, <&clkcon 3>;
> >       clock-names = "baud", "mux";
> >       clock-parents = <0> <&pll 1>;
> >       clock-rates = <0> <460800>;
> 
> Thank you for the review. This looks much better to me. My bad, I wasn't 
> aware 0 can be used to denote an empty phandle like this. ePAPR seems not 
> to be specifying exact meaning of the 'phandle' property values, except 
> they be unique. Anyway, it seems to be clearly documented within the
> __of_parse_phandle_with_args() function. 
> 
> I'll try this modified binding instead, presumably it would be useful to 
> have a variant of __of_parse_phandle_with_args() function which would 
> accept a context data containing result of previous call within an iteration, 
> similarly as of_property_next_string() is written. So we don't iterate 
> from beginning of the list with each __of_parse_phandle_with_args() call. 
> But it's an optimization issue that could be considered separately I guess.

I was always partial to the regulator style of blahblah-supply but
Grant's suggestion is much cleaner with respect to the rest of the clock
binding.

I guess it will be a bit ugly if a very long array is needed with a
sparse attribute. E.g. 20 clocks specified in the 'clocks' property and
only a single clock needs to have its parent or rate specified.

Is there a reason not to support both methods?

Regards,
Mike

> 
> --
> Thanks,
> Sylwester
