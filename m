From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Mar 2014 11:42:57 +0000
Subject: [PATCH v2 1/3] ata: ahci_st: Provide DT bindings for ST's SATA
 implementation
In-Reply-To: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140312114257.GA17461@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:41:19AM +0000, Lee Jones wrote:
> Cc: devicetree at vger.kernel.org
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-st.txt | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
> new file mode 100644
> index 0000000..1b69fa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STi SATA controller

Is that a family name or a particular device?

> +
> +This binding describes a SATA device.
> +
> +Required properties:
> + - compatible	   : Must be "st,ahci"

Is there not a more specific name? This is awfully generic.

> + - reg		   : Physical base addresses and length of register sets
> + - interrupts	   : Interrupt associated with the SATA device
> + - interrupt-names :   Associated name must be; "hostc"
> + - resets	   : The power-down and soft-reset lines of SATA IP
> + - reset-names	   :   Associated names must be; "pwr-dwn" and "sw-rst"

Get rid of the semicolon, it makes this harder to read. Same for the
other -names proeprties.

> + - clocks	   : The phandle for the clock
> + - clock-names	   :   Associated name must be; "ahci_clk"
> + - phys		   : The phandle for the PHY device
> + - phy-names	   :   Associated name must be; "ahci_phy"

This looks sane, but I'd like to see a more specific description and
compatible string.

Cheers,
Mark.

> +
> +Example:
> +
> +	sata0: sata at fe380000 {
> +		compatible      = "st,ahci";
> +		reg             = <0xfe380000 0x1000>;
> +		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
> +		interrupt-names = "hostc";
> +		phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
> +		phy-names       = "ahci_phy";
> +		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
> +				  <&softreset STIH416_SATA0_SOFTRESET>;
> +		reset-names     = "pwr-dwn", "sw-rst";
> +		clocks	        = <&CLK_S_ICN_REG_0>;
> +		clock-names     = "ahci_clk";
> +	};
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
