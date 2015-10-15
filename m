From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu, 15 Oct 2015 07:52:38 +0200
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <561E63C9.3040702@mentor.com>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
 <561E63C9.3040702@mentor.com>
Message-ID: <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 14.10.2015 um 16:16 schrieb Nathan Lynch <nathan_lynch@mentor.com>:

> On 10/14/2015 07:47 AM, H. Nikolaus Schaller wrote:
>>> diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
>>> index aedec81..27a9a0b 100644
>>> --- a/arch/arm/vdso/vdsomunge.c
>>> +++ b/arch/arm/vdso/vdsomunge.c
>>> @@ -45,7 +45,18 @@
>>> * it does.
>>> */
>>> 
>>> -#include <byteswap.h>
>>> +#define swab16(x) \
>>> +	((unsigned short)( \
>>> +		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
>>> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
>>> +
>>> +#define swab32(x) \
>>> +	((unsigned int)( \
>>> +		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
>>> +		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
>>> +		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
>>> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
>>> +
>>> #include <elf.h>
>>> #include <errno.h>
>>> #include <fcntl.h>
>>> @@ -104,17 +115,17 @@ static void cleanup(void)
>>> 
>>> static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
>>> {
>>> -	return swap ? bswap_32(word) : word;
>>> +	return swap ? swab32(word) : word;
>>> }
>>> 
>>> static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
>>> {
>>> -	return swap ? bswap_16(half) : half;
>>> +	return swap ? swab16(half) : half;
>>> }
>>> 
>>> static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
>>> {
>>> -	*dst = swap ? bswap_32(val) : val;
>>> +	*dst = swap ? swab32(val) : val;
>>> }
>> ping.
> 
> Sorry for the delay.
> 
> This is okay but I'd prefer the swab macros to be below the #include
> lines,

Ok.

> and it would be easier for me to deal with a patch that isn't
> whitespace-damaged.

You mean:

ERROR: space prohibited before that close parenthesis ')'
#46: FILE: arch/arm/vdso/vdsomunge.c:64:
+		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))

ERROR: space prohibited before that close parenthesis ')'
#53: FILE: arch/arm/vdso/vdsomunge.c:71:
+		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))

Well, I had copied that verbatim from arch/mips/boot/elf2ecoff.c and
thought that it is better readable, but it is easy to fix.

V3 is coming.

BR and thanks,
Nikolaus
