From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Dec 2015 10:02:24 +0100
Subject: [PATCH] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
In-Reply-To: <20151216151125.1e91b4f4@xhacker>
References: <1448466169-5230-1-git-send-email-jszhang@marvell.com>
 <56707F32.3030405@linaro.org> <20151216151125.1e91b4f4@xhacker>
Message-ID: <567128A0.8060107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 08:11 AM, Jisheng Zhang wrote:
> Dear Daniel,
>
> On Tue, 15 Dec 2015 21:59:30 +0100 Daniel Lezcano wrote:
>
>> On 11/25/2015 04:42 PM, Jisheng Zhang wrote:
>>> Let's assume the counter value is 0xf000000, the pistachio clocksource
>>> read cycles function would return 0xffffffff0fffffff, but it should
>>> return 0xfffffff.
>>>
>>> We fix this issue by calculating bitwise-not counter, then cast to
>>> cycle_t.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>
>> Hi Jisheng,
>>
>> I tried to reproduce this behavior on x86_64 but without success.
>>
>> On which architecture did you produce this result ? Do you have a simple
>> test program to check with ?
>
> I have no HW platforms with pistachio, just read the code and run the
> following test code in x86_64 and x86_32:
>
> #include <stdio.h>
> unsigned long long pistachio_clocksource_read_cycles()
> {
> 	unsigned int counter = 0xf000000;
> 	return ~(unsigned long long)counter;
> }
> int main()
> {
> 	printf("%llx\n", pistachio_clocksource_read_cycles());
> 	return 0;
> }

Ok, I reproduced it. I had an issue with the signed/unsigned type.

That's a good catch !


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
