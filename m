From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 9 Oct 2017 20:46:48 +0530
Subject: [RFC 2/2] phy: exynos5-usbdrd: remove disable and enable of phy
 clk
In-Reply-To: <CANAwSgSMFBS8n48=_OnNNs_=Di9Oqq2tNeiwZM9u1qaLevLP4w@mail.gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <1507264595-3565-2-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe9FCKqrvsgdohTAN9tXXwbMOuyaDiHPxZ1Ym1LLPD41w@mail.gmail.com>
 <CANAwSgSbHR+e_2wX3i3VoVxPe10mUOoS94uRpvebfUfybaNQ+g@mail.gmail.com>
 <20171008155015.252gefhsc4tks7k6@kozik-lap>
 <CANAwSgSMFBS8n48=_OnNNs_=Di9Oqq2tNeiwZM9u1qaLevLP4w@mail.gmail.com>
Message-ID: <CANAwSgRmyEqTbw1ZfZhenC8Cs4ffgeYB4vyDNsGeX-zvg92aPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Krzysztof,

On 9 October 2017 at 02:37, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On 8 October 2017 at 21:20, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Sun, Oct 08, 2017 at 06:11:12PM +0530, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> On 6 October 2017 at 12:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> > On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
>>> >> remove the disable and enable of phy clk.
>>> >> phy clk is needed to tune the phy controller.
>>> >
>>> > Drivers should in general enable and disable the clocks they use. Just
>>> > like in patch #1 please describe why you are doing this, what kind of
>>> > problem are you trying to solve and what exactly are you trying to do
>>> > here.
>>> >
>>> > BR,
>>> > Krzysztof
>>> >
>>>
>>> [snip]
>>>
>>> Usually we would disable the clk on error patch and return with failed.
>>> but in the current code we disable the clk in init routine and
>>> enable the clk in disable routine which seem incorrect.
>>

disable of clk could affect the PMU used to control the phy driver.

>> No. For example for exynos5_usbdrd_phy_exit() the driver enables the
>> clock only for the access to PHY block (PHY registers).
>>
>
> But I dont get it why we disable code phy clk, which could be used in
> future phy tune or link control as it part of CLK_FSYS.
>
>>>
>>> [0] https://github.com/torvalds/linux/blob/master/drivers/phy/samsung/phy-exynos5-usbdrd.c#L362-L412
>>> [1] https://github.com/torvalds/linux/blob/master/drivers/phy/samsung/phy-exynos5-usbdrd.c#L424-L446
>>>
>>> On 3.10.x kernel clk_summary all the clk are enables.
>>>
>>>     mout_usbdrd300              3           3            24000000
>>>        dout_usbdrd300           2           2            24000000
>>>           sclk_usbdrd300        1           1            24000000
>>>        dout_usbphy300           2           2            24000000
>>>           sclk_usbphy300        1           1            24000000
>>>     mout_usbdrd301              3           3            24000000
>>>        dout_usbdrd301           2           2            24000000
>>>           sclk_usbdrd301        1           1            24000000
>>>        dout_usbphy301           2           2            24000000
>>>           sclk_usbphy301        1           1            24000000
>>>
>>> Some more changes in clk driver might be required to stabilize the usb module.
>>
>> Please describe the issues with stability first.
>>
>> Best regards,
>> Krzysztof
>>
> On stability:
>
> USB 3.0 read / write performance is not up to mark with moderate data
> read / write speed,
> If you give long compilation of kernel or any source code it would
> likely be slow
> It work pretty good with USB 3.0 SSD but generally failed with 2.5' inc HDD.
>
> If needed I will share you some performance test result with and
> without these patches.
>
> I have some more changes related to usbdrd phy change queued along this on.
>
> Best Regards
> -Anand
