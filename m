From: jean.pihet@linaro.org (Jean Pihet)
Date: Thu, 16 Jan 2014 13:26:53 +0100
Subject: [PATCH] ARM64: perf: support dwarf unwinding in compat mode
In-Reply-To: <20140116115634.GE30257@mudshark.cambridge.arm.com>
References: <1389869123-5884-1-git-send-email-jean.pihet@linaro.org>
 <20140116115634.GE30257@mudshark.cambridge.arm.com>
Message-ID: <CAFrcx1=eAHsGZDsedGvvNai7Vrnf5p8RKLGFPS+cn5yGp7UQJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2014 12:56, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
> On Thu, Jan 16, 2014 at 10:45:23AM +0000, Jean Pihet wrote:
>> Add support for unwinding using the dwarf information in compat
>> mode. Using the correct user stack pointer allows perf to record
>> the frames correctly in the native and compat modes.
>>
>> Note that although the dwarf frame unwinding works ok using
>> libunwind in native mode (on ARMv7 & ARMv8), some changes are
>> required to the libunwind code for the compat mode. Those changes
>> are posted separately on the libunwind mailing list.
>>
>> Tested on ARMv8 platform with v8 and compat v7 binaries, the latter
>> are statically built.
>
> I guess it makes sense to include this with your earlier series adding
> support for compat backtracing?
>
>> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
>> ---
>>  arch/arm64/include/asm/ptrace.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index fbb0020..86d5b54 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -133,7 +133,7 @@ struct pt_regs {
>>       (!((regs)->pstate & PSR_F_BIT))
>>
>>  #define user_stack_pointer(regs) \
>> -     ((regs)->sp)
>> +     (!compat_user_mode(regs)) ? ((regs)->sp) : ((regs)->compat_sp)
>
> In your previous series, compat backtracing is actually split out into a
> separate function (compat_user_backtrace), so it would be more consistent to
> have a compat_user_stack_pointer macro, rather than add this check here.

Do you mean this change instead?

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 569b2187..9b88d2e 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -185,7 +185,8 @@ static inline bool arch_perf_have_user_stack_dump(void)
        return true;
 }

-#define perf_user_stack_pointer(regs) user_stack_pointer(regs)
+#define perf_user_stack_pointer(regs) \
+       (!compat_user_mode(regs)) ? ((regs)->sp) : ((regs)->compat_sp)
 #else
 static inline bool arch_perf_have_user_stack_dump(void)
 {

If so let me prepare/test and re-submit this.

Thx!
Jean

>
> Will
