From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 06 Mar 2014 11:21:21 +0900
Subject: [PATCH v6 1/2] arm64: Add audit support
In-Reply-To: <20140305025037.GT16640@madcap2.tricolour.ca>
References: <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-2-git-send-email-takahiro.akashi@linaro.org>
 <20140305025037.GT16640@madcap2.tricolour.ca>
Message-ID: <5317DBA1.2000907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2014 11:50 AM, Richard Guy Briggs wrote:
> On 14/02/28, AKASHI Takahiro wrote:
>> On AArch64, audit is supported through generic lib/audit.c and
>> compat_audit.c, and so this patch adds arch specific definitions required.
>>
>> Acked-by Will Deacon <will.deacon@arm.com>
>> Acked-by: Richard Guy Briggs <rgb@redhat.com>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/Kconfig               |    1 +
>>   arch/arm64/include/asm/syscall.h |   15 +++++++++++++++
>>   include/uapi/linux/audit.h       |    1 +
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 27bbcfc..aa47548 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -25,6 +25,7 @@ config ARM64
>>   	select GENERIC_STRNLEN_USER
>>   	select GENERIC_TIME_VSYSCALL
>>   	select HARDIRQS_SW_RESEND
>> +	select HAVE_ARCH_AUDITSYSCALL
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_TRACEHOOK
>>   	select HAVE_DEBUG_BUGVERBOSE
>> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
>> index 70ba9d4..6900183 100644
>> --- a/arch/arm64/include/asm/syscall.h
>> +++ b/arch/arm64/include/asm/syscall.h
>> @@ -16,7 +16,9 @@
>>   #ifndef __ASM_SYSCALL_H
>>   #define __ASM_SYSCALL_H
>>
>> +#include <linux/audit.h>
>
> This could be changed to <uapi/linux/audit.h> to pick up the
> AUDIT_ARCH_* definitions needed and not any of the audit kernel
> funcitons.

I will fix it in the next version.

Thank you,
-Takahiro AKASHI

>>   #include <linux/err.h>
>> +#include <asm/compat.h>
>>
>>
>>   static inline int syscall_get_nr(struct task_struct *task,
>> @@ -104,4 +106,17 @@ static inline void syscall_set_arguments(struct task_struct *task,
>>   	memcpy(&regs->regs[i], args, n * sizeof(args[0]));
>>   }
>>
>> +/*
>> + * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
>> + * AArch64 has the same system calls both on little- and big- endian.
>> + */
>> +static inline int syscall_get_arch(struct task_struct *task,
>> +				   struct pt_regs *regs)
>> +{
>> +	if (is_compat_thread(task_thread_info(task)))
>> +		return AUDIT_ARCH_ARM;
>> +
>> +	return AUDIT_ARCH_AARCH64;
>> +}
>> +
>>   #endif	/* __ASM_SYSCALL_H */
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 624df43..aa86fab 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -333,6 +333,7 @@ enum {
>>   /* distinguish syscall tables */
>>   #define __AUDIT_ARCH_64BIT 0x80000000
>>   #define __AUDIT_ARCH_LE	   0x40000000
>> +#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>>   #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>>   #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
>>   #define AUDIT_ARCH_ARMEB	(EM_ARM)
>> --
>> 1.7.9.5
>>
>
> - RGB
>
> --
> Richard Guy Briggs <rbriggs@redhat.com>
> Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
> Remote, Ottawa, Canada
> Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
>
