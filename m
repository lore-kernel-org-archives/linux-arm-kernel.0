From: hjc@rock-chips.com (Sandy Huang)
Date: Wed, 20 Sep 2017 09:51:30 +0800
Subject: [PATCH 1/3] dt-bindings: Add document for rockchip RGB output
 interface
In-Reply-To: <20170919144621.eledmglqgn7nf7zp@rob-hp-laptop>
References: <1505360594-196508-1-git-send-email-hjc@rock-chips.com>
 <1505360600-196567-1-git-send-email-hjc@rock-chips.com>
 <20170919144621.eledmglqgn7nf7zp@rob-hp-laptop>
Message-ID: <d631ff56-e3e6-688f-d9b6-a7101ce047d5@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi rob,
     thanks for you review.

? 2017/9/19 22:46, Rob Herring ??:
> On Thu, Sep 14, 2017 at 11:43:18AM +0800, Sandy Huang wrote:
>> This path add support rv1108 rgb output interface driver.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>>   .../bindings/display/rockchip/rockchip-rgb.txt     | 80 ++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> new file mode 100644
>> index 0000000..4164512
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>> @@ -0,0 +1,80 @@
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
>> +- rockchip,rgb-mode: should be "p888", "p666", "p565", "s888", "s888-dummy"
> 
> This should be a standard property. Any device with a parallel interface
> is going to need something like this.
> 
so, i need to move this property to panel? or just rename 
rockchip,rgb-mode to rgb-mode?

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
>> +		rockchip,rgb-mode = "p888";
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
>> +				rgb_in_vop: endpoint at 0 {
>> +					reg = <0>;
> 
> Don't need reg for a single endpoint.
> 
ok, this will be deleted at next version.
>> +					remote-endpoint = <&vop_out_rgb>;
>> +				};
>> +			};
>> +
>> +			rgb_out: port at 1 {
>> +				reg = <1>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				rgb_out_panel: endpoint at 0 {
>> +					reg = <0>;
> 
> ditto.
> 
ok, this will be deleted at next version.
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
