From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 29 Feb 2016 12:47:16 +0000
Subject: [PATCH][RFC] arm64: kaslr: add pseudo-RNG in kernel
In-Reply-To: <CAKv+Gu-KEF1MdWbxx_mQHuw9tK3xgTCzEbu1cWG_8ug=dMdR1g@mail.gmail.com>
References: <56D030A4.5050205@nxp.com>
 <CAKv+Gu_UdfQyGx7dU59b5vMqmCKs53XjHbG-UEYmvAZ+0=aQ0g@mail.gmail.com>
 <20160226121819.GB8728@leverpostej>
 <CAKv+Gu-KEF1MdWbxx_mQHuw9tK3xgTCzEbu1cWG_8ug=dMdR1g@mail.gmail.com>
Message-ID: <56D43DD3.9010508@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 02:37 PM, Ard Biesheuvel wrote:
> On 26 February 2016 at 13:18, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Feb 26, 2016 at 12:51:25PM +0100, Ard Biesheuvel wrote:
>>> On 26 February 2016 at 12:01, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>>> In case the bootloader doesn't provide randomness
>>>> (through device tree or by uefi protocol) generate
>>>> a pseudo-random seed based on the timer counter.
>>>> People might find this "week rng" approach convenient
>>>> as it gets rid of the bootloader dependency.
>>>>
>>>> The patch tries to mimic the x86's rdtsc
>>>> based implementation authored by Kees Cook.
>>>>
>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>
>>> Hi Laurentiu,
>>>
>>> I appreciate the interest in this work, but to be honest, I don't like
>>> this at all. I went out of my way to ensure that
>>> a) the kernel itself does not take part in generating the random bits, and
>>> b) the random bits are used in such a way that there is no correlation
>>> between the randomization of the core kernel, the module region and
>>> the linear region if there is no correlation between the random bits.
>>>
>>> The limited entropy of the cycle counter at early boot defeats that,
>>> and even worse, it will not encourage platform vendors to implement
>>> this properly in their boot code, given that it will appear to work,
>>> and the only thing more dangerous than no security is a false sense of
>>> security imo.
>>
>> I agree that a false sense of security is a worry here.
>>
>> Either way, I think we need numbers. It's non-obvious how much entropy
>> we can acquire through counters or other means at early boot time.
>>
>> Has anyone done an analysis of environmental entropy available (through
>> any means) at early boot, VM vs native?
>>
> 
> Define 'environmental'. The only architected thing you can rely on is
> the timer, which really does not hold a lot of entropy on modern solid
> state platforms. I don't have the numbers, but I do have the
> experience to back this up, unfortunately (at my former employer).
> 
> You could argue that KASLR does not require strong entropy like key
> generation, but I would prefer to simply steer clear of that entire
> debate. The bootloader simply needs to do the best job it can, either
> based on some peripheral that the kernel has no awareness of this
> early in the boot, or perhaps by other means if it doesn't (which
> could include storing a random seed in the file system, or even in a
> EFI variable). Punting it to the kernel is really the last resort.
> 
>> It's also not obvious that vendors will correctly implement the EFI RNG
>> protocol; depending on the above we may want to mix in additional entropy
>> regardless.
>>
> 
> True, but that is not the point. The main risk I see is that vendors
> will not bother at all once the digits start to look random to the
> human eye.
> 
>>> What I would ack, for development purposes, is something similar to
>>> what Mark Rutland implemented for randomizing TEXT_OFFSET, so that
>>> developers get to exercise this code even if their boot environment
>>> does not provide any entropy. Anything beyond that is a nack as far as
>>> I am concerned.
>>
>> FWIW, I would not like to see that approach. I can easily see a build-time
>> constant KASLR seed being abused to give a false sense of security. Having a
>> bootloader or hypervisor provide different random seeds to the same Image gives
>> you a much better turnaround time for testing regardless (vs rebuilding,
>> copying, etc).
>>

Hi guys,

And thanks for all the great comments. In conclusion, seems that this
patch is not the right direction, at least not in its current form.
 
> If it would be *instead* of the ordinary handling, with a big fat
> blurb saying that KASLR is disabled, I would not mind.

Ard,

Let me see if i understood your thoughts correctly.
Have something like a KConfig option (suggestions for name, please?
CONFIG_DEBUG_RANDOMIZE_BASE?) that disables the normal RNG seed
handling and replaces it with this counter based weak rng,
plus the big fat warning.

---
Best Regards, Laurentiu
