From: wulf@rock-chips.com (wlf)
Date: Fri, 11 Nov 2016 11:23:49 +0800
Subject: [PATCH] phy: rockchip-inno-usb2: correct 480MHz output clock
 stable time
In-Reply-To: <2283070.Hkeafucara@diego>
References: <1478523658-9400-1-git-send-email-wulf@rock-chips.com>
 <CAD=FV=VC15_QAs7+DOoqCeWrU6-qqnUku2SSPFLOvLanu8xL3g@mail.gmail.com>
 <9eeb3d84-f850-4b76-ce6a-67cc92d6de3b@rock-chips.com>
 <2283070.Hkeafucara@diego>
Message-ID: <e6d038f6-c324-fc06-5cf1-e03d6ec6d4e3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko?

? 2016?11?10? 17:21, Heiko St?bner ??:
> Am Donnerstag, 10. November 2016, 10:54:49 schrieb wlf:
>> Hi Doug,
>>
>> ? 2016?11?10? 04:54, Doug Anderson ??:
>>> Hi,
>>>
>>> On Mon, Nov 7, 2016 at 5:00 AM, William Wu <wulf@rock-chips.com> wrote:
>>>> We found that the system crashed due to 480MHz output clock of
>>>> USB2 PHY was unstable after clock had been enabled by gpu module.
>>>>
>>>> Theoretically, 1 millisecond is a critical value for 480MHz
>>>> output clock stable time, so we try to change the delay time
>>>> to 1.2 millisecond to avoid this issue.
>>>>
>>>> Signed-off-by: William Wu <wulf@rock-chips.com>
>>>> ---
>>>>
>>>>    drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c
>>>> b/drivers/phy/phy-rockchip-inno-usb2.c index ecfd7d1..8f2d2b6 100644
>>>> --- a/drivers/phy/phy-rockchip-inno-usb2.c
>>>> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
>>>> @@ -267,7 +267,7 @@ static int rockchip_usb2phy_clk480m_enable(struct
>>>> clk_hw *hw)>>
>>>>                           return ret;
>>>>                   
>>>>                   /* waitting for the clk become stable */
>>>>
>>>> -               mdelay(1);
>>>> +               udelay(1200);
>>> Several people who have seen this patch have expressed concern that a
>>> 1.2 ms delay is pretty long for something that's supposed to be
>>> "atomic" like a clk_enable().  Consider that someone might call
>>> clk_enable() while interrupts are disabled and that a 1.2 ms interrupt
>>> latency is not so great.
>>>
>>> It seems like this clock should be moved to be enabled in "prepare"
>>> and the "enable" should be a no-op.  This is a functionality change,
>>> but I don't think there are any real users for this clock at the
>>> moment so it should be fine.
>>>
>>> (of course, the 1 ms latency that existed before this patch was still
>>> pretty bad, but ...)
>> Thanks a lot for your suggestion.
>> I agree with you.  clk_enable() will call spin_lock_irqsave() to disable
>> interrupt, and we add
>> more than 1ms in clk_enable may cause big latency.
>>
>> And according to clk_prepare() description:
>>    In a simple case, clk_prepare can be used instead of clk_enable to
>> ungate a clk if the
>>    operation may sleep.  One example is a clk which is accessed over I2c.
>>
>> So maybe we can remove the clock to clk_prepare.
>>
>> Hi Heiko, Frank,
>>          What  do you think of it?
> moving to clk_prepare sounds sensible. That way you can switch from delay to
> sleep functions as well.
Thanks very much.
I will try to update a new patch.

Best regards,
          Wulf

>
>
> Heiko
>
>
>
