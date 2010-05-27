From: fachkar.datawind@gmail.com (f. achkar)
Date: Thu, 27 May 2010 11:18:41 -0400
Subject: [not solved yet] debugging linux kernel on arm926ejs target
Message-ID: <4BFE8D51.2020708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

anyone successfully debugged linux kernel via openocd + gdb pls read on:

greetings,

I'm newbie and have a s3c2450 based board (arm926ejs), I have a working compressed kernel image
zImage, this image boots properly via u-boot-1.1.6, however I simply 
failed to debug remotely the vmlinux (root directory of linux source tree) via openocd-0.4.0 with a j-link segger.
is there a good reference on how to properly debug the linux kernel via openocd/gdb for an arm target on a linux hot machine?

details:
1. let u-boot start the board;
2. I get the u-boot command prompt:

# bdinfo
      arch_number = 0x00000648
      env_t       = 0x00000000
      boot_params = 0x30000100
      DRAM bank   = 0x00000000
      -> start    = 0x30000000
      -> size     = 0x04000000
      DRAM bank   = 0x00000001
      -> start    = 0x38000000
      -> size     = 0x04000000
      ethaddr     = 00:40:5C:26:0A:5B
      ip_addr     = 192.168.3.5
      baudrate    = 115200 bps

3. halt the target via openocd/telnet;
4. cd to root directory of linux source code and issue:
gdb vmlinux
GNU gdb (GDB) 6.8.50.20090417
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu
--target=arm-none-linux-gnueabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
(gdb)

5.
(gdb) target remote localhost:3333
Remote debugging using localhost:3333
0xc3e01874 in ?? ()
0xc3e01874:    ldr    r3, [r0, #16]
(gdb)

6.
(gdb) set remote hardware-breakpoint-limit 2
(gdb) set remote hardware-watchpoint-limit 2

7.
(gdb) load
Loading section .init, size 0x7b000 lma 0xc0008000
Loading section .text, size 0x2bb618 lma 0xc0083000
Loading section __ksymtab, size 0x4a58 lma 0xc033f000
Loading section __ksymtab_gpl, size 0x1360 lma 0xc0343a58
Loading section __ksymtab_gpl_future, size 0x18 lma 0xc0344db8
Loading section __ksymtab_strings, size 0xcab7 lma 0xc0344dd0
Loading section __param, size 0x654 lma 0xc0351888
Loading section .data, size 0x21538 lma 0xc0352000
Start address 0xc0008000, load size 3582507
Transfer rate: 35 KB/sec, 15922 bytes/write.
(gdb)

8. if I do continue (gdb) c, then I don't see any output on the serial
console (as normally do during zImage booting process!)

where I'm messing up? or how should I get on with debugging the linux kernel at jtag level?

thanks,
ferar
