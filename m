From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Jun 2015 23:44:08 +0200
Subject: [RFC 0/3] switch I2C IP cores at runtime
Message-ID: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows an I2C bus to switch between multiple masters. This is not
hot-switching because connected I2C slaves will be re-instantiated. It is meant
to select the best I2C core at runtime once the task is known. Example: Prefer
i2c-gpio over another I2C core because of HW errata affecting your use case.

It works by using OF_DYNAMIC and en-/disabling the devices as needed. See patch
2 for the implementation and more documentation.


Changes since alpha v2 (only sent to sh-devel):

* don't use the i2c-mux infrastructure but create own adapter
  This makes the DT binding proper. Otherwise, they were nested
  another level deeper only for a useless reg = <0>;
  It makes the approach also less I2C specific.

* the bus can now be named
  I like this and consider moving this out of this series and
  implement it in the i2c-core.

* pinctrl states to be used are now named as the bus
  "active" was just a too random name IMO.

* bugfixes (removed two OOPSes)

* more error checking

* beautified the sysfs-readout to make distinction of adapters
  easier

So, this not only a brush up since the last version, rather a new revision.
I couldn't send this to the public with these obvious points left open :)

PS: Since these patches depend on two others, I pushed out a branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/ip-core-switch-v2-on-4.1-experimental


Wolfram Sang (3):
  of: make of_mutex public
  i2c: mux: demux-pinctrl: add driver
  ARM: shmobile: r8a7790: rework dts to use i2c demuxer

 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  44 ++++
 arch/arm/boot/dts/r8a7790-lager.dts                | 141 +++++++----
 drivers/i2c/muxes/Kconfig                          |   9 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 266 +++++++++++++++++++++
 drivers/of/of_private.h                            |   1 -
 include/linux/of.h                                 |   2 +
 7 files changed, 411 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

-- 
2.1.4
