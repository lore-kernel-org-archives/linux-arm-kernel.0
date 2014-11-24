From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 24 Nov 2014 11:36:13 -0800
Subject: [PATCH]  tty: serial: msm_serial: document DT alias
In-Reply-To: <54667D13.2070105@gmail.com>
References: <54667D13.2070105@gmail.com>
Message-ID: <20141124193613.GA10106@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 02:07:15PM -0800, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
> 
> Update devicetree binding for msm_serial to reflect msm_serial_probe()
> getting line id (port number) from the serialN alias.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt |   15 +++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> Index: linux/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> ===================================================================
> --- linux.orig/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> +++ linux/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> @@ -27,27 +27,52 @@ Optional properties:
>  - dmas: Should contain dma specifiers for transmit and receive channels
>  - dma-names: Should contain "tx" for transmit and "rx" for receive channels
>  
> +Note: Aliases may be defined to ensure the correct ordering of the UARTs.
> +The alias serialN will result in the UART being assigned port N.  If any
> +serialN alias exists, then an alias must exist for each enabled UART.  The
> +serialN aliases should be in a .dts file instead of in a .dtsi file.
> +
>  Examples:
>  
> -A uartdm v1.4 device with dma capabilities.
> +- A uartdm v1.4 device with dma capabilities.
> +
> +	serial at f991e000 {
> +		compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +		reg = <0xf991e000 0x1000>;
> +		interrupts = <0 108 0x0>;
> +		clocks = <&blsp1_uart2_apps_cxc>, <&blsp1_ahb_cxc>;
> +		clock-names = "core", "iface";
> +		dmas = <&dma0 0>, <&dma0 1>;
> +		dma-names = "tx", "rx";
> +	};
> +
> +- A uartdm v1.3 device without dma capabilities and part of a GSBI complex.
> +
> +	serial at 19c40000 {
> +		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> +		reg = <0x19c40000 0x1000>,
> +		<0x19c00000 0x1000>;
> +		interrupts = <0 195 0x0>;
> +		clocks = <&gsbi5_uart_cxc>, <&gsbi5_ahb_cxc>;
> +		clock-names = "core", "iface";
> +	};
> +
> +- serialN alias.
> +
> +	aliases {
> +		serial0 = &uarta;
> +		serial1 = &uartc;
> +		serial2 = &uartb;
> +	};
> +
> +	uarta: serial at 12490000 {
> +		status = "ok";
> +	};
> +
> +	uartb: serial at 16340000 {
> +		status = "ok";
> +	};
>  
> -serial at f991e000 {
> -	compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> -	reg = <0xf991e000 0x1000>;
> -	interrupts = <0 108 0x0>;
> -	clocks = <&blsp1_uart2_apps_cxc>, <&blsp1_ahb_cxc>;
> -	clock-names = "core", "iface";
> -	dmas = <&dma0 0>, <&dma0 1>;
> -	dma-names = "tx", "rx";
> -};
> -
> -A uartdm v1.3 device without dma capabilities and part of a GSBI complex.
> -
> -serial at 19c40000 {
> -	compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> -	reg = <0x19c40000 0x1000>,
> -	      <0x19c00000 0x1000>;
> -	interrupts = <0 195 0x0>;
> -	clocks = <&gsbi5_uart_cxc>, <&gsbi5_ahb_cxc>;
> -	clock-names = "core", "iface";
> -};
> +	uartc: serial at 1a240000 {
> +		status = "ok";
> +	};

Git complained about a whitespace issue in this patch, which I fixed up
by hand.  Please be more careful...

thanks,

greg k-h
