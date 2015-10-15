From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 11:58:20 +0100
Subject: [PATCH v11 1/8] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151015105820.GF8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

> > +		gic: interrupt-controller at 0xf1010000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xf1010000 0 0x1000>,
> +			      <0x0 0xf1020000 0 0x2000>;
> +			interrupts = <GIC_PPI 9
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};

No GICH and GICV?

Which exception level do CPUs boot at?

> +		clock {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#clock-cells = <1>;
> +			ranges;
> +
> +			cpg_clocks: cpg_clocks at e6150000 {
> +				compatible = "renesas,r8a7795-cpg-clocks",
> +					     "renesas,rcar-gen3-cpg-clocks";
> +				reg = <0 0xe6150000 0 0x1000>;
> +				clocks = <&extal_clk>;
> +				clock-indices = <
> +					R8A7795_CLK_MAIN R8A7795_CLK_PLL0
> +					R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
> +					R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
> +				>;
> +				clock-output-names = "main", "pll0", "pll1",
> +						     "pll2", "pll3", "pll4";
> +				#power-domain-cells = <0>;
> +			};
> +		};

This clock node makes no sense. It's not compatible with anything and
doesn't provide clocks itself, so #clock-cells is meaningless, and
nothing underneath it is guaranteed to be probed.

Please get rid of the clock node. It is a cargo-culted piece of magic
that shouldn't exist.

Also, cpg_clocks node is missing #clock-cells, given it has
clock-output-names I assume it is itself a clock provider, and
presumably should have #clock-cells = <1>.

Thanks,
Mark.
