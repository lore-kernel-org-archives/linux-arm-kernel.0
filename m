From: hjc@rock-chips.com (Sandy Huang)
Date: Fri, 1 Sep 2017 14:49:16 +0800
Subject: [PATCH v7 1/3] dt-bindings: display: Add Document for Rockchip
 Soc LVDS
In-Reply-To: <150421032.ptNih2SRiG@phil>
References: <1503469615-39406-1-git-send-email-hjc@rock-chips.com>
 <1503469622-39462-1-git-send-email-hjc@rock-chips.com>
 <59A53F27.2010308@rock-chips.com> <150421032.ptNih2SRiG@phil>
Message-ID: <8578950f-74a9-6fa7-5530-70f4b41a5a8f@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heiko,

? 2017/8/29 18:29, Heiko Stuebner ??:
> Am Dienstag, 29. August 2017, 18:17:11 CEST schrieb Mark yao:
>> On 2017?08?23? 14:26, Sandy Huang wrote:
>>> This patch add Document for Rockchip Soc RK3288 LVDS,
>>> This based on the patches from Mark yao and Heiko Stuebner.
>>>
>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>> Signed-off-by: Mark yao <mark.yao@rock-chips.com>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>> Looks good for me:
>>
>> Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
> 
> Signed-off ordering is wrong though ... you add a Signed-off below
> all others and you could also drop the one from me, as I don't
> think I did provide to much value between Mark's and Sandy's variant
> of the patches :-)
> 
> 
> Heiko
> 
> 
I will change the Singed off order as bellow at next version.

Signed-off-by: Mark yao <mark.yao@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sandy Huang <hjc@rock-chips.com>

>>> Changes according to Rob Herring's review.
>>>
>>>    .../bindings/display/rockchip/rockchip-lvds.txt    | 99 ++++++++++++++++++++++
>>>    1 file changed, 99 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>> new file mode 100644
>>> index 0000000..da6939e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>> @@ -0,0 +1,99 @@
>>> +Rockchip RK3288 LVDS interface
>>> +================================
>>> +
>>> +Required properties:
>>> +- compatible: matching the soc type, one of
>>> +	- "rockchip,rk3288-lvds";
>>> +
>>> +- reg: physical base address of the controller and length
>>> +	of memory mapped region.
>>> +- clocks: must include clock specifiers corresponding to entries in the
>>> +	clock-names property.
>>> +- clock-names: must contain "pclk_lvds"
>>> +
>>> +- avdd1v0-supply: regulator phandle for 1.0V analog power
>>> +- avdd1v8-supply: regulator phandle for 1.8V analog power
>>> +- avdd3v3-supply: regulator phandle for 3.3V analog power
>>> +
>>> +- rockchip,grf: phandle to the general register files syscon
>>> +- rockchip,output: "rgb", "lvds" or "duallvds", This describes the output interface
>>> +
>>> +Optional properties:
>>> +- pinctrl-names: must contain a "lcdc" entry.
>>> +- pinctrl-0: pin control group to be used for this controller.
>>> +
>>> +Required nodes:
>>> +
>>> +The lvds has two video ports as described by
>>> +	Documentation/devicetree/bindings/media/video-interfaces.txt
>>> +Their connections are modeled using the OF graph bindings specified in
>>> +	Documentation/devicetree/bindings/graph.txt.
>>> +
>>> +- video port 0 for the VOP input, the remote endpoint maybe vopb or vopl
>>> +- video port 1 for either a panel or subsequent encoder
>>> +
>>> +the lvds panel described by
>>> +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
>>> +
>>> +Panel required properties:
>>> +- ports for remote LVDS output
>>> +
>>> +Panel optional properties:
>>> +- data-mapping: should be "vesa-24","jeida-24" or "jeida-18".
>>> +This describes decribed by:
>>> +	Documentation/devicetree/bindings/display/panel/panel-lvds.txt
>>> +
>>> +Example:
>>> +
>>> +lvds_panel: lvds-panel {
>>> +	compatible = "auo,b101ean01";
>>> +	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
>>> +	data-mapping = "jeida-24";
>>> +
>>> +	ports {
>>> +		panel_in_lvds: endpoint {
>>> +			remote-endpoint = <&lvds_out_panel>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +For Rockchip RK3288:
>>> +
>>> +	lvds: lvds at ff96c000 {
>>> +		compatible = "rockchip,rk3288-lvds";
>>> +		rockchip,grf = <&grf>;
>>> +		reg = <0xff96c000 0x4000>;
>>> +		clocks = <&cru PCLK_LVDS_PHY>;
>>> +		clock-names = "pclk_lvds";
>>> +		pinctrl-names = "lcdc";
>>> +		pinctrl-0 = <&lcdc_ctl>;
>>> +		avdd1v0-supply = <&vdd10_lcd>;
>>> +		avdd1v8-supply = <&vcc18_lcd>;
>>> +		avdd3v3-supply = <&vcca_33>;
>>> +		rockchip,output = "rgb";
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			lvds_in: port at 0 {
>>> +				reg = <0>;
>>> +
>>> +				lvds_in_vopb: endpoint at 0 {
>>> +					reg = <0>;
>>> +					remote-endpoint = <&vopb_out_lvds>;
>>> +				};
>>> +				lvds_in_vopl: endpoint at 1 {
>>> +					reg = <1>;
>>> +					remote-endpoint = <&vopl_out_lvds>;
>>> +				};
>>> +			};
>>> +
>>> +			lvds_out: port at 1 {
>>> +				reg = <1>;
>>> +
>>> +				lvds_out_panel: endpoint {
>>> +					remote-endpoint = <&panel_in_lvds>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>
>>
>>
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
