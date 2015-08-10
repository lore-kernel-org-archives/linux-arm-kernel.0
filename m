From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Aug 2015 19:48:48 +0200
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <55C8E12E.6030305@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com>
Message-ID: <CAKv+Gu-9GTzjqyT=NeBKjcaL7q-uFMToqPpprkyD-faG0J3mkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 August 2015 at 19:36, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 10/08/15 17:06, Catalin Marinas wrote:
>>
>> Hi Suzuki,
>>
>> On Fri, Jul 24, 2015 at 10:43:47AM +0100, Suzuki K. Poulose wrote:
>>>
>>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>>
>>> Documentation of the infrastructure
>>>
>>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>>
>>
>> The implementation looks fine but I think the main discussion will be
>> around the goal of this feature and the ABI that it introduces. So I'll
>> just write my thoughts on this patch (I could as well have replied to
>> the cover letter).
>>
>> Another question: who's going to use this feature? I know people asked
>> in private but I'd like to have some public statements.
>
>
> Right, I am hoping that folks from glibc / JIT / GCC will respond to
> this thread.
>
>>
> ...
>
>>> + a) Any change to the HWCAPs requires an update to userspace (e.g libc)
>>> +    to detect the new changes, which can take a long time to appear in
>>> +    distributions. Exposing the registers allows applications to get the
>>> +    information without requiring other userspace components to be
>>> updated.
>>
>>
>> How does it help if you have a new CPUID field or even a new value in an
>> existing field? Doesn't userspace need to be changed anyway to make use
>> of the new feature? I don't think that's a valid argument.
>>
>
> Yes, the userspace would need an update to work with the new CPUID field. I
> understand.
> It is just that, "in the enterprise world" updates to the system libraries
> provided by
> the distribution might take a bit longer to provide the changes than a
> software vendor.
> I agree thats not a common case.
>
>
>>> + b) Access to HWCAPs is sometimes restricted (e.g prior to libc, or when
>>> ld is
>>> +    initialised at startup time).
>>
>>
>> That's useful indeed.
>
>
> OK
>
>>
>>> + c) HWCAPs cannot represent non-boolean information effectively. The
>>> +    architecture defines a canonical format for representing features
>>> +    in the ID registers; this is well defined and is capable of
>>> +    representing all valid architecture variations. Exposing the ID
>>> +    registers avoids having to come up with HWCAP representations
>>> +    and parsing code.
>>
>>
>> So far we've managed to cope with the boolean state of HWCAP, at least
>> for information relevant to user space. One thing it doesn't cover is
>> MIDR_EL1.
>>
>> But the question here is whether we continue to add HWCAP bits even when
>> we exposed the CPUID registers to user. IMO, we should continue to add
>> the HWCAP bits matching new CPUID features for a few reasons:
>
>
> I don't have a strong opinion against it.
>
>>
>> 1. It's the current interface that we have and the bits can be checked
>>     in standard C code without having to issue arm64-specific instructions
>>
>
> I agree. May be we could provide library interface for this in the future ?
>
>> 2. We still need features listed in /proc/cpuinfo, at least for humans
>>     reading this file or scripts that can't issue mrs instructions
>>
>
> Agreed, we still need to provide the features in /proc/cpuinfo. We could do
> this without HWCAP if we decide not to update the list.
>
>> And to debunk some of the counter arguments:
>>
>> a) Running out of HWCAP bits - I really doubt this, we can always
>>     introduce 64 more via a new elf_hwcapX
>

Note that ELF_HWCAP is also wired into ifunc resolution of GNU
indirect functions, which looks like a useful feature although it
isn't used that widely yet.

The ifunc prototype for aarch64 has only one 'long' parameter, and I
don't know if it is possible to extend that without having a bit in
HWCAPn to indicate that HWCAPn+1 is valid. Also, the ifunc resolvers
are restricted in the sense that they cannot use shared libraries or
code that uses constructors (AFAIR) so it may require a special static
library to call this CPU feature interface from such a resolver if
features are not covered by HWCAP bits.

So treating HWCAP bits as an endless supply may not be the wisest
approach here. Also, I think some alignment with the libc folks is
indeed in order.

-- 
Ard.
