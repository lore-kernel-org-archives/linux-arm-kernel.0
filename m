From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 24 Sep 2015 15:51:35 -0700
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <20150924090048.GA21626@n2100.arm.linux.org.uk>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
Message-ID: <56047E77.5030301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

+Cc: Lokesh

On 09/24/2015 02:00 AM, Russell King - ARM Linux wrote:
> Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
> SDP fail to boot due to lack of working MMC.  Both platforms fail to
> find their rootfs, which is on a SD card.
> 
> The breakage occurred somewhere between trees of September 9th (commit
> 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
> merge window.
> 
> Diffing those two trees show no changes to OMAP platform code, but
> substantial changes in the MMC code:
> 

[...]

> 
> So this probably results from the MMC update during the merge window:
> 
> 85579ad7f1df Merge tag 'mmc-v4.3' of git://git.linaro.org/people/ulf.hansson/mmc
> 
> The OMAP4430 reports this during it's boot log:
> 
> mmc0: new high speed MMC card at address 0001
> mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
> mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
> ...
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2): error -6
> b300         7757824 mmcblk0  driver: mmcblk
> b310            1024 mmcblk0boot1  (driver?)
> b308            1024 mmcblk0boot0  (driver?)
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)
> 
> whereas previous kernels reported:
> 
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: new high speed SD card at address 0002
> mmcblk0: mmc0:0002 00000 971 MiB
>   mmcblk0: p1 p2
> Waiting 2 sec before mounting root device...
> mmc1: new high speed MMC card at address 0001
> mmcblk1: mmc1:0001 SEM08G 7.39 GiB
> mmcblk1boot0: mmc1:0001 SEM08G partition 1 1.00 MiB
> mmcblk1boot1: mmc1:0001 SEM08G partition 2 1.00 MiB
> ...
> VFS: Mounted root (ext3 filesystem) on device 179:2.
> 
> OMAP3430 only reports:
> 
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6
> 
> where previous kernels reported:
> 
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: new high speed SD card at address 0002
> mmcblk0: mmc0:0002 00000 971 MiB
>   mmcblk0: p1 p2
> ...
> VFS: Mounted root (ext2 filesystem) on device 179:2.
> 

It looks like mmcX enumeration problem, which is not new, I think :(
Most probably with the last DT+code changes probing of MMC which handles SD
is deferred and as result it will get different ID.

I think Lokesh can comment more on this as he fixed it by switching uboot to 
UUIDs instead of partition names.

http://git.ti.com/ti-u-boot/ti-u-boot/commit/5e31eb59f03a424371c605448b6bbc2f93da787b   

-- 
regards,
-grygorii
