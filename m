From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 6 Dec 2016 13:19:08 +0100
Subject: [PATCH v3] arm: dts: zynq: Add MicroZed board support
In-Reply-To: <CAD6G_RQuJTaXsuHLCGBZMekaGXOc7pzdi7pkoZ0gNq2LWU9ptA@mail.gmail.com>
References: <1474624113-22825-1-git-send-email-jagan@amarulasolutions.com>
 <f0c33080-0811-a515-f897-e7f851b13b5e@xilinx.com>
 <CAD6G_RQuJTaXsuHLCGBZMekaGXOc7pzdi7pkoZ0gNq2LWU9ptA@mail.gmail.com>
Message-ID: <6d9ea52c-e486-7dbf-2ee8-5e0cafa665a6@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5.12.2016 17:28, Jagan Teki wrote:
> On Mon, Sep 26, 2016 at 8:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 23.9.2016 11:48, Jagan Teki wrote:
>>> From: Jagan Teki <jteki@openedev.com>
>>>
>>> Added basic dts support for MicroZed board.
>>>
>>> - UART
>>> - SDHCI
>>> - Ethernet
>>>
>>> Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Signed-off-by: Jagan Teki <jteki@openedev.com>
>>> ---
>>> Changes for v3:
>>>       - Add Xilinx copyright
>>> Changes for v2:
>>>       - Add SDHCI
>>>       - Add Ethernet
>>>
>>>  arch/arm/boot/dts/Makefile          |  1 +
>>>  arch/arm/boot/dts/zynq-microzed.dts | 96 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 97 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/zynq-microzed.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index faacd52..4d7b858 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -862,6 +862,7 @@ dtb-$(CONFIG_ARCH_VT8500) += \
>>>       wm8750-apc8750.dtb \
>>>       wm8850-w70v2.dtb
>>>  dtb-$(CONFIG_ARCH_ZYNQ) += \
>>> +     zynq-microzed.dtb \
>>>       zynq-parallella.dtb \
>>>       zynq-zc702.dtb \
>>>       zynq-zc706.dtb \
>>> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
>>> new file mode 100644
>>> index 0000000..b9376a4
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/zynq-microzed.dts
>>> @@ -0,0 +1,96 @@
>>> +/*
>>> + * Copyright (C) 2011 - 2014 Xilinx
>>> + * Copyright (C) 2016 Jagan Teki <jteki@openedev.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +/dts-v1/;
>>> +/include/ "zynq-7000.dtsi"
>>> +
>>> +/ {
>>> +     model = "Zynq MicroZED Development Board";
>>> +     compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
>>> +
>>> +     aliases {
>>> +             ethernet0 = &gem0;
>>> +             serial0 = &uart1;
>>> +     };
>>> +
>>> +     memory {
>>> +             device_type = "memory";
>>> +             reg = <0x0 0x40000000>;
>>> +     };
>>> +
>>> +     chosen {
>>> +             bootargs = "earlycon";
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +
>>> +     usb_phy0: phy0 {
>>> +             compatible = "usb-nop-xceiv";
>>> +             #phy-cells = <0>;
>>> +     };
>>> +};
>>> +
>>> +&clkc {
>>> +     ps-clk-frequency = <33333333>;
>>> +};
>>> +
>>> +&gem0 {
>>> +     status = "okay";
>>> +     phy-mode = "rgmii-id";
>>> +     phy-handle = <&ethernet_phy>;
>>> +
>>> +     ethernet_phy: ethernet-phy at 0 {
>>> +             reg = <0>;
>>> +     };
>>> +};
>>> +
>>> +&sdhci0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&uart1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&usb0 {
>>> +     status = "okay";
>>> +     dr_mode = "host";
>>> +     usb-phy = <&usb_phy0>;
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_usb0_default>;
>>> +};
>>> +
>>> +&pinctrl0 {
>>> +     pinctrl_usb0_default: usb0-default {
>>> +             mux {
>>> +                     groups = "usb0_0_grp";
>>> +                     function = "usb0";
>>> +             };
>>> +
>>> +             conf {
>>> +                     groups = "usb0_0_grp";
>>> +                     slew-rate = <0>;
>>> +                     io-standard = <1>;
>>> +             };
>>> +
>>> +             conf-rx {
>>> +                     pins = "MIO29", "MIO31", "MIO36";
>>> +                     bias-high-impedance;
>>> +             };
>>> +
>>> +             conf-tx {
>>> +                     pins = "MIO28", "MIO30", "MIO32", "MIO33", "MIO34",
>>> +                            "MIO35", "MIO37", "MIO38", "MIO39";
>>> +                     bias-disable;
>>> +             };
>>> +     };
>>> +};
>>>
>>
>> Applied.
> 
> Was it missed? I couldn't see it on the source for a while. any help?

Thanks for reminder. I have that patch in one branch (was in different)

https://github.com/Xilinx/linux-xlnx/commits/zynq/dt

Thanks,
Michal
