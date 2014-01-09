From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 09 Jan 2014 11:02:24 +0900
Subject: [GIT PULL] extcon next for 3.14
Message-ID: <52CE0330.4090501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg,

This is extcon-next full request for v3.14. I add detailed description of this
pull request on below. Please pull extcon with following updates.

This patchset is rebased on 'Linux 3-13-rc4' because char-misc-next is based on
'Linux 3-13-rc4'.

Best Regards,
Chanwoo Choi

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-3.14

for you to fetch changes up to 6544dfa5795060b01042fd62fd1a92e18c2fc485:

  extcon: gpio: Add power resume support (2014-01-09 09:53:30 +0900)

----------------------------------------------------------------
Update extcon for v3.14

This patchset add new driver of extcon-max14577.c which detect various external
connector and fix minor issue of extcon provider driver(extcon-arizona/palams/
gpio.c). Also, update documentation of previous 'switch' porting guide and
extcon git repository url.

Detailed description for patchset:
- New driver of extcon-max14577.c
: Add extcon-max14577.c drvier to support Maxim MUIC(Micro USB Interface
Controller) which detect USB/TA/JIG/AUDIO-DOCK and additional accessory
according to each resistance when connected external connector.

- extcon-arizoan.c driver
: Code clean to use define macro instead of hex value
: Fix minor issue to reset back to our staring state
: Fix race with microphone detection and removal

- extcon-palmas.c driver
: Fix minor issue and renaming compatible string of Devicetree

- extcon-gpio.c driver
: Fix bug about ordering initialization of gpio pin on probe()
: Send uevent after wakeup from suspend state because some SoC
  haven't wakeup interrupt on suspend state.

- Documentation (Documentation/extcon/porting-android-switch-class)
: Fix switch class porting guide

- Update extcon git repository url

----------------------------------------------------------------
Chanwoo Choi (2):
      MAINTAINERS: Add git repository for extcon
      extcon: max14577: Add extcon-max14577 driver to support MUIC device

Charles Keepax (5):
      extcon: arizona: Add defines for microphone detection levels
      extcon: arizona: Fix reset of HPDET after race with removal
      extcon: arizona: Fix race with microphone detection and removal
      extcon: arizona: No need to switch back down HPDET ranges
      extcon: arizona: Add support for headphone detection on wm5110 rev D

George Cherian (1):
      extcon: palmas: Handle ID interrupt properly using USB_ID_INT_SRC

Guenter Roeck (1):
      extcon: gpio: Request gpio pin before modifying its state

Kishon Vijay Abraham I (1):
      extcon: palmas: Added a new compatible type *ti,palmas-usb-vid*

MyungJoo Ham (1):
      extcon: fix switch class porting guide (Documentation)

Rongjun Ying (1):
      extcon: gpio: Add power resume support

 .../devicetree/bindings/extcon/extcon-palmas.txt   |   6 +-
 Documentation/extcon/porting-android-switch-class  |   9 +-
 MAINTAINERS                                        |   1 +
 drivers/extcon/Kconfig                             |  10 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-arizona.c                    |  73 +-
 drivers/extcon/extcon-gpio.c                       |  32 +-
 drivers/extcon/extcon-max14577.c                   | 752 +++++++++++++++++++++
 drivers/extcon/extcon-palmas.c                     |  17 +-
 include/linux/extcon/extcon-gpio.h                 |   1 +
 include/linux/mfd/arizona/registers.h              |   9 +
 11 files changed, 876 insertions(+), 35 deletions(-)
 create mode 100644 drivers/extcon/extcon-max14577.c
