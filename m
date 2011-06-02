From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 3 Jun 2011 08:48:05 +0900
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106022149.47936.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
Message-ID: <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Interesting, I also use the latest kernel and boot well.
As I don't have the s3c2416 user manaul, I'm not sure it's support
AUTO CMD12 or not. but at least it's support at s3c6410 and later.

[    1.355000] sdhci: Secure Digital Host Controller Interface driver
[    1.360000] sdhci: Copyright(c) Pierre Ossman
[    1.365000] s3c-sdhci s3c-sdhci.0: clock source 2: sclk_mmc (50000000 Hz)
[    1.375000] mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
[    1.380000] s3c-sdhci s3c-sdhci.2: clock source 2: sclk_mmc (50000000 Hz)
[    1.385000] mmc1: no vmmc regulator found
[    1.390000] mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.2] using ADMA
[    1.400000] s3c-sdhci s3c-sdhci.3: clock source 2: sclk_mmc (50000000 Hz)
[    1.405000] mmc2: no vmmc regulator found
[    1.410000] mmc2: SDHCI controller on samsung-hsmmc [s3c-sdhci.3] using ADMA
...
[    1.435000] Waiting for root device /dev/mmcblk0p3...
[    1.650000] mmc0: new high speed MMC card at address 0001
[    1.655000] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
[    1.660000] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
[    1.665000] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
[    1.675000]  mmcblk0: p1 p2 p3 p4 < p5 p6 >
[    1.680000]  mmcblk0boot1: unknown partition table
[    1.685000]  mmcblk0boot0: unknown partition table

I also check the external SD card.

Thank you,
Kyungmin Park


On Fri, Jun 3, 2011 at 4:49 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi,
>
> after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flooded (i.e.
> it never stops) by messages of the form:
>
> mmc1: Got data interrupt 0x00100000 even though no data operation was in
> progress.
> ?sdhci: =========== REGISTER DUMP (mmc1)===========
> ?sdhci: Sys addr: 0x37b1b000 | Version: ?0x00000401
> ?sdhci: Blk size: 0x00007200 | Blk cnt: ?0x00000000
> ?sdhci: Argument: 0x00010000 | Trn mode: 0x00000033
> ?sdhci: Present: ?0x01e70002 | Host ctl: 0x00000012
> ?sdhci: Power: ? ?0x0000000a | Blk gap: ?0x00000000
> ?sdhci: Wake-up: ?0x00000000 | Clock: ? ?0x0000020f
> ?sdhci: Timeout: ?0x0000000e | Int stat: 0x00108000
> ?sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
> ?sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
> ?sdhci: Caps: ? ? 0x05e80080 | Caps_1: ? 0x00000000
> ?sdhci: Cmd: ? ? ?0x00000d1a | Max curr: 0x00000000
> ?sdhci: Host ctl2: 0x00000000
> ?sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x37846808
> ?sdhci: ===========================================
>
>
> hardware: S3C2416 based board, mmc0 is an external micro-SD and mmc1 is a
> ?mmc1: new high speed MMC card at address 0001
> ?mmcblk1: mmc1:0001 HYNIX ?1.88 GiB
> ?mmcblk1boot0: mmc1:0001 HYNIX ?partition 1 256 KiB
> ?mmcblk1boot1: mmc1:0001 HYNIX ?partition 2 256 KiB
> ? mmcblk1: p1 p2 p3
> ? mmcblk1boot1: unknown partition table
> ? mmcblk1boot0: unknown partition table
>
> it uses therefore the sdhci-s3c driver.
>
>
> I did some prodding in the code and found the following peculiarities:
>
> - When I remove Kyungmins AUTO_CMD12-quirk in sdhci-s3c it seems I get one
> functional boot and have only the following messages in the kernel log
>
> ?mmcblk1boot0: retrying using single block read
> ?mmc1: ADMA error
> ?mmcblk1boot0: error -5 transferring data, sector 448, nr 32, card status
> 0x900
> ?end_request: I/O error, dev mmcblk1boot0, sector 448
> ?Buffer I/O error on device mmcblk1boot0, logical block 56
> ?mmcblk1boot1: retrying using single block read
> ?mmc1: ADMA error
> ?mmcblk1boot1: error -5 transferring data, sector 448, nr 32, card status
> 0x900
> ?end_request: I/O error, dev mmcblk1boot1, sector 448
>
> But after a soft reset the irq message flood seems to return.
>
> - When I completely remove the boot partition registration in
> mmc_blk_alloc_parts() in card/block.c it seems that everything return to
> normal, i.e. no strange messages at all
>
>
> I'm not sure if this is a problem of only my board or if it happens on more
> hardware.
>
>
> Heiko
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
