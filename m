From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 22 Mar 2016 12:02:32 +0000
Subject: [PATCH v2 02/18] dt-bindings: timer: sp804: add timer-width
 property
In-Reply-To: <56F10E84.1080607@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-3-git-send-email-narmstrong@baylibre.com>
 <20160317170926.GA28934@rob-hp-laptop> <56EAF212.7020700@arm.com>
 <CAL_JsqKRjFDNmGjkPfJ-BKXG8ekNzUgear3uLzsFYbZU7Zph7w@mail.gmail.com>
 <56EB03B3.3070106@arm.com> <56F10E84.1080607@baylibre.com>
Message-ID: <56F13458.1080401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 22/03/16 09:21, Neil Armstrong wrote:
> On 03/17/2016 08:21 PM, Robin Murphy wrote:
>> On 17/03/16 19:00, Rob Herring wrote:
>>> On Thu, Mar 17, 2016 at 1:06 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>> Hi Rob,
>>>>
>>>> On 17/03/16 17:09, Rob Herring wrote:
>>>>> That would not be an SP804 nor would the vendor be ARM in that case. So
>>>>> add a new compatible string for the vendor that decided to hack up ARM's
>>>>> IP block.
>>>>
>>>>
>>>> By all accounts this is some ancient reference design[1] which later evolved
>>>> _into_ the SP804, so that vendor would probably still be ARM ;)
>>>
>>> Right.
>>>
>>>> A separate compatible string would indeed make more sense, though. Both
>>>> semantically and in terms of letting the driver account for the differences
>>>> automatically.
>>>>
>>>> Robin.
>>>>
>>>> [1]:http://infocenter.arm.com/help/topic/com.arm.doc.ddi0170a/I350250.html
>>>
>>> Humm, same as integrator timers perhaps?
>>
>> Having had a quick look, what the Integrator/AP manual describes certainly smells like the same basic block as the "AMBA Timer" - 16 bit counters and the same control register layout - albeit in a mutant triple-timer version with a bigger offset between each register set. Integrator/CP, on the other hand, looks much more SP804-like.
>>
>> Robin.
>>
>
> Hi,
>
> I will switch to oxsemi,ox810se-rps-timer since it need a specific register width that will be handled by the driver.

By "needs a specific register width" do you mean the OxSemi 
implementation will give a bus error on a 32-bit access and requires 
16-bit accessors? If so, I'd expect to see patch 1 changing readl()s to 
readw()s at least somewhere. Otherwise, if it's merely that the 
clocksource API needs to know the upper 16 bits of a word it reads are 
undefined, then since that's the standard behaviour I'd be inclined to 
add it to the driver as a canonical "arm,amba-timer" implementation, 
then have your implementation-specific compatible on top of that just in 
case.

Robin.

>
> Thanks,
> Neil
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
