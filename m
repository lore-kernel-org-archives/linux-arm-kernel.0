From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 12 Feb 2016 15:38:46 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
Message-ID: <56BDFC86.5010705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/02/16 15:26, Catalin Marinas wrote:
> On Fri, Feb 12, 2016 at 04:17:09PM +0100, Ard Biesheuvel wrote:
>> On 12 February 2016 at 16:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> On Fri, Feb 12, 2016 at 04:02:58PM +0100, Ard Biesheuvel wrote:
>>>> On 12 February 2016 at 15:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>>> On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
>>>>>> This moves the module area to right before the vmalloc area, and
>>>>>> moves the kernel image to the base of the vmalloc area. This is
>>>>>> an intermediate step towards implementing KASLR, which allows the
>>>>>> kernel image to be located anywhere in the vmalloc area.
>>>>>>
>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>
>>>>> This patch is causing lots of KASAN warnings on Juno (interestingly, it
>>>>> doesn't seem to trigger on Seattle, though we only tried for-next/core).
>>>>> I pushed the branch that I'm currently using here:
>>>>>
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernmap
>>>>>
>>>>>
>>>>> A typical error (though its place varies based on the config options,
>>>>> kernel layout):
>>>>>
>>>>> BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x28/0x1b0 at addr ffffffc936257cc8
>>>>
>>>> Can you confirm that these are stack accesses? I was having similar
>>>> errors before, and I ended up creating the kasan zero page patch
>>>> because it turned out the kasan shadow page in question was aliased
>>>> and the stack writes were occurring elsewhere.
>>>
>>> It's possible, we are looking into this. Is there any other patch I miss on
>>> the above branch?
>>
>> I don't think so but I will check
>
> Commit 7b1af9795773 ("arm64: kasan: ensure that the KASAN zero page is
> mapped read-only") was merged in -rc2 while the branch above is based on
> -rc1. Anyway, I merged it into -rc2 and the errors are similar.
>

Sorry to add more confusion, but I observed similar KASAN warning
with latest mainline(v4.5-rc3+, commit c05235d50f68) with below diff.

Regards,
Sudeep

--->8

diff --git i/arch/arm64/Kconfig w/arch/arm64/Kconfig
index 8cc62289a63e..fdd1d75f5bad 100644
--- i/arch/arm64/Kconfig
+++ w/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
         select ARCH_HAS_GCOV_PROFILE_ALL
         select ARCH_HAS_SG_CHAIN
         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+       select ARCH_HAS_UBSAN_SANITIZE_ALL
         select ARCH_USE_CMPXCHG_LOCKREF
         select ARCH_SUPPORTS_ATOMIC_RMW
         select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git i/arch/arm64/configs/defconfig w/arch/arm64/configs/defconfig
index 86581f793e39..0006b0204b97 100644
--- i/arch/arm64/configs/defconfig
+++ w/arch/arm64/configs/defconfig
@@ -240,11 +240,14 @@ CONFIG_DEBUG_INFO=y
  CONFIG_DEBUG_FS=y
  CONFIG_MAGIC_SYSRQ=y
  CONFIG_DEBUG_KERNEL=y
+CONFIG_KASAN=y
+CONFIG_TEST_KASAN=m
  CONFIG_LOCKUP_DETECTOR=y
  # CONFIG_SCHED_DEBUG is not set
  # CONFIG_DEBUG_PREEMPT is not set
  # CONFIG_FTRACE is not set
  CONFIG_MEMTEST=y
+CONFIG_UBSAN=y
  CONFIG_SECURITY=y
  CONFIG_CRYPTO_ECHAINIV=y
  CONFIG_CRYPTO_ANSI_CPRNG=y
