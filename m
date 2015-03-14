From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:30:59 +0100
Subject: [PATCH 08/10] ARM: dts: zx: add an initial dts for zx296702
In-Reply-To: <1426333785-3952-9-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-9-git-send-email-jun.nie@linaro.org>
Message-ID: <2891190.FNOpxdiSkI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:43 Jun Nie wrote:
> 
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/zx296702-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +       };

Move the aliases to the board specific file: other boards might not
have the same set of uarts visible to users.

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a9";
> +                       device_type = "cpu";
> +                       reg = <0>;
> +               };
> +
> +               cpu at 1 {
> +                       compatible = "arm,cortex-a9";
> +                       device_type = "cpu";
> +                       reg = <1>;
> +               };
> +       };
> +

No enable-method?

> +               lsp1crpm: lsp1crpm at 0x09400000 {
> +                       compatible = "zte,zx296702-lsp1crpm";
> +                       reg = <0x09400000 0x1000>;
> +               };

What is an lsp1crpm?

> +               dwmmc0: dwmmc at 0x09408000 {

The node name should be "mmc", not "dwmmc".
> +
> +               clks: topcrm at 0x09800000 {
> +                       compatible = "zte,zx296702-topcrm";
> +                       reg = <0x09800000 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               lsp0crpm: lsp0crpm at 0x0b000000 {
> +                       compatible = "zte,zx296702-lsp0crpm";
> +                       reg = <0x0b000000 0x1000>;
> +               };

What is a topcrm and an lsp0crpm?

> +               dwmmc1: dwmmc at 0x0b003000 {
> +                       compatible = "snps,dw-mshc";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0b003000 0x1000>;
> +                       interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +                       fifo-depth = <32>;
> +                       clocks = <&clks ZX296702_SDMMC1_PCLK>,
> +                                <&clks ZX296702_SDMMC1_WCLK>;
> +                       clock-names = "biu", "ciu";
> +                       status = "disabled";
> +               };
> +
> +               aon_sysctrl: aon-sysctrl at 0xa0007000 {
> +                       compatible = "zte,aon-sysctrl";
> +                       reg = <0xa0007000 0x1000>;
> +               };
> +       };

This looks like  it's a system controller, so the node name
should probably be "system-controller", not aon-sysctrl,
and you may want to claim compatibility with "syscon" as well.

All the nodes need to have a documented binding.

	Arnd
