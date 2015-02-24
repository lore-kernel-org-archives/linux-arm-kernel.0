From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 11:37:36 +0100
Subject: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings
 documentation
In-Reply-To: <1424773744-15106-3-git-send-email-wens@csie.org>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
 <1424773744-15106-3-git-send-email-wens@csie.org>
Message-ID: <9851276.8ZCd3XfZle@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 18:29:02 Chen-Yu Tsai wrote:
> 
> +       rsb at 01f03400 {
> +               compatible = "allwinner,sun8i-a23-rsb";
> +               reg = <0x01f03400 0x400>;
> +               interrupts = <0 39 4>;
> +               clocks = <&apb0_gates 3>;
> +               clock-frequency = <3000000>;
> +               resets = <&apb0_rst 3>;
> +
> +               axp223: pmic at 2d {
> +                       compatible = "x-powers,axp223", "x-powers,axp221";
> +                       reg = <0x2d>;
> +                       allwinner,rsb-hw-addr = <0x3e3>;
> +
> +                       /* ... */
> +               };
> +       };

The child node cannot have a 'reg' property if the parent does not
have #address-cells/#size-cells. You should add these as mandatory
properties in the list.

I don't really understand the need for having two addresses (runtime
and hardware). Could the runtime address be configured at runtime?
Alternatively, could you use #address-cells=<2> and put both into
'reg'?

	Arnd
