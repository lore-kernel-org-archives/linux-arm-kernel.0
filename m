From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 11 Oct 2014 07:49:46 -0700
Subject: [PATCH] arm64: Fix compile error seen in non-SMP builds
In-Reply-To: <20141011131618.GA4043@lerouge>
References: <1412990134-31186-1-git-send-email-linux@roeck-us.net>
 <20141011131618.GA4043@lerouge>
Message-ID: <5439438A.9090407@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2014 06:16 AM, Frederic Weisbecker wrote:
> On Fri, Oct 10, 2014 at 06:15:34PM -0700, Guenter Roeck wrote:
>> Fix:
>>
>> In file included from ./arch/arm64/include/asm/irq_work.h:4:0,
>>          from include/linux/irq_work.h:46,
>>          from include/linux/perf_event.h:49,
>>          from include/linux/ftrace_event.h:9,
>>          from include/trace/syscall.h:6,
>>          from include/linux/syscalls.h:81,
>>          from init/main.c:18:
>> ./arch/arm64/include/asm/smp.h:24:3:
>> 	error: #error "<asm/smp.h> included in non-SMP build"
>>   # error "<asm/smp.h> included in non-SMP build"
>>     ^
>> ./arch/arm64/include/asm/smp.h:27:0: warning: "raw_smp_processor_id" redefined
>>   #define raw_smp_processor_id() (current_thread_info()->cpu)
>>   ^
>>
>> and:
>>
>> In file included from ./arch/arm64/include/asm/irq_work.h:4:0,
>>          from include/linux/irq_work.h:46,
>>          from kernel/irq_work.c:11:
>> ./arch/arm64/include/asm/smp_plat.h:56:30:
>>          error: ?NR_CPUS? undeclared here (not in a function)
>>          extern u64 __cpu_logical_map[NR_CPUS];
>>
>> by providing a helper function in smp_plat.h, similar to the arm implementation,
>> and by removing NR_CPUS from smp_plat.h.
>>
>> Fixes: 3631073659d0 ("arm64: Tell irq work about self IPI support")
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> That looks good to me.
>
> Note, ARM64 is one of the archs I couldn't test due to the lack of a
> nolibc cross compiler in https://www.kernel.org/pub/tools/crosstool/
>
No worries. Even if you had, you might not have caught the non-SMP case.
I only recently added a non-SMP build myself.

Is the toolchain issue out of principle (not wanting to use a cross
compiler that includes glibc) or because you did not find a cross
compiler ? Linaro provides toolchains for aarch64, though they are
only 32 bit. I built one myself using buildroot (select binutils 2.24
and gcc 4.9.1).

In general I have been quite successful using buildroot to create
toolchains, including ones for oddball architectures like score
(after patching buildroot to support it, of course).

Guenter
