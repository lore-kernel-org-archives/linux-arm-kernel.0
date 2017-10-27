From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 27 Oct 2017 13:59:39 +0300
Subject: [PATCH v2 2/2] media: ov7740: Document device tree bindings
In-Reply-To: <20171027074220.23839-3-wenyou.yang@microchip.com>
References: <20171027074220.23839-1-wenyou.yang@microchip.com>
 <20171027074220.23839-3-wenyou.yang@microchip.com>
Message-ID: <20171027105939.2rxfjfqezexcatc5@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

On Fri, Oct 27, 2017 at 03:42:20PM +0800, Wenyou Yang wrote:
> Add the device tree binding documentation for ov7740 driver and
> add a new entry of ov7740 to the MAINTAINERS file.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
> Changes in v2:
>  - Split off the bindings into a separate patch.
>  - Add a new entry to the MAINTAINERS file.
> 
>  .../devicetree/bindings/media/i2c/ov7740.txt       | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 ++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov7740.txt b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
> new file mode 100644
> index 000000000000..b306e5aa97bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
> @@ -0,0 +1,43 @@
> +* Omnivision OV7740 CMOS image sensor
> +
> +The Omnivision OV7740 image sensor supports multiple output image
> +size, such as VGA, and QVGA, CIF and any size smaller. It also
> +supports the RAW RGB and YUV output formats.
> +
> +Required Properties:
> +- compatible: should be "ovti,ov7740"
> +- clocks: reference to the xvclk input clock.
> +- clock-names: should be "xvclk".
> +
> +Optional Properties:
> +- reset-gpios: reference to the GPIO connected to the reset_b pin,
> +  if any. Active low with pull-ip resistor.
> +- powerdown-gpios: reference to the GPIO connected to the pwdn pin,
> +  if any. Active high with pull-down resistor.
> +
> +The device node must contain one 'port' child node for its digital
> +output video port, in accordance with the video interface bindings
> +defined in Documentation/devicetree/bindings/media/video-interfaces.txt.

Could you add there's a single endpoint node as well, and explicitly
document the relevant properties? E.g. as in
Documentation/devicetree/bindings/media/i2c/nokia,smia.txt .

> +
> +Example:
> +
> +	i2c1: i2c at fc028000 {
> +		ov7740: camera at 21 {
> +			compatible = "ovti,ov7740";
> +			reg = <0x21>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_sensor_power &pinctrl_sensor_reset>;
> +			clocks = <&isc>;
> +			clock-names = "xvclk";
> +			assigned-clocks = <&isc>;
> +			assigned-clock-rates = <24000000>;
> +			reset-gpios = <&pioA 43 GPIO_ACTIVE_LOW>;
> +			powerdown-gpios = <&pioA 44 GPIO_ACTIVE_HIGH>;
> +
> +			port {
> +				ov7740_0: endpoint {
> +					remote-endpoint = <&isc_0>;
> +				};
> +			};
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90230fe020f3..f0f3f121d1d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9965,6 +9965,14 @@ S:	Maintained
>  F:	drivers/media/i2c/ov7670.c
>  F:	Documentation/devicetree/bindings/media/i2c/ov7670.txt
>  
> +OMNIVISION OV7740 SENSOR DRIVER
> +M:	Wenyou Yang <wenyou.yang@microchip.com>
> +L:	linux-media at vger.kernel.org
> +T:	git git://linuxtv.org/media_tree.git
> +S:	Maintained
> +F:	drivers/media/i2c/ov7740.c
> +F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
> +
>  ONENAND FLASH DRIVER
>  M:	Kyungmin Park <kyungmin.park@samsung.com>
>  L:	linux-mtd at lists.infradead.org

Please put the MAINTAINERS change to the driver patch after the DT binding
patch.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
