From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 22 Mar 2016 15:29:46 +0100
Subject: [PATCH v2 02/18] dt-bindings: timer: sp804: add timer-width
 property
In-Reply-To: <56F13458.1080401@arm.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-3-git-send-email-narmstrong@baylibre.com>
 <20160317170926.GA28934@rob-hp-laptop> <56EAF212.7020700@arm.com>
 <CAL_JsqKRjFDNmGjkPfJ-BKXG8ekNzUgear3uLzsFYbZU7Zph7w@mail.gmail.com>
 <56EB03B3.3070106@arm.com> <56F10E84.1080607@baylibre.com>
 <56F13458.1080401@arm.com>
Message-ID: <56F156DA.3000602@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2016 01:02 PM, Robin Murphy wrote:
> Hi Neil,
>>>>
>>>> Humm, same as integrator timers perhaps?
>>>
>>> Having had a quick look, what the Integrator/AP manual describes certainly smells like the same basic block as the "AMBA Timer" - 16 bit counters and the same control register layout - albeit in a mutant triple-timer version with a bigger offset between each register set. Integrator/CP, on the other hand, looks much more SP804-like.
>>>
>>> Robin.
>>>
>>
>> Hi,
>>
>> I will switch to oxsemi,ox810se-rps-timer since it need a specific register width that will be handled by the driver.
> 
> By "needs a specific register width" do you mean the OxSemi implementation will give a bus error on a 32-bit access and requires 16-bit accessors? If so, I'd expect to see patch 1 changing readl()s to readw()s at least somewhere. Otherwise, if it's merely that the clocksource API needs to know the upper 16 bits of a word it reads are undefined, then since that's the standard behaviour I'd be inclined to add it to the driver as a canonical "arm,amba-timer" implementation, then have your implementation-specific compatible on top of that just in case.

No actually the bus access is 32bit but the counter is 24bit wide instead of 16bit, so the clocksource won't work and the system time will furiously drift. It's not the case of the clockevent since the delay fits in 24 bits.

It also seems is ignores the 32BIT config bit, so it seems based on the initial 16bit only reference design.

How do you think I should implement this ?

Neil

> Robin.
> 
>>
>> Thanks,
>> Neil
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
