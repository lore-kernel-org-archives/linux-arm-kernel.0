From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu, 15 Oct 2015 18:52:29 +0200
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <20151015163712.GD32532@n2100.arm.linux.org.uk>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
 <561E63C9.3040702@mentor.com>
 <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
 <20151015163712.GD32532@n2100.arm.linux.org.uk>
Message-ID: <2EC080E4-B31C-46F5-8239-FF96493DA861@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 15.10.2015 um 18:37 schrieb Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, Oct 15, 2015 at 07:52:38AM +0200, H. Nikolaus Schaller wrote:
>> ERROR: space prohibited before that close parenthesis ')'
>> #46: FILE: arch/arm/vdso/vdsomunge.c:64:
>> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
> 
> I have a pet hatred of too many parens.  I also have a hatred of idiotic
> casts.  What about changing the above to one of:
> 
> 		(((x) & 0xff00) >> 8)
> 		(((x) >> 8) & 0xff)
> 
>> 
>> ERROR: space prohibited before that close parenthesis ')'
>> #53: FILE: arch/arm/vdso/vdsomunge.c:71:
>> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
> 
> and one of:
> 
> 		(((x) & 0xff000000) >> 24)
> 		(((x) >> 24) & 0xff)
> 
> ?

Well, the semantics is sometimes the same but I think readability goes down
because the macro becomes quite un-symmetric and for >> 8 you should
better be sure that values are unsigned if combining with | operator.

Of course it is questionable why the constants (with U and UL modifiers)
are casted.

The full macro (as copied verbatim from existing arch/mips/boot/elf2ecoff.c) is:

+#define swab16(x) \
+	((unsigned short)( \
+		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
+		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8)))
+
+#define swab32(x) \
+	((unsigned int)( \
+		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
+		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
+		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
+		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24)))
+

I have already submitted a V3 of this patch, so please comment that.

A question is why this is not generally available for all HOSTCC based tools
so that we could simply include some header. But since that is no kernel
code but a tool, I think it is not really necessary to put significant efforts
into this piece of code.

This was probably the intention of the original code to simply include
byteswap.h - then you don't even see how complex the macros are -
but it is not a standard header.

BR and thanks,
Nikolaus Schaller
