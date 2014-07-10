From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 17:54:45 +0400
Subject: [RFC/PATCH RESEND -next 03/21] x86: add kasan hooks fort
 memcpy/memmove/memset functions
In-Reply-To: <87ion6nxap.fsf@tassilo.jf.intel.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-4-git-send-email-a.ryabinin@samsung.com>
 <87ion6nxap.fsf@tassilo.jf.intel.com>
Message-ID: <53BE9B25.6090906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 23:31, Andi Kleen wrote:
> Andrey Ryabinin <a.ryabinin@samsung.com> writes:
>> +
>> +#undef memcpy
>> +void *kasan_memset(void *ptr, int val, size_t len);
>> +void *kasan_memcpy(void *dst, const void *src, size_t len);
>> +void *kasan_memmove(void *dst, const void *src, size_t len);
>> +
>> +#define memcpy(dst, src, len) kasan_memcpy((dst), (src), (len))
>> +#define memset(ptr, val, len) kasan_memset((ptr), (val), (len))
>> +#define memmove(dst, src, len) kasan_memmove((dst), (src), (len))
> 
> I don't think just define is enough, gcc can call these functions
> implicitely too (both with and without __). For example for a struct copy.
> 
> You need to have true linker level aliases. 
> 

It's true, but problem with linker aliases that they cannot be disabled for some files
we don't want to instrument.

> -Andi
> 
