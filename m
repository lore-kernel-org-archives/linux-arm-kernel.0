From: slash.tmp@free.fr (Mason)
Date: Wed, 24 May 2017 17:26:25 +0200
Subject: User-space code aborts on some (but not all) misaligned accesses
Message-ID: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Message sent to both gcc-help and LAKML ]

Hello,

Consider the following user-space code, split over two files
to defeat the optimizer.

This test program maps a page of memory not managed by Linux,
and writes 4 words to misaligned addresses within that page.

$ cat store.c 
void store_at_addr_plus_0(void *addr, int val)
{
	__builtin_memcpy(addr + 0, &val, sizeof val);
}
void store_at_addr_plus_1(void *addr, int val)
{
	__builtin_memcpy(addr + 1, &val, sizeof val);
}

$ cat testcase.c 
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
void store_at_addr_plus_0(void *addr, int val);
void store_at_addr_plus_1(void *addr, int val);
int main(void)
{
	int fd = open("/dev/mem", O_RDWR | O_SYNC);
	void *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0xc0000000);
	store_at_addr_plus_0(ptr + 0, fd); puts("X");	// store at ptr + 0 => OK
	store_at_addr_plus_0(ptr + 1, fd); puts("X");	// store at ptr + 1 => OK
	store_at_addr_plus_1(ptr + 3, fd); puts("X");	// store at ptr + 4 => OK
	store_at_addr_plus_1(ptr + 0, fd); puts("X");	// store at ptr + 1 => ABORT
	return 0;
}

With optimizations turned off, the program works as expected.

$ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O0 testcase.c store.c -o misaligned_stores
$ ./misaligned_stores 
X
X
X
X

But if optimizations are enabled, the program aborts on the last store.

$ arm-linux-gnueabihf-gcc-6.3.1 -Wall -O1 testcase.c store.c -o misaligned_stores
# ./misaligned_stores 
X
X
X
Bus error
[ 8736.457254] Alignment trap: not handling instruction f8c01001 at [<000104aa>]
[ 8736.464496] Unhandled fault: alignment exception (0x811) at 0xb6f4b001
[ 8736.471106] pgd = de2d4000
[ 8736.473839] [b6f4b001] *pgd=9f56b831, *pte=c0000743, *ppte=c0000c33

(gdb) disassemble store_at_addr_plus_0
   0x000104a6 <+0>:     str     r1, [r0, #0]
   0x000104a8 <+2>:     bx      lr

(gdb) disassemble store_at_addr_plus_1
   0x000104aa <+0>:     str.w   r1, [r0, #1]
   0x000104ae <+4>:     bx      lr


So the 4th store (a misaligned store) aborts.
But why doesn't the 2nd store abort as well?
It targets the *same* address.
They're using different versions of the str instruction.

The compiler generates
str	r1, [r0]	@ unaligned
str	r1, [r0, #1]	@ unaligned

According to objdump

00000000 <store_at_addr_plus_0>:
   0:	6001      	str	r1, [r0, #0]
   2:	4770      	bx	lr

00000004 <store_at_addr_plus_1>:
   4:	f8c0 1001 	str.w	r1, [r0, #1]
   8:	4770      	bx	lr

Side issue, the T2 encoding for the STR instruction states
1 1 1 1 1 0 0 0 0 1 0 0 Rn
which comes out as f840, not f8c0; I don't understand.

My question is:

Why does instruction "6001" work on misaligned addresses,
while "f8c0 1001" aborts?

Below the disas of main FWIW.

Regards.



(gdb) disassemble main
   0x00010430 <+0>:     push    {r4, r5, r6, lr}
   0x00010432 <+2>:     sub     sp, #8
   0x00010434 <+4>:     movw    r1, #4098       ; 0x1002
   0x00010438 <+8>:     movt    r1, #16
   0x0001043c <+12>:    movw    r0, #4620       ; 0x120c
   0x00010440 <+16>:    movt    r0, #1
   0x00010444 <+20>:    blx     0x1032c <open@plt>
   0x00010448 <+24>:    mov     r5, r0
   0x0001044a <+26>:    mov.w   r3, #3221225472 ; 0xc0000000
   0x0001044e <+30>:    str     r3, [sp, #4]
   0x00010450 <+32>:    str     r0, [sp, #0]
   0x00010452 <+34>:    movs    r3, #1
   0x00010454 <+36>:    movs    r2, #3
   0x00010456 <+38>:    mov.w   r1, #4096       ; 0x1000
   0x0001045a <+42>:    movs    r0, #0
   0x0001045c <+44>:    blx     0x10338 <mmap@plt>
   0x00010460 <+48>:    mov     r6, r0
   0x00010462 <+50>:    mov     r1, r5
   0x00010464 <+52>:    bl      0x104a6 <store_at_addr_plus_0>
   0x00010468 <+56>:    movw    r4, #4632       ; 0x1218
   0x0001046c <+60>:    movt    r4, #1
   0x00010470 <+64>:    mov     r0, r4
   0x00010472 <+66>:    blx     0x10308 <puts@plt>
   0x00010476 <+70>:    mov     r1, r5
   0x00010478 <+72>:    adds    r0, r6, #1
   0x0001047a <+74>:    bl      0x104a6 <store_at_addr_plus_0>
   0x0001047e <+78>:    mov     r0, r4
   0x00010480 <+80>:    blx     0x10308 <puts@plt>
   0x00010484 <+84>:    mov     r1, r5
   0x00010486 <+86>:    adds    r0, r6, #3
   0x00010488 <+88>:    bl      0x104aa <store_at_addr_plus_1>
   0x0001048c <+92>:    mov     r0, r4
   0x0001048e <+94>:    blx     0x10308 <puts@plt>
   0x00010492 <+98>:    mov     r1, r5
   0x00010494 <+100>:   mov     r0, r6
   0x00010496 <+102>:   bl      0x104aa <store_at_addr_plus_1>
   0x0001049a <+106>:   mov     r0, r4
   0x0001049c <+108>:   blx     0x10308 <puts@plt>
   0x000104a0 <+112>:   movs    r0, #0
   0x000104a2 <+114>:   add     sp, #8
   0x000104a4 <+116>:   pop     {r4, r5, r6, pc}
