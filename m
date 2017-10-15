From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 15 Oct 2017 18:14:14 +0300
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <20171015130118.GJ20805@n2100.armlinux.org.uk>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <20171015130118.GJ20805@n2100.armlinux.org.uk>
Message-ID: <20171015151414.tedqu3byaelsm3e2@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 15, 2017 at 02:01:19PM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 15, 2017 at 01:46:40PM +0300, Aaro Koskinen wrote:
> > This seems to be simpler to debug/reproduce using busybox. Compiling
> > just busybox with GCC 7.2 and march=armv5te/mtune=xscale already
> > produces failing xz decompression:
> > 
> > root at thecus-n2100:~$ echo foo > foo.txt
> > root at thecus-n2100:~$ xz foo.txt 
> > root at thecus-n2100:~$ ./busybox.gcc-7.2 xz -d foo.txt.xz 
> > xz: corrupted data

[...]

> What mode do you have for alignment handling?
> 
> cat /proc/cpu/alignment

Oh right, thanks, yes it seems GCC generates unaligned access:

root at thecus-n2100:~$ echo 0 > /proc/cpu/alignment 
root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz 
gzip: crc error
root at thecus-n2100:~$ echo 2 > /proc/cpu/alignment 
root at thecus-n2100:~$ ./busybox.gcc-7.2 gzip -d foo.txt.gz 
root at thecus-n2100:~$ 

> Default for older CPUs is to "ignore" then, which basically means that
> unaligned loads are rotated - in other words, the 32-bit naturally
> aligned word is loaded and then rotated such that the addressed byte
> is in bits 0-7.  This is standard behaviour for older CPUs - it's
> how the CPU works when there's no trapping of unaligned accesses, and
> it should really be the way that GCC expects these CPUs to work.
> 
> Since there have been moves to drop older architecture support from GCC,
> I wouldn't be surprised if handling for pre-ARMv6 CPUs was bitrotting
> and GCC was producing code that fails.
> 
> I also know that various folk have put out calls for help with tooling
> for older CPUs (without which support gets dropped), but I don't think
> anyone stepped up.
> 
> So... you might be able to work around the userspace issues by setting
> the alignment fault handling to "fixup" but that really won't help the
> decompressor - we have no ways to take any faults in the decompressor,
> so we can't fix up an unaligned access.

Yes, the fixup is not really a solution. What is confusing is that I
was able to compile bootable kernels for OMAP1 boards, so there GCC is
compiling the decompressor correctly.

A.
