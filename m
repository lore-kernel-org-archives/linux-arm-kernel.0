From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 27 Feb 2012 21:15:34 +0900
Subject: [PATCH v6 0/5] Introduce External Connector Class (extcon)
In-Reply-To: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For external connectors, which may have different types of cables attached
(USB, TA, HDMI, Analog A/V, and others), we often have seperated device
drivers that detect the state changes at the port and device drivers that
do something according to the state changes.

An example is a 4-pin (or more pins?) analog audio connector
(usually referred as "3.5-pi" jacks). It can be implemented with the 5/5
patch, "adc-jack", supplied with information about IRQ, a method to get
ADC values, and ADC value ranges. With a 4-pin 3.5-pi port and adc-jack
driver with proper ADC configurations, the following modes may be
detected: "standard mono cable", "standard stereo cable",
"standard stereo + remote cable", "standard stereo + mic + remote cable",
"standard stereo + different-spec mic + remote cable", and such.
Note that for 4-pin cables with mic and remote, there are multiple
standards (at least Samsung and Apple use different configurations for
those 4-pin earphones although the pins looks exactly same.)
and they often can be distinguished with ADC values.

Although we may have simply given different "cable id" for "stereo" and
"stereo + mic". However, for those userspace processes or other device
drivers that are interested only in "stereo" part of possible combinations,
having seperated mode/id for "stereo" and "mic" is more desirable.
For example, if we do not have multistate capabilities, those who want
to know "stereo" is attached or not should monitor everything:
"standard stereo cable", "standard stereo + remove cable",
"standard stereo + mic + remote cable", and others. However, with
multistate capabilities, they only need to monitor the bit associated
with "standard stero".

For another example, when MAX8997-MUIC detects a Charger cable insertion,
another device driver (such as MAX8903 charger, MAX8997 charger, Charger
Manager, or board file) needs to set charger current limit accordingly
and when MAX8997-MUIC detects a HDMI cable insertion, multimedia device
drivers need to do some operations accordingly.


This patchset supports the usage of notifier for passing such information
between device drivers.

Another issue is that at a single switch port, there might be multiple
and heterogeneous cables attached at the same time. Besides the state
(Attached or Detached) of each cable may alter independently. Such extcon
devices that support simultaneous mult-cable attachment include, bot not
limited to, docks, cradles, and 30-pin-like ports (like that of NURI board
in linux/arch/arm/mach-exynos, which resembles Samsung Galaxy Tab series).
For example, the 30-pin port of NURI board may be used to connect analog
audio cables, analog video cable, and a USB or a charger. Because such
cables coonnect part of the 30 pins to external devices/cables, the
possible combinations of external devices/cables vary significantly and
users may fabricate their own design; e.g., an 30-pin adaptor connecting
USB, AC-DC adaptor, HDMI, analog audio, analog video, USB-host, SD-card,
and so on.

In order to address such issues, Android kernel's "Switch" class seems to
be a good basis and we have implemented "Multistate Switch Class" based on
it. The "Switch" class code of Android kernel is GPL as well.

Summary of changes from v5 patchset
- Excluded adc-jack from the "default" patchset. Adc-jack will be later
added after Extcon is finalized.
- Sysfs style updated
- Bugfixes after using at Exynos4412 boards with userspace processes
- Code stype updated

Summary of changes from v4 patchset
- Bugfixes after testing at Exynos4412 boards with userspace processes
- Added adc-jack to support 3.5-pi jack and other ADC-based cable detection
ports.

Summary of changes from v3 patchset
- Bugfixes after testing at Exynos4412 boards.

Summary of changes from v2 patchset
- Support to express mutually exclusive set of cables
- Revised device/class/sysfs-entries add/removal methods
- Added sysfs entries
- Revised documentation and comments
- Some bugfixes
- Compatible with Android (for extcon devices with "use_class_name_switch" set)

Summary of changes from RFC
- ABI documentation added
- Notifees may get notified for a state change of a specific cable, not
every cable of the corresponding extcon.
- Added kerneldoc comments
- Moved to /drivers/extcon/
- Added helper functions
- Some bugfixes

Donggeun Kim (1):
  Extcon: support notification based on the state changes.

MyungJoo Ham (4):
  Extcon (external connector): import Android's switch class and
    modify.
  Extcon: support generic GPIO extcon driver
  Extcon: support multiple states at a device.
  Extcon: support mutually exclusive relation between cables.

 Documentation/ABI/testing/sysfs-class-extcon |   97 +++
 drivers/Kconfig                              |    2 +
 drivers/Makefile                             |    1 +
 drivers/extcon/Kconfig                       |   35 ++
 drivers/extcon/Makefile                      |    6 +
 drivers/extcon/extcon_class.c                |  812 ++++++++++++++++++++++++++
 drivers/extcon/extcon_gpio.c                 |  175 ++++++
 include/linux/extcon.h                       |  322 ++++++++++
 include/linux/extcon/extcon_gpio.h           |   52 ++
 9 files changed, 1502 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-extcon
 create mode 100644 drivers/extcon/Kconfig
 create mode 100644 drivers/extcon/Makefile
 create mode 100644 drivers/extcon/extcon_class.c
 create mode 100644 drivers/extcon/extcon_gpio.c
 create mode 100644 include/linux/extcon.h
 create mode 100644 include/linux/extcon/extcon_gpio.h

-- 
1.7.4.1
