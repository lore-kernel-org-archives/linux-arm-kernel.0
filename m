From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 14 Oct 2015 09:16:41 -0500
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
Message-ID: <561E63C9.3040702@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 07:47 AM, H. Nikolaus Schaller wrote:
>> diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
>> index aedec81..27a9a0b 100644
>> --- a/arch/arm/vdso/vdsomunge.c
>> +++ b/arch/arm/vdso/vdsomunge.c
>> @@ -45,7 +45,18 @@
>> * it does.
>> */
>>
>> -#include <byteswap.h>
>> +#define swab16(x) \
>> +	((unsigned short)( \
>> +		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
>> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
>> +
>> +#define swab32(x) \
>> +	((unsigned int)( \
>> +		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
>> +		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
>> +		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
>> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
>> +
>> #include <elf.h>
>> #include <errno.h>
>> #include <fcntl.h>
>> @@ -104,17 +115,17 @@ static void cleanup(void)
>>
>> static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
>> {
>> -	return swap ? bswap_32(word) : word;
>> +	return swap ? swab32(word) : word;
>> }
>>
>> static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
>> {
>> -	return swap ? bswap_16(half) : half;
>> +	return swap ? swab16(half) : half;
>> }
>>
>> static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
>> {
>> -	*dst = swap ? bswap_32(val) : val;
>> +	*dst = swap ? swab32(val) : val;
>> }
> ping.

Sorry for the delay.

This is okay but I'd prefer the swab macros to be below the #include
lines, and it would be easier for me to deal with a patch that isn't
whitespace-damaged.
