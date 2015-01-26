From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 11:42:39 +0000
Subject: [PATCH 4/4] ARM: dts: Add initial support for Alpine platform
In-Reply-To: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
References: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
Message-ID: <20150126114239.GB23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 06:30:59PM +0000, Tsahee Zidenberg wrote:
> This patch introduces an initial device-tree for the Alpine platform.
>
> Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  .../bindings/arm/annapurna-labs,alpine.txt         |  96 +++++++++++
>  .../cpu-enable-method/annapurna-labs,alpine-smp    |  64 ++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/alpine.dts                       | 181 +++++++++++++++++++++
>  5 files changed, 344 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
>  create mode 100644 arch/arm/boot/dts/alpine.dts

[...]

> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
> new file mode 100644
> index 0000000..6245aa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
> @@ -0,0 +1,64 @@
> +========================================================
> +Secondary CPU enable-method "annapurna-labs,alpine-smp" binding
> +========================================================
> +
> +This document describes the "annapurna-labs,alpine-smp" method for
> +enabling secondary CPUs. To apply to all CPUs, a single
> +"annapurna-labs,alpine-smp" enable method should be defined in the
> +"cpus" node.
> +
> +Enable method name:    "annapurna-labs,alpine-smp"
> +Compatible machines:   "annapurna-labs,alpine"
> +Compatible CPUs:       "arm,cortex-a15"
> +Related properties:    (none)

Please describe what the contract of the method is? What's expected of
the system, FW, and kernel?

Otherwise the documentation is practically useless.

[...]

> diff --git a/arch/arm/boot/dts/alpine.dts b/arch/arm/boot/dts/alpine.dts
> new file mode 100644
> index 0000000..fa0da66
> --- /dev/null
> +++ b/arch/arm/boot/dts/alpine.dts
> @@ -0,0 +1,181 @@
> +/*
> + * Copyright 2015 Annapurna Labs Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "skeleton64.dtsi"
> +
> +/ {
> +       version = "2.4";

What's this for?

> +       compatible = "annapurna-labs,alpine";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       clock-ranges;

Surely this doesn't mean anything at the root node?

[...]

> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic_main>;
> +               ranges;
> +
> +               arch-timer {
> +                       compatible = "arm,cortex-a15-timer",
> +                                    "arm,armv7-timer";
> +                       interrupts =
> +                               <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                               <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                               <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                               <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +                       clock-frequency = <0>; /* Filled by loader */
> +               };

Please fix your bootloader/FW to configure CNTFRQ on all CPUs whenever
they are brought up.

Are CPUs booted at Hyp? If not, is CNTVOFF configured uniformly across
CPUs by the bootloader/FW?

If the answer to both those questions is no, timekeeping will not work
on this platform.

> +
> +               /* Interrupt Controller */
> +               gic_main: gic_main {
> +                       compatible = "arm,cortex-a15-gic";
> +                       #interrupt-cells = <3>;
> +                       #size-cells = <0>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0x0 0xfb001000 0x0 0x1000>,
> +                             <0x0 0xfb002000 0x0 0x2000>,
> +                             <0x0 0xfb004000 0x0 0x1000>,
> +                             <0x0 0xfb006000 0x0 0x2000>;
> +                   interrupts = <GIC_PPI 9
> +                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +               };
> +
> +               /* CPU Resume registers */
> +               cpu_resume {
> +                       compatible = "annapurna-labs,al-cpu-resume";
> +                       reg = <0x0 0xfbff5ec0 0x0 0x30>;
> +               };
> +
> +               /* North Bridge Service Registers */
> +               nb_service {
> +                       compatible = "annapurna-labs,al-sysfabric-service";
> +                       reg = <0x0 0xfb070000 0x0 0x10000>;
> +               };
> +
> +               /* Performance Monitor Unit */
> +               pmu {
> +                       compatible = "arm,cortex-a15-pmu";
> +                       interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH
> +                                       GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH
> +                                       GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
> +                                       GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +               };

Nit: please bracket list entries individually, as you have done
elsewhere.

[...]

> +               clocks {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;

There is absolutely no need for a clock container node. Please get rid
of it, and just place the clocks here without it.

Thanks,
Mark.
