From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 2 Nov 2015 08:41:12 +0800
Subject: [PATCH v10 09/17] dt-bindings: add document for rockchip variant
 of analogix_dp
In-Reply-To: <CAL_Jsq+Z0RSgB1aBg+x4Ez7zXAjyyn6BkOuua=3JeqpKR=v+Lg@mail.gmail.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446273737-15262-1-git-send-email-ykk@rock-chips.com>
 <CAL_Jsq+Z0RSgB1aBg+x4Ez7zXAjyyn6BkOuua=3JeqpKR=v+Lg@mail.gmail.com>
Message-ID: <5636B128.2060501@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2015 02:37 AM, Rob Herring wrote:
> On Sat, Oct 31, 2015 at 1:42 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>> Rockchip DP driver is a helper driver of analogix_dp coder driver,
>> so most of the DT property should be descriped in analogix_dp document.
>>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
Thanks,

- Yakir
>> ---
>> Changes in v10:
>> - Removed the duplicated signed-of.
>>
>> Changes in v9:
>> - Document more details for 'ports' property.
>>
>> Changes in v8:
>> - Modify the commit subject name. (Heiko)
>>
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5:
>> - Split binding doc's from driver changes. (Rob)
>> - Add eDP hotplug pinctrl property. (Heiko)
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   .../display/rockchip/analogix_dp-rockchip.txt      | 91 ++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
>> new file mode 100644
>> index 0000000..dae86c4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
>> @@ -0,0 +1,91 @@
>> +Rockchip RK3288 specific extensions to the Analogix Display Port
>> +================================
>> +
>> +Required properties:
>> +- compatible: "rockchip,rk3288-edp";
>> +
>> +- reg: physical base address of the controller and length
>> +
>> +- clocks: from common clock binding: handle to dp clock.
>> +         of memory mapped region.
>> +
>> +- clock-names: from common clock binding:
>> +              Required elements: "dp" "pclk"
>> +
>> +- resets: Must contain an entry for each entry in reset-names.
>> +         See ../reset/reset.txt for details.
>> +
>> +- pinctrl-names: Names corresponding to the chip hotplug pinctrl states.
>> +- pinctrl-0: pin-control mode. should be <&edp_hpd>
>> +
>> +- reset-names: Must include the name "dp"
>> +
>> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
>> +
>> +- ports: there are 2 port nodes with endpoint definitions as defined in
>> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
>> +    Port 0: contained 2 endpoints, connecting to the ouput of vop.
>> +    Port 1: contained 1 endpoint, connecting to the input of panel.
>> +
>> +For the below properties, please refer to Analogix DP binding document:
>> + * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>> +- phys (required)
>> +- phy-names (required)
>> +- hpd-gpios (optional)
>> +-------------------------------------------------------------------------------
>> +
>> +Example:
>> +       dp-controller: dp at ff970000 {
>> +               compatible = "rockchip,rk3288-dp";
>> +               reg = <0xff970000 0x4000>;
>> +               interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
>> +               clock-names = "dp", "pclk";
>> +               phys = <&dp_phy>;
>> +               phy-names = "dp";
>> +
>> +               rockchip,grf = <&grf>;
>> +               resets = <&cru 111>;
>> +               reset-names = "dp";
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&edp_hpd>;
>> +
>> +               status = "disabled";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       edp_in: port at 0 {
>> +                               reg = <0>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               edp_in_vopb: endpoint at 0 {
>> +                                       reg = <0>;
>> +                                       remote-endpoint = <&vopb_out_edp>;
>> +                               };
>> +                               edp_in_vopl: endpoint at 1 {
>> +                                       reg = <1>;
>> +                                       remote-endpoint = <&vopl_out_edp>;
>> +                               };
>> +                       };
>> +
>> +                       edp_out: port at 1 {
>> +                               reg = <1>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               edp_out_panel: endpoint {
>> +                                       reg = <0>;
>> +                                       remote-endpoint = <&panel_in_edp>
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       pinctrl {
>> +               edp {
>> +                       edp_hpd: edp-hpd {
>> +                               rockchip,pins = <7 11 RK_FUNC_2 &pcfg_pull_none>;
>> +                       };
>> +               };
>> +       };
>> --
>> 1.9.1
>>
>>
>
>
