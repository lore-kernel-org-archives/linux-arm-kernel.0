From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 18 Mar 2016 08:12:11 +0100
Subject: [PATCH] clocksource/arm_global_timer.c: Reduce the rating from
 300 to 150
In-Reply-To: <56EAE42C.3010001@ti.com>
References: <1458198933-3397-1-git-send-email-mike.looijmans@topic.nl>
 <56EAE42C.3010001@ti.com>
Message-ID: <56EBAA4B.2090104@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 17-03-16 18:06, Grygorii Strashko wrote:
> Hi Mike,
>
> On 03/17/2016 09:15 AM, Mike Looijmans wrote:
>> The arm_global_timer clock runs on the CPU clock, and does not correct
>> for cpufreq scaling. This makes the clock not very suitable as a
>> clocksource, and basically any clock running on an independent
>> oscilator is preferable. Few clocksources have a rating over 300,
>> so this clock usually gets selected as clock source.
>>
>> On the Zynq-7000 for example, the TTC clock on the chip is preferred
>> to the global timer, because the TTC can at least compensate for
>> cpufreq scaling. That makes the TTC (which rates itself 200) a much
>> better clock source than the ARM global timer.
>>
>> Reduce the rating to 150 to make systems select the ARM global timer
>> as a last resort instead of a first choice.
>
> Yeh. All this clocksource/clockevent/sched_clock selection process is not really clear and
> not always works in case of muliplatform build :..(
>
> For example, I've had opposite case recently :( I have to reduce rating of OMAP gp_timer (300->290),
> so it will be possible to use ARM GT as clocksource when no-CPUFrq and no-CPUIdle.
>
> When I've tried to deal with it, I've been thinking about smth. like this:
> - explicitly define set and initialization sequence of devices
>   chosen {
> 	linux,clocksource = <&clksrc1>, <&clksrc2>..
> 	linux,clockevent = <&clkevt1>, <&clkevt2>..
>
> - or mark devices's nodes
>    timer1: timer at 4ae18000 {
> 		compatible = "ti,omap5430-timer";
> 		linux,clocksource;
> 		linux,clockevent;
>
> but I were not able to proceed further due lack of time (^ might cause difficult DT discussion).

Devicetree would be a proper place for this. A simple implementation would be 
to just move the "rating" to the DT, but that would be silly, since the 
"winner" is already known to the author of th DT so he might as well just say 
"use this one".

Personally, I like the "chosen" method best in your proposal, just a list of 
clocks in order of selection. The DT author knows best.

The "rating" system will never actually work, since what's best on one board 
is almost broken on another.

But it's quite a bit of work to make it right, and I don't have a budget for 
that much work...

> Would it work for you if it will be possible to simply disable ARM GT when needed [1]?
>
> [1] http://www.spinics.net/lists/arm-kernel/msg480166.html

Yeah, what I do now is set status="disabled" for the global timer. I figured 
this patch to be more appropriate though.



>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>    drivers/clocksource/arm_global_timer.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
>> index 9df0d16..bb410eb 100644
>> --- a/drivers/clocksource/arm_global_timer.c
>> +++ b/drivers/clocksource/arm_global_timer.c
>> @@ -209,7 +209,7 @@ static void gt_resume(struct clocksource *cs)
>>
>>    static struct clocksource gt_clocksource = {
>>    	.name	= "arm_global_timer",
>> -	.rating	= 300,
>> +	.rating	= 150,
>>    	.read	= gt_clocksource_read,
>>    	.mask	= CLOCKSOURCE_MASK(64),
>>    	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>>
>
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
