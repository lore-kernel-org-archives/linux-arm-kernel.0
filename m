From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 10:39:45 -0800
Subject: [RFC 6/8] of: add clock providers
In-Reply-To: <1320801583-12774-7-git-send-email-grant.likely@secretlab.ca>
References: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
 <1320801583-12774-7-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20111109183945.GL31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [111108 16:51]:
> +
> +    /* external oscillator */
> +    osc: oscillator {
> +        compatible = "fixed-clock";
> +        #clock-cells = <1>;
> +        frequency  = <32678>;
> +        clock-output-name = "osc";
> +    };
> +
> +    /* phase-locked-loop device, generates a higher frequency clock
> +     * from the external oscillator reference */
> +    pll: pll {
> +        compatible = "some-pll-interface"
> +        #clock-cells = <1>;
> +        clock-input = <&osc 0>;
> +        clock-input-name = "ref";
> +        reg = <0x4c000 0x1000>;
> +        clock-output-name = "pll", "pll-switched";
> +    };

I think for the clocks we need something describing which bits
in the clock register the "pll" and "pll-switched" belong to.

Otherwise we'll end up having to map all that data in the clock
driver for various SoC variants.

> +    /* UART, using the low frequency oscillator for the baud clock,
> +     * and the high frequency switched PLL output for register
> +     * clocking */
> +    uart {
> +        compatible = "fsl,imx-uart";
> +        reg = <0xa000 0x1000>;
> +        interrupts = <33>;
> +        clock-input = <&osc 0>, <&pll 1>;
> +        clock-input-name = "baud", "register";
> +    };
> +

Here I think we need a better solution for finding the
clocks by name. Doing clock-input = <&osc 0>, <&pll 1> means
that we have redefine the uart for similar SoC many times.

How about using source + option in the name instead:

	   clock-source-name = "osc.osc", "pll.pll-switched";

This same solution would also work for the pinctrl names:

	   pinctrl-source-name = "uart1_rx.uart1_rx", "dss_data7.uart1_tx";

The reason I'm worried here is that just for omap2/3/4 we already
have 3 options for uart1 clock and 19 options for uart1_rx pin!

Using the signal names for both clocks and pinctrl would
allow defining the uart entry for for each reg address instead
of for each clock and pinctrl option.

Regards,

Tony
