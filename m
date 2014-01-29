From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 29 Jan 2014 14:58:59 +0900
Subject: [PATCH v3] audit: Add generic compat syscall support
In-Reply-To: <20140127121505.GD32608@arm.com>
References: <1384854235-6567-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-2-git-send-email-takahiro.akashi@linaro.org>
 <20140123145119.GE27520@arm.com> <52E5F56F.2030502@linaro.org>
 <20140127121505.GD32608@arm.com>
Message-ID: <52E898A3.2050401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

Let me correct myself,

On 01/27/2014 09:15 PM, Catalin Marinas wrote:
> On Mon, Jan 27, 2014 at 05:58:07AM +0000, AKASHI Takahiro wrote:
>> Catalin and audit maintainers,
>>
>> On 01/23/2014 11:51 PM, Catalin Marinas wrote:
>>> On Fri, Jan 17, 2014 at 08:03:15AM +0000, AKASHI Takahiro wrote:
>>>> diff --git a/lib/compat_audit.c b/lib/compat_audit.c
>>>> new file mode 100644
>>>> index 0000000..94f6480
>>>> --- /dev/null
>>>> +++ b/lib/compat_audit.c
>>>> @@ -0,0 +1,51 @@
>>>> +#include <linux/init.h>
>>>> +#include <linux/types.h>
>>>> +/* FIXME: this might be architecture dependent */
>>>> +#include <asm/unistd_32.h>
>>>
>>> It most likely is architecture dependent.
>>
>> I'm wondering what name is the most appropriate in this case.
>> Most archictures have __NR_xyz definitions in "unistd_32.h",
>> but arm64 doesn't have it, instead "unistd32." which contains
>> only __SYSCALL(xyz, NO). Confusing?
>
> I don't think we should introduce a new file (or at least it should be
> named something containing "audit" to make it clearer).
>
>>>> +int audit_classify_compat_syscall(int abi, unsigned syscall)
>>>> +{
>>>> +	switch (syscall) {
>>>> +#ifdef __NR_open
>>>> +	case __NR_open:
>>>> +		return 2;
>>>> +#endif
>>>> +#ifdef __NR_openat
>>>> +	case __NR_openat:
>>>> +		return 3;
>>>> +#endif
>>>> +#ifdef __NR_socketcall
>>>> +	case __NR_socketcall:
>>>> +		return 4;
>>>> +#endif
>>>> +	case __NR_execve:
>>>> +		return 5;
>>>> +	default:
>>>> +		return 1;
>>>> +	}
>>>> +}
>>>
>>> BTW, since they aren't many, you could get the arch code to define
>>> __NR_compat_open etc. explicitly and use these. On arm64 we have a few
>>> of these defined to avoid name collision in signal handling code.
>>
>> Again, most architecture have their own unistd32.h for compat system calls,
>> and use __NR_open-like naming.
>> It's unlikely for these archs to migrate to "generic compat" auditing,
>> but I believe that '__NR_open'-like naming is better because we may be able to avoid
>> arch-specific changes even for future(?) syscall-related enhancements in audit.

In my compat_audit.c, all the entries in audit classes are derived from asm-generic/audit_*.h,
where __NR_xyz are used to list the system calls. So it is not possible to use __NR_compat_xyz
as far as we re-use those generic files.
(Obviously we don't want to duplicate those header files, that is, audit_compat_*.h.)

I agree that we should not have similar but different files, like unist32.h and unistd_32.h,
but it seems to be inevitable for our case. (That is the reason why I dynamically generate unistd_32.h)

As for arch-specific header file name, "audit_unistd32.h" can be fine, but people on other architectures
might be unhappy with such a name since they can commonly use unistd32.h instead.


- Takahiro AKASHI

> My preference is as above, a few __NR_compat_* (just those required by
> audit) defined in unistd.h but I'm not an audit maintainer.
>
