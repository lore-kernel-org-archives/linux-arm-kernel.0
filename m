From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 28 Oct 2013 14:25:04 -0500
Subject: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
Message-ID: <40E3A029-C7E8-41DA-9218-3FB7ED97B707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 14, 2013, at 7:46 AM, Maxime COQUELIN wrote:

> This patch adds support to SSC (Synchronous Serial Controller)
> I2C driver. This IP also supports SPI protocol, but this is not
> the aim of this driver.
> 
> This IP is embedded in all ST SoCs for Set-top box platorms, and
> supports I2C Standard and Fast modes.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
> Documentation/devicetree/bindings/i2c/i2c-st.txt |   38 +
> drivers/i2c/busses/Kconfig                       |   10 +
> drivers/i2c/busses/Makefile                      |    1 +
> drivers/i2c/busses/i2c-st.c                      |  867 ++++++++++++++++++++++
> 4 files changed, 916 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
> create mode 100644 drivers/i2c/busses/i2c-st.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt
> new file mode 100644
> index 0000000..8b2fd0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-st.txt
> @@ -0,0 +1,38 @@
> +ST SSC binding, for I2C mode operation
> +
> +Required properties :
> +- compatible : Must be "st,comms-i2c"
> +- reg : Offset and length of the register set for the device
> +- interrupts : the interrupt specifier
> +- clock-names: Must contain "ssc".
> +- clocks: Must contain an entry for each name in clock-names. See the common
> +  clock bindings.
> +- A pinctrl state named "default" must be defined, using the bindings in
> +  ../pinctrl/pinctrl-binding.txt
> +
> +Optional properties :
> +- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
> +  the default 100 kHz frequency will be used. As only Normal and Fast modes
> +  are supported, possible values are 100000 and 400000.
> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width that is
> +  allowed through the deglitch circuit. In units of us.
> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width that is
> +  allowed through the deglitch circuit. In units of us.

i2c-min... should be vendor prefixed, st,i2c-min...

> +- A pinctrl state named "sleep" could be defined, using the bindings in
> +  ../pinctrl/pinctrl-binding.txt

I don't see any reference to "sleep" in pinctrl-binding.txt

> +
> +
> +Example :
> +
> +i2c0: i2c at fed40000 {
> +	compatible	= "st,comms-ssc-i2c";
> +	reg		= <0xfed40000 0x110>;
> +	interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +	clocks		= <&CLK_S_ICN_REG_0>;
> +	clock-names	= "ssc";
> +	clock-frequency = <400000>;
> +	pinctrl-names	= "default";
> +	pinctrl-0	= <&pinctrl_i2c0_default>;
> +	i2c-min-scl-pulse-width-us = <0>;
> +	i2c-min-sda-pulse-width-us = <5>;
> +};

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
