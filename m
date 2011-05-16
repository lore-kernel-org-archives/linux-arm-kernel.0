From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 16 May 2011 14:15:36 +0000
Subject: USB issue on Freescale's i.MX35 3-stack board
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA23CF08@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On the Freescale i.MX35 3DS board, there is a total of 256MB of DDR2 and the configuration is 128MB on Chip-select 0 and 128MB on chip-select 1. So physically, the memory is not contiguous, so we boot up the system with these mem= parameters(mem=128M at 0x80000000 mem=128M at 0x90000000). The system seems to be operating fine and passes stress testing using memtester and oprofile, except for USB.

Running a USB copy stress test on USB mass storage between a USB HDD and an SD/MMC card causes the system to hang. The hang can occur at any time between 10 minutes to 2 hours. The hang is much harder to re-create if logs or delays are introduced.

A few data points from my debugging:
1) If I run the system at 128MB(either at physical 0x80000000 or 0x90000000) then the hang never occurs.
2) Running the same test on a Freescale i.MX53 with a similar memory configuration also does not exhibit the error.
3) This failure can be reproduced on the both the Freescale BSP and the kernel.org BSP for MX35-3DS system.
4) I'm suspecting a memory abort access when the USB HW is DMA-ing its qtd and buffers, but I can't seem to trap on this condition. Any logs that I introduce into the EHCI driver seems to make the hang go away.

If anyone has any idea on how I can further debug, or better yet a suggested fix, I would greatly appreciate it. Also I am available to work with anyone to fix this problem if anyone is interested.

Thanks and best regards,

Dinh
