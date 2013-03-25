From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Mar 2013 10:43:30 +0100
Subject: [PATCH 1/6] clk: sunxi: Add support for AXI, AHB, APB0 and APB1
 gates
In-Reply-To: <1363962042-29536-2-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <51501C42.70207@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

I have a few comments below,

Le 22/03/2013 15:20, Emilio L?pez a ?crit :
> This patchset adds DT support for all the AXI, AHB, APB0 and APB1
> gates present on sunxi SoCs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 108 +++++++++++++++++++++-
>  drivers/clk/sunxi/clk-sunxi.c                     |  90 +++++++++++++++++-
>  2 files changed, 196 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index b23cfbd..c5432c4 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -10,15 +10,23 @@ Required properties:
>  	"allwinner,sunxi-pll1-clk" - for the main PLL clock
>  	"allwinner,sunxi-cpu-clk" - for the CPU multiplexer clock
>  	"allwinner,sunxi-axi-clk" - for the sunxi AXI clock
> +	"allwinner,sunxi-axi-gates-clk" - for the AXI gates
>  	"allwinner,sunxi-ahb-clk" - for the sunxi AHB clock
> +	"allwinner,sunxi-ahb-gates-clk" - for the AHB gates
>  	"allwinner,sunxi-apb0-clk" - for the sunxi APB0 clock
> +	"allwinner,sunxi-apb0-gates-clk" - for the APB0 gates
>  	"allwinner,sunxi-apb1-clk" - for the sunxi APB1 clock
>  	"allwinner,sunxi-apb1-mux-clk" - for the sunxi APB1 clock muxing
> +	"allwinner,sunxi-apb1-gates-clk" - for the APB1 gates

It has been pointed to me that the usual way of dealing with compatible
IPs in several generation of SoC in device tree is usually to use the
oldest SoC name to support it, and not some generic term like we use.

I'm currently struggling while doing some work on the A31, where some
IPs differ in a significant way from the A10/A13, and we can't just use
sunxi anymore.

I have a patchset that renames every other IP we have doing this, but
could you rename your compatible strings to allwinner,sun4i* as a first
patch for the already existing clocks, and use that prefix in the
following patches as well? Moreover, since it has been mostly tested on
an A10, if the IP came to differ to some aspect in the A13, it will make
our life easier as well.

>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
>  - clocks : shall be the input parent clock(s) phandle for the clock
> -- #clock-cells : from common clock binding; shall be set to 0.
> +- #clock-cells : from common clock binding; shall be set to 0 except for
> +	"allwinner,sunxi-*-gates-clk" where it shall be set to 1
> +
> +Additionally, "allwinner,sunxi-*-gates-clk" clocks require:
> +- clock-output-names : the corresponding gate names that the clock controls
>  
>  For example:
>  
> @@ -42,3 +50,101 @@ cpu: cpu at 01c20054 {
>  	reg = <0x01c20054 0x4>;
>  	clocks = <&osc32k>, <&osc24M>, <&pll1>;
>  };
> +
> +
> +
> +Gate clock outputs
> +
> +The "allwinner,sunxi-*-gates-clk" clocks provide several gatable outputs;
> +their corresponding offsets are listed below:
> +
> +  * AXI gates ("allwinner,sunxi-axi-gates-clk")
> +
> +    DRAM                                                                0
> +
> +  * AHB gates ("allwinner,sunxi-ahb-gates-clk")
> +
> +    USB0                                                                0
> +    EHCI0                                                               1
> +    OHCI0                                                               2*
> +    EHCI1                                                               3
> +    OHCI1                                                               4*
> +    SS                                                                  5
> +    DMA                                                                 6
> +    BIST                                                                7
> +    MMC0                                                                8
> +    MMC1                                                                9
> +    MMC2                                                                10
> +    MMC3                                                                11
> +    MS                                                                  12**
> +    NAND                                                                13
> +    SDRAM                                                               14
> +
> +    ACE                                                                 16
> +    EMAC                                                                17

Hmmm, this makes me thinking that I used wemac in the pinctrl driver,
and that it's not really consistent with the datasheet, what you have
here, and what I did in the EMAC driver. I'll need to change that...

> +    TS                                                                  18
> +
> +    SPI0                                                                20
> +    SPI1                                                                21
> +    SPI2                                                                22
> +    SPI3                                                                23
> +    PATA                                                                24
> +    SATA                                                                25**
> +    GPS                                                                 26*
> +
> +    VE                                                                  32
> +    TVD                                                                 33
> +    TVE0                                                                34
> +    TVE1                                                                35
> +    LCD0                                                                36
> +    LCD1                                                                37
> +
> +    CSI0                                                                40
> +    CSI1                                                                41
> +
> +    HDMI                                                                43
> +    DE_BE0                                                              44
> +    DE_BE1                                                              45
> +    DE_FE0                                                              46
> +    DE_FE1                                                              47
> +
> +    MP                                                                  50
> +
> +    MALI400                                                             52
> +
> +  * APB0 gates ("allwinner,sunxi-apb0-gates-clk")
> +
> +    CODEC                                                               0
> +    SPDIF                                                               1*
> +    AC97                                                                2
> +    IIS                                                                 3
> +
> +    PIO                                                                 5
> +    IR0                                                                 6
> +    IR1                                                                 7
> +
> +    KEYPAD                                                              10
> +
> +  * APB1 gates ("allwinner,sunxi-apb1-gates-clk")
> +
> +    TWI0                                                                0
> +    TWI1                                                                1
> +    TWI2                                                                2

I'd rather see here I2C. I know that it's called TWI in the datasheet,
but the term I2C is more commonly used in the kernel.

> +    CAN                                                                 4
> +    SCR                                                                 5
> +    PS20                                                                6
> +    PS21                                                                7
> +
> +    UART0                                                               16
> +    UART1                                                               17
> +    UART2                                                               18
> +    UART3                                                               19
> +    UART4                                                               20
> +    UART5                                                               21
> +    UART6                                                               22
> +    UART7                                                               23
> +
> +Notation:
> + [*]:  The datasheet didn't mention these, but they are present on AW code
> + [**]: The datasheet had this marked as "NC" but they are used on AW code

I'm really happy with the general documentation, thanks for this.
However, all of this is true only for the A10, could you mention it
somewhere?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
