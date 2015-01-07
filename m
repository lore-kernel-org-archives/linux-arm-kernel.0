From: wangweidong1@huawei.com (Wang Weidong)
Date: Wed, 7 Jan 2015 15:09:25 +0800
Subject: [Ask for HELP] Should it support ustat syscall for arm64
In-Reply-To: <B944B469BF5302468AC6EB05E56CC70DB3AD6D@lhreml503-mbs.china.huawei.com>
References: <54A0C35B.4010001@huawei.com> <54A10D8D.8060002@hisilicon.com>
 <B944B469BF5302468AC6EB05E56CC70DB3AD6D@lhreml503-mbs.china.huawei.com>
Message-ID: <54ACDBA5.8080801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/5 18:53, Frediano Ziglio wrote:
>> On 2014/12/29 10:58, Wang Weidong wrote:
>>> Hi,
>>>
>>> As I ran LTP testcase ustat01 and ustat02 on Arm64, and got the
>> result:
>>>
>>> ustat01     1  TFAIL  :  ustat(2) failed and setthe errno to 38 :
>> Function not implemented
>>>
>>> ustat02     1  TFAIL  :  ustat(2) failed to produce expected error;
>> 22, errno: EINVAL:
>>>                          TEST_ERRNO=ENOSYS(38): Function not
>> implemented
>>> ustat02     2  TFAIL  :  ustat(2) failed to produce expected error;
>> 14, errno: EFAULT:
>>>                          TEST_ERRNO=ENOSYS(38): Function not
>>> implemented
>>>
>>> -----------------------
>>>
>>> I found the glibc and kernel's implementation:
>>> The glibc version is 2.19, kernel is 3.16.
>>>
>>> The glibc will use the sysdeps/unix/sysv/linux/generic/ustat.c
>>> But it only return ENOSYS.
>>>
>>> The kernel doesn't support the NR_ustat syscall.
>>>
>>> So I did that:
>>> 1. In glibc:
>>> I changed the sysdeps/unix/sysv/linux/generic/ustat.c:
>>>
>>> -#include <errno.h>
>>> -#include <sys/ustat.h>
>>> +#define __ARCH_WANT_SYSCALL_DEPRECATED #include
>>> +<sysdeps/unix/sysv/linux/ustat.c>
>>>
>>> -#include <sysdep.h>
>>> -#include <sys/syscall.h>
>>> -
>>> -/* This deprecated syscall is no longer used (replaced with fstat).
>>> */ -int -ustat (dev_t dev, struct ustat *ubuf) -{
>>> -  __set_errno (ENOSYS);
>>> -  return -1;
>>> -}
>>> -stub_warning (ustat)
>>>
>>> 2. In Kernel:
>>> I changed the arch/arm64/include/uapi/asm/unistd.h:
>>>
>>> +#define __ARCH_WANT_SYSCALL_DEPRECATED #define __ARCH_WANT_SYS_FORK
>>> +#define __ARCH_WANT_SYS_VFORK
>>>
>>> After the changing, These cases will Pass.
>>
>> Hi Weidong,
>>
>>> So, Does it need to support ustat syscall for arm64?
>>
>> No, on arm64 the ustat syscall is obsolete.
>> You could find syscalls from "include/uapi/asm-generic/unistd.h".
>> And on arm64, there is no define for "__ARCH_WANT_SYSCALL_DEPRECATED".
>> So there is no support for the syscalls covered by the macro above.
>>
>> Best Regards,
>> Wei
>>
>>> Regards,
>>> Wang
>>>
> 
> Hi,
>   Opened an issue at https://github.com/linux-test-project/ltp/issues/25
> 
> Frediano
> 

OK, Got it.

Thanks,
Wang

> 
> .
> 
