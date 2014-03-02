From: dave.long@linaro.org (David Long)
Date: Sun, 02 Mar 2014 05:37:13 -0500
Subject: [PATCH v6 07/14] ARM: Remove use of struct kprobe from generic
 probes code
In-Reply-To: <20140228101226.GO21483@n2100.arm.linux.org.uk>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <1392017945-4507-8-git-send-email-dave.long@linaro.org>
 <20140228101226.GO21483@n2100.arm.linux.org.uk>
Message-ID: <531309D9.6050708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/14 05:12, Russell King - ARM Linux wrote:
> On Mon, Feb 10, 2014 at 02:38:58AM -0500, David Long wrote:
>> diff --git a/arch/arm/kernel/probes.c b/arch/arm/kernel/probes.c
>> index 7cd1763..179deac 100644
>> --- a/arch/arm/kernel/probes.c
>> +++ b/arch/arm/kernel/probes.c
>> @@ -12,11 +12,9 @@
>>    */
>>
>>   #include <linux/kernel.h>
>> -#include <linux/kprobes.h>
>>   #include <asm/system_info.h>
>
> How well has this code been tested?  This file doesn't even build because
> (I suspect) the above change:
>
> arch/arm/kernel/probes.c: In function 'test_alu_write_pc_interworking':
> arch/arm/kernel/probes.c:68:2: error: implicit declaration of function 'BUG_ON' [-Werror=implicit-function-declaration]
> make[2]: *** [arch/arm/kernel/probes.o] Error 1
>
> This is because linux/kprobes.h includes linux/bug.h, which would provide
> the requirements for BUG_ON().
>

It was tested by building and running on Panda with all four 
permutations of uprobes and kprobes enabled/disabled.  x86 was also test 
built and run to verify no regressions, and other testing was done 
inside Linaro for arm64 endianess correctness.  Very recently daily 
build testing has been added and this config problem has shown up, and 
our test configs adjusted accordingly.  I think the problem was masked 
on panda by CONFIG_PROFILING being set for that (and many other) 
platform(s).  On x86 it looks like the problem is avoided by 
CONFIG_PERF_EVENTS always being set in arch/x86/Kconfig.

I was not aware of the use/requirement (or existence even) of randconfig 
for validation testing, nor did I know a config dependency issue like 
this one would be considered a showstopper problem.

-dl
