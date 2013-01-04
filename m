From: girishgargdce@gmail.com (Girish garg)
Date: Fri, 4 Jan 2013 11:32:03 +0530
Subject: Fwd: how to check the hardware support of XN/XI bit support on
 ARM/MIPS platform
In-Reply-To: <CALTRzTn_2eaE7vr-tXwGKmO3fGqmif0hdrFEinQjbf6Dx=yHCg@mail.gmail.com>
References: <CALTRzTn_2eaE7vr-tXwGKmO3fGqmif0hdrFEinQjbf6Dx=yHCg@mail.gmail.com>
Message-ID: <CALTRzTknSz4kNB6EE7-jb1NOj5OOc95ZqH9c=rwuN0DoROPvvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,


Please let me know how to check the hardware support of XN/XI bit support
on ARM/MIPS platform.

As there is support of XN bit on ARM v >= 6 (I was using ARM 6), but no
support on MIPS (*MIPS 34Kc)*.

To check the hardware support , I run the paxtest i.e execstack. The
execstack test program must crash on ARM, but not on MIPS.

*But It is crashing on both ARM and MIPS.*

Please let me know how I can prove/check the hardware support of XN bit in
arm platform.



/* *execstack.c* - Tests wether code on the stack can be executed

 *

*/

#include <stdlib.h>

#include <stdio.h>

#include <sys/mman.h>

#include <unistd.h>

#include <errno.h>

#include <limits.h>

#include <signal.h>

#include <sys/types.h>

#include <sys/wait.h>



#ifndef PAGESIZE

#define PAGESIZE        (4096)

#endif /* PAGESIZE */



typedef void (*fptr)(void);

char *testname = "Executable stack                         ";



void itworked( void )

{

        printf( "Vulnerable\n" );

        exit( 1 );

}



void doit( void )

{

        char buf[8192];

        fptr func;



        /* Put a RETN instruction in the buffer */

        buf[0] = '\xc3';



        /* Convert the pointer to a function pointer */

        func = (fptr)buf;



        /* Call the code in the buffer */

        func();



        /* It worked when the function returns */

        itworked();

}



int main( int argc, char *argv[] )

{

        int status;



        printf( "%s: ", testname );

        fflush( stdout );



        if( fork() == 0 ) {

                do_mprotect((unsigned long)argv & ~4095U, 4096,
PROT_READ|PROT_WRITE|PROT_EXEC);

                doit();

        } else {

                wait( &status );

                if( WIFEXITED(status) == 0 ) {

                        printf( "Killed\n" );

                        exit( 0 );

                }

        }



        exit( 0 );

}


void itfailed( void )

{

        printf( "Ok\n" );

        exit( 2 );

}

int do_mprotect( const void *addr, size_t len, int prot )

{

        void *ptr;

        int retval;

        /* Allign to a multiple of PAGESIZE, assumed to be a power of two */

        ptr = (char *)(((unsigned long) addr) & ~(PAGESIZE-1));

         retval = mprotect( ptr, len, prot );

        if( retval != 0 && errno == EINVAL ) {

                perror( "could not mprotect():" );

                exit( 1 );

        }

         return retval;

}



*On MIPS target the execstack testcase giving below coredump although I
assume that XI bit is not supported in MIPS.
*

*To check the XI bit support on MIPS target I read the bit No 12 i.e RXI of
Config 3 register.*

The value of config3 register is *0x2425 *in MIPS kernel (X13).

Followings are the bit wise representation:

* *

Position

31















24















16





13





10









5





2



0

Value

0

* *

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

*1*

0

0

*1*

0

0

0

0

*1*

0

0

*1*

0

*1*

* *


**


****






VDLinux#> ./execstack

Executable stack[   53.272000] do_ri() : sending SIGILL to execstack,
PID:386

                [   53.280000]
================================================================================

[   53.288000]  KERNEL Version : 0045, debug

[   53.292000]
================================================================================

[   53.300000]

[   53.304000]
--------------------------------------------------------------------------------------

[   53.312000] EPC, RA MEMINFO

[   53.316000]
--------------------------------------------------------------------------------------

[   53.324000] epc:7f9c9548, ra:400854

[   53.328000]
--------------------------------------------------------------------------------------

[   53.336000] EPC meminfo (0x7f9c9148 to 0x7f9c9548)

[   53.340000] 9140:                   00000000 00000000 00000000 00000000
00000000 00000000

[   53.348000] 9160: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

[   53.360000] 9180: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

---- SKIP ---

[   53.616000] 9540: 00000000 00000000 ffffffff


[   53.624000]
--------------------------------------------------------------------------------------

[   53.636000] RA meminfo (0x00400054 to 0x00400854)

[   53.640000] 0040:                                              00000003
00000154 00400154

[   53.648000] 0060: 00400154 0000000d 0000000d 00000004 00000001 70000000
00000184 00400184

[   53.656000] 0080: 00400184 00000018 00000018 00000004 00000004 00000001
00000000 00400000

 [   53.692000] 0100: 00400164 00000020 00000020 00000004 00000004 6474e550
00000aac 00400aac

[   53.700000] 0120: 00400aac 00000034 00000034 00000004 00000004 00000000
00000000 00000000

--SKIP --

 [   53.888000] 03e0: 001b0011 00000035 00000000 00000000 00000012 000000a0
00400568 00000000

[   53.896000] 0400: 000c0012 00000001 00000000 00000000 00000022 675f5f00
5f6e6f6d 72617473

 [   54.200000]
--------------------------------------------------------------------------------------

[   54.208000]

[   54.208000] Cpu 0

[   54.212000] $ 0   : 00000000 00000001 00000000 00000001

[   54.216000] $ 4   : 7f9ca000 00001000 00000007 00000000

[   54.224000] $ 8   : 00000000 80000008 800ebe90 fffffff8

[   54.228000] $12   : 20202020 2af76000 00000000 7f9c9e20

[   54.232000] $16   : 7f9ca0e4 00000000 00580000 00d584a8

[   54.240000] $20   : 00590e05 00d5933c 005b0000 00000000

[   54.244000] $24   : 00000000 7f9c7fd8

[   54.248000] $28   : 2c1b6980 7f9c7fc0 00000000 00400854

[   54.256000] Hi    : 00000308

[   54.256000] Lo    : 0001e624

[   54.260000] epc   : 7f9c9548 0x7f9c9548

[   54.264000]     Tainted: P

[   54.268000] ra    : 00400854 0x400854

[   54.272000] Status: 01008c13    USER EXL IE

[   54.276000] Cause : 10800028

[   54.280000] PrId  : 00019555 (MIPS 34Kc)

[   54.284000] -----------------------------------------------------------

[   54.292000] * dump maps on pid (386)

[   54.296000] -----------------------------------------------------------

[   54.300000] 00400000-00401000 r-xp 00000000 08:01 353
/dtv/usb/sda1/pax_test_mips/execstack

[   54.312000] 00410000-00411000 rw-p 00000000 08:01 353
/dtv/usb/sda1/pax_test_mips/execstack

[   54.320000] 2af76000-2af88000 rw-p 00000000 00:00 0

[   54.324000] 2c000000-2c021000 r-xp 00000000 8a:0a 67
/mtd_exe/lib/ld-2.14.1.so

[   54.332000] 2c030000-2c031000 r--p 00020000 8a:0a 67
/mtd_exe/lib/ld-2.14.1.so

[   54.340000] 2c031000-2c032000 rw-p 00021000 8a:0a 67
/mtd_exe/lib/ld-2.14.1.so

[   54.348000] 2c040000-2c19b000 r-xp 00000000 8a:0a 71
/mtd_exe/lib/libc-2.14.1.so

[   54.356000] 2c19b000-2c1aa000 ---p 0015b000 8a:0a 71
/mtd_exe/lib/libc-2.14.1.so

[   54.368000] 2c1aa000-2c1ae000 r--p 0015a000 8a:0a 71
/mtd_exe/lib/libc-2.14.1.so

[   54.376000] 2c1ae000-2c1b0000 rw-p 0015e000 8a:0a 71
/mtd_exe/lib/libc-2.14.1.so

[   54.384000] 2c1b0000-2c1b3000 rw-p 00000000 00:00 0

[   54.388000] 7f9a9000-7f9cb000 rwxp 00000000 00:00 0          [stack]

[   54.396000] 7fff7000-7fff8000 r-xp 00000000 00:00 0          [vdso]

[   54.400000] -----------------------------------------------------------

[   54.400000]

[   54.408000] task stack info : pid(386) stack area (0x7f9a9000 ~
0x7f9cb000)

[   54.416000] -----------------------------------------------------------

[   54.424000] * dump user stack

[   54.428000] -----------------------------------------------------------

[   54.432000] dump user stack(0x7f9c7fc0 to 0x7f9c9f78)

[   54.440000] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

[   54.448000] 7fe0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

--- SKIP ---

 [   55.884000] 94c0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000

 [   55.912000] 9520: 00000000 00000000 2c039000 00000000 00000000 2c007458
00000000 00000000

[   55.920000] 9540: 00000000 00000000 ffffffff 00000000 00000000 00000000
00000000 00000000

--- SKIP ---

 [   56.600000] 9f20: 00000000 00000000 00000000 00000000 00410bbc 00d584a8
00590e05 00d5933c

[   56.608000] 9f40: 005b0000 00000000 00000000 2c00fea8 00410be0 00d584a8
00590e05 2af7628c

[   56.616000] 9f60: 2af76a70 00000001 00000001 00000000 2c039000 00d5933c
2c04a2bc

[   56.624000] -----------------------------------------------------------

[   56.624000]

[   56.636000] ##### send signal from KERNEL, SIG : 4, execstack, PID:386,
force_sig_info

[   56.644000] Call Trace:

[   56.644000] [<802fccd8>] dump_stack+0x8/0x34 from[<80044180>]
force_sig_info+0x54/0x1b0

[   56.652000] [<80044180>] force_sig_info+0x54/0x1b0 from[<80007364>]
ret_from_exception+0x0/0x10

[   56.664000]

[   56.664000] ##### send signal SIG : 4, execstack(386)->execstack(386)
__send_signal

[   56.672000] ##### deliver signal SIG : 4, execstack(386)
get_signal_to_deliver

[   56.680000] [VDLP COREDUMP] SIGNR:4

[   56.680000]

[   56.684000] ***** Coredump : Insert USB memory stick, mount check per
10sec... *****

[   57.724000] ***** USB detected *****

[   57.728000] ***** Create pid : 386 coredump file to USB mount dir
/dtv/usb/sda1/Coredump.386.gz ******

[   57.736000] * Ultimate CoreDump v1.0 : started dumping core into
'Coredump.386.gz' file *

[   57.744000] <1>##### elf aligned pages num : 1 + (3 Coredump guard
buffers)

[   57.752000] ##### Not used first lower guard page, elf_foffset : 1364,
aligned_elf_foffset : 4096

[   57.764000] ##### set_gzip_header() return success...

[   57.768000] ##### Allocated 267980 bytes for deflate workspace

[   57.776000] ##### coredump_alloc_workspaces() return success...

[   57.980000] ##### (vma->vm_next) == NULL ...

[   57.992000]  ##### Process addr space debug Info #####

[   57.996000]  ##### vma_cnt : 13

[   58.000000]  ##### vm_page : 65

[   58.004000]  ##### user_page_cnt : 17

[   58.008000]  ##### zero_page_cnt : 48

[   58.012000]  ##### kernel_page_cnt : 0

[   58.016000] ##### uncomp_coredump_file_size : 270336

[   58.020000] ##### GZIP tailer CRC32 : 2982301179

[   58.028000] ***** Create coredump file to USB mount dir ******

[   58.032000] CoreDump: finished dumping core

         : Killed




 *Similarly for ARM also it is giving core dump like this:*

VDLinux#> ./execstack

Executable stack[  451.784000] execstack: unhandled page fault (11) at
0xbead5860, code 0x80000007

[  451.792000]
================================================================================

[  451.800000]  KERNEL Version : 0000

[  451.804000]
================================================================================

[  451.812000]

[  451.812000]
--------------------------------------------------------------------------------------

[  451.820000] PC, LR MEMINFO

[  451.824000]
--------------------------------------------------------------------------------------

[  451.832000] PC:bead5860, LR:85c0

[  451.836000]
--------------------------------------------------------------------------------------

[  451.844000] PC meminfo (0xbead5460 to 0xbead5c60)

[  451.848000] 5460: ???????? ???????? ???????? ???????? ???????? ????????
???????? ????????

--- SKIP --

 [  452.524000] 7fe0: ???????? ???????? ???????? ???????? ???????? ????????
???????? ????????

[  452.532000] 8000: 464c457f 00010101 00000000 00000000 00280002 00000001
00008500 00000034

--- SKIP ---

 [  453.156000] 8980: 04000000 0000001d 00841901 05010000 0086b403 004f0500
14000000 02000001

[  453.164000] 89a0: 00004200 9a010400 01000000 000000da 00000043 00008644
000086ac 00000027

[  453.172000]
--------------------------------------------------------------------------------------

[  453.180000]

[  453.180000] pgd = e317c000

[  453.184000] [bead5860] *pgd=a9d2e831, *pte=00000000, *ppte=00000000

[  453.192000]

[  453.192000] Pid: 429, comm:            execstack

[  453.196000] CPU: 1    Tainted: P             (3.0.33 #124)

[  453.200000] PC is at 0xbead5860

[  453.204000] LR is at 0x85c0

[  453.208000] pc : [<bead5860>]    lr : [<000085c0>]    psr: 60000010

[  453.208000] sp : bead5860  ip : 40220f80  fp : 00000000

[  453.220000] r10: 40119000  r9 : 00000000  r8 : 00000000

[  453.224000] r7 : 00000000  r6 : 00008500  r5 : 00000000  r4 : bead79c4

[  453.232000] r3 : bead5860  r2 : 00000007  r1 : 00001000  r0 : 00000000

[  453.236000] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment
user

[  453.244000] Control: 10c53c7d  Table: a9d7c04a  DAC: 00000015

[  453.252000] [<c004b034>] (show_regs+0x0/0x58) from [<c004e588>]
(show_info+0xb0/0x104)

[  453.260000]  r4:e38e4ba0 r3:00000002

[  453.260000] [<c004e4d8>] (show_info+0x0/0x104) from [<c0055468>]
(__do_user_fault+0x50/0x94)

[  453.272000]  r6:0000000b r5:bead5860 r4:e38e4ba0 r3:00000000

[  453.276000] [<c0055418>] (__do_user_fault+0x0/0x94) from [<c03bf93c>]
(do_page_fault+0x2d8/0x324)

[  453.284000]  r7:e38e4ba0 r6:bead5860 r5:00030002 r4:e31c7fb0

[  453.292000] [<c03bf664>] (do_page_fault+0x0/0x324) from [<c003b260>]
(do_PrefetchAbort+0x44/0xa8)

[  453.300000] [<c003b21c>] (do_PrefetchAbort+0x0/0xa8) from [<c03bd6c8>]
(ret_from_exception+0x0/0x10)

[  453.308000] Exception stack(0xe31c7fb0 to 0xe31c7ff8)

[  453.312000] 7fa0:                                     00000000 00001000
00000007 bead5860

[  453.320000] 7fc0: bead79c4 00000000 00008500 00000000 00000000 00000000
40119000 00000000

[  453.328000] 7fe0: 40220f80 bead5860 000085c0 bead5860 60000010 ffffffff

[  453.336000]  r7:00000000 r6:00008500 r5:00000007 r4:0000040f

[  453.344000] -----------------------------------------------------------

[  453.348000] * dump maps on pid (429)

[  453.352000] -----------------------------------------------------------

[  453.360000] 00008000-00009000 r-xp 00000000 08:11 440
/dtv/usb/sdb1/paxtest-0.9.5/execstack

[  453.368000] 00010000-00011000 rw-p 00000000 08:11 440
/dtv/usb/sdb1/paxtest-0.9.5/execstack

[  453.376000] 400bc000-400bd000 rw-p 400bc000 08:11 440

[  453.380000] 400ce000-400cf000 rw-p 400ce000 08:11 440

[  453.384000] 400f2000-40110000 r-xp 00000000 b3:03 105 /mtd_exe/lib/
ld-2.14.1.so

[  453.392000] 40118000-40119000 r--p 0001e000 b3:03 105 /mtd_exe/lib/
ld-2.14.1.so

[  453.400000] 40119000-4011a000 rw-p 0001f000 b3:03 105 /mtd_exe/lib/
ld-2.14.1.so

[  453.408000] 4011c000-4011d000 rw-p 4011c000 b3:03 105

[  453.412000] 4015d000-40277000 r-xp 00000000 b3:03 113 /mtd_exe/lib/
libc-2.14.1.so

[  453.420000] 40277000-4027f000 ---p 0011a000 b3:03 113 /mtd_exe/lib/
libc-2.14.1.so

[  453.428000] 4027f000-40281000 r--p 0011a000 b3:03 113 /mtd_exe/lib/
libc-2.14.1.so

[  453.436000] 40281000-40282000 rw-p 0011c000 b3:03 113 /mtd_exe/lib/
libc-2.14.1.so

[  453.444000] 40282000-40285000 rw-p 40282000 b3:03 113

[  453.448000] beab6000-bead7000 rw-p befde000 b3:03 113

[  453.452000] bead7000-bead8000 rwxp befff000 b3:03 113

[  453.460000] ffff0000-ffff1000 r-xp ffff0000 b3:03 113

[  453.464000] -----------------------------------------------------------

[  453.464000]

[  453.472000] task stack info : pid(429) stack area (0xbead7000 ~
0xbead8000)

[  453.480000] -----------------------------------------------------------

[  453.484000] * dump user stack

[  453.488000] -----------------------------------------------------------

[  453.496000] pid(429) : seems stack overflow.

[  453.496000]   sp(bead5860), stack vma (0xbead7000 ~ 0xbead8000)

[  453.504000] -----------------------------------------------------------

[  453.504000]

[  453.512000] [VDLP COREDUMP] SIGNR:11

[  453.512000]

[  453.520000] ***** Coredump : Insert USB memory stick, mount check per
10sec... *****

[  453.528000] ***** USB detected *****

[  453.528000] ***** Create pid : 429 coredump file to USB mount dir
/dtv/usb/sdb1/Coredump.429.gz ******

[  453.540000] * Ultimate CoreDump v0.4 : started dumping core into
'Coredump.429.gz' file *

[  453.548000] <1>##### elf aligned pages num : 1 + (3 Coredump guard
buffers)

[  453.552000] ##### Not used first lower guard page, elf_foffset : 1488,
aligned_elf_foffset : 4096

[  453.564000] ##### set_gzip_header() return success...

[  453.568000] ##### Allocated 267980 bytes for deflate workspace

[  453.572000] ##### coredump_alloc_workspaces() return success...

                         : [  453.692000] ##### (vma->vm_next) == NULL ...

[  453.700000]  ##### Process addr space debug Info #####

[  453.704000]  ##### vma_cnt : 16

[  453.708000]  ##### vm_page : 47

[  453.708000]  ##### user_page_cnt : 15

[  453.712000]  ##### zero_page_cnt : 32

[  453.716000]  ##### kernel_page_cnt : 0

[  453.720000] ##### uncomp_coredump_file_size : 196608

[  453.724000] ##### GZIP tailer CRC32 : 1604686521

[  453.732000] ***** Create coredump file to USB mount dir ******

[  453.736000] CoreDump: finished dumping core

Killed



*Please let me know how to check the hardware support of XN bit in ARMv6
/ARMv7 and XI bit support on MIPS 34Kc.*

* *

Thanks and Regards,
Girish Gupta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130104/1fc4bfb8/attachment-0001.html>
