From: hjc@rock-chips.com (Sandy Huang)
Date: Mon, 9 Oct 2017 16:06:05 +0800
Subject: [PATCH v2 1/3] dt-bindings: Add document for rockchip RGB output
 interface
In-Reply-To: <20171003215631.rc2jsf2m3qgoltsb@rob-hp-laptop>
References: <1506049221-117283-1-git-send-email-hjc@rock-chips.com>
 <1506049229-117376-1-git-send-email-hjc@rock-chips.com>
 <20171003215631.rc2jsf2m3qgoltsb@rob-hp-laptop>
Message-ID: <2d502a9d-e952-8afb-d2d7-45c21c36da7e@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi rob,
     Thanks for your reply.

? 2017/10/4 5:56, Rob Herring ??:
> On Fri, Sep 22, 2017 at 11:00:26AM +0800, Sandy Huang wrote:
>> This path add support rv1108 rgb output interface driver.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>> Changes in v2:
>>   1. rename rockchip,rgb-mode to rgb-mode;
> 
> You can't just drop the vendor. This needs to be documented in a common
> place that others will find and use. See panel-common.txt or
> panel-dpi.txt.
> 
> Alternatively, you could just drop it and let the panel compatible imply
> what the mode is.
> 
> 
ok, get it, i will move the rgb-mode to panel and describe it at 
panel-rgb.txt. the patches will be send soon later.

>>   2. delete reg for signle endpoint;
>>
>>   .../bindings/display/rockchip/rockchip-rgb.txt     | 78 ++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> new file mode 100644
>> index 0000000..86bd1ce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> @@ -0,0 +1,78 @@
>> +Rockchip RV1108 RGB interface
>> +================================
>> +
>> +Required properties:
>> +- compatible: matching the soc type:
>> +	- "rockchip,rv1108-rgb";
>> +
>> +Optional properties:
>> +- pinctrl-names: must contain a "lcdc" entry.
>> +- pinctrl-0: pin control group to be used for this interface.
>> +
>> +Required nodes:
>> +- rgb-mode: should be "p888", "p666", "p565", "s888", "s888-dummy"
>> +	- p888: output r8-g8-b8 at each dclk cycle for per-pixel
>> +	- p666: output r6-g6-b6 at each dclk cycle for per-pixel
>> +	- p565: output r5-g6-b5 at each dclk cycle for per-pixel
>> +	- s888: output r8-g8-b8 in three dclk cycle for per-pixel
>> +	- s888-dmmy: output r8-g8-b8-dummy in four dclk cycle for per-pixel
>> +
>> +The rgb has two video ports described by:
>> +	Documentation/devicetree/bindings/media/video-interfaces.txt
>> +Their connections are modeled using the OF graph bindings specified in
>> +	Documentation/devicetree/bindings/graph.txt.
>> +
>> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
>> +- video port 1 for either a panel or subsequent encoder
>> +
>> +the panel described by:
>> +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
>> +Panel other required properties:
>> +- ports for remote rgb output.
>> +
>> +Example:
>> +
>> +panel: panel {
>> +	compatible = "auo,b101ean01";
>> +	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
>> +
>> +	ports {
>> +		panel_in_rgb: endpoint {
>> +			remote-endpoint = <&rgb_out_panel>;
>> +		};
>> +	};
>> +};
>> +
>> +For Rockchip RV1108:
>> +
>> +	rgb: rgb {
>> +		compatible = "rockchip,rv1108-rgb";
>> +		pinctrl-names = "lcdc";
>> +		pinctrl-0 = <&lcdc_ctl>;
>> +		rgb-mode = "p888";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			rgb_in: port at 0 {
>> +				reg = <0>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				rgb_in_vop: endpoint {
>> +					remote-endpoint = <&vop_out_rgb>;
>> +				};
>> +			};
>> +
>> +			rgb_out: port at 1 {
>> +				reg = <1>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				rgb_out_panel: endpoint {
>> +					remote-endpoint = <&panel_in_rgb>;
>> +				};
>> +			};
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
>>
> 
> 
> 
