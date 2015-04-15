From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 19:54:52 -0700
Subject: [PATCH 5/7] selftests/x86: fix cross build logic
In-Reply-To: <552DB1C5.7020704@amacapital.net>
References: <1429051978-14778-1-git-send-email-tyler.baker@linaro.org>
 <552DB1C5.7020704@amacapital.net>
Message-ID: <CANMBJr7pU-RX8=pEg3Y2gOQy73Ph2oARxhs9UDRu2ke86FLt1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 14 April 2015 at 17:33, Andy Lutomirski <luto@amacapital.net> wrote:
> On 04/14/2015 03:52 PM, Tyler Baker wrote:
>>
>> x86 tests should not be built when ARCH != x86. Reused the logic from
>> breakpoints to determine when it's appropriate to build.
>
>
> In the future, please cc the author of recently-written code that you're
> fixing :)

My apologies, thanks for keeping me in line ;)

>
> This patch is really weird.  You're generating ARCH, then you're modifying
> it part way through, and you're changing the rule for all_32 and all_64 to
> print an error (and succeed!) if run on the wrong arch.
>
> I don't see the point of the latter at all.  Just let all have no
> dependencies if you're on the wrong ARCH.

Ok, this should make life simpler. All this logic stems from the
breakpoints test (x86 only as well) so it seems like we should do the
same for it as well.

>
> As for the former, can you do this more cleanly?  This is really ugly. It
> looks to me (on naive reading) like 64-bit hosts won't do the right thing.
> (The right thing is to build both bitnesses of tests.)

It does build both bitnesses on a 64 bit host, however I do agree this
could be cleaned up based on the comments above.

>
> --Andy
>
>
>>
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>> ---
>>   tools/testing/selftests/x86/Makefile | 35
>> +++++++++++++++++++++++------------
>>   1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/Makefile
>> b/tools/testing/selftests/x86/Makefile
>> index f0a7918..7be67a0 100644
>> --- a/tools/testing/selftests/x86/Makefile
>> +++ b/tools/testing/selftests/x86/Makefile
>> @@ -7,31 +7,36 @@ BINARIES_64 := $(TARGETS_C_BOTHBITS:%=%_64)
>>
>>   CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
>>
>> -UNAME_P := $(shell uname -p)
>> -
>> -# Always build 32-bit tests
>> +# Taken from perf makefile
>> +uname_M := $(shell uname -m 2>/dev/null || echo not)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
>> +ifeq ($(ARCH),i386)
>> +ARCH := x86
>>   all: all_32
>> -
>> +endif
>> +ifeq ($(ARCH),x86_64)
>> +ARCH := x86
>>   # If we're on a 64-bit host, build 64-bit tests as well
>> -ifeq ($(shell uname -p),x86_64)
>> -all: all_64
>> +all: all_32 all_64
>>   endif
>>
>>   all_32: check_build32 $(BINARIES_32)
>>
>>   all_64: $(BINARIES_64)
>>
>> -clean:
>> -       $(RM) $(BINARIES_32) $(BINARIES_64)
>> -
>> -run_tests:
>> -       ./run_x86_tests.sh
>> -
>>   $(TARGETS_C_BOTHBITS:%=%_32): %_32: %.c
>> +ifeq ($(ARCH),x86)
>>         $(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
>> +else
>> +       echo "Not an x86 target, can't build x86 tests"
>> +endif
>>
>>   $(TARGETS_C_BOTHBITS:%=%_64): %_64: %.c
>> +ifeq ($(ARCH),x86)
>>         $(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
>> +else
>> +       echo "Not an x86 target, can't build x86 tests"
>> +endif
>>
>>   check_build32:
>>         @if ! $(CC) -m32 -o /dev/null trivial_32bit_program.c; then     \
>> @@ -46,3 +51,9 @@ check_build32:
>>           echo "  yum install glibc-devel.*i686";                       \
>>           exit 1;                                                       \
>>         fi
>> +
>> +run_tests:
>> +       ./run_x86_tests.sh
>> +
>> +clean:
>> +       $(RM) $(BINARIES_32) $(BINARIES_64)
>>
>

I'll wait to see if there any other comments on this series before
sending an update.

Thanks,

Tyler
