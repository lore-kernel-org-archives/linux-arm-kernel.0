From: rfefw@gmail.hu (rfefw at gmail.hu)
Date: Fri, 15 Sep 2017 15:51:58 +0200
Subject: arm assembly, how to write a character to the mobile phone's screen
 at boot =?UTF-8?Q?time=3F?=
Message-ID: <e0b45c8396a6cee9d34ca5ca4316e537@gmail.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi list

i would like to code a hello world like program that would be placed on 
a
phone's ?or an emulator image.

i have been checking out the current source for the boot record where i
found a code for 'puts' which prints out a text

?
   // linux/arch/arm/boot/compressed/head.S


@ puts corrupts {r0, r1, r2, r3}
puts:		loadsp	r3, r1
1:		ldrb	r2, [r0], #1
		teq	r2, #0
		moveq	pc, lr
2:		writeb	r2, r3
		mov	r1, #0x00020000
3:		subs	r1, r1, #1
		bne	3b
		teq	r2, #'\n'
		moveq	r2, #'\r'
		beq	2b
		teq	r0, #0
		bne	1b
		mov	pc, lr
@ putc corrupts {r0, r1, r2, r3}
putc:
		mov	r2, r0
		mov	r0, #0
		loadsp	r3, r1
		b	2b
...


it calls the macro 'writeb' which is defined as (well it has multiple 
definitions, but one of them for instance):

mcr	p14, 0, \ch, c0, c5, 0

what are these magical p14 and c0 c5 registers? is there a 
documentation for these?

but may be i am on the wrong track, if so, how do i print out a 
character at the boot code's level? is there something like a "video 
memory" where i can write to? or a "bios" interrupt call?
