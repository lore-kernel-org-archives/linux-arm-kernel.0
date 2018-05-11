From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 11 May 2018 16:37:27 +0200
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <20180508103016.GW16141@n2100.armlinux.org.uk>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180508103016.GW16141@n2100.armlinux.org.uk>
Message-ID: <CACT4Y+ZkLCqPEicOsB1ewF8MfZd4wJpQHjxP_S6i+B0ZGZuj2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 12:30 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Apr 26, 2018 at 03:08:46PM +0200, Dmitry Vyukov wrote:
>> KCOV is code coverage collection facility used, in particular, by syzkaller
>> system call fuzzer. There is some interest in using syzkaller on arm devices.
>> So port KCOV to arm.
>>
>> On implementation level this merely declares that KCOV is supported and
>> disables instrumentation of 3 special cases. Reasons for disabling are
>> commented in code.
>>
>> Tested with qemu-system-arm/vexpress-a15.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Abbott Liu <liuwenliang@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Koguchi Takuo <takuo.koguchi.sw@hitachi.com>
>> Cc: Atul Prakash <atulp@google.com>
>> Cc: linux at armlinux.org.uk
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: syzkaller at googlegroups.com
>> ---
>>  arch/arm/Kconfig                  | 1 +
>>  arch/arm/boot/compressed/Makefile | 3 +++
>>  arch/arm/mm/Makefile              | 4 ++++
>>  arch/arm/vdso/Makefile            | 3 +++
>>  4 files changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a7f8e7f4b88f..60558a6bb744 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -105,6 +105,7 @@ config ARM
>>       select REFCOUNT_FULL
>>       select RTC_LIB
>>       select SYS_SUPPORTS_APM_EMULATION
>> +     select ARCH_HAS_KCOV
>>       # Above selects are sorted alphabetically; please add new ones
>>       # according to that.  Thanks.
>
> Please read this comment and rework your patch, thanks.


Now that Mark's fixes are in mm tree, I mailed v2 with the following changes:

    Changes since v1:
     - remove disable of instrumentation for arch/arm/mm/fault.c
     - disable instrumentation of arch/arm/kvm/hyp/*
     - resort ARCH_HAS_KCOV alphabetically
