From: g3gg0.de@gmail.com (g3gg0)
Date: Thu, 9 Apr 2015 02:56:02 +0200
Subject: ARM946E NOMMU - memory setup issues
Message-ID: <CA+aECfpeDn9K9OaetAvFooeZz6FTC5hBdXHZAQaaxAr82x_PPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello *,

i am currently trying to port linux to Canon EOS DSLRs, which have this setup:
 - ARM946E, 200MHz
 - RAM(cached): 0x00000000 - 0x10000000
 - RAM(uncached): 0x40000000 - 0x50000000

I already had the kernel working when i used xipImage with hardcoded
"flash" address which definitely is in RAM.
config: https://bitbucket.org/hudson/magic-lantern/src/6d860529476b37be313ea157c610e6d1033b6447/contrib/linux-3.19-patches/ml_linux_config?at=linux-bootloader

Now i wanted to switch to the more correct zImage-way, putting it at
32 MiB of our RAM and executing it.
But i am facing some writes into the area around 0x00000000 and beyond
from ext4fs code (ext4_free_blocks) which i dont understand.
Maybe you can give me some hints where i might have a setup problem.
All of that output is from emulator code, however it worked fine with
the xipImage variant.


Important parts of the kernel config:

>  CONFIG_MMU=n
>  CONFIG_SET_MEM_PARAM=y
>  DRAM_BASE=0x00000000
>  DRAM_SIZE=0x10000000
>  AUTO_ZRELADDR=y

The kernel binary vmlinuz has these symbols, which look ok to me.

> Name            Start    End      R W X D L Align  Base Class
> ----            -----    ---      - - - - - -----  ---- -----
> .vectors        00000000 00000020 R . X . L dword  07   CODE
> .stubs          00001000 000012C0 R . X . L 32byte 08   CODE
> .head.text      00008000 00008070 R . X . L dword  01   CODE
> .text           00008080 0020D260 R . X . L 32byte 02   CODE
> .rodata         0020E000 00285F10 R . . . L 32byte 03   CONST
> __bug_table     00285F10 0028993C R . . . L byte   04   CONST
> __param         0028993C 00289E9C R . . . L dword  05   CONST
> __modver        00289E9C 0028A000 R . . . L dword  06   CONST
> .init.text      0028B2E0 0029D644 R . X . L dword  09   CODE
> .exit.text      0029D644 0029E118 R . X . L dword  0A   CODE
> .init.proc.info 0029E118 0029E14C R . X . L dword  0B   CODE
> .init.arch.info 0029E14C 0029E1B4 R . . . L dword  0C   CONST
> .init.tagtable  0029E1B4 0029E1FC R . . . L dword  0D   CONST
> .init.data      0029E1FC 002A232C R W . . L dword  0E   DATA
> .data           002A4000 002CA100 R W . . L 32byte 0F   DATA
> .bss            002CA100 002DCA5C R W . . L 32byte 10   BSS
> abs             002DCA5C 002DCA64 ? ? ? . L para   11

important information from our custom bootloader:

>  Magic Lantern Linux Loader
> ----------------------------
>   Checking RAM size...  256 MiB
>   Setup ATAGs...
>    - Memory:  0x00000000 Size: 0x10000000
>    - Ramdisk: 8192 KiB
>    - initrd:  0x0FB2D100 Size: 0x00400000
>    - cmdline: 'init=/bin/sh root=/dev/ram0 earlyprintk=1'
>   Copying initrd from 0x40961964 to 0x0FB2D100-0x0FF2D100 (0x00400000 bytes)...
>   Copying kernel from 0x40803C08 to 0x02000000-0x0215DD58 (0x0015DD58 bytes)...
>   Starting Kernel...

Now when booting the kernel, i get - as expected - the decompression
routine doing its job.

>  Uncompressing Linux... done, booting the kernel.

The kernel reports that lowmem is using the whole specified memory
range, namely 0x00000000 to 0x10000000.
The routine early_trap_init does also its job well and writes the IV
entries plus the poisoned instructions.

> Booting Linux on physical CPU 0x0
> Linux version 3.19.0-ml (root at linux-dev) (gcc version 4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220] (GNU Tools for ARM Embedded Processors) ) #53 Thu Apr 9 02:37:11 CEST 2015
> CPU: ARM946E-S [41059461] revision 1 (ARMv5TE), cr=00001025
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Canon EOS
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: init=/bin/sh root=/dev/ram0 earlyprintk=1
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 252856K/262144K available (2071K kernel code, 152K rwdata, 496K rodata, 100K init, 74K bss, 9288K reserved, 0K cma-reserved)
> Virtual kernel memory layout:
>     vector  : 0x00000000 - 0x00001000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
>     lowmem  : 0x00000000 - 0x10000000   ( 256 MB)
>       .text : 0x00008000 - 0x0028a024   (2569 kB)
>       .init : 0x0028b000 - 0x002a4000   ( 100 kB)
>       .data : 0x002a4000 - 0x002ca100   ( 153 kB)
>        .bss : 0x002ca100 - 0x002dca5c   (  75 kB)
> NR_IRQS:512
> sched_clock: 16 bits at 1000kHz, resolution 2000ns, wraps every 131070000ns
> console [eos-console0] enabled
> eos_console_init: init display
> BMP: 0x0F440000 YUV: 0x0F500000
> BMP: 0x0F440000 YUV: 0x0F500000
> eos_console_init: setup_timer
> Console: colour dummy device 80x30

After that, the usual initialization code runs until
calibrate_delay_loop freaks out and jumps into nowhere.
Running all that in my emulator revealed that the ext4fs code wrote
into various places where it shouldnt have written.
I am confident that it is not a bug in the ex4fs code, but perhaps
more like a invalid memory setup i passed to the kernel.

So i wonder if you can review settings above and can tell me if i am
doing something totally wrong?
Is it okay to define DRAM_BASE/SIZE to match the whole RAM, which also
contains vectors etc?
These constants get directly into CP15's protection registers, so they
must be sane and match our setup.

Maybe you have got a hint for me. Thanks in advance :)

BR,
Georg
