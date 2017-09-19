From: net147@gmail.com (Jonathan Liu)
Date: Wed, 20 Sep 2017 07:35:23 +1000
Subject: [PATCH] ARM: uaccess: Add missing include for set_thread_flag
In-Reply-To: <CAJcbSZEiHW=yH+ATvLq=am4nbVdhbqAxkH-+jEymhNkN+Pkb=A@mail.gmail.com>
References: <20170919115042.6800-1-net147@gmail.com>
 <CAJcbSZEiHW=yH+ATvLq=am4nbVdhbqAxkH-+jEymhNkN+Pkb=A@mail.gmail.com>
Message-ID: <CANwerB1Pn2YAN9VmbSAzD3Se47ThAQNBRLH71HV_e7VZ34yAPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

The top of the C source file I am compiling has:
#include <linux/kernel.h>
#include <asm/uaccess.h>

Tracing through the asm/uaccess.h include I see
asm/uaccess.h -> asm/domain.h -> asm/thread_info.h

but set_thread_info is defined in linux/thread_info.h not
asm/thread_info.h (see
http://elixir.free-electrons.com/linux/v4.14-rc1/ident/set_thread_flag).

Regards,
Jonathan

On 20 September 2017 at 00:32, Thomas Garnier <thgarnie@google.com> wrote:
> On Tue, Sep 19, 2017 at 4:50 AM, Jonathan Liu <net147@gmail.com> wrote:
>> Fixes "implicit declaration of function" compile error for out-of-tree
>> kernel modules including asm/uaccess.h.
>
> I failed to reproduce this issue by creating an out of tree module
> with a separate file (with only uaccess.h). Are you using a special
> config?
>
> Looking at the headers on uaccess.h. You get thread_info through:
>
>  asm/domain.h -> asm/thread_info.h
>
>>
>> Fixes: 73ac5d6a2b6a ("arm/syscalls: Check address limit on user-mode return")
>> Signed-off-by: Jonathan Liu <net147@gmail.com>
>> ---
>>  arch/arm/include/asm/uaccess.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
>> index 87936dd5d151..13d1877ffb75 100644
>> --- a/arch/arm/include/asm/uaccess.h
>> +++ b/arch/arm/include/asm/uaccess.h
>> @@ -17,6 +17,7 @@
>>  #include <asm/unified.h>
>>  #include <asm/compiler.h>
>>
>> +#include <linux/thread_info.h>
>>  #include <asm/extable.h>
>>
>>  /*
>> --
>> 2.13.2
>>
>
>
>
> --
> Thomas
