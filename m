From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 15 Nov 2016 11:43:14 +0100
Subject: [PATCH] reset: hisilicon: add a polarity cell for reset line
 specifier
In-Reply-To: <1479193794-18350-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1479193794-18350-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1479206594.2456.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiancheng,

Am Dienstag, den 15.11.2016, 15:09 +0800 schrieb Jiancheng Xue:
> Add a polarity cell for reset line specifier. If the reset line
> is asserted when the register bit is 1, the polarity is
> normal. Otherwise, it is inverted.
>
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> ---
>  .../devicetree/bindings/clock/hisi-crg.txt         | 11 ++++---
>  arch/arm/boot/dts/hi3519.dtsi                      |  2 +-
>  drivers/clk/hisilicon/reset.c                      | 36 ++++++++++++++++------
>  3 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
> index e3919b6..fcbb4f3 100644
> --- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
> +++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
> @@ -25,19 +25,20 @@ to specify the clock which they consume.
>  
>  All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
>  
> -- #reset-cells: should be 2.
> +- #reset-cells: should be 3.
>  
>  A reset signal can be controlled by writing a bit register in the CRG module.
> -The reset specifier consists of two cells. The first cell represents the
> +The reset specifier consists of three cells. The first cell represents the
>  register offset relative to the base address. The second cell represents the
> -bit index in the register.
> +bit index in the register. The third cell represents the polarity of the reset
> +line (0 for normal, 1 for inverted).

What is normal and what is inverted? Please specify which is active-high
and which is active-low.

>  
>  Example: CRG nodes
>  CRG: clock-reset-controller at 12010000 {
>  	compatible = "hisilicon,hi3519-crg";
>  	reg = <0x12010000 0x10000>;
>  	#clock-cells = <1>;
> -	#reset-cells = <2>;
> +	#reset-cells = <3>;
>  };
>  
>  Example: consumer nodes
> @@ -45,5 +46,5 @@ i2c0: i2c at 12110000 {
>  	compatible = "hisilicon,hi3519-i2c";
>  	reg = <0x12110000 0x1000>;
>  	clocks = <&CRG HI3519_I2C0_RST>;
> -	resets = <&CRG 0xe4 0>;
> +	resets = <&CRG 0xe4 0 0>;
>  };
> diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
> index 5729ecf..b7cb182 100644
> --- a/arch/arm/boot/dts/hi3519.dtsi
> +++ b/arch/arm/boot/dts/hi3519.dtsi
> @@ -50,7 +50,7 @@
>  	crg: clock-reset-controller at 12010000 {
>  		compatible = "hisilicon,hi3519-crg";
>  		#clock-cells = <1>;
> -		#reset-cells = <2>;
> +		#reset-cells = <3>;

That is a backwards incompatible change. Which I think in this case
could be tolerated, because there are no users yet of the reset
controller. Or are there any hi3519 based device trees that use the
resets out in the wild? If there are, the driver must continue to
support old device trees with two reset-cells. Which would not be
trivial because currently the core checks in reset_control_get that
rcdev->of_n_reset_cells is equal to the #reset-cells value from DT.
One possibility to get around changing the binding would be to stuff the
polarity bit into low bits of the register address cell.

Either way, I'm not very happy with blowing up the complexity of the
reset phandles at the reset consumer side.
If you do change the binding, is there any way you could change from a
register address + bit offset binding to an index based binding with the
information about reset bit positions and polarities contained in the
driver, or in the crg node, similarly to the ti-syscon-reset bindings?
That would also improve consistency with clock bindings, which already
use a number as identifier.

[...]
> @@ -59,14 +65,19 @@ static int hisi_reset_assert(struct reset_controller_dev *rcdev,
>  	unsigned long flags;
>  	u32 offset, reg;
>  	u8 bit;
> +	bool polarity;
>  
>  	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
> -	bit = id & HISI_RESET_BIT_MASK;
> +	bit = (id & HISI_RESET_BIT_MASK) >> HISI_RESET_BIT_SHIFT;
> +	polarity = id & HISI_RESET_POLARITY_MASK;
>  
>  	spin_lock_irqsave(&rstc->lock, flags);
>  
>  	reg = readl(rstc->membase + offset);
> -	writel(reg | BIT(bit), rstc->membase + offset);
> +	if (polarity)
> +		writel(reg & ~BIT(bit), rstc->membase + offset);
> +	else
> +		writel(reg | BIT(bit), rstc->membase + offset);

So there is no hardware polarity setting, which means the
ti-syscon-reset bindings could fit in this case.

regards
Philipp
