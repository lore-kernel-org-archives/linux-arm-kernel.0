From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 22:18:54 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <yw1xa8q5bwf9.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <3964884.0P2KA5fUaZ@wuerfel> <yw1xa8q5bwf9.fsf@unicorn.mansr.com>
Message-ID: <4087953.TJWxTSWgI0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 20:39:54 M?ns Rullg?rd wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > arnd at wuerfel:/tmp$ arm-linux-gnueabihf-gcc -Wall -O2 -mcpu=cortex-a15 idiv.c -c -o idiv-arm.o
> > arnd at wuerfel:/tmp$ objdump -dr idiv-arm.o   
> >
> > idiv-arm.o:     file format elf32-littlearm
> >
> > Disassembly of section .text:
> >
> > 00000000 <udiv>:
> >    0:   fbb0 f0f1       udiv    r0, r0, r1
> >    4:   4770            bx      lr
> >    6:   bf00            nop
> >
> > 00000008 <sdiv>:
> >    8:   fb90 f0f1       sdiv    r0, r0, r1
> >    c:   4770            bx      lr
> >    e:   bf00            nop
> 
> Your compiler seems to default to thumb so you should add -marm.
> 

Sorry about that.

	Arnd

arnd at wuerfel:/tmp$ arm-linux-gnueabihf-gcc -Wall -O2 -mcpu=cortex-a15 idiv.c -c -o idiv-arm.o -marm
arnd at wuerfel:/tmp$ objdump -dr idiv-arm.o 

idiv-arm.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <udiv>:
   0:   e730f110        udiv    r0, r0, r1
   4:   e12fff1e        bx      lr

00000008 <sdiv>:
   8:   e710f110        sdiv    r0, r0, r1
   c:   e12fff1e        bx      lr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: idiv-arm.o
Type: application/x-object
Size: 861 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/62e271ac/attachment.bin>
