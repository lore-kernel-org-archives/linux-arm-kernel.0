From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 27 Aug 2013 15:33:13 -0600
Subject: [RFC PATCH 1/3] pinctrl: add new generic pinconf config for
 deglitch filter
In-Reply-To: <521C587E.6050706@atmel.com>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
 <521B875E.1010605@wwwdotorg.org> <521B89D1.6010902@overkiz.com>
 <521C2347.4080702@wwwdotorg.org> <521C4451.1060908@overkiz.com>
 <521C587E.6050706@atmel.com>
Message-ID: <521D1B19.6080204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2013 01:42 AM, Nicolas Ferre wrote:
> On 27/08/2013 08:16, boris brezillon :
>> On 27/08/2013 05:55, Stephen Warren wrote:
>>> On 08/26/2013 11:01 AM, boris brezillon wrote:
>>>> Hello Stephen,
>>>>
>>>> On 26/08/2013 18:50, Stephen Warren wrote:
>>>>> On 08/24/2013 03:35 PM, Boris BREZILLON wrote:
>>>>>> Add a new parameter to support deglitch filter configuration.
>>>>>> A deglitch filter works like a debounce filter but with a smaller
>>>>>> delay (nanoseconds).
>>>>> Why not use the existing debounce property, just with a small delay
>>>>> specified. It seems like that's exactly what the property is for?
>>>> That's one of the question I asked in my cover letter :-)
>>>>
>>>> Indeed the at91 deglitch filter delay is not configurable and is
>>>> statically
>>>> assigned to half a master clk cycle (if master clk = 133MHz -> 8 ns).
>>>> The debounce property argument is currently expressed in usecs.
>>>>
>>>> This will result in always selecting the debounce filter (which is also
>>>> available on at91 SoCs) over the deglitch filter.
>>>>
>>>> Could we add a flag in the deglitch argument to specify the delay unit
>>>> (nsecs or usecs) ?
>>> If the value is hard-coded in HW, why not use non-zero (or 1) to enable
>>> and zero to disable?
>>
>> Indeed at91 pins support both deglitch and debounce filter and I have to
>> choose
>> between the two given the argument value (in usec).
>>
>> Here's what I can do:
>>
>> if (arg >= 1/2 * slowclock)    /* debounce case */
>>       /* choose debounce filter and configure the delay
>>           according to the given argument value */
>> else                                          /* deglitch case */
>>       /* choose deglitch filter */
>>
>>
>> Slow clock is running at 32KHz which gives a 30 usec clock cycle.
> 
> I am not in favor for this kind of complicated heuristic. Deglitch and
> Debounce filters are different features in at91 (even if they pursuit
> the same goal). So I do prefer to let the user choose which feature is
> preferred for his application and add a different flag.
> 
> 
>>> (this kind of thing is why I'm not convinced that generic pinconf works
>>> so well... What if we need psecs in the future?)
>>
>> Should I keep the at91 native pinconf binding and add the missing flags
>> to this binding
>> (OUTPUT configuration flags) ?
>>
>> This was another question I asked in my cover letter: wether or not the
>> generic pinconf
>> binding should be used.
> 
> The question is: how much this "generic" pinconf is... well... generic!

This is why I don't really like the concept of generic pinconf; it ends
up being more: whoever defines something first imposes their SoCs'
viewpoint on that feature/property, and then everything else is declared
non-generic.

In many cases, I think bindings will need to add SoC-specific properties
beyond generic pinconf (or perhaps only use SoC-specific properties and
ignore generic pinconf).

In the case of deglitch here, perhaps that's the best answer.
