From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 16:14:22 +0900
Subject: [PATCH v2 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
Message-ID: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the intention of this series is to extend use of the demuxer for I2C
on the lager/r8a7790 to cover all I2C IP blocks.

* This is based on work by Wolfram Sang.
* Testing is discussed below
* This series is based on renesas-devel-20160530-v4.7-rc1.
* To aid review it is provided in git at:
  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/i2c-demux-v2 
* I also intend to add demux for I2C to other R-Car Gen2 boards as a follow-up.

Changes since v1
* Provide GPIO fallback for I2C2,
  this does not seem appropriate for other I2C blocks on the lager board

Simon Horman (4):
  ARM: dts: r8a7790: lager: rename i2cexio as i2cexio0
  ARM: dts: r8a7790: lager: use demuxer for IIC1/I2C1
  ARM: dts: r8a7790: lager: use demuxer for IIC2/I2C2
  ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3

 arch/arm/boot/dts/r8a7790-lager.dts | 252 +++++++++++++++++++++++-------------
 1 file changed, 162 insertions(+), 90 deletions(-)

-- 
2.1.4

Discussion of Testing
=====================

My test case iterates through each available master of each demux that
is available and tries to select the masters in reverse. All relevant
drivers are present as per the shmobile_defconfig. The test fails when
the first error occurs. If there are no errors, that is all masters can
be initialises for all demuxes then the test passes.

My test script, which implements the above, is as follows:

--- begin ---
#!/bin/sh

set -e

cd /sys/devices/platform/

sleep 5 

for i in i2c-*; do
        [ "$i" != 'i2c-*' ] || break
        [ -e "$i/current_master" -a -e "$i/available_masters" ] || continue
        echo "I2C Demux: $i"
        for j in $(< "$i/available_masters" tr ' ' '\n' | tac); do
                idx=${j%:*}
                echo "  Master: $j ($idx)"
                echo "$idx" > "$i/current_master"
                sleep 5
        done
done
--- end ---


Results
-------

1. With no patches applied - that is only the demux for I2C0 present -
   the test passes. Excellent!

   # .  /exercise-i2c-demux.sh
   I2C Demux: i2c-8
     Master: 1:/i2c at e6508000 (1)
   [   22.532192] i2c-rcar e6508000.i2c: probed
     Master: 0:/i2c at e6500000 (0)
   [   27.549555] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz

   Unfortunately from there things are a little less rosy.

2. In general it seems that if more than one demux is present then the
   test fails when iterating through the masters for the first demux
   (that of I2C). E.g. with the first two patches of this series applied
   there is a demux present for I2C0 and I2C1 and the test run is as
   follows. Logs are from the kernel, displayed on the system console where
   the test is also run.

   # ./exercise-i2c-demux.sh
   I2C Demux: i2c-8
     Master: 1:/i2c at e650800
   [   97.694487] i2c-rcar e6508000.i2c: probed 0 (1)
     Master: 0:/i2c at e650000
   [  102.706365] i2c-demux-pinctrl i2c-8: failed to setup demux-adapter 0 (-19) 0 (0)

3. With some manual hacks so that only one demux is present in DT the test
   pasts for the I2C0 (as per 1, above) and I2C2 demux.

   For the I2C2 demux the result is as follows:
   # ./exercise-i2c-demux.sh
   I2C Demux: i2c-9
     Master: 1:/i2c at e6518000 (1)
   [   22.430321] i2c-rcar e6518000.i2c: probed
     Master: 0:/i2c at e6510000 (0)
   [   27.447884] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz

   3.1 Unfortunately it fails for the I2C2 dmux if the GPIO fallback is
       present.

       # ./exercise-i2c-demux.sh
       I2C Demux: i2c-10
         Master: 2:/i2c-11 (2)
       [   22.347864] i2c-gpio i2c-11: using pins 842 (SDA) and 841 (SCL)
       [   22.358210] i2c-demux-pinctrl i2c-10: failed to setup demux-adapter 2 (-19)
       With gpio fallback removed the test passes:

       # ./exercise-i2c-demux.sh
       I2C Demux: i2c-10
         Master: 1:/i2c at e6530000 (1)
       [  120.307738] i2c-rcar e6530000.i2c: probed
       [  120.313186] adv7180 8-0020: chip found @ 0x20 (i2c-demux (master i2c-2))
       [  120.337700] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
         Master: 0:/i2c at e6520000 (0)
       [  125.359197] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
       [  125.367702] adv7180 8-0020: chip found @ 0x20 (i2c-demux (master i2c-6))
       [  125.387803] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0

   3.2 The test also fails for the I2C3 demux but that appears to be due
       to a shortcoming in the voltage regulator code which does not
       appear to like being reinitialised. The kernel complains as follows:

       [   22.365156] ------------[ cut here ]------------
       [   22.374061] WARNING: CPU: 2 PID: 1959 at drivers/regulator/core.c:4099 regulator_unregister+0x6c/0xb8
       [   22.387730] CPU: 2 PID: 1959 Comm: exercise-i2c-de Not tainted 4.7.0-rc1-00006-g05ba3a31af73-dirty #200
       [   22.401620] Hardware name: Generic R8A7790 (Flattened Device Tree)
       [   22.412295] Backtrace:
       [   22.419217] [<c010a070>] (dump_backtrace) from [<c010a210>] (show_stack+0x18/0x1c)
       [   22.431344]  r6:c08271e6 r5:00000000 r4:60000013 r3:00404000
       [   22.441729] [<c010a1f8>] (show_stack) from [<c02d14d8>] (dump_stack+0x80/0xa0)
       [   22.453645] [<c02d1458>] (dump_stack) from [<c011e294>] (__warn+0xc4/0xf0)
       [   22.465179]  r5:c033e0b8 r4:00000000
       [   22.473477] [<c011e1d0>] (__warn) from [<c011e378>] (warn_slowpath_null+0x28/0x30)
       [   22.485785]  r10:c03a8830 r8:ee0d3cf0 r7:ef35ba80 r6:00000006 r5:ee9e4180 r4:ee975400
       [   22.498439] [<c011e350>] (warn_slowpath_null) from [<c033e0b8>] (regulator_unregister+0x6c/0xb8)
       [   22.512014] [<c033e04c>] (regulator_unregister) from [<c033eb20>] (devm_rdev_release+0x14/0x18)
       [   22.525539]  r4:eea2a620 r3:c033eb0c
       [   22.533959] [<c033eb0c>] (devm_rdev_release) from [<c03a8b94>] (release_nodes+0x1a8/0x1d4)
       [   22.547139] [<c03a89ec>] (release_nodes) from [<c03a8f70>] (devres_release_all+0x4c/0x54)
       [   22.560271]  r10:ee0d3f80 r9:ee0d2000 r8:00000100 r7:00000000 r6:c0a30678 r5:c0a22660
       [   22.573189]  r4:eea2a620
       [   22.580694] [<c03a8f24>] (devres_release_all) from [<c03a6178>] (__device_release_driver+0xa4/0x110)
       [   22.594895]  r4:eea2a620 r3:00000000
       [   22.603537] [<c03a60d4>] (__device_release_driver) from [<c03a6310>] (device_release_driver+0x24/0x30)
       [   22.617981]  r5:eea2a620 r4:eea2a654
       [   22.626609] [<c03a62ec>] (device_release_driver) from [<c03a4bf0>] (bus_remove_device+0xe0/0xf0)
       [   22.640434]  r5:ef142030 r4:eea2a620
       [   22.649030] [<c03a4b10>] (bus_remove_device) from [<c03a2770>] (device_del+0x150/0x1dc)
       [   22.662172]  r6:ef1bf058 r5:ee0d3e08 r4:eea2a620 r3:00000009
       [   22.673065] [<c03a2620>] (device_del) from [<c03a2810>] (device_unregister+0x14/0x20)
       [   22.686113]  r6:c04777b4 r5:ee0d3e08 r4:eea2a620
       [   22.696003] [<c03a27fc>] (device_unregister) from [<c047756c>] (i2c_unregister_device+0x30/0x34)
       [   22.710095]  r4:eea2a600 r3:00000008
       [   22.718949] [<c047753c>] (i2c_unregister_device) from [<c04777f4>] (__unregister_client+0x40/0x50)
       [   22.733285]  r4:eea2a600 r3:00000061
       [   22.742240] [<c04777b4>] (__unregister_client) from [<c03a2b0c>] (device_for_each_child+0x44/0x80)
       [   22.756669]  r4:00000000 r3:c0872000
       [   22.765644] [<c03a2ac8>] (device_for_each_child) from [<c0477c24>] (i2c_del_adapter+0x10c/0x1ac)
       [   22.779826]  r7:ef1bf020 r6:c0a7b498 r5:ef1bf058 r4:ef1bf020
       [   22.790898] [<c0477b18>] (i2c_del_adapter) from [<c047ee7c>] (current_master_store+0x64/0xb4)
       [   22.804751]  r8:00000025 r7:00000001 r6:00000000 r5:00000002 r4:ef1bf010 r3:00000002
       [   22.817976] [<c047ee18>] (current_master_store) from [<c03a19cc>] (dev_attr_store+0x20/0x2c)
       [   22.831904]  r8:00000051 r7:ee28a38c r6:edcf9a80 r5:00000002 r4:edcf9a80
       [   22.844254] [<c03a19ac>] (dev_attr_store) from [<c02336f4>] (sysfs_kf_write+0x44/0x50)
       [   22.857811] [<c02336b0>] (sysfs_kf_write) from [<c0232d44>] (kernfs_fop_write+0x154/0x1c0)
       [   22.871729]  r4:ee28a380 r3:c02336b0
       [   22.880953] [<c0232bf0>] (kernfs_fop_write) from [<c01d7298>] (__vfs_write+0x34/0x110)
       [   22.894589]  r10:00000000 r8:000228d0 r7:00000002 r6:ee0d3f80 r5:c0232bf0 r4:ee7c2b40
       [   22.908255] [<c01d7264>] (__vfs_write) from [<c01d7500>] (vfs_write+0xc4/0x150)
       [   22.921333]  r8:ee0d3f80 r7:000228d0 r6:00000002 r5:00000000 r4:ee7c2b40
       [   22.933907] [<c01d743c>] (vfs_write) from [<c01d7658>] (SyS_write+0x48/0x84)
       [   22.946715]  r10:00000000 r8:c01070c4 r7:000228d0 r6:00000002 r5:ee7c2b40 r4:ee7c2b40
       [   22.960386] [<c01d7610>] (SyS_write) from [<c0106f00>] (ret_fast_syscall+0x0/0x3c)
       [   22.973666]  r7:00000004 r6:000217bc r5:00000002 r4:000228d0
       [   22.985117] ---[ end trace 6ff385e193525a58 ]---
       [   22.997372] i2c-rcar e6540000.i2c: probed
