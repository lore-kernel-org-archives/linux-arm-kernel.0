From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Wed, 30 Nov 2016 11:05:41 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <7a35d1ae-73df-03a5-c9d6-1a52754acf25@redhat.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
 <7a35d1ae-73df-03a5-c9d6-1a52754acf25@redhat.com>
Message-ID: <583EB285.5050305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 10:08, Florian Weimer wrote:
> On 11/25/2016 08:38 PM, Dave Martin wrote:
>> The Scalable Vector Extension (SVE) [1] is an extension to AArch64 which
>> adds extra SIMD functionality and supports much larger vectors.
>>
>> This series implements core Linux support for SVE.
>>
>> Recipents not copied on the whole series can find the rest of the
>> patches in the linux-arm-kernel archives [2].
>>
>>
>> The first 5 patches "arm64: signal: ..." factor out the allocation and
>> placement of state information in the signal frame.  The first three
>> are prerequisites for the SVE support patches.
>>
>> Patches 04-05 implement expansion of the signal frame, and may remain
>> controversial due to ABI break issues:
>>
>>  * Discussion is needed on how userspace should detect/negotiate signal
>>    frame size in order for this expansion mechanism to be workable.
> 
> I'm leaning towards a simple increase in the glibc headers (despite the ABI risk), plus a personality flag to
> disable really wide vector registers in case this causes problems with old binaries.
> 

if the kernel does not increase the size and libc
does not add size checks then old binaries would
work with new libc just fine..
but that's non-conforming, posix requires the check.

if the kernel increases the size then it has to be
changed in bionic and musl as well and old binaries
may break.

> A more elaborate mechanism will likely introduce more bugs than it makes existing applications working, due to
> its complexity.
> 
>> The remaining patches implement initial SVE support for Linux, with the
>> following limitations:
>>
>>  * No KVM/virtualisation support for guests.
>>
>>  * No independent SVE vector length configuration per thread.  This is
>>    planned, but will follow as a separate add-on series.
> 
> Per-thread register widths will likely make coroutine switching (setcontext) and C++ resumable
> functions/executors quite challenging.
> 

i'd assume it's undefined to context switch to a different
thread or to resume a function on a different thread
(because the implementation can cache thread local state
on the stack: e.g. errno pointer).. of course this does
not stop ppl from doing it, but the practice is questionable.

> Can you detail your plans in this area?
> 
> Thanks,
> Florian
