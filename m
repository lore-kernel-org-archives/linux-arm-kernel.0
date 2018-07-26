From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 16:31:58 +0100
Subject: [PATCH v2 16/18] arm64: dts: allwinner: a64: NanoPi-A64: Add
 Ethernet
In-Reply-To: <b2519ce5-eadf-79b6-5eb7-fefe6bb0ab72@orpaltech.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-17-andre.przywara@arm.com>
 <f2380842-2c7a-13d3-fa0f-ed23afb89e30@orpaltech.com>
 <B1F768E3-0C8E-4DBE-92AE-1CFA57BFE7F5@aosc.io>
 <e2f98352-30f5-d162-5bf9-46c7f15e8a80@arm.com>
 <b2519ce5-eadf-79b6-5eb7-fefe6bb0ab72@orpaltech.com>
Message-ID: <ea9c7e8b-e768-35f5-46e2-63befd1e896a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On 26/07/18 16:25, Sergey Suloev wrote:
> On 07/26/2018 05:06 PM, Andre Przywara wrote:
>> Hi,
>>
>> On 26/07/18 14:41, Icenowy Zheng wrote:
>>>
>>> ? 2018?7?26? GMT+08:00 ??9:39:56, Sergey Suloev
>>> <ssuloev@orpaltech.com> ??:
>>>> Hi,
>>>>
>>>> On 07/26/2018 03:35 AM, Andre Przywara wrote:
>>>>> The NanoPi-A64 has the usual Realtek Gbit PHY connected to the EMAC,
>>>>> so add the respective nodes to the DT. The PHY is powered by the
>>>>> VDD_SYS_3.3V line, which is always on.
>>>>>
>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>> ---
>>>>> ?? arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 17
>>>> +++++++++++++++++
>>>>> ?? 1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>>>> index 5caba225b4f7..bd35a093e6cd 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>>>> @@ -51,6 +51,7 @@
>>>>> ?????? compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
>>>>> ?? ?????? aliases {
>>>>> +??????? ethernet0 = &emac;
>>>>> ?????????? serial0 = &uart0;
>>>>> ?????? };
>>>>> ?? @@ -67,6 +68,15 @@
>>>>> ?????? status = "okay";
>>>>> ?? };
>>>>> ?? +&emac {
>>>>> +??? pinctrl-names = "default";
>>>>> +??? pinctrl-0 = <&rgmii_pins>;
>>>>> +??? phy-mode = "rgmii";
>>>>> +??? phy-handle = <&ext_rgmii_phy>;
>>>>> +??? phy-supply = <&reg_dcdc1>;
>>>>> +??? status = "okay";
>>>>> +};
>>>>> +
>>>>> ?? /* i2c1 connected with gpio headers like pine64, bananapi */
>>>>> ?? &i2c1 {
>>>>> ?????? pinctrl-names = "default";
>>>>> @@ -78,6 +88,13 @@
>>>>> ?????? bias-pull-up;
>>>>> ?? };
>>>>> ?? +&mdio {
>>>>> +??? ext_rgmii_phy: ethernet-phy at 1 {
>>>>> +??????? compatible = "ethernet-phy-ieee802.3-c22";
>>>>> +??????? reg = <1>;
>>>>> +??? };
>>>>> +};
>>>>> +
>>>>> ?? &mmc0 {
>>>>> ?????? pinctrl-names = "default";
>>>>> ?????? pinctrl-0 = <&mmc0_pins>;
>>>> did you test? "reg = <1>" on a real hardware ?
>> No, thanks for pointing this out.
>>
>> According to the PHY's datasheet the PHY address is configured by the
>> three pins also used for the LEDs. By looking at the schematics back
>> then I somehow managed to convince myself that it should be 1, as most
>> other boards use, but from looking again it indeed looks more like 7
>> (the other LED pin connected to 3.3V).
>>
>> Can you please try with reg = <7> and confirm that it works that way?
>>
>> Many thanks,
>> Andre.
> ok, let me check this.

Thanks!

> And what data sheet are you talking about ? Can
> you provide a link, please.

The RTL8211 datasheet, for instance from here:
http://files.pine64.org/doc/datasheet/pine64/rtl8211e(g)-vb(vl)-cg_datasheet_1.6.pdf

Chapter 7.8 explains how the PHY address configuration works. If I match
this with the schematic, it should be 7 indeed.

Cheers,
Andre.


>>>> I have? "reg = <0>" in my dts? and? it has been working on my board for
>>> 0 is a wildcard address.
>>>
>>> For nano pi, if 1 doesn't work, then it should be 7. 0 can work,
>>> but it won't be accepted by DT maintainers.
>>>
>>>> ages.
>>>>
>>>> Thanks
> 
> 
