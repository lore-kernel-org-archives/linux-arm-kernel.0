From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 21 Apr 2016 13:20:11 +0200
Subject: [PATCH v2 03/11] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <1461225849-28074-4-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-4-git-send-email-joel@jms.id.au>
Message-ID: <4956403.scaVRGhPEf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+clock-related patches should include clock-maintainers and lists]

Am Donnerstag, 21. April 2016, 17:34:01 schrieb Joel Stanley:
> +For example:
> +
> +	clk_clkin: clk_clkin {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <48000000>;
> +	};
> +
> +	clk_hpll: clk_hpll {
> +		compatible = "aspeed,g4-hpll-clock";
> +		#clock-cells = <0>;
> +		reg = <0x1e6e2008 0x4>;
> +	};
> +
> +	clk_apb: clk_apb at 1e6e2008 {
> +		#clock-cells = <0>;
> +		compatible = "aspeed,g4-apb-clock";
> +		reg = <0x1e6e2008 0x4>;
> +		clocks = <&clk_hpll>;
> +	};

You have both the hpll and apb_clk in the same register (probably even more 
clocks?) and separate clock instances where each instance will of_iomap the 
register itself (and thus multiple times in general).

>From what I remember exposing the clock controller as one block (instead of 
declaring each clock individually in the dts) is still the preferred way but I 
don't think I can find Mike's mail from back then easily.

And I think most clock-controller implementations actually use that paradigm.


Heiko
