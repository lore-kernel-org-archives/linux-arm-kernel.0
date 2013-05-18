From: w@1wt.eu (Willy Tarreau)
Date: Sat, 18 May 2013 19:01:58 +0200
Subject: ARM: 3.10-rc1 does not boot anymore on OpenBlocks AX3
Message-ID: <20130518170158.GB1936@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

I wanted to give a try to your marvell-pcie-v10-and-seb-clks branch on
my AX3 and got the following error, which I also got after switching
back to plain 3.10-rc1 :

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.10.0-rc-mvebu (willy at pcw) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG 1.18.0) ) #6 SMP Sat May 18 17:40:55 CEST 2013
CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: Marvell Armada 370/XP (Device Tree), model: PlatHome OpenBlocks AX3-4 board
bootconsole [earlycon0] enabled
INITRD: 0x07000040+0x00a5c000 is not a memory region - disabling initrd
Memory policy: ECC disabled, Data cache writealloc
Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

Finally I bisected this to the following patch :

  commit 74898364e717c6bd939bb88d95049fc91d2b4950
  Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
  Date:   Fri Apr 12 16:29:10 2013 +0200

    ARM: dts: mvebu: Convert mvebu device tree files to 64 bits
    
    In order to be able to use more than 4GB of RAM when the LPAE is
    activated, the dts must be converted in 64 bits.
    
    Only Armada XP is LPAE capable, but as it shares a common dtsi file
    with Armada 370, then the common file include the skeleton64. Thanks
    to the use of the overload capability of the device tree format,
    armada-370 include the 32 bit skeleton and all the armada 370 based
    dts can remain the same.
    
    This was heavily based on the work of Lior Amsalem.
    
    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

I'm used to boot my kernel and initrd from the network this way :

  tftpboot 0x7000000 uInitrd4
  tftpboot 0x6400000 uImage-ax3.dtb
  bootm 0x6400000 0x7000000

So the address reported above clearly is the one of the initrd, and
the reported size seems to match my initrd's size (10 MB). I tried
to load at a lower address but it did not change anything. I bisected
using mvebu_defconfig.

My AX3 has 3 GB of RAM if that can make a difference (I still have
not found a 4GB DDR3 module to experiment with). Do you have any idea
of what causes the issue, or do you want me to run more tests ? I can
even open it and remove the 2GB DDR3 module if that can help diagnose
the issue.

Thanks,
Willy
