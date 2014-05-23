From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 22 May 2014 18:35:46 -0700
Subject: [PATCH/RFC V6 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
References: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
 <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140523013546.9521.55361@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-05-19 10:22:51)
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 700e7aa..bee649b 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -132,3 +132,35 @@ clock signal, and a UART.
>    ("pll" and "pll-switched").
>  * The UART has its baud clock connected the external oscillator and its
>    register clock connected to the PLL clock (the "pll-switched" signal)
> +
> +==Assigned clock parents and rates==
> +
> +Some platforms require static initial configuration of default parent clocks
> +and clock frequecies. Such a configuration can be specified in a device node

s/frequecies/frequencies/

> +through clock-parents and clock-rates DT properties. The former should contain
> +a list of parent clocks in form of phandle and clock specifier pairs, the
> +latter the list of assigned clock frequency values (one cell each).
> +To skip setting parent or rate of a clock its corresponding entry should be
> +set to 0, or can be omitted if it is not followed by any non-zero entry.
> +
> +    uart at a000 {
> +        compatible = "fsl,imx-uart";
> +        reg = <0xa000 0x1000>;
> +        ...
> +        clocks = <&clkcon 0>, <&clkcon 3>;
> +        clock-names = "baud", "mux";
> +
> +        clock-parents = <0>, <&pll 1>;
> +        clock-rates = <460800>;
> +    };
> +
> +In this example the pll is set as parent of "mux" clock and frequency of
> +"baud" clock is specified as 460800 Hz.
> +
> +Configuring a clock's parent and rate through the device node that consumes
> +the clock can be done only for clocks that have a single user. Specifying
> +conflicting parent or rate configuration in multiple consumer nodes for
> +a shared clock is forbidden.
> +
> +Configuration of common clocks, which affect multiple consumer devices can
> +be similarly specified in the clock provider node.

Is it worthwhile to show an example of this? I guess the outcome will
depend on whether or not we support "assigned-clocks" property, which I
just revisited in the V5 thread.

Regards,
Mike
