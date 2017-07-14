From: jacobchen110@gmail.com (Jacob Chen)
Date: Fri, 14 Jul 2017 09:52:30 +0800
Subject: [PATCH 1/5] arm64: dts: rockchip: Add rk3399 vop and
 display-subsystem
In-Reply-To: <4655605.dLm3uFpe8F@phil>
References: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
 <1499875435-23944-2-git-send-email-jacob-chen@iotwrt.com>
 <4655605.dLm3uFpe8F@phil>
Message-ID: <CAFLEztSbZExA2_t5D+TWGsrCU5Gqrg7azdi97brhjO2wPdup3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heko,

2017-07-14 7:34 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> Hi Jacob,
>
> Am Donnerstag, 13. Juli 2017, 00:03:51 CEST schrieb Jacob Chen:
>> Add devicetree nodes for rk3399 VOP (Video Output Processors), and the
>> top level display-subsystem root node.
>>
>> Later patches add endpoints (eDP, HDMI, MIPI, etc) that attach to the
>> VOPs' output ports.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 65 ++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index e795135..300e500 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1455,6 +1455,71 @@
>>               status = "disabled";
>>       };
>>
>> +     vopl: vop at ff8f0000 {
>> +             compatible = "rockchip,rk3399-vop-lit";
>> +             reg = <0x0 0xff8f0000 0x0 0x1ffc>, <0x0 0xff8f2000 0x0 0x400>;
>
> What is this second memory region doing? It looks like this is the meant
> to cover VOP_GAMMA_LUT_ADDR, but can't you just map the whole area?
> ChromeOS seems to be doing fine using the whole area as
>         <0x0 0xff8f0000 0x0 0x3efc>
> and I've also not seen any code changes actually mapping/using this
> second area.
>

0x1c00 - 0x200 for cabc_lut
0x2000 - 0x300 for gama_lut

My mistakes, It seems mark havn't send gamma and cabc support to upstream.
We shoud just using the whole area map.


>
>> +             interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
>> +             clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>, <&cru DCLK_VOP1_DIV>;
>> +             clock-names = "aclk_vop", "dclk_vop", "hclk_vop", "dclk_source";
>
> While I know that this is based on my idea on handling the hdmi pll-rate
> requirements, I haven't found the matching code- and dt-binding-changes
> posted to a list yet.
>

Yeah, should i collect mark's patches or remove it at first?

>
> Heiko
>
