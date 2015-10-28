From: amittomer25@gmail.com (Amit Tomer)
Date: Thu, 29 Oct 2015 00:32:51 +0530
Subject: [PATCH v1] Ftrace: arm/arm64: Define a new arm/arm64 trace clock
 source based on CNTPCT/CNTPCT_EL0 register.
In-Reply-To: <20151028124726.GD25451@leverpostej>
References: <1445854558-16253-1-git-send-email-amittomer25@gmail.com>
 <20151028124726.GD25451@leverpostej>
Message-ID: <CABHD4K-KugtaLvc98wEMWm0iN_3v=d2UYkSmpSMCX91s-EAnhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 6:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 26, 2015 at 03:45:58PM +0530, Amit wrote:
>> From: Amit Singh Tomar <amittomer25@gmail.com>
>>
>> Define new arm/arm64 specific trace clock using CNTPCT/CNTPCT_EL0 register,
>> similar to x86-tsc. It can be used to correlate trace events across
>> hosts and guest that can be useful for debugging purpose.
>>
>> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
>> ---
>> Changes since RFC:
>>       * Replaced define with static inline
>>       * Revert few changes done in ftrace.txt
>>       * Made it common between ARM and ARM64.
>> ---
>>  Documentation/trace/ftrace.txt       | 12 ++++++++++++
>>  arch/arm/include/asm/Kbuild          |  1 -
>>  arch/arm/include/asm/trace_clock.h   | 21 +++++++++++++++++++++
>>  arch/arm/kernel/Makefile             |  2 ++
>>  arch/arm/kernel/trace_clock.c        | 33 +++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/Kbuild        |  1 -
>>  arch/arm64/include/asm/trace_clock.h | 21 +++++++++++++++++++++
>>  arch/arm64/kernel/Makefile           |  2 ++
>>  8 files changed, 91 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/include/asm/trace_clock.h
>>  create mode 100644 arch/arm/kernel/trace_clock.c
>>  create mode 100644 arch/arm64/include/asm/trace_clock.h
>>
>> diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
>> index ef621d3..13f3737 100644
>> --- a/Documentation/trace/ftrace.txt
>> +++ b/Documentation/trace/ftrace.txt
>> @@ -351,6 +351,18 @@ of ftrace. Here is a list of some of the key files:
>>                 to correlate events across hypervisor/guest if
>>                 tb_offset is known.
>>
>> +      arm-pct: This uses ARM Physical Count register value.This
>> +               is different from default "local" clock which
>> +               usese Virtual Count register.This is consistent
>> +               across processors and can be used to correlate
>> +               events across host/guest.
>> +
>> +      arm64-pct: This uses ARM64 Physical Timer Count register
>> +                   value. This is different from default "local"
>> +                   clock which usese Virtual Timer Count register.
>> +                   This is consistent across processors and can be
>> +                   used to correlate events across host/guest.
>
> The above is wrong. Both the physical and virtual counters have the same
> guarantees w.r.t. consistency across CPUs for the same VM image. Neither
> is more local than the other.

I never said virtual counters are not consistent across CPU's but pointed out
that Values of Virtual counter seen by host and guest are
different(but even in Host context
I have seen VCT is not exactly equal to PCT).

> In the host you will have access to CNTVOFF, so you can use that to
> correlate the virtual counter.

I don't think CNTVOFF can be accessible from normal el1 host code and
do you think reading it from el2 and then feed it to virtual counter
is good idea?

> Additionally, it's not safe to read the physical counter register unless
> you know that access has not been denied by the hypervisor; so any Linux
> image not booted at hyp cannot use this. If the hypervisor emulates the
> access, it will also be horrifically slow.
>

Sorry but are you saying if kernel doesn't boot in HYP mode , I have no way to
read Physical counter in Guest?


>
> This is arch/arm. This cannot build for 32-bit.
>

I did build it on ARM(32 bit) and for the same made a check using
"#ifdef CONFIG_ARM64", so would you  relook at it again.

Thanks
Amit.
