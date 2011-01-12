From: rabin@rab.in (Rabin Vincent)
Date: Wed, 12 Jan 2011 19:48:10 +0530
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <alpine.LFD.2.00.1101111347320.17086@xanadu.home>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
	<20110111183942.GL11039@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101111347320.17086@xanadu.home>
Message-ID: <AANLkTimyjEvKVusSvmdpgcMT=WeP3WwYDDYcWO8XKiY2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 00:21, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 11 Jan 2011, Russell King - ARM Linux wrote:
>> On Tue, Jan 11, 2011 at 11:12:05PM +0530, Rabin Vincent wrote:
>> > The CLZ instruction does not alter the condition flags, so remove the
>> > "cc" clobber from the inline asm for fls().
>>
>> Do you have any evidence that this changes anything, or is it just
>> subjective?
>
> This probably doesn't change anything, as gcc has been presuming that
> inline asms do clobber the condition code for years now, in order to
> prevent issues caused by a lack of %? appended to instructions in order
> to conditionally execute them otherwise.

FWIW, note that I am able to see GCC using the condition code clobber
information.  For example, for this (artificial) test code:

static inline int fls(int x)
{
	int ret;

#ifdef CLOBBER
	asm("clz %0,%1" : "=r" (ret) : "r" (x): "cc");
#else
	asm("clz %0,%1" : "=r" (ret) : "r" (x));
#endif
	return 32 - ret;
}

int f(int b)
{
	int x = fls(b);
	return b > 100 ? x : x + 10;
}

I get (GCC 4.5.1, at -O2):

--- clobber.s   2011-01-12 19:41:36.000000000 +0530
+++ noclobber.s 2011-01-12 19:41:36.000000000 +0530
@@ -1,12 +1,12 @@

-clobber.o:     file format elf32-littlearm
+noclobber.o:     file format elf32-littlearm


 Disassembly of section .text:

 00000000 <f>:
-   0:  e16f3f10        clz     r3, r0
-   4:  e3500064        cmp     r0, #100        ; 0x64
-   8:  e2630020        rsb     r0, r3, #32
+   0:  e3500064        cmp     r0, #100        ; 0x64
+   4:  e16f0f10        clz     r0, r0
+   8:  e2600020        rsb     r0, r0, #32
    c:  d280000a        addle   r0, r0, #10
   10:  e12fff1e        bx      lr
