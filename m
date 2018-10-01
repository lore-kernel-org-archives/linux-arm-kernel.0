From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 1 Oct 2018 13:52:32 -0700
Subject: RESEND [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
In-Reply-To: <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
References: <20181001175845.168430-1-salyzyn@android.com>
 <20181001175845.168430-12-salyzyn@android.com>
 <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
Message-ID: <a602b661-dde5-399d-6245-cf48a0e43f54@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2018 11:15 AM, Thomas Gleixner wrote:
> On Mon, 1 Oct 2018, Mark Salyzyn wrote:
>>   
>> +static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
>> +{
>> +	u32 seq, mult, shift;
>> +	u64 nsec, cycle_last;
>> +	vdso_wtm_clock_nsec_t wtm_nsec;
>> +
>> +	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
>> +	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
>> +	ts->tv_nsec = nsec;
>> +
>> +	return 0;
>> +}
>> +
> Instead of adding yet another copy of the same code you might want to look
> at the rework I did for the x86 vdso in order to support CLOCK_TAI w/o
> running into the issue of the clock switch case being compiled into a jump
> table and then the compile asking for retpoline.
>
>    http://lkml.kernel.org/r/20180917124533.329334911 at linutronix.de
>
> Thanks,
>
> 	tglx

Great idea. Thanks!

The point of the first 12 patches is to _align_ the arm code to match 
the assembler for arm64 exactly 1:1. Then switch arm64 assembler to use 
the _same_ code in 'C' as a library. No performance degradation.

Next extend the vdso framework on arm64 to _also_ use that library for 
vDSO32 (arm32 compat on 64-bit). At this point we achieve a 0.4% power 
reduction on Android.

At that point, we would be ready for a rework that fixes all three (ARM 
vDSO, ARM64 vDSO and ARM64 vDSO32) to get the compiler to handle the 
switch statement better. One step at a time.

-- Mark
