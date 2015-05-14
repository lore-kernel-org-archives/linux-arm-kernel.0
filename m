From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 14 May 2015 07:15:48 -0700
Subject: [PATCH 2/2] selftests/breakpoints: only set TEST_PROGS when built
In-Reply-To: <5553C51B.6080504@osg.samsung.com>
References: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
 <1431467947-29847-3-git-send-email-tyler.baker@linaro.org>
 <5553C51B.6080504@osg.samsung.com>
Message-ID: <CANMBJr5Y5LaGHbdSqUL=Xj01-s20TAawRKaj0uDbkdMZZoUoYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 14:41, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> On 05/12/2015 03:59 PM, tyler.baker at linaro.org wrote:
>> From: Tyler Baker <tyler.baker@linaro.org>
>>
>> Set TEST_PROGS only when a build has occurred.
>>
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>> ---
>>  tools/testing/selftests/breakpoints/Makefile | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
>> index 1822356..54cc3e7 100644
>> --- a/tools/testing/selftests/breakpoints/Makefile
>> +++ b/tools/testing/selftests/breakpoints/Makefile
>> @@ -12,12 +12,11 @@ endif
>>  all:
>>  ifeq ($(ARCH),x86)
>>       gcc breakpoint_test.c -o breakpoint_test
>> +     TEST_PROGS := breakpoint_test
>>  else
>>       echo "Not an x86 target, can't build breakpoints selftests"
>>  endif
>>
>> -TEST_PROGS := breakpoint_test
>> -
>>  include ../lib.mk
>>
>>  clean:
>>
>
> Hmm. With this change install fails to copy breakpoint_test all
> together. Remember setting TEST_PROGS in compile step makes it
> not stick around when install target is called. A better approach
> would be the following:
>
> if [ -f breakpoint_test ]
>     TEST_PROGS := breakpoint_test
> fi

Thanks for pointing this out, this is a good catch. We will also need
to do this for the x86 tests IIRC. Would it make more sense to have
this check performed in the INSTALL_RULE so that we don't have to have
a bunch of IF statements in the various Makefiles?

Something like...

       @for ARTIFACT in $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES); do \
               if [ -f $$ARTIFACT ]; then \
                    install -t $(INSTALL_PATH) $$ARTIFACT; \
               fi; \
       done;

>
> include ../lib.mk
>
> -- Shuah
>
> --
> Shuah Khan
> Sr. Linux Kernel Developer
> Open Source Innovation Group
> Samsung Research America (Silicon Valley)
> shuahkh at osg.samsung.com | (970) 217-8978

Cheers,

Tyler
