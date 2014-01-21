From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 21 Jan 2014 13:48:43 +0100
Subject: [RFC] dt-bindings: configuration of parent clocks and clock frequency
Message-ID: <52DE6CAB.10008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

During LCE13 there was a discussion regarding initial configuration
of clocks from consumer perspective and the related device tree bindings.

It seems no one started working on this, at least I couldn't see any
related posts/patches on the mailing list, so I thought I'd give a try
the initial binding proposal [1].

As it turns out, by adding only a single property with a list of parent
clock specifiers or clock frequencies corresponding to clocks listed in
the 'clocks' property it is difficult to specify parent clocks or
frequencies only for selected clocks of a device.

So I modified the proposed binding and there are some variants below
it would be nice to get a feedback for.

Let's assume a clock provider and an UART device:

clk {
	#clock-cells = <1>;
};

uart: uart {
	clocks = 	<&clk 10>, <&clk 11>, <&clk 12>;
	clock-names = 	"sclk_0",  "sclk_1",  "gate";
	...
};

1. The first version I actually tried in practice is
   'assigned-clk-parents' and assigned-clk-rates properties listing
   <clk clk_parent> and <clk clk_rate> pairs respectively:

 uart {
	clocks =  <&clk 10>, <&clk 11>, <&clk 12>;
	clock-names =  "sclk_0", "sclk_1", "gate";

	assigned-clk-parents = <&clk_a 10 &clk_a 20>,
				<&clk_a 11 &clk_a 100>;

	assigned-clk-rates = <&clk_a 10 600000>,
			     <&clk_a 100 100000>;
 };

Parsing assigned-clk-parents is straightforward, only assigned-clk-rates
requires a bit more exercise.

2. A different option would be to list all the required clocks in clock/
   clock-names properties and use properties as below to refer to the
   clocks by name:

 uart {
	clocks =  <&clk 10>, <&clk 11>, <&clk 12>, &clk 100> /* PLL */;
	clock-names =  "sclk_0", "sclk_1", "gate", "pll";

	assigned-clk-parent-clocks = "sclk_0";
	assigned-clk-parent-parents = "pll";

	assigned-clk-rate-clocks = "pll";
	assigned-clk-rate-values = <600000>;
 };

It might be more readable and would allow configuring things more
consciously. However it adds an additional indirection and introduces
specifiers of clocks potentially unrelated to a device in clocks/
clock-names properties.

3. A simplified variant of 2., with indexes to 'clocks' property rather
   than values from the clock-names property:

 uart: uart {
	clocks =  <&clk 10>, <&clk 11>, <&clk 12>, &clk 100> /* PLL */;
	clock-names =  "sclk_0", "sclk_1", "gate", "pll";

	assigned-clk-parent-clocks = 0;
	assigned-clk-parent-parents = 3;

	assigned-clk-rate-clocks = 3;
	assigned-clk-rate-values = <600000>;
 };

4. With phandle + clock specifier instead of device clock names:

 uart: uart {
	clocks =  <&clk 10>, <&clk 11>, <&clk 12>, &clk 100> /* PLL */;
	clock-names =  "sclk_0", "sclk_1", "gate", "pll";

	assigned-clk-parent-clocks = <&clk 10>;
	assigned-clk-parent-parents = <&clk 100>;

	assigned-clk-rate-clocks = <&clk 100>;
	assigned-clk-rate-values = <600000>;
 };

5. Similarly to the regulator bindings the clock names could be appended
  to name of a DT property:

 [clk_name]-assigned-clock-parent = <...>;
 [clk_name]-assigned-clock-rate = <...>;

It has an issue though that length of a DT property name is limited
to 31 characters and there may not be enough room for the clock name.

 uart: uart {
	clocks =  <&clk 10>, <&clk 11>, <&clk 12>;
	clock-names =  "sclk_0", "sclk_1", "gate";

	sclk_0-assigned-clk-parent = <&clk 100>;

	pll-assigned-clk-rate = <600000>;
 };


Does any of these look reasonable ? Perhaps someone could suggest
a better approach ?

[1] https://lkml.org/lkml/2013/8/22/2

--
Regards,
Sylwester
