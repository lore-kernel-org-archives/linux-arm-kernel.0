From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 22 Dec 2016 09:15:20 +0800
Subject: [RESEND PATCH v2] arm64: dts: rockchip: add u2phy clock for ehci
 and ohci of rk3399
In-Reply-To: <CAD=FV=WFFGSc7yBeaE+++VAuRKwMixpGUwA9bCCro4TCe0+GAA@mail.gmail.com>
References: <1482316182-2305-1-git-send-email-zhengxing@rock-chips.com>
 <1482316865-2769-1-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=WFFGSc7yBeaE+++VAuRKwMixpGUwA9bCCro4TCe0+GAA@mail.gmail.com>
Message-ID: <e3494c43-9be4-18be-a8b7-a8dc312ef87c@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016?12?22? 08:47, Doug Anderson ??:
> Hi,
>
> On Wed, Dec 21, 2016 at 2:41 AM, Xing Zheng <zhengxing@rock-chips.com> wrote:
>> From: William wu <wulf@rock-chips.com>
>>
>> We found that the suspend process was blocked when it run into
>> ehci/ohci module due to clk-480m of usb2-phy was disabled.
>>
>> The root cause is that usb2-phy suspended earlier than ehci/ohci
>> (usb2-phy will be auto suspended if no devices plug-in). and the
>> clk-480m provided by it was disabled if no module used. However,
>> some suspend process related ehci/ohci are base on this clock,
>> so we should refer it into ehci/ohci driver to prevent this case.
>>
>> The u2phy clock flow like this:
>> ===
>>        u2phy ________________
>>             |                |    |-----> UTMI_CLK ---------> | EHCI |
>> OSC_24M ---|---> PHY_PLL----|----|
>>             |________^_______|    |-----> 480M_CLK ---|G|---> | USBPHY_480M_SRC| ----> USBPHY_480M for SoC
>>                      |
>>                      |
>>                     GRF
>> ===
>>
>> Signed-off-by: William wu <wulf@rock-chips.com>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - update the commit message
>> - remove patches whic add and export the USBPHYx_480M_SRC clock IDs
>>
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index b65c193..2ad9255 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -315,8 +315,10 @@
>>                  compatible = "generic-ehci";
>>                  reg = <0x0 0xfe380000 0x0 0x20000>;
>>                  interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>;
>> -               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
>> -               clock-names = "hclk_host0", "hclk_host0_arb";
>> +               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>> +                        <&u2phy0>;
>> +               clock-names = "usbhost", "arbiter",
>> +                             "utmi";
>>                  phys = <&u2phy0_host>;
>>                  phy-names = "usb";
>>                  status = "disabled";
>> @@ -326,8 +328,12 @@
>>                  compatible = "generic-ohci";
>>                  reg = <0x0 0xfe3a0000 0x0 0x20000>;
>>                  interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>;
>> -               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
>> -               clock-names = "hclk_host0", "hclk_host0_arb";
>> +               clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
>> +                        <&u2phy0>;
>> +               clock-names = "usbhost", "arbiter",
>> +                             "utmi";
>> +               phys = <&u2phy0_host>;
>> +               phy-names = "usb";
>>                  status = "disabled";
>>          };
>>
>> @@ -335,8 +341,10 @@
>>                  compatible = "generic-ehci";
>>                  reg = <0x0 0xfe3c0000 0x0 0x20000>;
>>                  interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>;
>> -               clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
>> -               clock-names = "hclk_host1", "hclk_host1_arb";
>> +               clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
>> +                        <&u2phy1>;
>> +               clock-names = "usbhost", "arbiter",
>> +                             "utmi";
>>                  phys = <&u2phy1_host>;
>>                  phy-names = "usb";
>>                  status = "disabled";
>> @@ -346,8 +354,12 @@
>>                  compatible = "generic-ohci";
>>                  reg = <0x0 0xfe3e0000 0x0 0x20000>;
>>                  interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
>> -               clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
>> -               clock-names = "hclk_host1", "hclk_host1_arb";
>> +               clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
>> +                        <&u2phy1>;
>> +               clock-names = "usbhost", "arbiter",
>> +                             "utmi";
>> +               phys = <&u2phy1_host>;
>> +               phy-names = "usb";
> This all looks better to me.  From a device tree point of view it
> makes lots of sense to expose this PHY clock to the controller.  Thus:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
> I can't say that I understand all the interactions between the PHY
> code and the USB driver, but presumably others have reviewed that
> more?  Offline Heiko pointed me at rockchip_usb2phy_otg_sm_work()
> which apparently calls rockchip_usb2phy_power_off() and
> rockchip_usb2phy_power_on() directly sometimes behind the back of the
> PHY framework.  Very strange.
>
>
> I will also say that there were still some unanswered questions from
> the previous thread, namely:
>
> A) Heiko: Also, with the change, the ehci will keep the clock (and
> thus the phy) always on. Does the phy-autosuspend even save anything
> now?
>
> B) Brian: Is thre a race between power_off() and the delayed work in
> your USB2 PHY driver?
>
>
> IMHO neither of those two questions affect the correctness of this
> patch: that this clock ought to be provided to the USB Controller.
> ...but they both are important questions that should be answered.
>
> One other last note is that we probably should be specifying a more
> specific compatible string, like:
>
>    "rk3399-ehci", "generic-ehci"
>
> That will allow us later to use these same device tree files and
> perhaps deal with the clocks / PHYs in a more efficient way.
>
>
> -Doug
>
I will *ping* Frank and William to answer your questions until they 
finish the business travel.

Thanks.

-- 
- Xing Zheng
