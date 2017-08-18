From: hjc@rock-chips.com (Sandy Huang)
Date: Fri, 18 Aug 2017 16:08:50 +0800
Subject: [PATCH v5 1/3] dt-bindings: display: Add Document for Rockchip
 Soc LVDS
In-Reply-To: <20170817205622.s7ivkxu7uac5rnwa@rob-hp-laptop>
References: <1502768955-176510-1-git-send-email-hjc@rock-chips.com>
 <1502768961-176569-1-git-send-email-hjc@rock-chips.com>
 <20170817205622.s7ivkxu7uac5rnwa@rob-hp-laptop>
Message-ID: <fe1f87b8-a980-b036-6d3c-210ea0c6ed14@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

? 2017/8/18 4:56, Rob Herring ??:
> On Tue, Aug 15, 2017 at 11:49:19AM +0800, Sandy Huang wrote:
>> This patch add Document for Rockchip Soc RK3288 LVDS,
>> This based on the patches from Mark yao and Heiko Stuebner.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Signed-off-by: Mark yao <mark.yao@rock-chips.com>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> Changes according to Mark Yao reviews.
>>
>>   .../bindings/display/rockchip/rockchip-lvds.txt    | 105 +++++++++++++++++++++
>>   1 file changed, 105 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>> new file mode 100644
>> index 0000000..c153411
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>> @@ -0,0 +1,105 @@
>> +Rockchip RK3288 LVDS interface
>> +================================
>> +
>> +Required properties:
>> +- compatible: matching the soc type, one of
>> +	- "rockchip,rk3288-lvds";
>> +
>> +- reg: physical base address of the controller and length
>> +	of memory mapped region.
>> +- clocks: must include clock specifiers corresponding to entries in the
>> +	clock-names property.
>> +- clock-names: must contain "pclk_lvds"
>> +
>> +- avdd1v0-supply: regulator phandle for 1.0V analog power
>> +- avdd1v8-supply: regulator phandle for 1.8V analog power
>> +- avdd3v3-supply: regulator phandle for 3.3V analog power
>> +
>> +- rockchip,grf: phandle to the general register files syscon
>> +
>> +Optional properties:
>> +- pinctrl-names: must contain a "lcdc" entry.
>> +- pinctrl-0: pin control group to be used for this controller.
>> +
>> +Required nodes:
>> +
>> +The lvds has two video ports as described by
>> +	Documentation/devicetree/bindings/media/video-interfaces.txt.
>> +Their connections are modeled using the OF graph bindings specified in
>> +	Documentation/devicetree/bindings/graph.txt.
>> +
>> +- video port 0 for the VOP inputs
>> +- video port 1 for either a panel or subsequent encoder
>> +
>> +the lvds panel described by
>> +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
>> +
>> +Panel required properties:
>> +- rockchip,data-width : should be <18> or <24>;
>> +- rockchip,output: should be "rgb", "lvds" or "duallvds",
>> +	This describes the output face.
> 
> These either aren't needed or shouldn't be Rockchip specific. Probably
> the former because no one else has them so far.
> 
rockchip,data-width will be deleted and rockchip,output will moved to 
lvds at next version v6.

>> +- ports for remote LVDS output
>> +
>> +Panel optional properties:
>> +- rockchip,data-mapping: should be "vesa" or "jeida",
>> +	This describes how the color bits are laid out in the
>> +	serialized LVDS signal.
> 
> There's a common property for this.
> 
I willuse data-mapping instead of rockchip,data-mapping and 
rockchip,data-width at next version.

>> +Example:
>> +
>> +lvds_panel: lvds-panel {
>> +	status = "okay";
>> +	compatible = "simple-panel";
> 
> Not a valid compatible. simple-panel is more a driver, than a binding.
> 
This will be fixed next version v6;

>> +	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
>> +	rockchip,data-mapping = "jeida";
>> +	rockchip,data-width = <24>;
>> +	rockchip,output = "rgb";
>> +
>> +	ports {
>> +		panel_in_lvds: endpoint {
>> +			remote-endpoint = <&lvds_out_panel>;
>> +		};
>> +	};
>> +};
>> +
>> +For Rockchip RK3288:
>> +
>> +	lvds: lvds at ff96c000 {
>> +		compatible = "rockchip,rk3288-lvds";
>> +		rockchip,grf = <&grf>;
>> +		reg = <0xff96c000 0x4000>;
>> +		clocks = <&cru PCLK_LVDS_PHY>;
>> +		clock-names = "pclk_lvds";
>> +		pinctrl-names = "lcdc";
>> +		pinctrl-0 = <&lcdc_ctl>;
>> +		avdd1v0-supply = <&vdd10_lcd>;
>> +		avdd1v8-supply = <&vcc18_lcd>;
>> +		avdd3v3-supply = <&vcca_33>;
>> +		rockchip,data-mapping = "jeida";
>> +		rockchip,data-width = <24>;
>> +		rockchip,output = "rgb";
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			lvds_in: port at 0 {
>> +				reg = <0>;
>> +
>> +				lvds_in_vopb: endpoint at 0 {
>> +					reg = <0>;
>> +					remote-endpoint = <&vopb_out_lvds>;
>> +				};
>> +				lvds_in_vopl: endpoint at 1 {
>> +					reg = <1>;
>> +					remote-endpoint = <&vopl_out_lvds>;
>> +				};
>> +			};
>> +
>> +			lvds_out: port at 1 {
>> +				reg = <1>;
>> +
>> +				lvds_out_panel: endpoint {
>> +					remote-endpoint = <&panel_in>;
>> +				};
>> +			};
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 
