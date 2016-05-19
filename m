From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2016 18:54:40 +0200
Subject: [PATCH/RFC 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <1463629845-7115-2-git-send-email-horms+renesas@verge.net.au>
References: <1463629845-7115-1-git-send-email-horms+renesas@verge.net.au>
 <1463629845-7115-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdV0tvAPvCQ3NjXVar6fykOwWzGs9fzks-0eEqk8-ZsTKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, May 19, 2016 at 5:50 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Basic support for the Gen 3 R-Car M3-W SoC.
>
> Based on work for the r8a7795 and r8a7796 SoCs by
> Takeshi Kihara, Dirk Behme and Geert Uytterhoeven.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -0,0 +1,120 @@
> +/*
> + * Device Tree Source for the r8a7796 SoC
> + *
> + * Copyright (C) 2016 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/clock/r8a7796-cpg-mssr.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "renesas,r8a7796";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               /* 1 core only at this point */
> +               a57_0: cpu at 0 {
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       reg = <0x0>;
> +                       device_type = "cpu";
> +                       next-level-cache = <&L2_CA57>;
> +                       enable-method = "psci";
> +               };
> +       };
> +
> +       L2_CA57: cache-controller at 0 {
> +               compatible = "cache";

With W=1:

Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit
name, but no reg property

> +               cache-unified;
> +               cache-level = <2>;
> +       };

Please add the missing "reg = <0>;>, and move this node under the cpus node
so he reg property matches #address-cells/#size-cells.

> +       /* External SCIF clock - to be overridden by boards that provide it */
> +       scif_clk: scif {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +               status = "disabled";

Please drop the disabled status.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
