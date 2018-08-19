From: dgilbert@interlog.com (Douglas Gilbert)
Date: Sun, 19 Aug 2018 10:42:48 -0400
Subject: broken at91: [PATCH 2/7] mmc: atmel-mci: use sg_copy_{from, to}_buffer
Message-ID: <24a3de74-06e5-b727-bd98-60ed1111b25f@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch can be found on the linux-mmc list on 20180518 and is live in
lk 4.18.0 (and .1,.2,.3). It was not cc-ed to this list.

It is broken on the AT91SAM9G25 and I suspect any AT91 series silicon from
Atmel that uses this driver. In the likely scenario that systems use this
driver to fetch the boot or rootfs partition then they will fail to boot:

...
[    1.700000] Waiting for root device /dev/mmcblk0p2...
[    1.700000] mmc0: unrecognised SCR structure version 2
[    1.710000] mmc0: error -22 whilst initialising SD card
[    1.850000] mmc0: unrecognised SCR structure version 2
[    1.850000] mmc0: error -22 whilst initialising SD card
.... Ad nauseam

The solution is either:
   a) revert the patch, or
   b) or switch the introduced sg_pcopy_from_buffer() calls to
      sg_pcopy_to_buffer() calls, and vice versa

So it is reasonably clear the patch was never tested on real hardware.

Doug Gilbert
