From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Apr 2016 11:22:46 +0200
Subject: [PATCH 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <1460533460-32336-3-git-send-email-songjun.wu@atmel.com>
References: <1460533460-32336-1-git-send-email-songjun.wu@atmel.com>
 <1460533460-32336-3-git-send-email-songjun.wu@atmel.com>
Message-ID: <20160415092246.GC3544@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-media at vger.kernel.org

On Wed, Apr 13, 2016 at 03:44:20PM +0800, Songjun Wu wrote:
> DT binding documentation for ISC driver.
> 
> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
> ---
> 
>  .../devicetree/bindings/media/atmel-isc.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
> new file mode 100644
> index 0000000..449f05f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
> @@ -0,0 +1,84 @@
> +Atmel Image Sensor Controller (ISC)
> +----------------------------------------------
> +
> +Required properties:
> +- compatible
> +	Must be "atmel,sama5d2-isc"
> +- reg
> +	Physical base address and length of the registers set for the device;
> +- interrupts
> +  Should contain IRQ line for the ISI;
> +- clocks
> +	List of clock specifiers, corresponding to entries in
> +	the clock-names property;
> +	Please refer to clock-bindings.txt.
> +- clock-names
> +	Required elements: "hclock", "ispck".
> +- pinctrl-names, pinctrl-0
> +	Please refer to pinctrl-bindings.txt.
> +- clk_in_isc
> +	ISC internal clock node, it includes the isc_ispck and isc_mck.
> +	Please refer to clock-bindings.txt.
> +- atmel,sensor-preferred
> +	Sensor is preferred to process image (1-preferred, 0-not).
> +	The default value is 1.
> +
> +ISC supports a single port node with parallel bus. It should contain one
> +'port' child node with child 'endpoint' node. Please refer to the bindings
> +defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +Example:
> +isc: isc at f0008000 {
> +	compatible = "atmel,sama5d2-isc";
> +	reg = <0xf0008000 0x4000>;
> +	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
> +	clocks = <&isc_clk>, <&isc_ispck>;
> +	clock-names = "hclock", "ispck";
> +	atmel,sensor-preferred = <1>;
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		isc_0: endpoint at 0 {
> +			remote-endpoint = <&ov7740_0>;
> +			hsync-active = <1>;
> +			vsync-active = <0>;
> +			pclk-sample = <1>;
> +		};
> +	};
> +
> +	clk_in_isc {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		isc_ispck: isc_ispck {
> +			#clock-cells = <0>;
> +			reg = <0>;
> +			clocks = <&isc_clk>, <&iscck>;
> +		};
> +
> +		isc_mck: isc_mck {
> +			#clock-cells = <0>;
> +			reg = <1>;
> +			clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
> +		};
> +	};
> +};
> +
> +i2c1: i2c at fc028000 {
> +	ov7740: camera at 0x21 {
> +	compatible = "ovti,ov7740";
> +	reg = <0x21>;
> +
> +	clocks = <&isc_mck>;
> +	clock-names = "xvclk";
> +	assigned-clocks = <&isc_mck>;
> +	assigned-clock-rates = <24000000>;
> +
> +	port {
> +		ov7740_0: endpoint {
> +			remote-endpoint = <&isc_0>;
> +		};
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
