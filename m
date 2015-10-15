From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 15 Oct 2015 12:07:36 -0500
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
 <561E63C9.3040702@mentor.com>
 <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
Message-ID: <561FDD58.1020602@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 12:52 AM, H. Nikolaus Schaller wrote:
> Am 14.10.2015 um 16:16 schrieb Nathan Lynch <nathan_lynch@mentor.com>:
>> and it would be easier for me to deal with a patch that isn't
>> whitespace-damaged.
> 
> You mean:
> 
> ERROR: space prohibited before that close parenthesis ')'
> #46: FILE: arch/arm/vdso/vdsomunge.c:64:
> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
> 
> ERROR: space prohibited before that close parenthesis ')'
> #53: FILE: arch/arm/vdso/vdsomunge.c:71:
> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
> 
> Well, I had copied that verbatim from arch/mips/boot/elf2ecoff.c and
> thought that it is better readable, but it is easy to fix.

That's not what I was referring to, but it is fine to fix that too.

What I meant was that the first column of the patch body is corrupted.
Your v2 has hunks like this (bad):

static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
{
-	return swap ? bswap_32(word) : word;
+	return swap ? swab32(word) : word;
}


Your v3 has this (good):

 static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
 {
-	*dst = swap ? bswap_32(val) : val;
+	*dst = swap ? swab32(val) : val;
 }
