From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 14 May 2015 10:11:52 -0700
Subject: [PATCH 2/2] selftests/breakpoints: only set TEST_PROGS when built
In-Reply-To: <5554BED4.9040204@osg.samsung.com>
References: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
 <1431467947-29847-3-git-send-email-tyler.baker@linaro.org>
 <5553C51B.6080504@osg.samsung.com>
 <CANMBJr5Y5LaGHbdSqUL=Xj01-s20TAawRKaj0uDbkdMZZoUoYg@mail.gmail.com>
 <5554BED4.9040204@osg.samsung.com>
Message-ID: <CANMBJr5jpTq08eWZRcbD72-3QC7uGuavYqZWMZLNDOm_2KGbEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2015 at 08:27, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> On 05/14/2015 08:15 AM, Tyler Baker wrote:
>> On 13 May 2015 at 14:41, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>>> On 05/12/2015 03:59 PM, tyler.baker at linaro.org wrote:
>>>> From: Tyler Baker <tyler.baker@linaro.org>
>>>>
>>>> Set TEST_PROGS only when a build has occurred.
>>>>
>>>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>>>> ---
>>>>  tools/testing/selftests/breakpoints/Makefile | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
>>>> index 1822356..54cc3e7 100644
>>>> --- a/tools/testing/selftests/breakpoints/Makefile
>>>> +++ b/tools/testing/selftests/breakpoints/Makefile
>>>> @@ -12,12 +12,11 @@ endif
>>>>  all:
>>>>  ifeq ($(ARCH),x86)
>>>>       gcc breakpoint_test.c -o breakpoint_test
>>>> +     TEST_PROGS := breakpoint_test
>>>>  else
>>>>       echo "Not an x86 target, can't build breakpoints selftests"
>>>>  endif
>>>>
>>>> -TEST_PROGS := breakpoint_test
>>>> -
>>>>  include ../lib.mk
>>>>
>>>>  clean:
>>>>
>>>
>>> Hmm. With this change install fails to copy breakpoint_test all
>>> together. Remember setting TEST_PROGS in compile step makes it
>>> not stick around when install target is called. A better approach
>>> would be the following:
>>>
>>> if [ -f breakpoint_test ]
>>>     TEST_PROGS := breakpoint_test
>>> fi
>>
>> Thanks for pointing this out, this is a good catch. We will also need
>> to do this for the x86 tests IIRC. Would it make more sense to have
>> this check performed in the INSTALL_RULE so that we don't have to have
>> a bunch of IF statements in the various Makefiles?
>
> Right. x86 will need this type of logic for 32-bit execs when they
> aren't not built on a 64-bit system, and for 64-bit execs when they
> aren't built on a 32-bit system.

Considering the change below we can now simplify this case for x86 to:

diff --git a/tools/testing/selftests/x86/Makefile
b/tools/testing/selftests/x86/Makefile
index 12d8e76..3e238d0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,13 +14,9 @@ UNAME_M := $(shell uname -m)
 ifeq ($(CROSS_COMPILE),)
 # Always build 32-bit tests
 all: all_32
-# Install 32-bit tests
-TEST_PROGS += $(BINARIES_32) run_x86_tests.sh
 # If we're on a 64-bit host, build 64-bit tests as well
 ifeq ($(UNAME_M),x86_64)
 all: all_64
-# Install 64-bit tests
-TEST_PROGS += $(BINARIES_64)
 endif
 endif

@@ -28,6 +24,9 @@ all_32: check_build32 $(BINARIES_32)

 all_64: $(BINARIES_64)

+# Install the tests
+TEST_PROGS := $(BINARIES_32) $(BINARIES_64) run_x86_tests.sh
+
 include ../lib.mk

 clean:

If the binaries do not exist, they will be not be installed. If you
and Andy are ok with this, I'll add a patch to this series.

>
>>
>> Something like...
>>
>>        @for ARTIFACT in $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES); do \
>>                if [ -f $$ARTIFACT ]; then \
>>                     install -t $(INSTALL_PATH) $$ARTIFACT; \
>>                fi; \
>>        done;
>>
>
> I think it makes perfect sense to do this in INSTALL_RULE.
> As you said, this will avoid changes to test individual
> Makefiles and new test writers don't have to worry about
> adding this.
>
> Would you like make the necessary changes?

Sure, I'll add this in the next revision.

>
> thanks,
> -- Shuah
>
>
> --
> Shuah Khan
> Sr. Linux Kernel Developer
> Open Source Innovation Group
> Samsung Research America (Silicon Valley)
> shuahkh at osg.samsung.com | (970) 217-8978

Cheers,

Tyler
