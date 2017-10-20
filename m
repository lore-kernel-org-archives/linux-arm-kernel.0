From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 20 Oct 2017 14:45:57 -0500
Subject: [PATCH v7 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20171019225050.25410-3-brendanhiggins@google.com>
References: <20171019225050.25410-1-brendanhiggins@google.com>
 <20171019225050.25410-3-brendanhiggins@google.com>
Message-ID: <CAL_JsqJGe85FAOQwt=zJ5jOBoT-F1itnK6kmc9k34FJu=3Z=bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 5:50 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ---

[...]

> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> new file mode 100644
> index 000000000000..85506b3cdd39
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> @@ -0,0 +1,198 @@
> +/*
> + * DTSi file for the NPCM750 SoC
> + *
> + * Copyright 2012 Tomer Maimon <tomer.maimon@nuvoton.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/nuvoton,npcm7xx-clks.h>
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm7xx-smp";
> +
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <0>;
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <1>;
> +                       next-level-cache = <&l2>;
> +               };
> +       };
> +
> +/* external clock signal rg1refck, supplied by the phy */
> +clk-rg1refck {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <125000000>;
> +};
> +
> +/* external clock signal rg2refck, supplied by the phy */
> +clk-rg2refck {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <125000000>;
> +};
> +
> +clk-xin {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <50000000>;
> +};
> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges = <0x0 0xf0000000 0x00900000>;
> +
> +               gcr: gcr at f0800000 {

Should be gcr at 800000. Build the dtb with W=1 and it will give you
warnings for this.

> +                       compatible = "nuvoton,npcm750-gcr", "syscon",
> +                               "simple-mfd";
> +                       reg = <0x800000 0x1000>;
> +               };
> +
> +               scu: scu at f03fe000 {
> +                       compatible = "arm,cortex-a9-scu";
> +                       reg = <0x3fe000 0x1000>;
> +               };
> +
> +               l2: cache-controller at f03fc000 {
> +                       compatible = "arm,pl310-cache";
> +                       reg = <0x3fc000 0x1000>;
> +                       interrupts = <0 21 4>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +                       clocks = <&clk NPCM7XX_CLK_AXI>;
> +               };
> +
> +               gic: interrupt-controller at f03ff000 {
> +                       compatible = "arm,cortex-a9-gic";
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       reg = <0x3ff000 0x1000>,
> +                           <0x3fe100 0x100>;
> +               };
> +
> +               timer at f03fe600 {
> +                       compatible = "arm,cortex-a9-twd-timer";
> +                       reg = <0x3fe600 0x20>;
> +                       interrupts = <1 13 0x304>;
> +                       clocks = <&clk NPCM7XX_CLK_TIMER>;
> +               };
> +       };
> +
> +       ahb {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges = <0x80000000 0x80000000 0x40010000
> +                         0xe0800000 0xe0800000 0x0f800000
> +                         0x00000000 0xf0000000 0x00900000
> +                         0xf8000000 0xf8000000 0x02000000
> +                         0xfb000000 0xfb000000 0x00002000>;

Just do "ranges;" here if all the translation is at the next level down.

Sorry, it's hard to say exactly what to do without knowing the whole memory map.

> +
> +               clk: clock-controller at f0801000 {

Seems like this belongs under /soc based on the address.

> +                       compatible = "nuvoton,npcm750-clk";
> +                       #clock-cells = <1>;
> +                       reg = <0x801000 0x1000>;
> +                       status = "okay";
> +               };
> +
> +               apb {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "simple-bus";
> +                       interrupt-parent = <&gic>;
> +                       ranges = <0x0 0x0 0x00300000>;

And then this would be "<0x0 0xf0000000 0x300000>".

> +
> +                       timer0: timer at f0000000 {
> +                               compatible = "nuvoton,npcm750-timer";
> +                               interrupts = <0 32 4>;
> +                               reg = <0x0 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
> +                       };
> +
> +                       watchdog0: watchdog at f0008000 {
> +                               compatible = "nuvoton,npcm750-wdt";
> +                               interrupts = <0 47 4>;
> +                               reg = <0x8000 0x1000>;
> +                               status = "disabled";
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
> +                       };
> +
> +                       watchdog1: watchdog at f0009000 {
> +                               compatible = "nuvoton,npcm750-wdt";
> +                               interrupts = <0 48 4>;
> +                               reg = <0x9000 0x1000>;
> +                               status = "disabled";
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
> +                       };
> +
> +                       watchdog2: watchdog at f000a000 {
> +                               compatible = "nuvoton,npcm750-wdt";
> +                               interrupts = <0 49 4>;
> +                               reg = <0xa000 0x1000>;
> +                               status = "disabled";
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
> +                       };
> +
> +                       serial0: serial at f0001000 {
> +                               compatible = "nuvoton,npcm750-uart";
> +                               reg = <0x1000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +                               interrupts = <0 2 4>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial1: serial at f0002000 {
> +                               compatible = "nuvoton,npcm750-uart";
> +                               reg = <0x2000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +                               interrupts = <0 3 4>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial2: serial at f0003000 {
> +                               compatible = "nuvoton,npcm750-uart";
> +                               reg = <0x3000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +                               interrupts = <0 4 4>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial3: serial at f0004000 {
> +                               compatible = "nuvoton,npcm750-uart";
> +                               reg = <0x4000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +                               interrupts = <0 5 4>;
> +                               status = "disabled";
> +                       };
> +               };
> +       };
> +};
> diff --git a/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h b/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> new file mode 100644
> index 000000000000..c69d3bbf7e42
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2016 Nuvoton Technologies,  tali.perry at nuvoton.com
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_NPCM7XX_H
> +#define _DT_BINDINGS_CLK_NPCM7XX_H
> +
> +#define NPCM7XX_CLK_PLL0       0
> +#define NPCM7XX_CLK_PLL1       1
> +#define NPCM7XX_CLK_PLL2       2
> +#define NPCM7XX_CLK_GFX                3
> +#define NPCM7XX_CLK_APB1       4
> +#define NPCM7XX_CLK_APB2       5
> +#define NPCM7XX_CLK_APB3       6
> +#define NPCM7XX_CLK_APB4       7
> +#define NPCM7XX_CLK_APB5       8
> +#define NPCM7XX_CLK_MC         9
> +#define NPCM7XX_CLK_CPU                10
> +#define NPCM7XX_CLK_SPI0       11
> +#define NPCM7XX_CLK_SPI3       12
> +#define NPCM7XX_CLK_SPIX       13
> +#define NPCM7XX_CLK_UART_CORE  14
> +#define NPCM7XX_CLK_TIMER      15
> +#define NPCM7XX_CLK_HOST_UART  16
> +#define NPCM7XX_CLK_MMC                17
> +#define NPCM7XX_CLK_SDHC       18
> +#define NPCM7XX_CLK_ADC                19
> +#define NPCM7XX_CLK_GFX_MEM    20
> +#define NPCM7XX_CLK_USB_BRIDGE 21
> +#define NPCM7XX_CLK_AXI                22
> +#define NPCM7XX_CLK_AHB                23
> +#define NPCM7XX_CLK_EMC                24
> +#define NPCM7XX_CLK_GMAC       25
> +
> +#endif
> --
> 2.15.0.rc0.271.g36b669edcc-goog
>
