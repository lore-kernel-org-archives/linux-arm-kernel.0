From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 14 Feb 2016 20:55:01 +0100
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160214165010.GA3189@roeck-us.net>
References: <20160214165010.GA3189@roeck-us.net>
Message-ID: <20160214195501.GA12289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding lakml and rmk to Cc]

Hello Guenter,

On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
> Uwe,
> 
> Your patch 'driver-core: platform: probe of-devices only using list of
> compatibles' causes the following qemu tests to crash in -next.
> 
> arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
> arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
> arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
> arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
> 
> Crash log:
> 
> VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
> Please append a correct "root=" boot option; here are the available partitions:
> 1f00          131072 mtdblock0  (driver?)
> 1f01           32768 mtdblock1  (driver?)
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> ie the mmc driver no longer instantiates. Reverting the patch fixes the problem.

The driver is drivers/mmc/host/mmci.c, right? and the relevant device
tree snippet is:

	mmci at 05000 {
		compatible = "arm,pl180", "arm,primecell";
		...
	};

? So the unexpected abnormality here is that even though this device is
instantiated by dt, the driver doesn't provide any compatibles.
Either my expectation is wrong, then 67d02a1bbb33455 should be reverted
(or handle this case in a different way), or the mmci driver should
declare compatibles (but then it needs to be a platform driver and not
an amba driver?).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
