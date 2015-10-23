From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 23 Oct 2015 21:20:13 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151023181406.GK10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather>
Message-ID: <20151023212013.50bcbe4a@OPI2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Oct 2015 20:14:06 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Oct 21, 2015 at 06:20:27PM +0200, Jens Kuske wrote:
> > +		bus_gates: clk at 01c20060 {
> > +			#clock-cells = <1>;
> > +			compatible = "allwinner,sun8i-h3-bus-gates-clk";
> > +			reg = <0x01c20060 0x14>;
> > +			clock-indices = <5>, <6>, <8>,
> > +					<9>, <10>, <13>,
> > +					<14>, <17>, <18>,
> > +					<19>, <20>,
> > +					<21>, <23>,
> > +					<24>, <25>,
> > +					<26>, <27>,
> > +					<28>, <29>,
> > +					<30>, <31>, <32>,
> > +					<35>, <36>, <37>,
> > +					<40>, <41>, <43>,
> > +					<44>, <52>, <53>,
> > +					<54>, <64>,
> > +					<65>, <69>, <72>,
> > +					<76>, <77>, <78>,
> > +					<96>, <97>, <98>,
> > +					<112>, <113>,
> > +					<114>, <115>, <116>,
> > +					<128>, <135>;
> > +			clocks = <&ahb1>, <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb2>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb2>,
> > +				 <&ahb2>, <&ahb2>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&ahb1>, <&ahb1>,
> > +				 <&ahb1>, <&apb1>,
> > +				 <&apb1>, <&apb1>, <&apb1>,
> > +				 <&apb1>, <&apb1>, <&apb1>,
> > +				 <&apb2>, <&apb2>, <&apb2>,
> > +				 <&apb2>, <&apb2>,
> > +				 <&apb2>, <&apb2>, <&apb2>,
> > +				 <&ahb1>, <&ahb1>;  
> 
> This is not really what I had in mind...
> 
> This IP has 2 parents, and only two parents. The mapping between the
> IPs should be done in the driver itself, not in the DT where it is
> very error prone and barely readable.
> 
> And note that I never have expected you to use clk-simple-gates
> either. This is a complicated clock, unlike the other we've seen so
> far, it definitely deserves a driver of its own.

It seems that Allwinner puts the gate definitions anywhere in the array
of registers, so, I think that the H3 scheme will not be the last
complicated one, and if the parent clocks are in the code instead of in
the DT, we will have more and more code to develop.

An other way to describe the gates would be to add containers per parent
(with still a small patch in the clk-simple-gates):

	bus_gates: clk at 01c20060 {
		#clock-cells = <1>;
		compatible = "allwinner,sun8i-h3-bus-gates-clk";
		reg = <0x01c20060 0x14>;
		ahb1_gates {
			clocks = <&ahb1>;
			clock-indices = <5>, <6>, <8>,
					<9>, <10>, <13>,
					<14>, <18>,
					<19>, <20>,
					...;
			};
			clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0",
				"ahb1_mmc1", "ahb1_mmc2", "ahb1_nand",
				"ahb1_sdram", "ahb1_ts",
				"ahb1_hstimer", "ahb1_spi0",
				...;
		};
		ahb2_gates {
			clocks = <&ahb2>;
			clock-indices = <17>, <29>,
					<30>, <31>, <32>,
					...;
			clock-output-names = "ahb2_gmac", "ahb2_ohic1",
					"ahb2_ohic2", "ahb2_ohic3", "ahb1_ve",
					...;
		};
		apb1_gates {
			...
		};
		apb2_gates {
			...
		};
	};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
