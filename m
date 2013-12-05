From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 05 Dec 2013 17:45:12 -0500
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <20131205201659.GA14539@kroah.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
 <20131205040104.GA14641@kroah.com> <52A0DE42.3080602@codeaurora.org>
 <20131205201659.GA14539@kroah.com>
Message-ID: <52A101F8.3060104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 03:16 PM, Greg Kroah-Hartman wrote:
> On Thu, Dec 05, 2013 at 03:12:50PM -0500, Christopher Covington wrote:
[...]
> And adding new features to code that is "dead" and should probably be
> removed isn't a good idea, as I'm sure you can understand.

I would consider feature additions to be a sign of life. Maybe the
architecture or user interface isn't ideal, but would you suggest just as
quickly for media codec or cryptography hardware support be removed? Those
operations can also be performed purely in software, and of course the pure
software implementation is easier to integrate cleanly across multiple
architectures, but as with tracing hardware, software implementations don't
perform at the rate and scale that some use cases require.

>>>> Coresight ETM is not just faster than /sys/kernel/debug/tracing, it
>>>> provides more detailed and customisable info. For instance, you can
>>>> trace every load, store, instruction fetch, along with the number of
>>>> cycles taken, with almost zero-overhead.
>>>
>>> Can't you already do that with the 'perf' tool the kernel provides
>>> without the ETM driver?
>>
>> With perf one can get a count of how many instructions have been executed,
>> with little overhead, but not the full list of opcodes and addresses.
> 
> Is that a limitation of perf on ARM or perf in general?  For some reason
> I thought I had seen this using perf on x86, but it's been a while since
> I last used it.

Try this:

perf record -e instructions:u -c 1 echo hello && perf script

At least on my machines this clearly does not produce an instruction trace.
What you probably are familiar with is the periodic sampling I mentioned below.

>> (One can also sample the Program Counter intermittently, which might
>> suffice for performance analysis, but probably doesn't for most
>> debugging use cases.) I think with perf one can have a handful of
>> watchpoints looking at a very few loads and stores, with large
>> overhead. As I understand it, ETM can handle arbitrarily large
>> regions, with little overhead.
> 
> How much work is it to incorportate ETM into the perf framework?  Don't
> you think that this is a better thing to do overall, instead of having
> duplicating interfaces for the same thing?

I'm not familiar enough with the ETM hardware (and the ETB, the buffer where
the data is stored) and driver to say. One factor may be whether the perf
events framework would need to be extended for complete functionality or could
be used as-is.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
