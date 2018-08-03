From: Richard.Earnshaw@arm.com (Richard Earnshaw (lists))
Date: Fri, 3 Aug 2018 10:42:40 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Message-ID: <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/18 10:29, Ard Biesheuvel wrote:
> On 3 August 2018 at 11:15, Ramana Radhakrishnan
> <ramana.gcc@googlemail.com> wrote:
>> On Fri, Aug 3, 2018 at 8:53 AM, Florian Weimer <fweimer@redhat.com> wrote:
>>> On 08/03/2018 09:11 AM, Andrew Pinski wrote:
>>>>
>>>> Yes fix Links not to use memcpy on the framebuffer.
>>>> It is undefined behavior to use device memory with memcpy.
>>>
>>>
>>> Some (de facto) ABIs require that it is supported, though.  For example, the
>>> POWER string functions avoid unaligned loads and stores for this reason
>>> because the platform has the same issue with device memory.  And yes, GCC
>>> will expand memcpy on POWER to something that is incompatible with device
>>> memory. 8-(
>>
>> GCC for AArch64 - use -mstrict-align
>> GCC for AArch32 - use -mno-unaligned-access.
>>
>> If you see unaligned accesses coming out of the compiler for well
>> defined programs then that's a bug. Frequently we see undefined
>> programs that get the compiler to produce traps - atleast one or 2
>> bugs a year  in  GCC .
>>
>>
>>>
>>> If we don't want people to use memcpy, we probably need to provide a
>>> credible alternative.
>>
>> I believe a number of packages have rolled their own to take these
>> constraints into account
>> for AArch32, perhaps it needs to be expanded for AArch64 as well.
>>
> 
> I guess the semantics of a framebuffer are not strictly defined, but
> the current reality is that it is expected to have memory semantics
> (by Linux/glibc)
> 
> Matt is saying fundamental properties of the underlying interconnects
> (AMBA) make that impossible on ARM, but I'd like to understand better
> if that is universally the case, and whether such a system is still
> PCIe compliant.
> 
> The discussion about whether memcpy() should rely on unaligned
> accesses, and whether you should use it on device memory is orthogonal
> to that, and not the heart of the matter IMO
> 

Whoa, hold on.

Memcpy should never be used on device memory.  Period.  Memcpy doesn't
know anything about what size of access is needed for accessing a device.

But why is the buffer in device memory rather than some other form of
uncached memory?

If you change memcpy to deal with an aspect of the system hardware,
you'll end up hosing performance EVERYWHERE.  DON'T DO IT!

If you must, create a new API with tighter semantics, but don't change
memcpy to accommodate this.

Anyway, back to the original report.  What memory mapping is being used?
 In detail?

R.
