From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 1 Nov 2017 13:32:50 -0700
Subject: [PATCH] arm64: write_sysreg asm illegal for aarch32
In-Reply-To: <ba7f7072-88e5-92ee-f573-4282b6a082d4@android.com>
References: <20171101170014.20931-1-salyzyn@android.com>
 <35cf2062-f27e-16e6-19b1-cae5200d7081@arm.com>
 <24cdf320-35e3-76f2-6e07-8b5548ac67a0@android.com>
 <20171101175642.c65f7kngixjndavr@lakrids.cambridge.arm.com>
 <ba7f7072-88e5-92ee-f573-4282b6a082d4@android.com>
Message-ID: <caa10a1c-b834-3a08-b425-ba8d2ca7a9b0@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 11:16 AM, Mark Salyzyn wrote:
> On 11/01/2017 10:56 AM, Mark Rutland wrote:
>> On Wed, Nov 01, 2017 at 10:49:00AM -0700, Mark Salyzyn wrote:
>>> On 11/01/2017 10:14 AM, Robin Murphy wrote:
>>>> On 01/11/17 16:58, Mark Salyzyn wrote:
>>>>> Cross compiling to aarch32 (for vdso32) using clang correctly
>>>>> identifies that (the unused) write_sysreg inline asm directive is
>>>>> illegal in that architectural context:
>>>>>
>>>>> arch/arm64/include/asm/arch_timer.h: error: invalid input 
>>>>> constraint 'rZ' in asm
>>>>> ????????? write_sysreg(cntkctl, cntkctl_el1);
>>>>> ????????? ^
>>>>> arch/arm64/include/asm/sysreg.h: note: expanded from macro 
>>>>> 'write_sysreg'
>>>>> ?????????????????????? : : "rZ" (__val));
>>>>> ?????????????????????????? ^
>>>>>
>>>>> GCC normally checks for correctness everywhere. But uniquely for
>>>>> unused asm, will optimize out and suppress the error report.
>>>> It sounds more like some paths are wrong in the compat vDSO build if
>>>> it's pulling in this header in the first place - nothing in this 
>>>> file is
>>>> relevant to AArch32.
>>>>
>>>> Robin.
>>>>
>>> And yet, when you CROSS_COMPILE_ARM32 a vdso32, you have no choice 
>>> but to
>>> utilize the arm64 headers since they contain all the relevant kernel
>>> structures and environment.
>> This itself is the underlying issue.
>>
>> When building the compat VDSO, we must ensure that we only include
>> headers that make sense for 32-bit arm.
>>
>> If the build system can't do that today, we should rework it so that it
>> can. Anything else cannot be a complete fix.
>>
>>> asm/arch_timer.h (remember we are using arm instructions to access 
>>> arch64
>>> timers)
>>>
>>> linux/time.h (really only for struct timespec())
>>>
>>> asm/processor.h (eg: cpu_relax())
>>>
>>> pull in a _lot_ of architectural related cruft that always somehow 
>>> picks up
>>> asm/sysreg.h somewhere in the multitude of includes to fulfill some 
>>> unused
>>> inline's needs.
>> ... these are just the particular symptoms this problem results in
>> today.
>>
>> Thanks,
>> Mark.
>
> Ok, will attack it and see just how bad the scale is...
>
> . . .
>
> -- Mark
>
>
Scoped, not as bad as I thought, but there is some open-coded evilness 
to fix:

1) linux/jiffies.h can not be included, replace with open coding:

#include <asm/param.h>

#define TICK_NSEC TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)

2) linux/hrtimer.h can not be included, replace with open coding (must 
have above to work):

#define LOW_RES_NSEC??? ??? TICK_NSEC
#ifdef CONFIG_HIGH_RES_TIMERS
# define HIGH_RES_NSEC??? ??? 1
# define MONOTONIC_RES_NSEC??? HIGH_RES_NSEC
#else
# define MONOTONIC_RES_NSEC??? LOW_RES_NSEC
#endif

3) asm/processor.h can not be included, replace with open coding:

static inline void cpu_relax(void)
{
 ??? asm volatile("yield" ::: "memory");
}

4) linux/time.h can not be included, replace with open coding:

#include <linux/compiler.h>

#include <linux/math64.h>

#include <uapi/linux/time.h>

#define NSEC_PER_SEC 1000000000L

static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
{
 ??? a->tv_sec += __iter_div_u64_rem(a->tv_nsec + ns, NSEC_PER_SEC, &ns);
 ??? a->tv_nsec = ns;
}


I am at a loss to determine if there is an acceptable way to split off 
the open-coding. For instance asm-generic/processor.h (for cpu_relax()), 
uapi/linux/hrtimer.h and uapi/linux/jiffies.h for the #defines (uapi is 
a bad choice, flipping coin?). The time open-coding is probably OK given 
that they have not changed since near the limits of git history.

-- Mark
