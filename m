From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Tue, 2 Sep 2014 10:29:31 +0200
Subject: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not
 conflict with regulators
In-Reply-To: <20140819152405.GA12002@atomide.com>
References: <20140819152405.GA12002@atomide.com>
Message-ID: <20140902082931.GA32460@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-19 08:24:05 [-0700], Tony Lindgren wrote:
> 
> This allows us to enable the PMIC configuration for n900.
> 
> Fixes: 43fef47f94a1 (mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle)

My beaglebone-ab does not like this. With this patch applied I end up
with:
[    2.437316] Waiting for root device /dev/mmcblk0p2...
[    4.428192] mmc0: card never left busy state
[    4.432647] mmc0: error -110 whilst initialising SD card

I noticed this after I disabled lock debugging and tracing (syscall tracing
was enabled). Enabling both again makes the error go away.
With debugging + tracing disabled (so the error pops up) and git bisect
I get this commit (daebabd57) reported.
A diff between a good/bad bootlog (with lock-debug + tracing switched
off):

| smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
| smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
| hsusb2_vbus: disabling
| VPLL2: disabling
| VUSB3V1: disabling
|+VDAC: disabling
|+VAUX3: disabling
| Waiting for root device /dev/mmcblk0p2...
|-mmc0: host does not support reading read-only switch. assuming write-enable.
|-mmc0: new high speed SDHC card at address 1234
|-mmcblk0: mmc0:1234 SA04G 3.63 GiB 
|- mmcblk0: p1 p2 p3
|-BTRFS: device fsid 2e050bbb-1520-425e-a215-1e5bf865c7dc devid 1 transid 496 /dev/root
|-BTRFS info (device mmcblk0p2): disk space caching is enabled
|-BTRFS: detected SSD devices, enabling SSD mode
|-VFS: Mounted root (btrfs filesystem) readonly on device 0:13.
|-devtmpfs: mounted
|-Freeing unused kernel memory: 216K (c051a000 - c0550000)
|-BTRFS info (device mmcblk0p2): disk space caching is enabled
|-
|-Please press Enter to activate this console. 
|+mmc0: card never left busy state
|+mmc0: error -110 whilst initialising SD card

reverting this commit on top of -rc3 makes mmc0 work again.

Sebastian
