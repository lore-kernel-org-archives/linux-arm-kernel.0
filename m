From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  3 Jul 2018 17:04:09 +1000
Subject: [RFC PATCH 0/4] sysfs interface to miscellaneous BMC controls and
 fields
Message-ID: <20180703070413.28756-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*Dons firefighting gear*

Hello,

This series introduces a bmc-misc-ctrl driver for exposing hardware interfaces
provided by the BMC (Baseboard Management Controller) for scratch register
communication between the host and the BMC, and other miscellaneous switches
controlling BMC hardware features that can be exposed to the host.

Previously Ben Herrenschmidt sent mail wanting to get some consensus on a good
way forward:

https://lkml.org/lkml/2018/4/10/222

To summarise Ben's points:

We have found that the controls we need to expose do not fit well into existing
driver models for several reasons:

1. Not exposing the fields to userspace would instead mean encoding policy
   affecting the host system into the BMC kernel (typically scratch registers)
2. Some controls are so unique as to defy integration into other drivers
3. Exposing specific, well-constrained fields feels less evil than falling back
   to devmem.

This series is one implementation of what we had in mind. My motivation is with
respect to ASPEED BMC hardware but Dell have also indicated they would also
make use of something similar for Nuvoton BMCs.

To those ends, the implementation of bmc-misc-ctrl introduced here:

1. Uses devicetree to describe the miscellaneous fields and switches
2. Exposes the fields in sysfs via value/mask/set/clear attributes
3. Adds a 'bmc' class for the fields to aid discovery in userspace

Now, the intent is bmc-misc-ctrl is used as a last resort. If features can
sanely be exposed in more appropriate drivers, then that should (obviously) be
done instead.

I'm sending this out as an RFC as I'm sure people will have feedback. I hope it
will be more constructive than 'NAK'.

Thanks,

Andrew

Andrew Jeffery (4):
  dts: misc: Add bindings documentation for bmc-misc-ctrl
  Documentation: ABI: Add sysfs-class-bmc documentation to testing
  misc: Add bmc-misc-ctrl
  dts: aspeed-g5: Add bmc-misc-ctrl nodes to devicetree

 Documentation/ABI/testing/sysfs-class-bmc     |  62 +++
 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi              | 192 +++++++++
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/bmc-misc-ctrl.c                  | 363 ++++++++++++++++++
 7 files changed, 885 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-bmc
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
 create mode 100644 drivers/misc/bmc-misc-ctrl.c

-- 
2.17.1
