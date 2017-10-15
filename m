From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 15 Oct 2017 13:46:40 +0300
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <87mv4txuid.fsf@belgarion.home>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
Message-ID: <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 14, 2017 at 11:57:30PM +0200, Robert Jarzmik wrote:
> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> > On Sat, Sep 02, 2017 at 11:50:55PM +0200, Andrea Adami wrote:
> >> On Thu, Jul 20, 2017 at 8:57 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> >> > Andrea Adami <andrea.adami@gmail.com> writes:
> >> > I have the same report on userspace side on buildroot from Petr [1], which
> >> > triggers endless segfaults in userspace (init) with gcc7 while everything is
> >> > fine with gcc6. I have confirmation on my test farm the problem happens as well.
> >> >
> >> > Since debugging in userspace is far easier, I would suggest attacking the debug
> >> > with Petr on userspace side, and once sorted out, come back to kernel side.
> >> 
> >> sorry for the delay, I was awaiting to test gcc 7.2 and binutils 2.29.
> >> Unfortunately, same issue: XZ-compressed data is corrupt - System Halted.
> >
> > Has anyone been able to debug this further? It seems there are also issues
> > on iop32x/n2100 with GCC 7.2 and binutils 2.29.1 - early boot hangs silently
> > and I cannot get earlyprintk to work. Compiling with GCC 6.4.0 it's OK.
> 
> I didn't find the time for GCC 7.2 testing.
> Yet I have earlyprintk working on my platforms, you need :
>  - on kernel command line for ttyS0 in my case :
>    earlycon=early_pxa,mmio,0x40100000

It dies already during decompression so earlycon does not help much.

This seems to be simpler to debug/reproduce using busybox. Compiling
just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
produces failing xz decompression:

root at thecus-n2100:~$ echo foo > foo.txt
root at thecus-n2100:~$ xz foo.txt 
root at thecus-n2100:~$ ./busybox.gcc-7.2 xz -d foo.txt.xz 
xz: corrupted data
root at thecus-n2100:~$ ./busybox.gcc-6.4 xz -d foo.txt.xz 
root at thecus-n2100:~$ cat foo.txt
foo

gzip is no better:

root at thecus-n2100:~$ gzip foo.txt 
root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz 
gzip: crc error
root at thecus-n2100:~$ ./busybox.gcc-6.4 gzip -d foo.txt.gz 
root at thecus-n2100:~$ cat foo.txt
foo

With bigger files (e.g. compressed binary), gzip gets stuck and produces
an ever growing file.

This requires specific hardware to reproduce:

root at thecus-n2100:~$ cat /proc/cpuinfo 
processor       : 0
model name      : XScale-80219 rev 0 (v5l)
BogoMIPS        : 591.87
Features        : swp half thumb fastmult edsp 
CPU implementer : 0x69
CPU architecture: 5TE
CPU variant     : 0x0
CPU part        : 0x2e3
CPU revision    : 0

Hardware        : Thecus N2100
Revision        : 0000
Serial          : 0000000000000000

The same failing binary (busybox.gcc-7.2) seems to work fine on RPi 2...?!

Anyway it seems that GCC 7.2 is unsuitable for building Linux at least
for some ARM platforms.

A.
