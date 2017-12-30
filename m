From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 30 Dec 2017 01:10:14 +0100
Subject: [RFC PATCH v12 5/5] arm64: dts: rockchip: Move PCIe WAKE# irq to
 pcie port for Gru
In-Reply-To: <20171229175539.GK3875@atomide.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
 <20171226023646.17722-6-jeffy.chen@rock-chips.com>
 <20171229175539.GK3875@atomide.com>
Message-ID: <CAJZ5v0ievZh=LULfJZm5ZQhg++r1D++MaE73RswR_WAJ=+bNGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 6:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Jeffy Chen <jeffy.chen@rock-chips.com> [171226 02:41]:
>> Currently we are handling PCIe WAKE# irq in mrvl wifi driver.
>>
>> Move it to rockchip pcie port since we are going to handle it in the
>> pci core.
>
> Yes in the PCIe case, the pcie port node is the right place for
> the wakeirq instead of the child the mvl_wifi node. So one
> question further down below to verify this..

You seem to be using a convention by which the port represents the
whole "slot" or "PCI device" (as an entity consisting of up to 8
functions) connected to it.

That is fair enough as long as the port is not the top of a more
complex branch of the PCIe hierarchy, so maybe that case needs to be
made special somehow?

Also, I would document the convention by mentioning that the wakeup
signaled via that interrupt doesn't apply to the port itself, but to
the functions (endpoints) below it.

>> Also avoid this irq been considered as the PCI interrupt pin in the
>> of_irq_parse_pci().
>
> The above paragraph needs a bit more clarification to be
> readable :)
>
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> @@ -719,15 +719,16 @@ ap_i2c_audio: &i2c8 {
>>               #size-cells = <2>;
>>               ranges;
>>
>> +             interrupts-extended = <&pcie0 1>, <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
>> +             interrupt-names = "pci", "wakeup";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&wlan_host_wake_l>;
>> +             wakeup-source;
>> +
>>               mvl_wifi: wifi at 0,0 {
>>                       compatible = "pci1b4b,2b42";
>>                       reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>>                              0x83010000 0x0 0x00100000 0x0 0x00100000>;
>> -                     interrupt-parent = <&gpio0>;
>> -                     interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>> -                     pinctrl-names = "default";
>> -                     pinctrl-0 = <&wlan_host_wake_l>;
>> -                     wakeup-source;
>>               };
>>       };
>>  };
>
> So the above modifies pcie at 0,0 node. And that node describes
> the particular PCIe port that the WLAN is connected to instead
> of describing the whole PCIe controller device, right?
>
> If so, then yeah it's totally where the wakeirq should be
> defined for a PCIe device in the dts file :)

As long as the convention used here is clear to everybody, that is.

Thanks,
Rafael
