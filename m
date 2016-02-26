From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 20:07:34 +0100
Subject: [PATCH][RFC] arm64: kaslr: add pseudo-RNG in kernel
In-Reply-To: <CAGXu5jLgDHhQ7srDU09i=MZndimzhwLopRJR29r7kAoWAyTrxQ@mail.gmail.com>
References: <56D030A4.5050205@nxp.com>
 <CAKv+Gu_UdfQyGx7dU59b5vMqmCKs53XjHbG-UEYmvAZ+0=aQ0g@mail.gmail.com>
 <20160226121819.GB8728@leverpostej>
 <CAKv+Gu-KEF1MdWbxx_mQHuw9tK3xgTCzEbu1cWG_8ug=dMdR1g@mail.gmail.com>
 <CAGXu5jLgDHhQ7srDU09i=MZndimzhwLopRJR29r7kAoWAyTrxQ@mail.gmail.com>
Message-ID: <CAKv+Gu_MkkrRiDtD6juN_VxE0=dZMEVYnusJM40Q9FamFdi=LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2016 at 19:56, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Feb 26, 2016 at 4:37 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 26 February 2016 at 13:18, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Fri, Feb 26, 2016 at 12:51:25PM +0100, Ard Biesheuvel wrote:
>>>> On 26 February 2016 at 12:01, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>>> > In case the bootloader doesn't provide randomness
>>>> > (through device tree or by uefi protocol) generate
>>>> > a pseudo-random seed based on the timer counter.
>>>> > People might find this "week rng" approach convenient
>>>> > as it gets rid of the bootloader dependency.
>>>> >
>>>> > The patch tries to mimic the x86's rdtsc
>>>> > based implementation authored by Kees Cook.
>>>> >
>>>> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> > Cc: Kees Cook <keescook@chromium.org>
>>>>
>>>> Hi Laurentiu,
>>>>
>>>> I appreciate the interest in this work, but to be honest, I don't like
>>>> this at all. I went out of my way to ensure that
>>>> a) the kernel itself does not take part in generating the random bits, and
>>>> b) the random bits are used in such a way that there is no correlation
>>>> between the randomization of the core kernel, the module region and
>>>> the linear region if there is no correlation between the random bits.
>>>>
>>>> The limited entropy of the cycle counter at early boot defeats that,
>>>> and even worse, it will not encourage platform vendors to implement
>>>> this properly in their boot code, given that it will appear to work,
>>>> and the only thing more dangerous than no security is a false sense of
>>>> security imo.
>>>
>>> I agree that a false sense of security is a worry here.
>>>
>>> Either way, I think we need numbers. It's non-obvious how much entropy
>>> we can acquire through counters or other means at early boot time.
>>>
>>> Has anyone done an analysis of environmental entropy available (through
>>> any means) at early boot, VM vs native?
>>>
>>
>> Define 'environmental'. The only architected thing you can rely on is
>> the timer, which really does not hold a lot of entropy on modern solid
>> state platforms. I don't have the numbers, but I do have the
>> experience to back this up, unfortunately (at my former employer).
>>
>> You could argue that KASLR does not require strong entropy like key
>> generation, but I would prefer to simply steer clear of that entire
>> debate. The bootloader simply needs to do the best job it can, either
>> based on some peripheral that the kernel has no awareness of this
>> early in the boot, or perhaps by other means if it doesn't (which
>> could include storing a random seed in the file system, or even in a
>> EFI variable). Punting it to the kernel is really the last resort.
>>
>>> It's also not obvious that vendors will correctly implement the EFI RNG
>>> protocol; depending on the above we may want to mix in additional entropy
>>> regardless.
>>>
>>
>> True, but that is not the point. The main risk I see is that vendors
>> will not bother at all once the digits start to look random to the
>> human eye.
>
> Surely there may be RNG sources that will come along in time that the
> kernel can add to the entropy?

Nope, not for kaslr on arm64.

There are two things to keep in mind here:
- arm64 does not have a decompressor, so there is no runtime
environment with MMU caches etc enabled where you can reasonably
execute arbitrary C code, and I am already pushing the envelope in
kaslr_early_init by mapping the kernel at its default address, enable
the MMU and caches, jump into C code to parse the /chosen node and set
up the randomized mapping, and then tear down the default mapping,
reapply all relocations and reinitialize bss etc etc.
- arm64 is an architecture, not a platform like x86/pc, and so the
only thing we can rely on before we have a clue what kind of system we
are running on, dispatch drivers etc, is what the architecture gives
us, and that does not include anything like a RDRAND instruction.

IOW, the highly restricted C environment that we have before KASLR is
set up does not support arbitrary platforms to slot in the code that
wires up their entropy source, and so we must leave it to the
bootloader.

> I worry about boot loaders doing a
> terrible job of finding a good RNG...
>

The bootloader is more tightly coupled to the hardware than the kernel
is, so it is in a better position to find entropy. Case in point is
UEFI, which can implement its EFI_RNG_PROTOCOL in various ways,

-- 
Ard.
