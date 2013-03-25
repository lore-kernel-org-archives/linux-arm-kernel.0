From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 14:58:15 +0100
Subject: [PATCH] ARM: zynq: add gem support
In-Reply-To: <1364042295-16710-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1364042295-16710-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3dLDUC+o25y-ZBxFqMt53iCa_eKeJi9GOp0vCkhm27e6cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> The zynq includes a Cadence GEM IP core. This is compatible with the macb driver.
> Add it to the zynq-7000 DT.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 0dd2dc7..88564fa 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -54,6 +54,26 @@
>                         clocks = <&uart_clk 1>;
>                 };
>
> +               gem0: ethernet at e000b000 {
> +                       compatible = "cdns,gem";
> +                       reg = <0xe000b000 0x4000>;
> +                       status = "disabled";
> +                       interrupts = <0 22 4>;
> +                       clocks = <&gem0_clk 0>, <&gem0_clk 0>;
> +                       clock-names = "pclk", "hclk";
> +                       phy-mode = "rgmii";
> +               };
> +
> +               gem1: ethernet at e000c000 {
> +                       compatible = "cdns,gem";
> +                       reg = <0xe000c000 0x4000>;
> +                       status = "disabled";
> +                       interrupts = <0 45 4>;
> +                       clocks = <&gem1_clk 0>, <&gem1_clk 0>;
> +                       clock-names = "pclk", "hclk";
> +                       phy-mode = "rgmii";
> +               };
> +
>                 slcr: slcr at f8000000 {
>                         compatible = "xlnx,zynq-slcr";
>                         reg = <0xF8000000 0x1000>;
> @@ -89,6 +109,22 @@
>                                         reg = <0x108 0x118>;
>                                         clock-output-names = "iopll";
>                                 };
> +                               gem0_clk: gem0_clk {
> +                                       #clock-cells = <1>;
> +                                       compatible = "xlnx,zynq-periph-clock";
> +                                       clocks = <&iopll &armpll &ddrpll>;
> +                                       reg = <0x140>;
> +                                       clock-output-names = "gem0_ref_clk1",
> +                                                            "gem0_ref_clk2";
> +                               };
> +                               gem1_clk: gem1_clk {
> +                                       #clock-cells = <1>;
> +                                       compatible = "xlnx,zynq-periph-clock";
> +                                       clocks = <&iopll &armpll &ddrpll>;
> +                                       reg = <0x144>;
> +                                       clock-output-names = "gem1_ref_clk1",
> +                                                            "gem1_ref_clk2";
> +                               };

This is nice. Will look at it.
I have checked you have sent some macb related patches.
Do I need them to apply them to get this to work?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
