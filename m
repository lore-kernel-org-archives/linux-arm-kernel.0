From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 11 Jul 2018 15:01:18 +0930
Subject: [RFC PATCH v2 0/4] sysfs interface to miscellaneous BMC controls and
 fields
Message-ID: <20180711053122.30773-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a second stab at exposing hardware controls on Baseboard
Management Controllers that are hard to fit into any a coherent abstraction.

The patches introduce new devicetree bindings and sysfs attributes, along with
a platform driver to expose devicetree nodes of the former as the latter.

Obviously not having an abstract interface to these knobs and switches is not
ideal, but the proposal does have some advantages over devmem:

1. Removal of read-modify-write races, as register update is atomic
2. Reduced foot-gun, as only the defined field is accessible
3. Improved discoverability as the fields are named

The intent is that the setup should be used as a second-last resort (over
devmem). I'm interested in feedback on:

a) Is this a acceptable improvement over devmem?
b) If a), is the devicetree the best way to describe the fields?
c) If b), is directly mapping them to a sysfs attr group managable longterm?

My concern with b) and c) is that there's not a clear restriction on what
fields can be exposed using the driver, so I've tried to compensate by
explicitly documenting the recognised fields in the bindings.

Looking for feedback on all fronts.

Cheers,

Andrew

Andrew Jeffery (4):
  dt-bindings: misc: Add bindings for misc. BMC control fields
  Documentation: ABI: Add sysfs-devices-platform-field to testing
  misc: Add bmc-misc-ctrl
  dts: aspeed-g5: Describe VGA, SIO scratch and DAC mux fields

 .../ABI/testing/sysfs-devices-platform-field  |  95 ++++
 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++
 MAINTAINERS                                   |   8 +
 arch/arm/boot/dts/aspeed-g5.dtsi              | 192 ++++++++
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/bmc-misc-ctrl.c                  | 446 ++++++++++++++++++
 7 files changed, 1005 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-field
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
 create mode 100644 drivers/misc/bmc-misc-ctrl.c

-- 
2.17.1
