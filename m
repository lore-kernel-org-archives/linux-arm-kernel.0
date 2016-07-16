From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 17:43:31 -0500
Subject: [PATCH v3 1/2] ASoC: atmel-i2s: add DT bindings for I2S controller
In-Reply-To: <901eec0b7edfa488ff735e7057fbc25ea8dc59f7.1468405019.git.cyrille.pitchen@atmel.com>
References: <cover.1468405019.git.cyrille.pitchen@atmel.com>
 <901eec0b7edfa488ff735e7057fbc25ea8dc59f7.1468405019.git.cyrille.pitchen@atmel.com>
Message-ID: <20160716224331.GA19101@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 12:25:38PM +0200, Cyrille Pitchen wrote:
> This patch adds DT bindings for the new Atmel I2S controller embedded
> inside sama5d2x SoCs.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  .../devicetree/bindings/sound/atmel-i2s.txt        | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
> new file mode 100644
> index 000000000000..25dcb32314bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
> @@ -0,0 +1,87 @@
> +* Atmel I2S controller
> +
> +Required properties:
> +- compatible:     Should be "atmel,sama5d2-i2s".
> +- reg:            Should be the physical base address of the controller and the
> +                  length of memory mapped region.
> +- interrupts:     Should contain the interrupt for the controller.
> +- dmas:           Should be a list of pairs of DMA controller phandle and flags.

How many?

> +- dma-names:      Should be a list of DMA channel name among "rx", "tx" or
> +                  "rx-tx".

When is rx-tx used? Seems like there may need to be more than 1 
compatible string if there is variation here.

> +- clocks:         Should be a list of phandles of clocks used by the controller
> +                  (1).

This should be a specific number for each compatible string.

> +- clock-names:    Should be a list matching the clocks phandles list:
> +                  - "pclk" (peripheral clock) Required.
> +                  - "gclk" (generated clock) Optional (1).
> +                  - "aclk" (Audio PLL clock) Optional (1).
> +
> +Optional properties:
> +- pinctrl-0:      Should specify pin control groups used for this controller.
> +- princtrl-names: Should contain only one value - "default".
> +
> +
> +(1) : Only the peripheral clock is required. The generated clock and the Audio
> +      PLL clock are optional and should only be set together.
> +
> +Example:
> +
> +	i2s at f8050000 {
> +		compatible = "atmel,sama5d2-i2s";
> +		reg = <0xf8050000 0x300>;
> +		interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
> +		dmas = <&dma0
> +			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +			 AT91_XDMAC_DT_PERID(31))>,
> +		       <&dma0
> +			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +			 AT91_XDMAC_DT_PERID(32))>;
> +		dma-names = "tx", "rx";
> +		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>;
> +		clock-names = "pclk", "gclk", "aclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2s0_default>;
> +	};
> +
> +
> +sama5d2 SoCs only:

That's the only SoC documented here...

> +
> +When the I2S controller is configured as a master, it generates the master,
> +bitrate and frame clocks from a PMC input clock. This PMC input clock can be
> +either the I2S peripheral clock or the I2S generated clock.
> +The generated clock can reach higher frequencies and is more suited for audio
> +applications hence should be preferred to the peripheral clock.
> +The I2SCLKSEL register of the Special Function Register (SFR) is used to select
> +the relevant PMC input clock: bit0 selects the input clock for I2S controller 0
> +whereas bit1 selects the input clock for I2S controller 1.

This seems like all internal details of the block.

> +Aliases are used in the device-tree to retrieve the index of each I2S controller
> +so the right bit can be updated in the I2SCLKSEL register.

I'd prefer aliases not be used for this.

> +
> +Finally, the SFR itself is handled by the generic syscon driver.
> +Its "compatible" DT property must contain the "atmel,sama5d2-sfr" string so the
> +I2S controller driver (and likely other drivers) can find the SFR node when
> +needed.

Typically we would have a phandle to the syscon with a cell to give the 
bit position.

If this is all just for clock control, then it seems like you need a 
proper clock driver for this clock control bit.

Rob
