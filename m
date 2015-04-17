From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 17 Apr 2015 15:24:24 -0700
Subject: [PATCH v2 5/8] selftest/x86: build both bitnesses
In-Reply-To: <CALCETrVJr3Lx-Z=_N8BwCC8Ef3bT-mWSSVWGbFg3YSr0ApqC_g@mail.gmail.com>
References: <1429308096-4667-1-git-send-email-tyler.baker@linaro.org>
 <CALCETrVJr3Lx-Z=_N8BwCC8Ef3bT-mWSSVWGbFg3YSr0ApqC_g@mail.gmail.com>
Message-ID: <CANMBJr4ihEvO-21hAhbCvzHL2t8tAPU709=z3u+C-Kj+Nhe5rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2015 at 15:06, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Apr 17, 2015 at 3:01 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
>> Using uname with the processor flag option in some cases can yield 'unknown'
>> so lets use the machine flag option as it is deterministic. Add a dependency
>> for all_32 when building on a x86 64 bit host so that both bitnesses are
>> built in this case.
>>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>> ---
>>  tools/testing/selftests/x86/Makefile | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
>> index f0a7918..57090ad 100644
>> --- a/tools/testing/selftests/x86/Makefile
>> +++ b/tools/testing/selftests/x86/Makefile
>> @@ -7,14 +7,14 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
>>
>>  CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
>>
>> -UNAME_P := $(shell uname -p)
>> +UNAME_M := $(shell uname -m)
>>
>>  # Always build 32-bit tests
>>  all: all_32
>>
>>  # If we're on a 64-bit host, build 64-bit tests as well
>> -ifeq ($(shell uname -p),x86_64)
>> -all: all_64
>> +ifeq ($(UNAME_M),x86_64)
>> +all: all_32 all_64
>
> This duplicates the all: all_32 above.

I agree with you but the behavior is different than expected.

>From a clean linux-next tree building on a 64-bit x86 host

(jessie)tyler at localhost:~/Dev/kernels/linux$ git describe
next-20150415
(jessie)tyler at localhost:~/Dev/kernels/linux$ uname -m
x86_64
(jessie)tyler at localhost:~/Dev/kernels/linux$ make -C
tools/testing/selftests/x86/
make: Entering directory
'/home/tyler/Dev/kernels/linux/tools/testing/selftests/x86'
cc -m32 -o sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall  sigreturn.c -lrt -ldl
make: Leaving directory
'/home/tyler/Dev/kernels/linux/tools/testing/selftests/x86'

With this series applied on top I get

(jessie)tyler at localhost:~/Dev/kernels/linux$ make -C
tools/testing/selftests/x86/
make: Entering directory
'/home/tyler/Dev/kernels/linux/tools/testing/selftests/x86'
Makefile:41: warning: overriding recipe for target 'run_tests'
../lib.mk:12: warning: ignoring old recipe for target 'run_tests'
gcc -m32 -o sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall  sigreturn.c -lrt -ldl
gcc -m64 -o sigreturn_64 -O2 -g -std=gnu99 -pthread -Wall  sigreturn.c -lrt -ldl
make: Leaving directory
'/home/tyler/Dev/kernels/linux/tools/testing/selftests/x86'

Which is what I expected.

>
> --Andy
>
>>  endif
>>
>>  all_32: check_build32 $(BINARIES_32)
>> --
>> 2.1.4
>>
>
>
>
> --
> Andy Lutomirski
> AMA Capital Management, LLC

Tyler
