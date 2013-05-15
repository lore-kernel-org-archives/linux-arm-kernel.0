From: pavel@denx.de (Pavel Machek)
Date: Wed, 15 May 2013 15:05:35 +0200
Subject: [PATCH 4/5] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1368571955-6652-4-git-send-email-dinguyen@altera.com>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
 <1368571955-6652-4-git-send-email-dinguyen@altera.com>
Message-ID: <20130515130535.GC9066@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> CC: Pavel Machek <pavel@denx.de>
> CC: <linux@arm.linux.org.uk>

git says:

[pavel at pollux linux]$ cat /tmp/delme | git apply
<stdin>:136: space before tab in indent.
      	     	   altr,dw-mshc-sdr-timing = <0 3>;
<stdin>:143: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
[pavel at pollux linux]$ 

Is this patch series expected to be enough to get MMC to work? I
applied all 5 patches, and it detects the controller, but mmcblkX
devices do not show up.

Synopsys Designware Multimedia Card Interface Driver
dwmmc_socfpga ff704000.dwmmc0: couldn't determine pwr-en, assuming
pwr-en = 0
dwmmc_socfpga ff704000.dwmmc0: Using internal DMA controller.
dwmmc_socfpga ff704000.dwmmc0: Version ID is 240a
dwmmc_socfpga ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit
host data width, 1024 deep fifo
mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz,
actual 400000HZ div = 125)
...
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
Please append a correct "root=" boot option; here are the available
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)

It should be configured in:

CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y

.

Otherwise, it looks good.

Reviewed-by: Pavel Machek <pavel@denx.de>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
