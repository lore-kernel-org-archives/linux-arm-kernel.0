From: robh@kernel.org (Rob Herring)
Date: Thu, 23 Mar 2017 21:06:30 -0500
Subject: [PATCH] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <1489569810-24350-1-git-send-email-gabriel.fernandez@st.com>
References: <1489569810-24350-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170324020630.vhffmeeb6wto53zx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 10:23:30AM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch enables clocks for STM32H743 boards.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |  152 ++
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-stm32h7.c                          | 1586 ++++++++++++++++++++
>  include/dt-bindings/clock/stm32h7-clks.h           |  165 ++
>  include/dt-bindings/mfd/stm32h7-rcc.h              |  138 ++
>  5 files changed, 2042 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>  create mode 100644 drivers/clk/clk-stm32h7.c
>  create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
>  create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
> new file mode 100644
> index 0000000..9d4b587
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
> @@ -0,0 +1,152 @@
> +STMicroelectronics STM32H7 Reset and Clock Controller
> +=====================================================
> +
> +The RCC IP is both a reset and a clock controller.
> +
> +Please refer to clock-bindings.txt for common clock controller binding usage.
> +Please also refer to reset.txt for common reset controller binding usage.
> +
> +Required properties:
> +- compatible: Should be:
> +  "st,stm32h743-rcc"
> +
> +- reg: should be register base and length as documented in the
> +  datasheet
> +
> +- #reset-cells: 1, see below
> +
> +- #clock-cells : from common clock binding; shall be set to 1
> +
> +- clocks: External oscillator clock phandle
> +  - high speed external clock signal (HSE)
> +  - low speed external clock signal (LSE)
> +  - external I2S clock (I2S_CKIN)
> +
> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
> +  write protection (RTC clock).
> +
> +- pll x node: Allow to register a pll with specific parameters.
> +  Please see PLL section below.
> +
> +Example:
> +
> +	rcc: rcc at 58024400 {
> +		#reset-cells = <1>;
> +		#clock-cells = <2>
> +		compatible = "st,stm32h743-rcc", "st,stm32-rcc";
> +		reg = <0x58024400 0x400>;
> +		clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s_ckin>;
> +
> +		st,syscfg = <&pwrcfg>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vco1 at 58024430 {
> +			#clock-cells = <0>;
> +			compatible = "stm32,pll";
> +			reg = <0>;

The reg addr value and unit address don't match.

> +		};
> +
> +		vco2 at 58024438 {
> +			#clock-cells = <0>;
> +			compatible = "stm32,pll";
> +			reg = <1>;
> +			st,clock-div = <2>;
> +			st,clock-mult = <40>;
> +			st,frac-status = <0>;
> +			st,frac = <0>;
> +			st,vcosel = <1>;
> +			st,pllrge = <2>;
> +		};
> +	};
> +
> +
> +STM32H7 PLL
> +-----------
> +
> +The VCO of STM32 PLL could be reprensented like this:
> +
> +  Vref    ---------       --------
> +    ---->| / DIVM  |---->| x DIVN | ------> VCO
> +          ---------       --------
> +		             ^
> +			     |
> +	                  -------
> +		         | FRACN |
> +		          -------
> +
> +When the PLL is configured in integer mode:
> +- VCO = ( Vref / DIVM ) * DIVN
> +
> +When the PLL is configured in fractional mode:
> +- VCO = ( Vref / DIVM ) * ( DIVN + FRACN / 2^13)
> +
> +
> +Required properties for pll node:
> +- compatible: Should be:
> +  "stm32,pll"

Only 1 single PLL design for all STM32 chips ever?

> +
> +- #clock-cells: from common clock binding; shall be set to 0
> +- reg: Should be the pll number.
> +
> +Optional properties:
> +- st,clock-div:  DIVM division factor       : <1..63>
> +- st,clock-mult: DIVN multiplication factor : <4..512>
> +
> +- st,frac-status:
> +   - 0 Pll is configured in integer mode
> +   - 1 Pll is configure in fractional mode

Isn't this implied by the presence of the next property?

> +
> +- st,frac: Fractional part of the multiplication factor : <0..8191>
> +
> +- st,vcosel: VCO selection
> +  - 0: Wide VCO range:192 to 836 MHz
> +  - 1: Medium VCO range:150 to 420 MHz
> +
> +- st,pllrge: PLL input frequency range
> +  - 0: The PLL input (Vref / DIVM) clock range frequency is between 1 and 2 MHz
> +  - 1: The PLL input (Vref / DIVM) clock range frequency is between 2 and 4 MHz
> +  - 2: The PLL input (Vref / DIVM) clock range frequency is between 4 and 8 MHz
> +  - 3: The PLL input (Vref / DIVM) clock range frequency is between 8 and 16 MHz

Seems like you could figure this out based on the input freq and other 
properties.

> +
> +
> +The peripheral clock consumer should specify the desired clock by
> +having the clock ID in its "clocks" phandle cell.
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/stm32h7-clks.h header and can be used in device
> +tree sources.
> +
> +Example:
> +
> +		timer5: timer at 40000c00 {
> +			compatible = "st,stm32-timer";
> +			reg = <0x40000c00 0x400>;
> +			interrupts = <50>;
> +			clocks = <&rcc TIM5_CK>;
> +
> +		};
> +
> +Specifying softreset control of devices
> +=======================================
> +
> +Device nodes should specify the reset channel required in their "resets"
> +property, containing a phandle to the reset device node and an index specifying
> +which channel to use.
> +The index is the bit number within the RCC registers bank, starting from RCC
> +base address.
> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
> +Where bit_offset is the bit offset within the register.
> +
> +For example, for CRC reset:
> +  crc = AHB4RSTR_offset / 4 * 32 + CRCRST_bit_offset = 0x88 / 4 * 32 + 19 = 1107
> +
> +All available preprocessor macros for reset are defined dt-bindings//mfd/stm32h7-rcc.h
> +header and can be used in device tree sources.
> +
> +example:
> +
> +	timer2 {
> +		resets	= <&rcc STM32H7_APB1L_RESET(TIM2)>;
> +	};
