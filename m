From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 27 Jan 2014 14:58:07 +0900
Subject: [PATCH v3] audit: Add generic compat syscall support
In-Reply-To: <20140123145119.GE27520@arm.com>
References: <1384854235-6567-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-2-git-send-email-takahiro.akashi@linaro.org>
 <20140123145119.GE27520@arm.com>
Message-ID: <52E5F56F.2030502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin and audit maintainers,

On 01/23/2014 11:51 PM, Catalin Marinas wrote:
> On Fri, Jan 17, 2014 at 08:03:15AM +0000, AKASHI Takahiro wrote:
>> lib/audit.c provides a generic definition for auditing system calls.
>> This patch extends it for compat syscall support on bi-architectures
>> (32/64-bit) by adding lib/compat_audit.c when CONFIG_COMPAT enabled.
>>
>> Each architecture that wants to use this must define audit_is_compat()
>> in asm/audit.h.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> I'm not familiar with the audit subsystem but I have some (cosmetic)
> comments below.
>
>> diff --git a/include/linux/audit.h b/include/linux/audit.h
>> index bf1ef22..3d71949 100644
>> --- a/include/linux/audit.h
>> +++ b/include/linux/audit.h
>> @@ -78,6 +78,15 @@ extern int is_audit_feature_set(int which);
>>   extern int __init audit_register_class(int class, unsigned *list);
>>   extern int audit_classify_syscall(int abi, unsigned syscall);
>>   extern int audit_classify_arch(int arch);
>> +#if defined(CONFIG_AUDIT_GENERIC) && defined(CONFIG_COMPAT)
>> +extern unsigned compat_write_class[];
>> +extern unsigned compat_read_class[];
>> +extern unsigned compat_dir_class[];
>> +extern unsigned compat_chattr_class[];
>> +extern unsigned compat_signal_class[];
>> +
>> +extern int audit_classify_compat_syscall(int abi, unsigned syscall);
>> +#endif
>>
>>   /* audit_names->type values */
>>   #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
>> diff --git a/lib/Makefile b/lib/Makefile
>> index a459c31..73ea908 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -93,6 +93,9 @@ obj-$(CONFIG_TEXTSEARCH_BM) += ts_bm.o
>>   obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
>>   obj-$(CONFIG_SMP) += percpu_counter.o
>>   obj-$(CONFIG_AUDIT_GENERIC) += audit.o
>> +ifeq ($(CONFIG_COMPAT),y)
>> +obj-$(CONFIG_AUDIT_GENERIC) += compat_audit.o
>> +endif
>
> You could use a CONFIG_AUDIT_COMPAT_GENERIC and simplify other #ifdefs
> as well.

I will add the following in lib/Kconfig:

   config AUDIT_COMPAT_GENERIC
     depends on AUDIT_GENERIC & COMPAT
     default y

>> --- a/lib/audit.c
>> +++ b/lib/audit.c
>> @@ -1,6 +1,7 @@
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/audit.h>
>> +#include <asm/audit.h>
>>   #include <asm/unistd.h>
>>
>>   static unsigned dir_class[] = {
>> @@ -30,11 +31,20 @@ static unsigned signal_class[] = {
>>
>>   int audit_classify_arch(int arch)
>>   {
>> +#ifdef CONFIG_COMPAT
>> +	if (audit_is_compat(arch))
>> +		return 1;
>> +#endif
>>   	return 0;
>>   }
>
> Here and in other places, just define a default audit_is_compat()
> functions which returns false when !CONFIG_COMPAT to avoid the #ifdefs.

OK. With Richard's comment, the definition below will be added
to uapi/linux/audit.h:

   #ifdef CONFIG_COMPAT
   #define audit_is_compat(arch)  (!!((arch) & __AUDIT_ARCH_64BIT))
   #else
   #define audit_is_compat(arch)  false
   #endif

>> diff --git a/lib/compat_audit.c b/lib/compat_audit.c
>> new file mode 100644
>> index 0000000..94f6480
>> --- /dev/null
>> +++ b/lib/compat_audit.c
>> @@ -0,0 +1,51 @@
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +/* FIXME: this might be architecture dependent */
>> +#include <asm/unistd_32.h>
>
> It most likely is architecture dependent.

I'm wondering what name is the most appropriate in this case.
Most archictures have __NR_xyz definitions in "unistd_32.h",
but arm64 doesn't have it, instead "unistd32." which contains
only __SYSCALL(xyz, NO). Confusing?

>> +int audit_classify_compat_syscall(int abi, unsigned syscall)
>> +{
>> +	switch (syscall) {
>> +#ifdef __NR_open
>> +	case __NR_open:
>> +		return 2;
>> +#endif
>> +#ifdef __NR_openat
>> +	case __NR_openat:
>> +		return 3;
>> +#endif
>> +#ifdef __NR_socketcall
>> +	case __NR_socketcall:
>> +		return 4;
>> +#endif
>> +	case __NR_execve:
>> +		return 5;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>
> BTW, since they aren't many, you could get the arch code to define
> __NR_compat_open etc. explicitly and use these. On arm64 we have a few
> of these defined to avoid name collision in signal handling code.

Again, most architecture have their own unistd32.h for compat system calls,
and use __NR_open-like naming.
It's unlikely for these archs to migrate to "generic compat" auditing,
but I believe that '__NR_open'-like naming is better because we may be able to avoid
arch-specific changes even for future(?) syscall-related enhancements in audit.

But, anyway, it's up to audit maintainer's preference.

Thanks,
-Takahiro AKASHI
