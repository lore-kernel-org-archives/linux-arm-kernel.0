From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 11 Nov 2013 16:40:07 +0900
Subject: [PATCH 3/4] arm64: audit: Add AArch32 support
In-Reply-To: <20131108145527.GL17461@mudshark.cambridge.arm.com>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1383733546-2846-4-git-send-email-takahiro.akashi@linaro.org>
 <20131108145527.GL17461@mudshark.cambridge.arm.com>
Message-ID: <528089D7.1070009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 11:55 PM, Will Deacon wrote:
> On Wed, Nov 06, 2013 at 10:25:45AM +0000, AKASHI Takahiro wrote:
>> ---
>>   arch/arm64/include/asm/audit32.h  |   12 ++
>>   arch/arm64/include/asm/unistd32.h |  387 +++++++++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/Makefile        |    3 +
>>   arch/arm64/kernel/audit.c         |   18 ++
>>   arch/arm64/kernel/audit32.c       |   46 +++++
>>   5 files changed, 466 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/audit32.h
>>   create mode 100644 arch/arm64/kernel/audit32.c
>>
>> diff --git a/arch/arm64/include/asm/audit32.h b/arch/arm64/include/asm/audit32.h
>> new file mode 100644
>> index 0000000..debfe57
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/audit32.h
>> @@ -0,0 +1,12 @@
>> +#ifndef __ASM_AUDIT32_H
>> +#define __ASM_AUDIT32_H
>> +
>> +extern unsigned aarch32_dir_class[];
>> +extern unsigned aarch32_read_class[];
>> +extern unsigned aarch32_write_class[];
>> +extern unsigned aarch32_chattr_class[];
>> +extern unsigned aarch32_signal_class[];
>> +
>> +extern int aarch32_classify_syscall(unsigned);
>> +
>> +#endif /* __ASM_AUDIT32_H */
>> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
>> index 58125bf..fdf5e56 100644
>> --- a/arch/arm64/include/asm/unistd32.h
>> +++ b/arch/arm64/include/asm/unistd32.h
>> @@ -21,6 +21,393 @@
>>   #define __SYSCALL(x, y)
>>   #endif
>>
>> +#ifdef __AARCH32_AUDITSYSCALL
>> +/*
>> + * FIXME: Currenty only audit uses (part of) these definitions.
>> + * See audit32.c
>> + */
>> +#define __NR_restart_syscall 0
>> +#define __NR_exit 1
>> +#define __NR_fork 2
>> +#define __NR_read 3
>
> Don't bother with this file. It's a needless replication of data already in
> the file and you don't even need it all.

Unfortunately, I need them not only for aarch32_classify_syscall(), but 
also in asm-generic/audit_*.h. Actually 47 of __NR_xxx are referred to 
in those files.
The problem is that aarch64 and aarch32 have different system call
numbers, but that there are no __NR_xxx definitions for aarch32 in
asm/unistd32.h.

>> diff --git a/arch/arm64/kernel/audit32.c b/arch/arm64/kernel/audit32.c
>> new file mode 100644
>> index 0000000..2aa4d7d
>> --- /dev/null
>> +++ b/arch/arm64/kernel/audit32.c
>> @@ -0,0 +1,46 @@
>> +#define __AARCH32_AUDITSYSCALL
>> +#include <asm/unistd32.h>
>> +
>> +unsigned aarch32_dir_class[] = {
>> +#include <asm-generic/audit_dir_write.h>
>> +~0U
>> +};
>> +
>> +unsigned aarch32_read_class[] = {
>> +#include <asm-generic/audit_read.h>
>> +~0U
>> +};
>> +
>> +unsigned aarch32_write_class[] = {
>> +#include <asm-generic/audit_write.h>
>> +~0U
>> +};
>> +
>> +unsigned aarch32_chattr_class[] = {
>> +#include <asm-generic/audit_change_attr.h>
>> +~0U
>> +};
>> +
>> +unsigned aarch32_signal_class[] = {
>> +#include <asm-generic/audit_signal.h>
>> +~0U
>> +};
>> +
>> +int aarch32_classify_syscall(unsigned syscall)
>> +{
>> +       switch(syscall) {
>> +       case __NR_open:
>> +               return 2;
>> +       case __NR_openat:
>> +               return 3;
>> +       /*
>> +        * obsolute in EABI
>> +        * case __NR_socketcall:
>> +        *      return 4;
>> +        */
>> +       case __NR_execve:
>> +               return 5;
>> +       default:
>> +               return 1; /* 32-bit on biarch */
>> +       }
>
> Instead, just add __NR_compat_{open,openat,execve}, like we have done for
> the signal-related syscalls.

As far as xxx_classify_syscall is concerned, it is possible to change
the code to use __NR_compat_..., but it is difficult to remove __NR_...
from unistd32.h because, as I mentioned above, asm-generic/audit_xxx.h
use __NR_...

> Also, can't the generic lib/audit.c be reworked to work with compat too?

I hope so, but don't think re-work is practical unless we have
generic solution against this issue.
(In addition, other architectures already have their own
implementation.)

-Takahiro AKASHI

> Will
>
