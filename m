From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 21 Apr 2011 07:59:30 +0900
Subject: [PATCH 1/3] bitops: add ifdef CONFIG_GENERIC_FIND_BIT_LE guard
In-Reply-To: <201104201631.40017.arnd@arndb.de>
References: <1303309252-9946-1-git-send-email-akinobu.mita@gmail.com>
	<201104201631.40017.arnd@arndb.de>
Message-ID: <BANLkTimBF312svk0mRkt5_Y=t+B12cLW+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 20 April 2011, Akinobu Mita wrote:
>> index 946a21b..bd2253e 100644
>> --- a/include/asm-generic/bitops/le.h
>> +++ b/include/asm-generic/bitops/le.h
>> @@ -30,6 +30,8 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
>>
>> ?#define BITOP_LE_SWIZZLE ? ? ? ((BITS_PER_LONG-1) & ~0x7)
>>
>> +#ifdef CONFIG_GENERIC_FIND_BIT_LE
>> +
>> ?extern unsigned long find_next_zero_bit_le(const void *addr,
>> ? ? ? ? ? ? ? ? unsigned long size, unsigned long offset);
>> ?extern unsigned long find_next_bit_le(const void *addr,
>> @@ -38,6 +40,8 @@ extern unsigned long find_next_bit_le(const void *addr,
>> ?#define find_first_zero_bit_le(addr, size) \
>> ? ? ? ? find_next_zero_bit_le((addr), (size), 0)
>>
>> +#endif /* CONFIG_GENERIC_FIND_BIT_LE */
>> +
>> ?#else
>> ?#error "Please fix <asm/byteorder.h>"
>> ?#endif
>
> The style that we normally use in asm-generic is to test the macro itself
> for existence, so in asm-generic, do:
>
> #ifndef find_next_zero_bit_le
> extern unsigned long find_next_zero_bit_le(const void *addr,
> ? ? ? ? ? ? ? ? unsigned long size, unsigned long offset);
> #endif
>
> and in the architectures, write
>
> static inline unsigned long find_next_zero_bit_le(const void *addr,
> ? ? ? ? ? ? ? ? unsigned long size, unsigned long offset)
> #define find_next_zero_bit_le find_next_zero_bit_le
>
> I guess we can do the #ifdef separately for each of the three macros,
> or choose one of them to use as a key.

I see.

Should we also kill CONFIG_GENERIC_FIND_BIT_LE option comletely,
then add the #ifdef for each find_*() in lib/find_next_bit.c and always build
it unconditionally ?
