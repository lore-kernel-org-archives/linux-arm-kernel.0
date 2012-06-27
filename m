From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 26 Jun 2012 22:16:59 -0400
Subject: [PATCH] ARM: sa1100: fix build failure on missing IOMEM
In-Reply-To: <20120626232223.GB22977@n2100.arm.linux.org.uk>
References: <1340751341-5248-1-git-send-email-paul.gortmaker@windriver.com>
 <20120626232223.GB22977@n2100.arm.linux.org.uk>
Message-ID: <20120627021658.GA481@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH] ARM: sa1100: fix build failure on missing IOMEM] On 27/06/2012 (Wed 00:22) Russell King - ARM Linux wrote:

> On Tue, Jun 26, 2012 at 06:55:41PM -0400, Paul Gortmaker wrote:
> > Introduced by commit 6686732c8b8974fafbdd7886de0fcf77cf34ec07 [linux-next]
> > 
> >     "ARM: sa11x0/pxa: convert OS timer registers to IOMEM"
> > 
> > which causes:
> > 
> > arch/arm/mach-sa1100/cpu-sa1100.c:153:3: error: implicit declaration of function 'IOMEM'
> 
> I disagree, that commit doesn't - that commit is in my build tree, and:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=1253
> 
> It will be due to some other commit.

I'm not doubting that you've tested it, but I'll need your help in
understanding this bisect result then.  I just re-ran it for the 2nd
fail fix I posted, and this time logged it.  Result is unchanged.

The "bisect run" is just a two liner:
-----
  make O=../test badge4_defconfig
  make O=../test arch/arm/mach-sa1100/jornada720_ssp.o
-----

The jun26 reference is to linux-next of June 26.  Apologies in advance
if I've somehow missed something obvious.

Paul.
---

Script started on Tue 26 Jun 2012 10:02:17 PM EDT
~/git/linux-head$ git bisect good v3.5-rc4
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]? y
~/git/linux-head$ git bisect bad jun26
Bisecting: 2756 revisions left to test after this (roughly 12 steps)
[7510a42fea340d95cdef4b8f1e9c3e52b66605be] Merge remote-tracking branch 'iommu/next'
~/git/linux-head$ git bisect run ~/bisect
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 1462 revisions left to test after this (roughly 11 steps)
[6059a123d53917c0d911ebef2ad58e90b8afe6c2] Merge remote-tracking branch 'slave-dma/next'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 689 revisions left to test after this (roughly 9 steps)
[e72dff68ba26e85d5c624eea938e6007fc4faf39] Merge remote-tracking branch 'vfs/for-next'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  HOSTCC  scripts/mod/modpost.o
  HOSTLD  scripts/mod/modpost
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 254 revisions left to test after this (roughly 8 steps)
[c207eae5dda17351a299fa5a4c7ecee5f72d72f3] Merge remote-tracking branch 'mips/mips-for-linux-next'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 176 revisions left to test after this (roughly 8 steps)
[fe30869505566251e4fc21ac9591d8f486419277] Merge remote-tracking branch 'spi-current/spi/merge'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
Bisecting: 67 revisions left to test after this (roughly 7 steps)
[5fa491b8f19b1968b61ce8370c6d9d00b76daab7] Merge branch 'next/bcm63xx' into mips-for-linux-next
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
Bisecting: 39 revisions left to test after this (roughly 5 steps)
[1a4460ae2e647a11aa15ee1b2c416ab7577dbaf3] Merge remote-tracking branch 'm68k/for-next'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 12 revisions left to test after this (roughly 4 steps)
[798d9f327bf81f847ee93eb4602d1a9e9a040c72] Merge remote-tracking branch 'cris/for-next'
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 8 revisions left to test after this (roughly 3 steps)
[4d0d790e914e85c62bfc099e82eb034222b05837] Merge branches 'fixes' and 'misc' into for-next
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[de02387e01ed38252688cb5668e5a4868b330f96] ARM: Realview: use SGI0 to wake secondary CPUs
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 0 revisions left to test after this (roughly 1 step)
[6686732c8b8974fafbdd7886de0fcf77cf34ec07] ARM: sa11x0/pxa: convert OS timer registers to IOMEM
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c: In function 'jornada_ssp_byte':
/home/paul/git/linux-head/arch/arm/mach-sa1100/jornada720_ssp.c:63: error: implicit declaration of function 'IOMEM'
make[2]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 1
make[1]: *** [arch/arm/mach-sa1100/jornada720_ssp.o] Error 2
make: *** [sub-make] Error 2
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[bcccc50ce8fcc833cfed4bb71ede211a6ef5b84a] ARM: 7420/1: Improve build environment isolation
running /home/paul/bisect
  GEN     /home/paul/git/test/Makefile
#
# configuration written to .config
#
  GEN     /home/paul/git/test/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/paul/git/linux-head as source for kernel
  GEN     /home/paul/git/test/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/paul/git/linux-head/scripts/checksyscalls.sh
  CC      arch/arm/mach-sa1100/jornada720_ssp.o
6686732c8b8974fafbdd7886de0fcf77cf34ec07 is the first bad commit
commit 6686732c8b8974fafbdd7886de0fcf77cf34ec07
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Wed Jun 6 11:42:36 2012 +0100

    ARM: sa11x0/pxa: convert OS timer registers to IOMEM
    
    Make the OS timer registers have IOMEM like properities so they can
    be passed to readl_relaxed/writel_relaxed() et.al. rather than being
    straight volatile dereferences.
    
    This fixes these warnings:
    
    arch/arm/mach-sa1100/time.c: In function 'sa1100_timer_init':
    arch/arm/mach-sa1100/time.c:104: warning: passing argument 1 of 'clocksource_mmio_init' discards qualifiers from pointer target type
    arch/arm/mach-pxa/time.c: In function 'pxa_timer_init':
    arch/arm/mach-pxa/time.c:126: warning: passing argument 1 of 'clocksource_mmio_init' discards qualifiers from pointer target type
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

:040000 040000 fa8e336dda95cbe568452fa228268b0e361bd7df eaec2d7dccb8c7c471098120cb630750937e0d80 M	arch
:040000 040000 1f663b8e9987de28126083b5ad535a8c83064a86 b5b475f491cdc85b3c48b4cd99ef74dc6751ac8d M	drivers
bisect run success
~/git/linux-head$

~/git/linux-head$ git bisect log
git bisect start
# good: [6b16351acbd415e66ba16bf7d473ece1574cf0bc] Linux 3.5-rc4
git bisect good 6b16351acbd415e66ba16bf7d473ece1574cf0bc
# bad: [c7a83d99d1fa6639344072e3a3cfba937f7fa961] Add linux-next
# specific files for 20120626
git bisect bad c7a83d99d1fa6639344072e3a3cfba937f7fa961
# bad: [7510a42fea340d95cdef4b8f1e9c3e52b66605be] Merge remote-tracking
# branch 'iommu/next'
git bisect bad 7510a42fea340d95cdef4b8f1e9c3e52b66605be
# bad: [6059a123d53917c0d911ebef2ad58e90b8afe6c2] Merge remote-tracking
# branch 'slave-dma/next'
git bisect bad 6059a123d53917c0d911ebef2ad58e90b8afe6c2
# bad: [e72dff68ba26e85d5c624eea938e6007fc4faf39] Merge remote-tracking
# branch 'vfs/for-next'
git bisect bad e72dff68ba26e85d5c624eea938e6007fc4faf39
# bad: [c207eae5dda17351a299fa5a4c7ecee5f72d72f3] Merge remote-tracking
# branch 'mips/mips-for-linux-next'
git bisect bad c207eae5dda17351a299fa5a4c7ecee5f72d72f3
# good: [fe30869505566251e4fc21ac9591d8f486419277] Merge remote-tracking
# branch 'spi-current/spi/merge'
git bisect good fe30869505566251e4fc21ac9591d8f486419277
# good: [5fa491b8f19b1968b61ce8370c6d9d00b76daab7] Merge branch
# 'next/bcm63xx' into mips-for-linux-next
git bisect good 5fa491b8f19b1968b61ce8370c6d9d00b76daab7
# bad: [1a4460ae2e647a11aa15ee1b2c416ab7577dbaf3] Merge remote-tracking
# branch 'm68k/for-next'
git bisect bad 1a4460ae2e647a11aa15ee1b2c416ab7577dbaf3
# bad: [798d9f327bf81f847ee93eb4602d1a9e9a040c72] Merge remote-tracking
# branch 'cris/for-next'
git bisect bad 798d9f327bf81f847ee93eb4602d1a9e9a040c72
# bad: [4d0d790e914e85c62bfc099e82eb034222b05837] Merge branches 'fixes'
# and 'misc' into for-next
git bisect bad 4d0d790e914e85c62bfc099e82eb034222b05837
# bad: [de02387e01ed38252688cb5668e5a4868b330f96] ARM: Realview: use
# SGI0 to wake secondary CPUs
git bisect bad de02387e01ed38252688cb5668e5a4868b330f96
# bad: [6686732c8b8974fafbdd7886de0fcf77cf34ec07] ARM: sa11x0/pxa:
# convert OS timer registers to IOMEM
git bisect bad 6686732c8b8974fafbdd7886de0fcf77cf34ec07
# good: [bcccc50ce8fcc833cfed4bb71ede211a6ef5b84a] ARM: 7420/1: Improve
# build environment isolation
git bisect good bcccc50ce8fcc833cfed4bb71ede211a6ef5b84a
~/git/linux-head$ 

Script done on Tue 26 Jun 2012 10:04:27 PM EDT
