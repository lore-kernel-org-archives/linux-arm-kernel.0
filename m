From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jul 2015 17:23:00 +0100
Subject: [PATCH v4 1/8] Documentation: add DT binding for ARM System
 Control and Power Interface(SCPI) protocol
In-Reply-To: <55AFBD24.8020903@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
 <20150722095501.GA15809@leverpostej> <55AFBD24.8020903@arm.com>
Message-ID: <20150722162300.GD15809@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +Other required properties for all clocks(all from common clock binding):
> >> +- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
> >> +	outputs. The clock specifier will be the index to an entry in the list
> >> +	of output clocks.
> >
> > Huh? That's somewhat a circular definition.
> >
> > What does that number correspond to in the HW? If it's just the number
> > that the FW expects, that's a reasonable definition.
> >
> 
> Not exactly. The clock specifier are used by the consumers and they just
> indicate the index into the list of clock outputs provided by the clock
> provider. The consumers need not know the exact identifier used by the
> provider to identify the clock(either via H/W or F/W)

Currently the definition is circular because clock-indices is misued. If
you sort that out then this should become grounded and well-defined.

[...]

> >> +scpi_protocol: scpi at 2e000000 {
> >> +	compatible = "arm,scpi";
> >> +	mboxes = <&mailbox 0 &mailbox 1>;
> >> +	shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
> >> +
> >> +	clocks {
> >> +		compatible = "arm,scpi-clocks";
> >> +
> >> +		scpi_dvfs: scpi_clocks at 0 {
> >> +			compatible = "arm,scpi-dvfs-clocks";
> >> +			#clock-cells = <1>;
> >> +			clock-indices = <0>, <1>, <2>;
> >> +			clock-output-names = "vbig", "vlittle", "vgpu";
> >> +		};
> >> +		scpi_clk: scpi_clocks at 3 {
> >> +			compatible = "arm,scpi-variable-clocks";
> >> +			#clock-cells = <1>;
> >> +			clock-indices = <3>, <4>;
> >> +			clock-output-names = "pxlclk0", "pxlclk1";
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +cpu at 0 {
> >> +	...
> >> +	reg = <0 0>;
> >> +	clocks = <&scpi_dvfs 0>;
> >> +	clock-names = "vbig";
> >> +};
> >> +
> >> +hdlcd at 7ff60000 {
> >> +	...
> >> +	reg = <0 0x7ff60000 0 0x1000>;
> >> +	clocks = <&scpi_clk 1>;
> >> +	clock-names = "pxlclk";
> >> +};
> >> +
> >> +In the above example, the #clock-cells is set to 1 as required.
> >> +scpi_dvfs has 3 output clocks namely: vbig, vlittle and vgpu with 0, 1
> >> +and 2 as clock-indices. scpi_clk has 2 output clocks namely: pxlclk0 and
> >> +pxlclk1 with 3 and 4 as clock-indices.
> >> +
> >> +The first consumer in the example is cpu at 0 and it has vbig as input clock.
> >> +The index '0' in the clock specifier here points to the first entry in the
> >> +output clocks of scpi_dvfs for which clock_id asrequired by the firmware
> >> +is 0.
> >> +
> >> +Similarly the second example is hdlcd at 7ff60000 and it has pxlclk0 as input
> >> +clock. The index '1' in the clock specifier here points to the second entry
> >> +in the output clocks of scpi_clocks for which clock_id as required by the
> >> +firmware is 4.
> >
> > To the best of my knowledge, this is wrong. Per the example in
> > Documentation/devicetree/bindings/clock/clock-bindings.txt, the
> > clock-indices apply to the logical value in the clock-specifier.
> >
> > So <&scpi_clk 3>, <&scpi_clk 4> exist, (and are named "pxlclk0",
> > "pxlclk1" respectively), but <&scpi_clk 0>, <&scpi_clk 1> do not (or at
> > least don't have names).
> >
> 
> That depends, if your clock provider provides a callback for decoding
> clock and does this translation, then they can exist.

Sure, hence the "(or at least don't have names)".

> Since SCPI is using standard/default callback(of_clk_src_onecell_get),
> only <&scpi_clk 0>, <&scpi_clk 1> in above example. For any value >=2,
> of_clk_src_onecell_get will bail out as we have only 2 clocks
> registered from that provider.

That's in violation of the semantics of clock-indices, which was added
to map from a non-contiguous set of clock-specifier values to a list of
strings. Take a look at of_clk_get_parent_name (which this won't work
with).

Also see Documentation/devicetree/bindings/clock/clock-bindings.txt
(relevant portion duplicated below):

----
clock-indices:	   If the identifying number for the clocks in the node
		   is not linear from zero, then this allows the mapping of
		   identifiers into the clock-output-names array.

For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:

	oscillator {
		compatible = "myclocktype";
		#clock-cells = <1>;
		clock-indices = <1>, <3>;
		clock-output-names = "clka", "clkb";
	}

	This ensures we do not have any empty strings in clock-output-names
----

Note that the indices are the clock-specifier values, not the raw HW/FW
values.

Either you should be using <&scpi_clk 3> and <&scpi_clk 4>, or you need
a different property to map your logical indices to raw HW values.

Thanks,
Mark.
