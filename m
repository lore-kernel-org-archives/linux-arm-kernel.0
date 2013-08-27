From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 27 Aug 2013 08:16:49 +0200
Subject: [RFC PATCH 1/3] pinctrl: add new generic pinconf config for
 deglitch filter
In-Reply-To: <521C2347.4080702@wwwdotorg.org>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
 <521B875E.1010605@wwwdotorg.org> <521B89D1.6010902@overkiz.com>
 <521C2347.4080702@wwwdotorg.org>
Message-ID: <521C4451.1060908@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2013 05:55, Stephen Warren wrote:
> On 08/26/2013 11:01 AM, boris brezillon wrote:
>> Hello Stephen,
>>
>> On 26/08/2013 18:50, Stephen Warren wrote:
>>> On 08/24/2013 03:35 PM, Boris BREZILLON wrote:
>>>> Add a new parameter to support deglitch filter configuration.
>>>> A deglitch filter works like a debounce filter but with a smaller
>>>> delay (nanoseconds).
>>> Why not use the existing debounce property, just with a small delay
>>> specified. It seems like that's exactly what the property is for?
>> That's one of the question I asked in my cover letter :-)
>>
>> Indeed the at91 deglitch filter delay is not configurable and is statically
>> assigned to half a master clk cycle (if master clk = 133MHz -> 8 ns).
>> The debounce property argument is currently expressed in usecs.
>>
>> This will result in always selecting the debounce filter (which is also
>> available on at91 SoCs) over the deglitch filter.
>>
>> Could we add a flag in the deglitch argument to specify the delay unit
>> (nsecs or usecs) ?
> If the value is hard-coded in HW, why not use non-zero (or 1) to enable
> and zero to disable?

Indeed at91 pins support both deglitch and debounce filter and I have to 
choose
between the two given the argument value (in usec).

Here's what I can do:

if (arg >= 1/2 * slowclock)    /* debounce case */
     /* choose debounce filter and configure the delay
         according to the given argument value */
else                                          /* deglitch case */
     /* choose deglitch filter */


Slow clock is running at 32KHz which gives a 30 usec clock cycle.

>
> (this kind of thing is why I'm not convinced that generic pinconf works
> so well... What if we need psecs in the future?)

Should I keep the at91 native pinconf binding and add the missing flags 
to this binding
(OUTPUT configuration flags) ?

This was another question I asked in my cover letter: wether or not the 
generic pinconf
binding should be used.
