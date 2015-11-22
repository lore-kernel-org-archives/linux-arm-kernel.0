From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 21:37 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151122200326.GK8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <4527012.vmieWOaE32@wuerfel> <20151122200326.GK8644@n2100.arm.linux.org.uk>
Message-ID: <3964884.0P2KA5fUaZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 20:03:26 Russell King - ARM Linux wrote:
> On Sun, Nov 22, 2015 at 08:58:08PM +0100, Arnd Bergmann wrote:
> > does it work with -mcpu=cortex-a15?  I've tried crosstool as versions
> > 2.23.52.20130913, 2.24.0.20141017 and 2.25.51.20150518, and they
> > all seem to behave as expected, failing with -mcpu=cortex-a9 and
> > marvell-pj4 but succeeding with -mcpu=cortex-a15 or marvell-pj4+idiv.
> 
> Appears not:
> 
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a15+idiv' -marm
> /tmp/ccSovg32.s: Assembler messages:
> /tmp/ccSovg32.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a15+idiv' -mthumb
> /tmp/cchbT3EE.s: Assembler messages:
> /tmp/cchbT3EE.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'
> 
> Same without the +idiv.

I've attached files with those instructions, maybe that helps.

> > I've also found some /proc/cpuinfo output to cross-reference SoCs
> > to their core names.
> > 
> > 		variant	part	revision	name		features
> > mmp2:		0	0x581	5		PJ4		idivt
> > dove:		0	0x581	5		PJ4		idivt
> 
> Yes, that agrees with my dove.

ok.

arnd at wuerfel:/tmp$ cat idiv.c 
unsigned int udiv(unsigned int a, unsigned int b)
{
        return a / b;
}

int sdiv(int a, int b)
{
        return a / b;
}
arnd at wuerfel:/tmp$ arm-linux-gnueabihf-gcc -Wall -O2 -mcpu=cortex-a15 idiv.c -c -o idiv-arm.o
arnd at wuerfel:/tmp$ objdump -dr idiv-arm.o   

idiv-arm.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <udiv>:
   0:   fbb0 f0f1       udiv    r0, r0, r1
   4:   4770            bx      lr
   6:   bf00            nop

00000008 <sdiv>:
   8:   fb90 f0f1       sdiv    r0, r0, r1
   c:   4770            bx      lr
   e:   bf00            nop
arnd at wuerfel:/tmp$ arm-linux-gnueabihf-gcc -Wall -O2 -mcpu=cortex-a15 idiv.c -c -o idiv-thumb.o -mthumb
arnd at wuerfel:/tmp$ objdump -dr idiv-thumb.o 

idiv-thumb.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <udiv>:
   0:   fbb0 f0f1       udiv    r0, r0, r1
   4:   4770            bx      lr
   6:   bf00            nop

00000008 <sdiv>:
   8:   fb90 f0f1       sdiv    r0, r0, r1
   c:   4770            bx      lr
   e:   bf00            nop


	Arnd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: idiv-arm.o
Type: application/x-object
Size: 861 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/50ec74f8/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: idiv-thumb.o
Type: application/x-object
Size: 861 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/50ec74f8/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: idiv.c
Type: text/x-csrc
Size: 112 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/50ec74f8/attachment-0005.bin>
