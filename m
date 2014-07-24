From: keescook@chromium.org (Kees Cook)
Date: Wed, 23 Jul 2014 21:41:30 -0700
Subject: [PATCH v5 2/3] asm-generic: Add generic seccomp.h for secure
 computing mode 1
In-Reply-To: <53D0802A.7070703@amacapital.net>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>
 <1406020499-5537-3-git-send-email-takahiro.akashi@linaro.org>
 <53D0802A.7070703@amacapital.net>
Message-ID: <CAGXu5j+GuoxR5o8CZZFZAEwQA=rRwBmBM-ZDU+nFAfHoqf8z9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 8:40 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On 07/22/2014 02:14 AM, AKASHI Takahiro wrote:
>>
>> Those values (__NR_seccomp_*) are used solely in secure_computing()
>> to identify mode 1 system calls. If compat system calls have different
>> syscall numbers, asm/seccomp.h may override them.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   include/asm-generic/seccomp.h |   28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 include/asm-generic/seccomp.h
>>
>> diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
>> new file mode 100644
>> index 0000000..5e97022
>> --- /dev/null
>> +++ b/include/asm-generic/seccomp.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * include/asm-generic/seccomp.h
>> + *
>> + * Copyright (C) 2014 Linaro Limited
>> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef _ASM_GENERIC_SECCOMP_H
>> +#define _ASM_GENERIC_SECCOMP_H
>> +
>> +#include <asm-generic/unistd.h>
>> +
>> +#if defined(CONFIG_COMPAT) && !defined(__NR_seccomp_read_32)
>> +#define __NR_seccomp_read_32           __NR_read
>> +#define __NR_seccomp_write_32          __NR_write
>> +#define __NR_seccomp_exit_32           __NR_exit
>> +#define __NR_seccomp_sigreturn_32      __NR_rt_sigreturn
>> +#endif /* CONFIG_COMPAT && ! already defined */
>> +
>> +#define __NR_seccomp_read              __NR_read
>> +#define __NR_seccomp_write             __NR_write
>> +#define __NR_seccomp_exit              __NR_exit
>> +#define __NR_seccomp_sigreturn         __NR_rt_sigreturn
>
>
> I don't like these names.  __NR_seccomp_read sounds like the number of a
> syscall called seccomp_read.
>
> Also, shouldn't something be including this header?  I'm confused.

Ah! Good catch. These names are correct (see kernel/seccomp.c's
mode1_syscalls and mode1_syscalls_32 arrays), but the location of this
change was unexpected. I was expecting this file to live in
arch/*/include/asm/seccomp.h, not in include/asm-generic/seccomp.h.

However, since it's always the same list, it might make sense to
consolidate them into a single place as a default to make arch porting
easier. However, I think that should be a separate patch.

-Kees

-- 
Kees Cook
Chrome OS Security
