From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Sep 2015 17:13:16 +0100
Subject: [PATCH 2/2] arm64: dts: mt8173: add timer node
In-Reply-To: <1442501816.4784.3.camel@mtksdaap41>
References: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
 <1442369095-1094-2-git-send-email-yingjoe.chen@mediatek.com>
 <55FAC570.8040307@arm.com> <1442501816.4784.3.camel@mtksdaap41>
Message-ID: <55FAE69C.2000906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/09/15 15:56, Yingjoe Chen wrote:
> On Thu, 2015-09-17 at 14:51 +0100, Sudeep Holla wrote:
>>
>> On 16/09/15 03:04, Yingjoe Chen wrote:
>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>
>>> Add device node to enable GPT timer. This timer will be
>>> used as sched clock source.
>>>
>>
>> Interesting any known issues with or advantage over the arch timers
>> to prefer it as sched clock source. I see even arch timers are present
>> in DT, hence the question. Or is it just a incorrect commit log ?
>>
>> How does this get selected as sched clock source ? I don't see
>> sched_clock_register in mtk_timer.c
>>
>> To be clear, I am not against adding this timer support, but just want
>> to know is it preferred for sched clock source ? if yes why ? better
>> resolution ?
>
> Hi Sudeep,
>
> Thanks for your review.
>
> I hit the send too soon and missed cover letter, please see:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-September/002303.html
>

OK

> The main reason to use GPT as sched clock is it won't stop during idle.
>
>

I think your are confusing the system counter with arch timers. System
counter is always-on, but the arch timers(logic implementing timers
comparators) might not be off when the processor is powered down.

I think you need this timer and are using it for low power idle states
in which case you will use this as a clock event and not clock source.
It will be used as a hardware broadcast event source.

There's no call to sched_clock_register in mtk_timer.c, so it can't be
the sched clock, so you need to fix the commit log.

[...]

>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index d18ee42..d763803 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -238,6 +238,15 @@
>>>    			reg = <0 0x10007000 0 0x100>;
>>>    		};
>>>
>>> +		timer: timer at 10008000 {
>>> +			compatible = "mediatek,mt8173-timer",
>>
>> Missing documentation ? I am referring upstream and it might be in some
>> patches already queued perhaps ?
>
> This is documented in
> Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt.
> Do you mean I should add "mediatek,mt8173-timer" to that file?
>

Yes

Regards,
Sudeep
