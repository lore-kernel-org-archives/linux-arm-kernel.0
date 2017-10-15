From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Oct 2017 14:01:19 +0100
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
Message-ID: <20171015130118.GJ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 15, 2017 at 01:46:40PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> It dies already during decompression so earlycon does not help much.
> 
> This seems to be simpler to debug/reproduce using busybox. Compiling
> just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
> produces failing xz decompression:
> 
> root at thecus-n2100:~$ echo foo > foo.txt
> root at thecus-n2100:~$ xz foo.txt 
> root at thecus-n2100:~$ ./busybox.gcc-7.2 xz -d foo.txt.xz 
> xz: corrupted data
> root at thecus-n2100:~$ ./busybox.gcc-6.4 xz -d foo.txt.xz 
> root at thecus-n2100:~$ cat foo.txt
> foo
> 
> gzip is no better:
> 
> root at thecus-n2100:~$ gzip foo.txt 
> root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz 
> gzip: crc error
> root at thecus-n2100:~$ ./busybox.gcc-6.4 gzip -d foo.txt.gz 
> root at thecus-n2100:~$ cat foo.txt
> foo
> 
> With bigger files (e.g. compressed binary), gzip gets stuck and produces
> an ever growing file.
> 
> This requires specific hardware to reproduce:
> 
> root at thecus-n2100:~$ cat /proc/cpuinfo 
> processor       : 0
> model name      : XScale-80219 rev 0 (v5l)
> BogoMIPS        : 591.87
> Features        : swp half thumb fastmult edsp 
> CPU implementer : 0x69
> CPU architecture: 5TE
> CPU variant     : 0x0
> CPU part        : 0x2e3
> CPU revision    : 0
> 
> Hardware        : Thecus N2100
> Revision        : 0000
> Serial          : 0000000000000000
> 
> The same failing binary (busybox.gcc-7.2) seems to work fine on RPi 2...?!
> 
> Anyway it seems that GCC 7.2 is unsuitable for building Linux at least
> for some ARM platforms.

What mode do you have for alignment handling?

cat /proc/cpu/alignment

Default for older CPUs is to "ignore" then, which basically means that
unaligned loads are rotated - in other words, the 32-bit naturally
aligned word is loaded and then rotated such that the addressed byte
is in bits 0-7.  This is standard behaviour for older CPUs - it's
how the CPU works when there's no trapping of unaligned accesses, and
it should really be the way that GCC expects these CPUs to work.

Since there have been moves to drop older architecture support from GCC,
I wouldn't be surprised if handling for pre-ARMv6 CPUs was bitrotting
and GCC was producing code that fails.

I also know that various folk have put out calls for help with tooling
for older CPUs (without which support gets dropped), but I don't think
anyone stepped up.

So... you might be able to work around the userspace issues by setting
the alignment fault handling to "fixup" but that really won't help the
decompressor - we have no ways to take any faults in the decompressor,
so we can't fix up an unaligned access.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
