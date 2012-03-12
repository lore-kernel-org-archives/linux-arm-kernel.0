From: hunold@linuxtv.org (Michael Hunold)
Date: Mon, 12 Mar 2012 15:17:02 +0100
Subject: iMX53 SATA performance
Message-ID: <4F5E055E.9050202@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have tried to benchmark the performance of the SATA link on the iMX53
Quick Start Board.

I have used a TOSHIBA THNSNB030GBSJ SSD which reads about 190MB/s and
writes about 55MB/s on my host PC using "dd" and using /dev/zero as the
data source or sink.

On the iMX53 Quick Start Board both reading and writing using the same
options with "dd" is limited to about 40MB/s.

During a read test, "vmstat" shows the following:
[...]
 1  1      0 837464 185472   3192    0    0 43136     0  369  684  0 28
 0 72
 1  0      0 793320 228864   3192    0    0 43392     0  363  684  0 23
 0 77
 1  1      0 749672 272128   3192    0    0 43264     0  371  687  0 28
 0 72
 1  1      0 705900 315264   3192    0    0 43136     0  367  680  1 28
 0 71
 1  1      0 662128 358400   3192    0    0 43136     0  368  685  1 25
 0 74
[...]

"top" shows:
Cpu(s):  0.6%us, 25.1%sy,  0.0%ni,  0.0%id, 73.7%wa,  0.0%hi,  0.6%si,
0.0%st

"hdparm -t /dev/sda" says "/dev/sda: Timing buffered disk reads:  127 MB
in 3.00 seconds = 43246 kB/s"

The device is detected as follows:
[    0.550659] ata1: SATA max UDMA/133 mmio [mem 0x10000000-0x10000fff]
port 0x100 irq 28
[    0.904998] ata1: SATA link down (SStatus 0 SControl 300)
[...]
[   27.114990] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   27.121378] ata1.00: ATA-8: TOSHIBA THNSNB030GBSJ, AJRA0201, max UDMA/100
[   27.128207] ata1.00: 58626288 sectors, multi 16: LBA48
[   27.133800] ata1.00: configured for UDMA/100
[   27.138109] ata1: EH complete
[   27.141726] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNSNB03
AJRA PQ: 0 ANSI: 5

The output of "vmstat" suggests that really only about 43k 1kB blocks
are travelling via the controller and the output of "top" suggests that
the CPU is really waiting for the I/O.

Does this sound like a reasonable performance for the SATA link of the
iMX53 Quick Start Board?

Of course I was hoping for a little bit more.

CU
Michael.
