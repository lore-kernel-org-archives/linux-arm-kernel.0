From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 14:45:32 -0600
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <1380623952-4252-2-git-send-email-maxime.coquelin@st.com>
References: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
 <1380623952-4252-2-git-send-email-maxime.coquelin@st.com>
Message-ID: <524B346C.8070607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 04:39 AM, Maxime COQUELIN wrote:
> This patch adds support to SSC (Synchronous Serial Controller)
> I2C driver. This IP also supports SPI protocol, but this is not
> the aim of this driver.
> 
> This IP is embedded in all ST SoCs for Set-top box platorms, and
> supports I2C Standard and Fast modes.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt

> +Required properties :

> +- clocks : phandle to the I2C clock source
> +- clock-names : from common clock binding: Shall be "ssc"

I'd prefer to define that as:

clock-names: Must contain "ssc".
clocks: Must contain an entry for each name in clock-names. See the
common clock bindings.

That way, it makes it clear that clock-names is the primary lookup
mechanism, rather than some auxiliary documentation.

> +Recommended properties :
> +- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise

s/Otherwise/If not specified,/

> +  the default 100 kHz frequency will be used. As only Normal and Fast modes
> +  are supported, possible values are 100000 and 400000.

I think that's just optional. Since there's a well-defined sensible
default, there's no need to recommend it.

> +Optional properties :
> +- i2c-min-scl-pulse-width-us : The minimum valid SCL pulse width that is allowed
> +  through the deglitch circuit. In units of us.
> +- i2c-min-sda-pulse-width-us : The minimum valid SDA pulse width that is allowed
> +  through the deglitch circuit. In units of us.

Are those properties specific to this binding, or intended to be
generic? If specific to this binding, a vendor prefix should be present
in the property name. If not, you probably want to document the
properties in some common file.

> +Examples :

s/Examples/Example/ since there's just one.

> +i2c0: i2c at fed40000 {
> +	compatible	= "st,comms-ssc-i2c";
> +	reg		= <0xfed40000 0x110>;
> +	interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +	clocks		= <&CLK_S_ICN_REG_0>;
> +	clock-names	= "ssc";
> +	clock-frequency = <400000>;
> +	pinctrl-names	= "default";
> +	pinctrl-0	= <&pinctrl_i2c0_default>;

That wasn't mentioned in the binding definition. You'd probably want to
document the requirement for those two properties by saying something like:

A pinctrl state named "default" must be defined, using the bindings in
../pinctrl/pinctrl-binding.txt.
