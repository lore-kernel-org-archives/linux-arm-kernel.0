From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 19 Jan 2017 20:41:14 +0800
Subject: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
In-Reply-To: <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764@linaro.org>
 <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
Message-ID: <74160889-5eb0-ceb2-2727-61e9d538cf2f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/19 17:44, Fu Wei wrote:
> Hi Hanjun,
>
> On 19 January 2017 at 16:02, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Hi Fuwei,
>>
>> One comments below.
>>
>>
>> On 2017/1/18 21:25, fu.wei at linaro.org wrote:
>>>
>>> From: Fu Wei <fu.wei@linaro.org>
>>>
>>> The counter frequency detection call(arch_timer_detect_rate) combines two
>>> ways to get counter frequency: system coprocessor register and MMIO timer.
>>> But in a specific timer init code, we only need one way to try:
>>> getting frequency from MMIO timer register will be needed only when we
>>> init MMIO timer; getting frequency from system coprocessor register will
>>> be needed only when we init arch timer.
>>>
>>> This patch separates paths to determine frequency:
>>> Separate out the MMIO frequency and the sysreg frequency detection call,
>>> and use the appropriate one for the counter.
>>>
>>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>>> ---
>>>  drivers/clocksource/arm_arch_timer.c | 40
>>> ++++++++++++++++++++++--------------
>>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c
>>> b/drivers/clocksource/arm_arch_timer.c
>>> index 6484f84..9482481 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>>>         return 0;
>>>  }
>>>
>>> -static void arch_timer_detect_rate(void __iomem *cntbase)
>>> +static void __arch_timer_determine_rate(u32 rate)
>>>  {
>>> -       /* Who has more than one independent system counter? */
>>> -       if (arch_timer_rate)
>>> -               return;
>>> +       /* Check the timer frequency. */
>>> +       if (!arch_timer_rate) {
>>> +               if (rate)
>>> +                       arch_timer_rate = rate;
>>> +               else
>>> +                       pr_warn("frequency not available\n");
>>> +       } else if (rate && arch_timer_rate != rate) {
>>
>>                         ^
>> Typo? I think it's "&" here.
>
> Not a typo, It's definitely a ?&&?  :-)
>
> Here arch_timer_rate is not zero.
>
> If rate is not zero(that means we got a valid rate), and
> arch_timer_rate != rate ,
> we will print warning message.

Ah, misreading the code, thanks for clarify :)

Hanjun
