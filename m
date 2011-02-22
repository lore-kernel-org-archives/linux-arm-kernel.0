From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Feb 2011 17:15:07 +0100
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110222103349.GA2755@pengutronix.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
	<20110222085256.GA19871@S2100-06.ap.freescale.net>
	<20110222103349.GA2755@pengutronix.de>
Message-ID: <201102221715.07480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 February 2011, Wolfram Sang wrote:
> # mount -t vfat /dev/mmcblk0p1 /mnt
> # dd if=/mnt/test.dat of=/tmp/a bs=1024
> # umount /mnt
> # ./dd --version
> dd (coreutils) 8.5

In general, you should try to rule out file system, garbage collection,
partitioning and cache effects.

With coreutils dd, a good command is

dd if=/dev/zero of=/dev/mmcblk0 bs=64K count=64 seek=256 oflag=direct

* Always write multiples of 4 MB to avoid garbage collection
* smaller block sizes may be faster, so writing 64 times 64K may
  be better than writing 4 MB once, depending on the card
* don't write to the FAT area, so start writing at 16 MB into the
  device.
* use direct I/O to bypass the page cache.
* read from /dev/zero instead of a disk file to avoid measuring the
  wrong thing

	Arnd
