From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 22 Jun 2016 16:42:00 +0800
Subject: [PATCH v6 0/5] Thermal: Support for hardware-tracked trip points
Message-ID: <1466584925-4829-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you all for providing inputs and comments on previous versions of
this patchset.
Especially thanks to the (Mikko,Sascha,Eduardo,Javi,Steve,Rui....).

The history patches come from Mikko and Sascha.
    http://thread.gmane.org/gmane.linux.power-management.general/59451

Now, I pick them up to continue upstream.
Nevermind!

This series history patches:
v5: https://lkml.org/lkml/2016/6/6/353
v4: https://lkml.org/lkml/2016/5/27/122
v3: https://lkml.org/lkml/2016/5/24/797
v2: https://lkml.org/lkml/2016/5/3/220
v1: https://lkml.org/lkml/2016/4/24/227

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

This series patches rebase the conflicts with the lastest next kernel.
Note that the hardware-tracked trip points are very well tested currently.

Verified and tested on https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0622
That's based on the next kernel (4.7-rc4).
localhost / # cat /proc/version
Linux version 4.7.0-rc4-next-20160622-06645-g5cba085 (wxt at nb)
---
There are five pathes in this series.
thermal: Add support for hardware-tracked trip point
thermal: of: implement .set_trips for device tree thermal zones
thermal: streamline get_trend callbacks
thermal: bang-bang governor: act on lower trip boundary
thermal: rockchip: add the set_trips function

Note: the hardware-tracked trip points that the similar patches were verified
on ChromoeOs platform.
e.g.:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.18
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
---

Anyway, I take the lastest thermal change to test from next kernel,

Tested on RK3399 SoCs on https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
And
Tested on RK3288 SoCs with chromebook on next kernel.
localhost / # while true; do grep "" /sys/class/thermal/thermal_zone[0-1]/temp; sleep .5; done
/sys/class/thermal/thermal_zone1/temp:45454
/sys/class/thermal/thermal_zone2/temp:44090
/sys/class/thermal/thermal_zone1/temp:44545
/sys/class/thermal/thermal_zone2/temp:44545
/sys/class/thermal/thermal_zone1/temp:45454
/sys/class/thermal/thermal_zone2/temp:44545
/sys/class/thermal/thermal_zone1/temp:45000
...
Then add the loading,
localhost / # md5sum /dev/zero &
[3] 8354
..
The Set trips trigger the hardware-tracked points.

rockchip-thermal ff280000.tsadc: sensor 1 - temp: 68461, retval: 0
rockchip-thermal ff280000.tsadc: sensor 2 - temp: 64166, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 75000
rockchip-thermal ff280000.tsadc: sensor 2 - temp: 66153, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 70000
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 68076, retval: 0
rockchip-thermal ff280000.tsadc: sensor 2 - temp: 65384, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 75000
rockchip-thermal ff280000.tsadc: sensor 2 - temp: 65384, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 70000
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70833, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 75000
rockchip-thermal ff280000.tsadc: sensor 2 - temp: 66153, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69230, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 70000
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70416, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 75000
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 69615, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 70000
rockchip-thermal ff280000.tsadc: sensor 1 - temp: 70000, retval: 0
rockchip-thermal ff280000.tsadc: rockchip_thermal_set_trips: sensor 1: low: 68000, high 75000
..
---
Anyway, the series patches are verified on rockchip platform.

Thanks someone are reviewing and testing for it.

-Caesar


Changes in v6:
- add Javi's Reviewed-by
- As Rui's comments on https://patchwork.kernel.org/patch/9157909/,
  add the "get_trip_hyst" to judge.
- fixes a check warning from the scripts.
- as the Keerthy comments on https://patchwork.kernel.org/patch/9157913/,
  change the get_trend for of_thermal.c.

Changes in v5:
- add the lock for thermal_zone_set_trips function.
- change based on next kernel.
- add the tested by Steve.

Changes in v4:
- Missing the lock added in v3.
- as the Javi comments, %s/implemnets/implements.

Changes in v3:
- as Javi comments on https://patchwork.kernel.org/patch/9001281/.
- add the lock for preventing the called from multi placce
- add the note for pre_low/high_trip.
- as the Javi comments on https://patchwork.kernel.org/patch/9001311/.
- add the select if they set the option for devicetree.
- Add the peter's ACK.

Changes in v2:
- update the sysfs-api.txt for set_trips.
- add the commit in patch[v2 2/5].
- Update the commit for patch[v2 4/5].

Caesar Wang (1):
  thermal: rockchip: add the set_trips function

Sascha Hauer (4):
  thermal: Add support for hardware-tracked trip points
  thermal: of: implement .set_trips for device tree thermal zones
  thermal: streamline get_trend callbacks
  thermal: bang-bang governor: act on lower trip boundary

 Documentation/thermal/sysfs-api.txt                |  7 +++
 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/of-thermal.c                       | 35 ++++++++------
 drivers/thermal/rockchip_thermal.c                 | 39 ++++++++++++++++
 drivers/thermal/thermal_core.c                     | 54 ++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c                    |  3 ++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++------
 include/linux/thermal.h                            | 16 ++++++-
 8 files changed, 147 insertions(+), 34 deletions(-)

-- 
1.9.1
