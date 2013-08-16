From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 16 Aug 2013 13:41:29 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <B78CECED-CF8B-4FC0-A4C5-D29F81F8D40E@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
 <520C9AEA.6030507@arm.com>
 <9E753731-852D-4F04-931B-112B589D9FFB@codeaurora.org>
 <520E0556.5080702@arm.com>
 <B78CECED-CF8B-4FC0-A4C5-D29F81F8D40E@codeaurora.org>
Message-ID: <520E1DF9.6070005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/13 12:31, Kumar Gala wrote:
>
> On Aug 16, 2013, at 5:56 AM, Punit Agrawal wrote:
>
>> Hi Kumar,
>>
>> On 15/08/13 20:00, Kumar Gala wrote:
>>>
>>> On Aug 15, 2013, at 4:10 AM, Punit Agrawal wrote:
>>>
>>>>> What is the list of interrupts related to, should there be an associated interrupts-names
>>>>>
>>>>
>>>> For the CCI PMU, each interrupt signal corresponds to the overflow of a performance counter.
>>>>
>>>> Here again, I was trying to be robust in the face of differing hardware configurations - specially the scenario where multiple interrupt lines from the CCI PMU are tied together to generate a single interrupt to the CPU.
>>>
>>> Even in the case of multiple interrupt lines tied together, why wouldn't you still specify each interrupt specifier and they all just be the same and thus the interrupt appears to be shared ?
>>>
>>
>> I am not quite sure what you are asking here. Are you suggesting that even if the interrupts are muxed, they should be specified multiple times?
>
> I'm saying the # of interrupts should equal the # of counters w/regards to the dts and binding.
>
>> Below is an update I've added to the documentation to better describe the interrupts. Does this help?
>>
>> @@ -104,8 +103,19 @@ specific to ARM.
>>                 - interrupts:
>>                         Usage: required
>>                         Value type: <prop-encoded-array>
>> -                   Definition: comma-separated list of unique PMU
>> -                               interrupts
>> +                 Definition: comma-separated list of counter overflow
>> +                             interrupts.
>> +
>> +                             The CCI PMU has an interrupt signal for each
>> +                             counters. Typically, the number of
>> +                             interrupts will be equal to the number of
>> +                             counters.
>> +
>> +                             On some platforms, the individual interrupt
>> +                             signals may be combined in some fashion
>> +                             before being routed to the interrupt
>> +                             controller resulting in less number of
>> +                             interrupts than counters.
>
> I'd drop the last paragraph.  Think about a case in which the SoC ORs all the interrupts for each counter together, in the .dts it should still look something like (my example assumes 4 counters):
>
> interrupts = < 0 100 4 >, < 0 100 4 >, < 0 100 4 >, < 0 100 4 >;
>
> or lets say the SoC has 2 interrupts with counters 1 & 2 on first interrupt and 3 & 4 on second
>
> interrupts = < 0 100 4 >, < 0 100 4 >, < 0 101 4 >, < 0 101 4 >;
>
> or a crazy SoC (counters 1 & 3 on first interrupt, 2 & 4 on second):
>
> interrupts = < 0 100 4 >, < 0 101 4 >, < 0 100 4 >, < 0 101 4 >;
>
> make sense?
>

Got it. I was trying to prevent the need to specify duplicate interrupts 
but I'll update the patch with this and the other review comments and 
post a new version.

Thanks once again for the review.

Cheers,
Punit

> - k
>
