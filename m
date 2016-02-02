From: adhemerval.zanella@linaro.org (Adhemerval Zanella)
Date: Tue, 2 Feb 2016 16:28:02 -0200
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <56B0F47C.7060004@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
 <20160128160747.GN775@arm.com> <56AA470E.1020606@linaro.org>
 <56B0E7EA.9050601@arm.com> <56B0F19C.5090007@linaro.org>
 <56B0F47C.7060004@arm.com>
Message-ID: <56B0F532.2070600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02-02-2016 16:25, Szabolcs Nagy wrote:
> On 02/02/16 18:12, Adhemerval Zanella wrote:
>> On 02-02-2016 15:31, Szabolcs Nagy wrote:
>>> On 28/01/16 16:51, Adhemerval Zanella wrote:
>>>> On 28-01-2016 14:07, Will Deacon wrote:
>>>>> On Tue, Jan 26, 2016 at 10:25:38PM +0530, Siddhesh Poyarekar wrote:
>>>>>> Adding Adhemerval to cc since he had volunteered to follow up on this,
>>>>>> mainly because he had a couple of additional ideas on the kernel
>>>>>> front.
>>>>>>
>>>>>> On Tue, Jan 26, 2016 at 04:21:43PM +0000, Suzuki K. Poulose wrote:
>>>>>>> On 26/01/16 16:02, Will Deacon wrote:
>>>>>>>> Hi Suzuki,
>>>>>>>>
>>>>>>>> On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
>>>>>>>>> ARMv8.2 extensions [1] include an optional feature, which supports
>>>>>>>>> half precision(16bit) floating point/asimd data processing
>>>>>>>>> instructions. This patch adds support for detecting and exposing
>>>>>>>>> the same to the userspace via HWCAPs
>>>>>>>
>>>>>>>
>>>>>>>>> +#define HWCAP_FPHP		(1 << 9)
>>>>>>>>> +#define HWCAP_ASIMDHP		(1 << 10)
>>>>>>>>
>>>>>>>> Where did we get to with the mrs trapping you proposed here?
>>>>>>>>
>>>>>>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html
>>>>>>>
>>>>>>> We are yet to get some feedback from glibc/gcc folks. Siddhesh was looking
>>>>>>> to make use of it [2]. But haven't heard anything back. Ramana mentioned
>>>>>>> (in private) that they had some plans to take a look at it.
>>>>>>
>>>>>> I believe one of Adhemerval's ideas was similar to what I had
>>>>>> mentioned back then, which was to provide all of the CPU information
>>>>>> in a single file instead of having to traverse a directory structure.
>>>>>
>>>>> My understanding was that libc needed this information extremely early
>>>>> on (i.e. before it could even issue system calls), and therefore such
>>>>> an approach would be in addition to the proposal here. Am I mistaken?
>>>>
>>>> If the idea is to use these instruction for function implementation selection
>>>> (iFUNC) the idea is to have on PLT resolution either by accessing it directly
>>>> or using a caching mechanism. x86_64 does something similar with cacheline
>>>> information: it issues a single cpuid and create processor information table
>>>> based on its information (it is also what the __builtin_supports() also
>>>> does).
>>>>
>>>
>>> __builtin_supports is not a single cpuid on x86, it is
>>> a cpuid per dso with one cache per dso.
>>>
>>> (gcc-5 used a single cache in libgcc_s.so.1 and that
>>> turned out to be broken because ifunc in other dsos
>>> could not reliably access it.)
>>
>> It is with static libgcc (default), but if you use -shared-gcc only one
>> __cpu_model (used by __builtin_cpu_supports) will be linked.  But since
>> static libgcc is default it will be indeed one per DSO.
> 
> with shared libgcc x86 fmv is broken, the ifunc
> resolver may run before libgcc gets relocated.
> 
> fwiw shared libgcc is also broken on arm with old kernels.
> (because it aborts if 64bit atomics is not supported,
> the check assumes it only gets linked in if user code
> uses 64bit atomics, but with shared libgcc the check
> is always done.)
> 
> so i dont think shared libgcc is well supported..
> 
>>>>>> The other idea was to add a vDSO function that returns this data so as
>>>>>> to avoid (or at least reduce) the context switch latency.
>>>>>
>>>>> I'm not at all keen on adding a data ABI to the vDSO. I think people tried
>>>>> similar things in the past (something on PPC?) and have horror stories
>>>>> from that.
>>>>
>>>> In fact ppc still exports it in vDSO (include/asm/vdso_datapage.h), with
>>>> information like the LPAR cfg, platform, processor, {d,i}cache, etc.
>>>> I recall that I have see some code back at IBM that tried to use these
>>>> fields directly, but indeed it is not recommended.
>>>>
>>>> What I have in mind is something what ppc does with __kernel_get_syscall_map.
>>>> It is vDSO function that returns a vDSO internal data related to which
>>>> syscalls are implemented in the running kernel (through a bitmap field).
>>>>
>>>
>>> fs access or vdso does not work for ifunc based dispatch
>>> (assuming the current ifunc implementation in glibc).
>>>
>>> (for vdso you need the AT_SYSINFO_EHDR auxval somehow and
>>> then implement elf symbol lookup in the ifunc resolver
>>> without calling any libc function. passing auxvals to the
>>> ifunc resolver can be done by changing the ifunc abi, but
>>> doing symbol lookups there is unrealistic.)
>>>
>>> in the libc (e.g. for memcpy) ifunc is a bit easier to use,
>>> but in user code (function-multi-versioning) ifunc is very
>>> limited.
>>>
>>> i wrote about the ifunc limitations here:
>>> https://sourceware.org/ml/libc-alpha/2015-11/msg00108.html
>>> see point (4) and (5).
>>>
>>
>> I recall this thread and indeed iFUNC have a set of limitations.  Although for
>> use within libc itself it might be safe with the constraints you have described.
>>
>> Now for vDSO usage I think it might be safe to use within GLIBC
>> with correct vDSO pointers initialization order. At least it is done
>> on GLIBC for gettimeofday for x86_64 and powerpc (the iFUNC returns
>> the vDSO function pointer).
>>
> 
> i don't see how that can work with static linking.
> (vdso setup happens after ifunc resolvers are run)

Direct syscalls are used for static case. I didn't yet dig into why exactly
vDSO setup happens after ifunc and if it is possible to change it to
enable this for static linking as well.
