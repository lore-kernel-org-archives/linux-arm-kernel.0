From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 10 Oct 2017 11:57:28 +0530
Subject: [RFC 1/2] ARM: dts: exynos: update the usbdrd phy and ref clk
In-Reply-To: <CANAwSgRK+F62xKFeFM9ZJ_rgPWj831ca=tX9BSKXUyRBhN4yhA@mail.gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe=hd7QdsaqpqPv3cNvL59FBqCfy24mYmGdQvi7Yp8wBQ@mail.gmail.com>
 <CANAwSgRK+F62xKFeFM9ZJ_rgPWj831ca=tX9BSKXUyRBhN4yhA@mail.gmail.com>
Message-ID: <368b8301-3b7e-ecf7-ff8d-8f94728749df@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/2017 06:06 PM, Anand Moon wrote:
> Hi Krzysztof,
>
> On 6 October 2017 at 12:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
>>> update the usbdrd link control and phy contol clks.
>> The commit title and especially commit message should explain why you
>> are doing this and what are you doing. "Update" is not enough.
>> Everything could be called update.
>>
>> Therefore I do not understand the reason behind the patch.
>>
>> BR,
>> Krzysztof
> so as per the driver.
> @clk: phy clock for register access
> @ref_clk: reference clock to PHY block from which PHY's operational
> clocks are derived
>
> Both CLK_SCLK_USBPHY300 and CLK_SCLK_USBD300 belong to FSYS Clock
> and CLK_USBD300 clk is being used by the usbdrd dwc3 module.

 From what i vaguely remember, the CLK_SCLK* are the parent clocks going 
to the
FSYS block. In this FSYS block the two clocks - CLK_USBD300, and 
CLK_SCLK_USBPHY300
are coming.

"phy" - represents the AHB clock used only for the register writes, and 
is required only
during register access. Since we don't need this clock for phy 
operation, your next change
that removes the clk_disable() sounds incorrect to me.
Just to double check, this AHB clock should be 200MHz (from what i remember)
"ref_clk" - the phy reference that clocks the phy PLL. This is a 24MHz 
clock.

Clubbing the changes in two patches:
- You change the "phy" clock from CLK_USBD300 to CLK_SCLK_USBPHY300, and 
then
   you _had_ to remove the clk_disable().
   I think you needed the second patch just because you introduced this 
change in the clocks.

- Like Krzysztof mentioned in the thread, if there's a performance 
improvement you may
want to double check the clock rates.


Best regards
Vivek

>
> [0] https://github.com/torvalds/linux/blob/master/drivers/clk/samsung/clk-exynos5420.c#L1040-L1053
>
> So their is mismatch of the clk used by the usbdrd driver.
> with the above changes the driver work well with camera and disk drives
> connected to usb 3.0 ports and their is improvement in the performance.
>
> root at odroid:~# lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>      |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
>          |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=uas, 5000M
>          |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=uas, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
>
> Best Regards
> -Anand

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
