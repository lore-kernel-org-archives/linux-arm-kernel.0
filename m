From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Tue, 28 Aug 2018 10:31:15 +0200
Subject: [PATCH v5 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
In-Reply-To: <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
 <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
Message-ID: <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.8.2018 10:12, Sandy Huang wrote:
> This path add support rv1108 and px30 rgb output interface driver.

Hi Sandy,
Seems like you forgot to address Rob's comment regarding the "driver" word.
Also fix the typo: s/path/patch
The subject could be improved as well: s/devicetree\/bindings/dt-bindings

Best regards, Michal
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc at rock-chips.com
> ---
>   .../bindings/display/rockchip/rockchip-rgb.txt     | 70 ++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> new file mode 100644
> index 0000000..1f4909c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> @@ -0,0 +1,70 @@
> +Rockchip RV1108 RGB interface
> +================================
> +
> +Required properties:
> +- compatible: matching the soc type:
> +	- "rockchip,px30-rgb";
> +	- "rockchip,rv1108-rgb";
> +
> +Optional properties:
> +- pinctrl-names: should be a "lcdc" entry or a "default" entry.
> +- pinctrl-0: pin control group to be used for this interface.
> +
> +The rgb has two video ports described by:
> +	Documentation/devicetree/bindings/media/video-interfaces.txt
> +Their connections are modeled using the OF graph bindings specified in
> +	Documentation/devicetree/bindings/graph.txt.
> +
> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
> +- video port 1 for either a panel or subsequent encoder
> +
> +the panel described by:
> +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +Panel other required properties:
> +- ports for remote rgb output.
> +
> +Example:
> +
> +panel: panel {
> +	compatible = "auo,b101ean01";
> +	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
> +
> +	ports {
> +		panel_in_rgb: endpoint {
> +			remote-endpoint = <&rgb_out_panel>;
> +		};
> +	};
> +};
> +
> +For Rockchip RV1108:
> +
> +	rgb: rgb {
> +		compatible = "rockchip,rv1108-rgb";
> +		pinctrl-names = "lcdc";
> +		pinctrl-0 = <&lcdc_ctl>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgb_in: port at 0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				rgb_in_vop: endpoint {
> +					remote-endpoint = <&vop_out_rgb>;
> +				};
> +			};
> +
> +			rgb_out: port at 1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				rgb_out_panel: endpoint {
> +					remote-endpoint = <&panel_in_rgb>;
> +				};
> +			};
> +		};
> +	};
> 
