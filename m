From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 10 Aug 2015 18:36:46 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
Message-ID: <55C8E12E.6030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/15 17:06, Catalin Marinas wrote:
> Hi Suzuki,
>
> On Fri, Jul 24, 2015 at 10:43:47AM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Documentation of the infrastructure
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>
> The implementation looks fine but I think the main discussion will be
> around the goal of this feature and the ABI that it introduces. So I'll
> just write my thoughts on this patch (I could as well have replied to
> the cover letter).
>
> Another question: who's going to use this feature? I know people asked
> in private but I'd like to have some public statements.

Right, I am hoping that folks from glibc / JIT / GCC will respond to
this thread.

>
...

>> + a) Any change to the HWCAPs requires an update to userspace (e.g libc)
>> +    to detect the new changes, which can take a long time to appear in
>> +    distributions. Exposing the registers allows applications to get the
>> +    information without requiring other userspace components to be updated.
>
> How does it help if you have a new CPUID field or even a new value in an
> existing field? Doesn't userspace need to be changed anyway to make use
> of the new feature? I don't think that's a valid argument.
>

Yes, the userspace would need an update to work with the new CPUID field. I understand.
It is just that, "in the enterprise world" updates to the system libraries provided by
the distribution might take a bit longer to provide the changes than a software vendor.
I agree thats not a common case.


>> + b) Access to HWCAPs is sometimes restricted (e.g prior to libc, or when ld is
>> +    initialised at startup time).
>
> That's useful indeed.

OK

>
>> + c) HWCAPs cannot represent non-boolean information effectively. The
>> +    architecture defines a canonical format for representing features
>> +    in the ID registers; this is well defined and is capable of
>> +    representing all valid architecture variations. Exposing the ID
>> +    registers avoids having to come up with HWCAP representations
>> +    and parsing code.
>
> So far we've managed to cope with the boolean state of HWCAP, at least
> for information relevant to user space. One thing it doesn't cover is
> MIDR_EL1.
>
> But the question here is whether we continue to add HWCAP bits even when
> we exposed the CPUID registers to user. IMO, we should continue to add
> the HWCAP bits matching new CPUID features for a few reasons:

I don't have a strong opinion against it.

>
> 1. It's the current interface that we have and the bits can be checked
>     in standard C code without having to issue arm64-specific instructions
>

I agree. May be we could provide library interface for this in the future ?

> 2. We still need features listed in /proc/cpuinfo, at least for humans
>     reading this file or scripts that can't issue mrs instructions
>

Agreed, we still need to provide the features in /proc/cpuinfo. We could do
this without HWCAP if we decide not to update the list.

> And to debunk some of the counter arguments:
>
> a) Running out of HWCAP bits - I really doubt this, we can always
>     introduce 64 more via a new elf_hwcapX

OK :)

>
> b) Non-boolean information - The CPUID scheme (not MIDR) is pretty much
>     boolean, each increment of the field adding a new feature or
>     extending an existing one. We could do the same with HWCAP bits (e.g.
>     HWCAP_FEATUREv4)

OK

>> + b) Security :
>> +    Applications should only be able to receive information that is relevant
>> +    to the normal operation in userspace. Hence, some of the fields
>> +    are masked out and the values of the fields are set to indicate the
>> +    feature is 'not supported' (See the 'visible' field in the
>> +    table in Section 4). Also, the kernel may manipulate the fields based on what
>> +    it supports. e.g, If FP is not supported by the kernel, the values
>> +    could indicate that the FP is not available (even when the CPU provides
>> +    it).
>
> That's fine as well.
>
> What we don't cover is what to do with emulated features. Luckily, we
> don't have any for AArch64 currently. If we ever need to do this, do we
> fake the CPUID to pretend we have the feature or we don't expose it at
> all. I would vote for the latter but that's probably too vague to make
> any decision now.

Right. We could pretend to have a feature which the userspace can safely
operate, given kernel/hardware can handle it.

>
>> + c) Implementation Defined Features
>> +    The infrastructure doesn't expose any register which is
>> +    IMPLEMENTATION DEFINED as per ARMv8-A Architecture and is set to 0.
>
> It may be worth adding somewhere the (unwritten; yet) rules of the CPUID
> fields: original 4-bit signed field is RAZ. When a feature is added or
> extended, the field is incremented. If an existing feature is removed
> for which the CPUID field is 0, the field becomes negative (0xf).

May be I can add it as an 'Notes' section at the end ?

>
>> + d) CPU Identification :
>> +    MIDR_EL1 is exposed to help identify the processor. On a heterogeneous
>> +    system, this could be racy (just like getcpu()). The process could be
>> +    migrated to another CPU by the time we use the register value. Hence,
>
> s/we use/it uses/

Will fix it.
  

>> +    there is no guarantee that the value reflects the processor that it is
>> +    currently executing on.
>
> You could extend this a bit, something like "unless the CPU affinity is
> set".

Sure, makes sense.

>
> Anyway, for this reason, we decided not to expose REVIDR since it can
> only be read in conjunction with MIDR.

Right.

...
>> +3. Implementation
>> +--------------------
>> +
...
>> +The infrastructure emulates only the following system register space:
>> +	Op0=3, Op1=0, CRn=0
>> +
>> +(See Table C5-6 'System instruction encodings for System register accesses'
>> + in ARMv8 ARM, for the list of registers).
>> +
>> +
>> +The following rules are applied to the value returned by the infrastructure:
>> +
>> + a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
>> + b) The value of a reserved field is set to the reserved value(as
>> +    defined by the architecture).
>
> Do we expose any IMPLEMENTATION DEFINED or reserved field to user?

We don't. All such fields are marked invisible. The above rules define
how we fill those 'special' (invisible) fields. We 'emulate' all
access to the space (as defined above) with Op0=3, Op1=0 & CRn=0.
Out of this space, there are only a very few 'visible' fields(listed in
section 4). These rules, define how the values are emulated.

>
>> + c) The value of a field marked as not 'visible', is set to indicate
>> +    the feature is missing (as defined by the architecture).
>> + d) The value of a 'visible' field holds the system wide safe value
>> +    for the particular feature(except for MIDR_EL1, see section 4)
>
> I'm slightly confused by the visible/not-visible definition. GIC for
> example may be present but we don't want to expose it to user, hence you
> marked it as "not visible" in the table. But the feature is definitely
> not missing, it may be present and we just decided not to expose it to
> EL0 since it is not relevant.

Thats right. In this case, the userspace will see that 'GIC' is not present
even though it is available. Btw, the system wide value(exposed to the system
wide users) could be different from what the user gets. e.g, if all the CPUs
have GIC system register access, the system view will have 'GIC' available.

Taking another example to explain rule (d), if all CPUs but one supports CRC32
instructions, both the system view and the user view will have CRC32 disabled.


Thanks
Suzuki
