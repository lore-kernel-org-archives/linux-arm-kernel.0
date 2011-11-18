From: conqrx@gmail.com (=?ISO-8859-1?B?TW9sbuFyIEfhYm9y?=)
Date: Fri, 18 Nov 2011 12:54:42 +0100
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
Message-ID: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear everyone,

im working on a project wich aims at porting the 2.6.38 kernel to an
arm11 mpcore based board.

The kernel fails to boot, in the paging_init func, it throws an
exception (pc: FFFF_000C) when executing the third mcr instruction in
the list below:

0xc000bf34  <>:    blx	r3
0xc000bf38  <>:    mov	r5, #0	; 0x0
0xc000bf3c  <>:    mcr	15, 0, r5, cr7, cr10, {4}
0xc000bf40  <>:    mcr	15, 0, r5, cr8, cr6, {0}
0xc000bf44  <>:    mcr	15, 0, r5, cr8, cr5, {0} //throws an exception
here, Invalidate Instruction TLB Register
0xc000bf48  <>:    mcr	15, 0, r5, cr7, cr5, {6}
0xc000bf4c  <>:    mcr	15, 0, r5, cr7, cr10, {4}
0xc000bf50  <>:    mcr	15, 0, r5, cr7, cr5, {4}
0xc000bf54  <>:    ldr	lr, [pc, #176]	; 0xc000c00c

The kernel has been patched with the 2.6.38-arm1 patch, and configured
to be as minimal as possible (the vmlinux.elf is 1.8MB) and
cross-compiled with the?Codesourcery gcc toolchain.
The minimal size is improtant because the aim is to make the kernel
run with only 5-6MB of memory (from c0000000 to c0500000).
The 'boot_loader' i wrote passes the atag pointers (basically core and
memory) and the kernel seemingly reads and parses them fine. The
__log_buf before the exception:

<5>Linux version 2.6.38-rc8 (VirtualBox) (gcc version 4.5.2 (Sourcery
G++ Lite 2011.03-41) ) #6 Wed Nov 9 21:59:29 CET 2011
<4>CPU: ARMv6-compatible processor [410fb025] revision 5 (ARMv7), cr=08c5387f"
<4>CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
<4>Machine: ARM-RealView PB11MPCore
<5>Ignoring RAM at c0000000-c04fffff (vmalloc region overlap).

The last one might be solved with setting the high mem option before
compiling (it might be a problem as i load the whole kernel to that
region).

Im only a beginner,?and im sorry for the low quality of the question,
i appreciate any help. Even comments on how 'accomplishable' this
project is. Also, the board is not a realview board, but it might not
be an issue at this stage.

Thank you in advance.
