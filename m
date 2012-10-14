From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 14 Oct 2012 12:59:02 +0200
Subject: [RFC] Common clock framework for external clock generators
In-Reply-To: <50785EBF.3060508@gmail.com>
References: <4FAB15DB.5050702@googlemail.com> <5076847A.3010705@gmail.com>
 <5076ED22.3060803@gmail.com> <50785EBF.3060508@gmail.com>
Message-ID: <507A9AF6.4030008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding LAKML and devtree as there might be people willing to comment about
DT representation of i2c-attached clock generators, too.

On 10/12/2012 08:17 PM, Daniel Mack wrote:
> On 11.10.2012 18:00, Sebastian Hesselbarth wrote:
 >> [...]
>> Does any of you work rely on a working si5351 driver?
>
> Yes, it does actually. I can hack around it for now, but at some point,
> a proper driver is needed. And yours looks quite feature complete, so it
> would be easiest to finish this one :)

Well, yes it is some kind of feature complete except regmap and DT. Adding
regmap to the driver should be quite easy but with DT I am still thinking
of the best way to represent the internal connections between OSC, PLLs, and
CLKOUTs. In the last version of the driver I had a callback that was
board specific to setup these connections but with DT there will be no board
specific code anymore.

Maybe one of the common clk maintainers can give a hint how this could be
done in a clean way. The question is how to represent a i2c-attached clock
generator config in DT where you want to setup clock parents of CLKOUTs and
PLLs.

A possible solution would be something like this:

si5351a at 60 {
	compatible = "silabs,si5351a";
	reg = <0x60>;

	si_osc: osc {
		compatible = "fixed-clock";
		clock-frequency = <270000000>;
	};

	si_plla: pll at 0 {
		compatible = "silabs,si5351-pll";
		/* hook-up plla to osc input */
		clocks = <&si_osc>;
	};

	si_clkout0: clkout at 0 {
		compatible = "silabs,si5351-clkout";
		/* hook-up clkout0 to plla */
		clocks = <&si_plla>;
		/* request target frequency */
		clock-frequency = <148500000>;
	};	
};

Although this perfectly describes the clock hierarchy I still don't like
the sub-node style. Another flat solution would be something like:

si_osc: osc {
	compatible = "fixed-clock";
	clock-frequency = <270000000>;
};

si5351a at 60 {
	compatible = "silabs,si5351a";
	reg = <0x60>;
	clocks = <&si_osc>;

	si5351-pll-config = <0 0   /* pll A to osc */
			     1 0>; /* pll B to osc */

	si5351-clock-config = <0 0 148500000   /* clkout 0 to pll A, 148.5MHz */
			       1 0         0   /* clkout 1 to pll A, disabled */
			       2 1  24000000>; /* clkout 2 to pll B,  24.0Mhz */
};

> Do you still have access to hardware you wrote the driver for? Let me
> know if you need any help around here.

Yes, hardware is still available although I only have access to the Si5351a
with 3 clkouts. The code should be compatible for Si5351a with 8 clkouts and
code skeleton for 5351b (OSC and VXCO input) and 5351c (OSC and CLKIN) is
there but untested.

I've transferred the current driver version to my repository to work on. As soon
as I have regmap done, I will push it online and give you a note.

Sebastian
