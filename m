From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Sep 2015 00:46:38 +0100
Subject: Possible regression: module insertion, relocation misalignement
In-Reply-To: <87vbbvysfc.fsf@belgarion.home>
References: <87egil26sn.fsf@belgarion.home>
 <87vbbvysfc.fsf@belgarion.home>
Message-ID: <20150831234638.GI21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 01:00:39AM +0200, Robert Jarzmik wrote:
> [2] readelf -Sr pxa3xx_nand.ko
> ==============================
> There are 36 section headers, starting at offset 0x6a58:
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .note.gnu.build-i NOTE            00000000 000034 000024 00   A  0   0  4
>   [ 2] .text             PROGBITS        00000000 000058 0020c4 00  AX  0   0  4
>   [ 3] .rel.text         REL             00000000 006378 0004b8 08   I 34   2  4
>   [ 4] .init.text        PROGBITS        00000000 00211c 000014 00  AX  0   0  4
>   [ 5] .rel.init.text    REL             00000000 006830 000018 08   I 34   4  4
>   [ 6] .exit.text        PROGBITS        00000000 002130 00000c 00  AX  0   0  4
>   [ 7] .rel.exit.text    REL             00000000 006848 000010 08   I 34   6  4
>   [ 8] .ARM.extab        PROGBITS        00000000 00213c 000000 00   A  0   0  1
>   [ 9] .ARM.exidx        ARM_EXIDX       00000000 00213c 0000b8 00  AL  2   0  4
>   [10] .rel.ARM.exidx    REL             00000000 006858 0000c0 08   I 34   9  4
>   [11] .rodata.str       PROGBITS        00000000 0021f4 00003e 01 AMS  0   0  1
>   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  1

This shows that the bug table has an alignment of 1, which is silly as
it contains 32-bit values - this really ought to be indicating an
alignment of 4.

I notice that a bunch of my modules are the same as well.  Try adding
".align 2" into arch/arm/include/asm/bug.h, __BUG() macro, just after
".pushsection __bug_table" which should have the effect of increasing
the alignment of the section.

It probably hasn't been noticed on ARMv6 and later because they'll
always fix up these relocations transparently.

For ARMv5 and older, you really ought to have the alignment handler
enabled - IP networking pretty much relies on this being present to
catch corner cases (eg, with TCP options mis-aligning subsequent data.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
