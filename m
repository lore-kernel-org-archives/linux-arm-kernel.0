From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 08:41:53 -0600
Subject: [PATCH v4 15/36] platform: add video-multiplexer subdevice driver
In-Reply-To: <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170227144153.g4jzzbrcb7oyddyj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:19:17PM -0800, Steve Longerbeam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> This driver can handle SoC internal and external video bus multiplexers,
> controlled either by register bit fields or by a GPIO. The subdevice
> passes through frame interval and mbus configuration of the active input
> to the output side.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> --
> 
> - fixed a cut&paste error in vidsw_remove(): v4l2_async_register_subdev()
>   should be unregister.
> 
> - added media_entity_cleanup() and v4l2_device_unregister_subdev()
>   to vidsw_remove().
> 
> - added missing MODULE_DEVICE_TABLE().
>   Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> - there was a line left over from a previous iteration that negated
>   the new way of determining the pad count just before it which
>   has been removed (num_pads = of_get_child_count(np)).
> 
> - Philipp Zabel has developed a set of patches that allow adding
>   to the subdev async notifier waiting list using a chaining method
>   from the async registered callbacks (v4l2_of_subdev_registered()
>   and the prep patches for that). For now, I've removed the use of
>   v4l2_of_subdev_registered() for the vidmux driver's registered
>   callback. This doesn't affect the functionality of this driver,
>   but allows for it to be merged now, before adding the chaining
>   support.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  .../bindings/media/video-multiplexer.txt           |  59 +++

Please make this a separate commit.

>  drivers/media/platform/Kconfig                     |   8 +
>  drivers/media/platform/Makefile                    |   2 +
>  drivers/media/platform/video-multiplexer.c         | 474 +++++++++++++++++++++
>  4 files changed, 543 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/video-multiplexer.txt
>  create mode 100644 drivers/media/platform/video-multiplexer.c
> 
> diff --git a/Documentation/devicetree/bindings/media/video-multiplexer.txt b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> new file mode 100644
> index 0000000..9d133d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> @@ -0,0 +1,59 @@
> +Video Multiplexer
> +=================
> +
> +Video multiplexers allow to select between multiple input ports. Video received
> +on the active input port is passed through to the output port. Muxes described
> +by this binding may be controlled by a syscon register bitfield or by a GPIO.
> +
> +Required properties:
> +- compatible : should be "video-multiplexer"
> +- reg: should be register base of the register containing the control bitfield
> +- bit-mask: bitmask of the control bitfield in the control register
> +- bit-shift: bit offset of the control bitfield in the control register
> +- gpios: alternatively to reg, bit-mask, and bit-shift, a single GPIO phandle
> +  may be given to switch between two inputs
> +- #address-cells: should be <1>
> +- #size-cells: should be <0>
> +- port@*: at least three port nodes containing endpoints connecting to the
> +  source and sink devices according to of_graph bindings. The last port is
> +  the output port, all others are inputs.
> +
> +Example:
> +
> +syscon {
> +	compatible = "syscon", "simple-mfd";
> +
> +	mux {
> +		compatible = "video-multiplexer";
> +		/* Single bit (1 << 19) in syscon register 0x04: */
> +		reg = <0x04>;
> +		bit-mask = <1>;
> +		bit-shift = <19>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 0 {
> +			reg = <0>;
> +
> +			mux_in0: endpoint {
> +				remote-endpoint = <&video_source0_out>;
> +			};
> +		};
> +
> +		port at 1 {
> +			reg = <1>;
> +
> +			mux_in1: endpoint {
> +				remote-endpoint = <&video_source1_out>;
> +			};
> +		};
> +
> +		port at 2 {
> +			reg = <2>;
> +
> +			mux_out: endpoint {
> +				remote-endpoint = <&capture_interface_in>;
> +			};
> +		};
> +	};
> +};
