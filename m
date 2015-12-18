From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 07:06:33 -0800
Subject: [RFC 7/9] ARM: dts: omap4: add hwmod module clocks
In-Reply-To: <1450447141-29936-8-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-8-git-send-email-t-kristo@ti.com>
Message-ID: <20151218150633.GG23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [151218 05:57]:
> +	mmu_dsp_mod_ck: mmu_dsp_mod_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,omap4-hw-mod-clock";
> +		reg = <0x0420>;
> +		clocks = <&dpll_iva_m4x2_ck>;
> +	};
> +
> +	dsp_mod_ck: dsp_mod_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,omap4-hw-mod-clock";
> +		reg = <0x0420>;
> +		clocks = <&dpll_iva_m4x2_ck>;
> +	};

In general we should get rid of the overlapping reg entries
for clocks. That's a separate patch series for sure.. But I
think it can be done simply with something like this probably
for all of them (totally untested):

	mux_div_gate_ck: clk at 420 {
		#clock-cells = <1>;
		compatible = "ti,mux-divider-gate";
		clock-indices = <0>, <1>;
		clock-output-names = "mux", "div", "gate";
		reg = <0x420 0x4>;
		foo_mux_ck: clock at 0 {
			reg = <0>;
			compatible = "ti,mux-clock";
		};
		foo_div_ck: clock at 8 {
			reg = <8>;
			compatible = "ti,divider-clock";
			ti,max-div = <31>;
		};
		foo_gate_ck: clock at 16 {
			reg = <16>;
			compatible = "ti,gate-clock";
			clocks = <&mux_source_ck>;
		};
	};

Then the output can be referenced with the standard clock binding
index. For example to use the mux clock:

clocks = <&mux_div_gate_ck 0>;

Regards,

Tony
