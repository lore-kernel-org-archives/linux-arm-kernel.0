From: gmane@chmurka.net (Adam Wysocki)
Date: Thu, 18 Aug 2016 14:05:26 +0000 (UTC)
Subject: Linux 4.7 and Jornada 720 (SA-1100)
Message-ID: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I don't know if this is a proper group, but maybe someone will help?

I have a problem running Linux 4.7 on Jornada 720 handheld PC. This 
antique has a StrongARM SA-1100 CPU (ARMv4-based) and Windows CE 3.0 
stored in ROM. There is also an utility called jlinexec.exe (from 
JLime project which is now nearly-dead) that is able to boot Linux 
kernel on this machine.

There is another, older kernel (from this JLime project) that already runs 
there:

gof at jornada7xx:~$ uname -a
Linux jornada7xx 2.6.25-jlime #1 Wed Jul 16 15:52:07 CEST 2008 armv4l unknown 

CPU is:

gof at jornada7xx:~$ cat /proc/cpuinfo
Processor       : StrongARM-1110 rev 8 (v4l)
BogoMIPS        : 137.21
Features        : swp half 26bit fastmult
CPU implementer : 0x69
CPU architecture: 4
CPU variant     : 0x0
CPU part        : 0xb11
CPU revision    : 8

Hardware        : HP Jornada 720
Revision        : 0000
Serial  : 0000000000000000 

I wanted to compile new, fresh 4.7 with BX emulation patch applied:

https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=arm/netwinder&id=6d833b52d0591b47ee65ef2808c459a99f1d37ec

so I could run Debian userland compiled for "armel" architecture there 
(these binaries don't use Thumb state, which this CPU lacks, but use BX 
instruction, so they immediately fail with SIGILL). I did my compilation 
with arm-linux-gnueabi cross-compiler and it compiled cleanly.

However, when I try to run the kernel, the machine hangs. Only one 
horizontal line is visible on the LCD (probably because CPU, normally 
responsible for LCD refreshing, stops doing that) and that's all.

I connected terminal to a serial port and tried playing with earlyprintk= 
and console= settings (earlyprintk=serial,ttyS0,115200), but without luck. 
The only thing I get on the serial port is the jlinexec.exe "logo":

--------linexec--------

I'm not even sure if early printk is available on this architecture...

Kernel command line contains only ram=32 now and there's no initial 
ramdisk (when I get to the point of booting it, I'll add root= and try to 
mount rootfs).

I also tried booting kernel ELF image with hpcboot.exe (a bootloader from 
Jornada NetBSD port), but it failed to boot, too. Well, it's not supposed 
to boot Linux anyway...

Here's my first thread on debian-arm list:

https://groups.google.com/forum/#!topic/linux.debian.ports.arm/lbvmPvA6_2k

But as it became a kernel problem now, I think it's more appropriate to 
ask here.

My kernel .config is here: http://pastebin.com/QSsJybS8

Anyone able to help troubleshoot that?

Thank you!

-- 
http://www.chmurka.net/
