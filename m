From: ocean_ieee@yahoo.it (ocean)
Date: Tue, 14 May 2013 20:31:47 +0200
Subject: SIGSEGV changing pc register (help for my master thesis on ARM/linux
 kernel)
Message-ID: <51928313.4010902@yahoo.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all I'm a student in computer engineering and for my master thesis
(on the security of virtualization on ARM/linux) i really need to
understand this:

i'm trying to make a jump from kernel code (the actual instruction is
blx r3) to a location allocated using mmap, which results in a SIGSEGV:

  mmap_start = 0x57677000;
  mmap_size = sysconf(_SC_PAGE_SIZE);

  if (mmap((void*)mmap_start, mmap_size, PROT_READ|PROT_WRITE|PROT_EXEC,
	   MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0) == MAP_FAILED) {
    printf("mmap failed\n");
    exit(1); }

the actual kernel code is:
0xc05819ec <+204>:	beq	0xc0581a08 <sock_diag_rcv_msg+232>
0xc05819f0 <+208>:	ldr	r3, [r3, #4]
0xc05819f4 <+212>:	mov	r1, r4
0xc05819f8 <+216>:	mov	r0, r6
0xc05819fc <+220>:	blx	r3
0xc0581a00 <+224>:	mov	r4, r0

(for those wondering it's related to CVE-2013-1763)

stepping or trying to change the value with gdb gives that SIGSEGV and
sometimes changes pc with 0x00000008 (that's strange too, i can't
understand why).

"(gdb) ni
KGDB only knows signal 9 (pass) and 15 (pass and disconnect)
Executing a continue without signal passing

Program received signal SIGSEGV, Segmentation fault.
0x00000008 in ?? ()


I've tried also other locations (all mapped correctly, i can read them
with x/x in GDB)

(gdb) set $pc=0x57677FF4
Cannot access memory at address 0x0
(gdb) set $pc=0x57677FF3
Cannot access memory at address 0x0
(gdb) set $pc=0x57677FF1
Cannot access memory at address 0x0
(gdb) set $pc=0x57670001
(gdb) ni
0x57670000 in ?? ()
Cannot access memory at address 0x57670000
(gdb)

strange enough (gdb) set $pc=0x57670001 don't give errors but then i
cannot step on....


Thank you if anyone would help me understand (i'm new to ARM learned all
i know in a few days so please excuse me if it's trivial)

Best Regards
Davide Quarta
