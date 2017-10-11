From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 11 Oct 2017 11:16:22 +0530
Subject: [RFC 1/2] ARM: dts: exynos: update the usbdrd phy and ref clk
In-Reply-To: <368b8301-3b7e-ecf7-ff8d-8f94728749df@codeaurora.org>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe=hd7QdsaqpqPv3cNvL59FBqCfy24mYmGdQvi7Yp8wBQ@mail.gmail.com>
 <CANAwSgRK+F62xKFeFM9ZJ_rgPWj831ca=tX9BSKXUyRBhN4yhA@mail.gmail.com>
 <368b8301-3b7e-ecf7-ff8d-8f94728749df@codeaurora.org>
Message-ID: <CANAwSgSmw1=b_57Zt7D_ijg-OaqqpuBqDMZKACT_7Wn16WAUdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 10 October 2017 at 11:57, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
>
> On 10/08/2017 06:06 PM, Anand Moon wrote:
>>
>> Hi Krzysztof,
>>
>> On 6 October 2017 at 12:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>
>>>> update the usbdrd link control and phy contol clks.
>>>
>>> The commit title and especially commit message should explain why you
>>> are doing this and what are you doing. "Update" is not enough.
>>> Everything could be called update.
>>>
>>> Therefore I do not understand the reason behind the patch.
>>>
>>> BR,
>>> Krzysztof
>>
>> so as per the driver.
>> @clk: phy clock for register access
>> @ref_clk: reference clock to PHY block from which PHY's operational
>> clocks are derived
>>
>> Both CLK_SCLK_USBPHY300 and CLK_SCLK_USBD300 belong to FSYS Clock
>> and CLK_USBD300 clk is being used by the usbdrd dwc3 module.
>
>
> From what i vaguely remember, the CLK_SCLK* are the parent clocks going to
> the
> FSYS block. In this FSYS block the two clocks - CLK_USBD300, and
> CLK_SCLK_USBPHY300
> are coming.
>
> "phy" - represents the AHB clock used only for the register writes, and is
> required only
> during register access. Since we don't need this clock for phy operation,
> your next change
> that removes the clk_disable() sounds incorrect to me.
> Just to double check, this AHB clock should be 200MHz (from what i remember)
> "ref_clk" - the phy reference that clocks the phy PLL. This is a 24MHz
> clock.
>
> Clubbing the changes in two patches:
> - You change the "phy" clock from CLK_USBD300 to CLK_SCLK_USBPHY300, and
> then
>   you _had_ to remove the clk_disable().
>   I think you needed the second patch just because you introduced this
> change in the clocks.
>
> - Like Krzysztof mentioned in the thread, if there's a performance
> improvement you may
> want to double check the clock rates.
>

Yes their is slight improvement with these changes
I will share my test result once I add few more changes to this drive.

>
> Best regards
> Vivek
>

Thank for your explanation on the clk internals.
I have read few detail on the initial mainline list.

[0] https://lkml.org/lkml/2014/4/8/247

CLK_GATE_TOP_SCLK_FSYS

SCLK_USBDRD301       Gating SUSPEND_CLK for USBDRD30_1
SCLK_USBDRD300       Gating SUSPEND_CLK for USBDRD30_0
SCLK_USBPHY300        Gating USB30_SCLK_100M for USBDRD30_PHY_0
                                            Gating USB20_PICO_CLKCORE
for PICO PHY
SCLK_USBPHY300        Gating USB30_SCLK_100M for USBDRD30_PHY_1

So we did not considered the SUSPEN_CLK for phy.

Below is the clk structure diagram for usb drd phy.

[1] https://lkml.org/lkml/2014/4/10/240

Here is how it shown in manual.

                                   ___________________
                                   |                                          |
SUSPEND_CLK     |      ____________        |
 ------------------------- |      | PHY                 |        |
                                   |      | controller
|------|--------------------------------------------------------
                                   |      |___________|        |
                                                                   |
                                   |
       |
           |
                                   |
       |
          |
                                   |         USB 3.0
|      USB30_SCLK_100M------------- |-------------------------------|
                                   |           DRD
 |                                                               |
                                    |---->vbus
                                   ---------------------------------
                                                            |
                               |
                                   |        Controller
|                                                               |
 |---------------------|    |
                                   |
       |            Pipe interface                          |       |
USB 3.0 DRD  |    |
                                   |      ----------------
  |-----------------------------------------------|
|____________|    |
                                   |     |       PHY       |
  |            UTMI+ Interface                       |
                        |
                                   |     | Link cont.    |
|-----------------------------------------------|
                   |
                                   |     |-----------------|
 |
|__________________|
                                   |
       |
                                   |__________________|


So how can we support SUSPEND_CLK ?
Do we need to keep this SUSPEND_CLK enable ?

As of now my dts change are wrong
How about below changes.

 &usbdrd_phy0 {
-       clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
+       clocks = <&clock CLK_SCLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
        clock-names = "phy", "ref";
        samsung,pmu-syscon = <&pmu_system_controller>;
 };
@@ -1476,7 +1476,7 @@
 };

 &usbdrd_phy1 {
-       clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
+       clocks = <&clock CLK_SCLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
        clock-names = "phy", "ref";
        samsung,pmu-syscon = <&pmu_system_controller>;
 };

Best Regards
-Anand
