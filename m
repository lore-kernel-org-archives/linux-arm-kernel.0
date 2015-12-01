From: dcashman@android.com (Daniel Cashman)
Date: Tue, 1 Dec 2015 10:19:32 -0800
Subject: [PATCH v4 4/4] x86: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <CAGXu5j+Wj_=27gsYStV5OuwNSznux7MtDcMuYe5wM2ORrna_TQ@mail.gmail.com>
References: <1448578785-17656-1-git-send-email-dcashman@android.com>
 <1448578785-17656-2-git-send-email-dcashman@android.com>
 <1448578785-17656-3-git-send-email-dcashman@android.com>
 <1448578785-17656-4-git-send-email-dcashman@android.com>
 <1448578785-17656-5-git-send-email-dcashman@android.com>
 <CAGXu5j+Wj_=27gsYStV5OuwNSznux7MtDcMuYe5wM2ORrna_TQ@mail.gmail.com>
Message-ID: <565DE4B4.5050305@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 04:03 PM, Kees Cook wrote:
> On Thu, Nov 26, 2015 at 2:59 PM, Daniel Cashman <dcashman@android.com> wrote:
>> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
>> index 844b06d..647fecf 100644
>> --- a/arch/x86/mm/mmap.c
>> +++ b/arch/x86/mm/mmap.c
>> @@ -69,14 +69,14 @@ unsigned long arch_mmap_rnd(void)
>>  {
>>         unsigned long rnd;
>>
>> -       /*
>> -        *  8 bits of randomness in 32bit mmaps, 20 address space bits
>> -        * 28 bits of randomness in 64bit mmaps, 40 address space bits
>> -        */
>>         if (mmap_is_ia32())
>> -               rnd = (unsigned long)get_random_int() % (1<<8);
>> +#ifdef CONFIG_COMPAT
>> +               rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
>> +#else
>> +               rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>> +#endif
>>         else
>> -               rnd = (unsigned long)get_random_int() % (1<<28);
>> +               rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>>
>>         return rnd << PAGE_SHIFT;
>>  }
>> --
>> 2.6.0.rc2.230.g3dd15c0
>>
> 
> Can you rework this logic to look more like the arm64 one? I think
> it's more readable as:
> 
> #ifdef CONFIG_COMPAT
>     if (mmap_is_ia32())
>             rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
>     else
> #endif
>             rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
> 
> -Kees
> 

There is a subtle difference between the two that requires this
difference. the x86 code was written to be used by both 32-bit and
64-bit kernels, whereas the arm64 code runs only for 64-bit.  The
assumption I've made with arm64 is that TIF_32BIT should never be set if
CONFIG_COMPAT is not set, but with x86 we could encounter a 32-bit
application without CONFIG_COMPAT, in which case it should use the
default mmap_rnd_bits, not compat, since there is no compat.

-Dan
