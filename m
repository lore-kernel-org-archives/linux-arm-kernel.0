From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jun 2014 18:26:14 -0700
Subject: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8)
In-Reply-To: <538e6a20.0168440a.7895.422b@mx.google.com>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
Message-ID: <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainline is bust on OMAP5 uevm:

On Tue, Jun 3, 2014 at 5:36 PM, Olof's autobooter <build@lixom.net> wrote:
>
> Failed boards:
>
>     omap5uevm    omap2plus_defconfig           :        FAILED  1:46.03
>     omap5uevm    multi_v7_defconfig            :        FAILED  1:54.51
>     omap5uevm    multi_lpae_defconfig          :        FAILED  1:48.83

...

> ========================================================================
>
>         Board omap5uevm-omap2plus_defconfig failure log:
>         -------------------------------------------------
>
> [    2.625639] Key type dns_resolver registered
> [    2.625730] omap_vc_init_channel: No PMIC info for vdd_core
> [    2.625733] omap_vp_init: No PMIC info for vdd_core
> [    2.625742] omap_vc_init_channel: No PMIC info for vdd_mm
> [    2.625744] omap_vp_init: No PMIC info for vdd_mm
> [    2.625753] omap_vc_init_channel: No PMIC info for vdd_mpu
> [    2.625755] omap_vp_init: No PMIC info for vdd_mpu
> [    2.626307] ThumbEE CPU extension supported.
> [    2.626325] Registering SWP/SWPB emulation handler
> [    2.626328] SmartReflex Class3 initialized
> [    2.683943] mmc0: new high speed MMC card at address 0001
> [    2.685575] palmas 0-0048: Irq flag is 0x00000000
> [    2.696066] mmcblk0: mmc0:0001 SEM04G 3.68 GiB
> [    2.701082] mmcblk0boot0: mmc0:0001 SEM04G partition 1 2.00 MiB
> [    2.707860] mmcblk0boot1: mmc0:0001 SEM04G partition 2 2.00 MiB
> [    2.717172]  mmcblk0: unknown partition table
> [    2.723777]  mmcblk0boot1: unknown partition table
> [    2.730652]  mmcblk0boot0: unknown partition table
> [    2.736698] palmas 0-0048: Muxing GPIO 2, PWM 0, LED 0
> [    2.786540] smps123: 600 <--> 1500 mV at 1060 mV
> [    2.793524] smps45: 600 <--> 1310 mV at 1030 mV
> [    2.800839] smps6: 1200 mV
> [    2.805538] smps7: 1800 mV
> [    2.810397] smps8: 600 <--> 1310 mV at 1040 mV
> [    2.816920] smps9: failed to get the current voltage
> [    2.822852] palmas-pmic palmas_pmic.9: failed to register palmas_pmic.9 regulator
> [    2.833489] palmas-pmic: probe of palmas_pmic.9 failed with error -22
> [    2.840394] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
> [    2.847386] omap_i2c 4807c000.i2c: bus 4 rev0.12 at 400 kHz
> [    2.853554] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc at 4809c000[0]'
> [    2.862637] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc at 4809c000[0]'
> [    2.871980] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -517
> [    2.878930] platform 4809c000.mmc: Driver omap_hsmmc requests probe deferral
> [    2.887507] /home/build/work/batch/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    2.896210] sr_init: No PMIC hook to init smartreflex
> [    2.901664] sr_init: platform driver register failed for SR
> [    2.929862] pbias_mmc_omap5: disabling
> [    2.935342] Waiting for root device /dev/mmcblk1p2...
> ~$off
> # PYBOOT: Exception: timeout


This seems to be from palmas registration failing, which in turns
causes vmmc regulator lookup to fail. See the errors about palmas-pmic
above.

I bisected this down to a merge commit:

commit 4c04ef25b8aae6b5a8c4cc5c0235fc5d239209fd
Merge: 2c7a6a3 dbabd62 0ee42bb ab3ca77 0608032 b203e0d
Author:     Mark Brown <broonie@linaro.org>
AuthorDate: Mon Jun 2 17:08:08 2014 +0100
Commit:     Mark Brown <broonie@linaro.org>
CommitDate: Mon Jun 2 17:08:08 2014 +0100

    Merge remote-tracking branches 'regulator/topic/palmas',
'regulator/topic/pbias', 'regulator/topic/pfuze100',
'regulator/topic/s2mpa01' and 'regulator/topic/s2mps11' into
regulator-next


linux-next has been so broken that I didn't notice this as specific
failures, last successful boot there was May 29.


-Olof
