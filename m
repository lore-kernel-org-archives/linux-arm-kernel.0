From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Tue, 24 Dec 2013 13:36:26 +0200
Subject: [PATCH v2 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <52B9479B.3040108@ti.com>
References: <1387297337-25493-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387297337-25493-2-git-send-email-ivan.khoronzhuk@ti.com>
 <20131224005804.GF31766@codeaurora.org> <52B9479B.3040108@ti.com>
Message-ID: <52B971BA.7040705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2013 10:36 AM, ivan.khoronzhuk wrote:
> On 12/24/2013 02:58 AM, Stephen Boyd wrote:
>> On 12/17, Ivan Khoronzhuk wrote:
>>> +static void __init keystone_timer_init(struct device_node *np)
>>> +{
>>> +    struct clock_event_device *event_dev = &timer.event_dev;
>>> +    unsigned long rate;
>> [...]
>>> +
>>> +    timer.hz_period = rate / (HZ);
>>
>> Unnecessary parentheses here. Also, do you need to use do_div()
>> here? I'm lost how the hz_period is ever greater than 32 bits
>> though because HZ is most likely very small and the rate is
>> unsigned long.
>>
> 
> You are right.
> I'll do the following:
> 
> timer.hz_period = rate / (HZ)    ---> timer.hz_period = rate / HZ
> u64 hz_period            ---> unsigned long hz_period
> 

... maybe it be better to use DIV_ROUND_UP to be sure in no less than HZ period:

timer.hz_period = rate / (HZ) --> timer.hz_period = DIV_ROUND_UP(rate, HZ)

-- 
Regards,
Ivan Khoronzhuk
