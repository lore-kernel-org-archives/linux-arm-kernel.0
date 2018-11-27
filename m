From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 27 Nov 2018 17:04:24 +0100
Subject: [PATCH v11 09/24] arm64: move untagged_addr macro from uaccess.h
 to memory.h
In-Reply-To: <20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com>
 <0288334225edc99d98d70c896494e19c3bd9361a.1542648335.git.andreyknvl@google.com>
 <20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com>
Message-ID: <CAAeHK+xgmM9Fs2Yw8Cv8zGhz_hg6G31uhHabudibj7wszmCVAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 6:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 19, 2018 at 06:26:25PM +0100, Andrey Konovalov wrote:
>> Move the untagged_addr() macro from arch/arm64/include/asm/uaccess.h
>> to arch/arm64/include/asm/memory.h to be later reused by KASAN.
>>
>> Also make the untagged_addr() macro accept all kinds of address types
>> (void *, unsigned long, etc.). This allows not to specify type casts in
>> each place where the macro is used. This is done by using __typeof__.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/include/asm/memory.h  | 8 ++++++++
>>  arch/arm64/include/asm/uaccess.h | 7 -------
>>  2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 05fbc7ffcd31..deb95be44392 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -73,6 +73,14 @@
>>  #define KERNEL_START      _text
>>  #define KERNEL_END        _end
>>
>> +/*
>> + * When dealing with data aborts, watchpoints, or instruction traps we may end
>> + * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>> + * pass on to access_ok(), for instance.
>> + */
>> +#define untagged_addr(addr)  \
>> +     (__typeof__(addr))sign_extend64((__u64)(addr), 55)
>
> Minor nits:
>
> * s/__u64/u64/ (or s/__u64/unsigned long/), since this isn't a UAPI
>   header.
>
> * Please move this down into the #ifndef __ASSEMBLY__ block, after we
>   include <linux/bitops.h>, which is necessary for sign_extend64().
>
> With those fixed up, this patch looks sound to me:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.

Will do in v12, thanks!

>
>> +
>>  /*
>>   * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
>>   * address space for the shadow region respectively. They can bloat the stack
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index 07c34087bd5e..281a1e47263d 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -96,13 +96,6 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>>       return ret;
>>  }
>>
>> -/*
>> - * When dealing with data aborts, watchpoints, or instruction traps we may end
>> - * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>> - * pass on to access_ok(), for instance.
>> - */
>> -#define untagged_addr(addr)          sign_extend64(addr, 55)
>> -
>>  #define access_ok(type, addr, size)  __range_ok(addr, size)
>>  #define user_addr_max                        get_fs
>>
>> --
>> 2.19.1.1215.g8438c0b245-goog
>>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe at googlegroups.com.
> To post to this group, send email to kasan-dev at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20181123173739.osgvnnhmptdgtlnl%40lakrids.cambridge.arm.com.
> For more options, visit https://groups.google.com/d/optout.
