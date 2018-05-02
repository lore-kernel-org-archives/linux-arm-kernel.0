From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 2 May 2018 17:29:04 +0200
Subject: [PATCH 3/6] arm64: untag user addresses in copy_from_user and
 others
In-Reply-To: <20180426154725.74a33tnevvbtqx63@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <949c343a4b02b41b80f324c2b7cd56b75e6a04f3.1524077494.git.andreyknvl@google.com>
 <20180426154725.74a33tnevvbtqx63@armageddon.cambridge.arm.com>
Message-ID: <CAAeHK+xWV2RNuoOrgkLrQ973eV2r8xFOcrzHWVrQZz7XA2WGYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 5:47 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Apr 18, 2018 at 08:53:12PM +0200, Andrey Konovalov wrote:
>> @@ -238,12 +239,15 @@ static inline void uaccess_enable_not_uao(void)
>>  /*
>>   * Sanitise a uaccess pointer such that it becomes NULL if above the
>>   * current addr_limit.
>> + * Also untag user pointers that have the top byte tag set.
>>   */
>>  #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
>>  static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>>  {
>>       void __user *safe_ptr;
>>
>> +     ptr = untagged_addr(ptr);
>> +
>>       asm volatile(
>>       "       bics    xzr, %1, %2\n"
>>       "       csel    %0, %1, xzr, eq\n"
>
> First of all, passing a tagged user pointer throughout the kernel is
> safe with uaccess routines but not suitable for find_vma() etc.
>
> With this change, we may have an inconsistent behaviour on the tag
> masking, depending on whether the entry code uses __uaccess_mask_ptr()
> or not. We could preserve the tag with something like:
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e66b0fca99c2..ed15bfcbd797 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -244,10 +244,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>         void __user *safe_ptr;
>
>         asm volatile(
> -       "       bics    xzr, %1, %2\n"
> +       "       bics    xzr, %3, %2\n"
>         "       csel    %0, %1, xzr, eq\n"
>         : "=&r" (safe_ptr)
> -       : "r" (ptr), "r" (current_thread_info()->addr_limit)
> +       : "r" (ptr), "r" (current_thread_info()->addr_limit),
> +         "r" (untagged_addr(ptr))
>         : "cc");
>
>         csdb();

Just to make sure I understood this assembly snippet correctly, this
change will result in checking untagged address against addr_limit,
and returning the original tagged address if the check passes. Sure,
sounds good, I'll do that.
