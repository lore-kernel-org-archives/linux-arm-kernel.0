From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:19 +0200
Subject: [PATCH 0/8] pinctrl: meson: clean pin offsets
Message-ID: <20170920133927.17390-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial goal of this series was move to TEST_N pin from the EE
controller to AO controller, where it belongs. This meant modify the
EE_OFF value.

This offset is a quirk we brought from the vendor driver when it was
initially merged. There no reason to keep this around and we could simply
let pinctrl figure the pin base value.

Removing this offset, while simple, ends up being quite a patch bomb.
This is why I split the change over 5 first patches, so the important
change, patch #1 remains visible. Of course, to avoid breaking bisect,
these first 5 patches should be squashed into one. (If you prefer that I
squash it myself, I may have to send you a PR as the patch would exceed
VGER 100000 characters limit)

The last change is this series, while not directly related, also requires
to adjust the gpio-line-names property in DT. Having these changes going
together would make it easier to coordinate the DTS changes.

This was changeset has been test on gxbb P200, gxl libretech-cc.  It was
also boot tested on meson8 (Thx Martin!)

Jerome Brunet (8):
  pinctrl: meson: remove offset from pinctrl
  pinctrl: meson: remove offset continued - gxbb
  pinctrl: meson: remove offset continued - gxl
  pinctrl: meson: remove offset continued - meson8
  pinctrl: meson: remove offset continued - meson8b
  pinctrl: meson: get rid of pin_base
  pinctrl: meson-gx: TEST_N belongs to the AO controller
  pinctrl: meson-gxbb: add missing GPIOX_22 pin

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 859 +++++++++++++------------
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 818 ++++++++++++------------
 drivers/pinctrl/meson/pinctrl-meson.c      |  48 +-
 drivers/pinctrl/meson/pinctrl-meson.h      |   8 +-
 drivers/pinctrl/meson/pinctrl-meson8.c     | 964 ++++++++++++++---------------
 drivers/pinctrl/meson/pinctrl-meson8b.c    | 780 ++++++++++++-----------
 include/dt-bindings/gpio/meson-gxbb-gpio.h |   2 +-
 include/dt-bindings/gpio/meson-gxl-gpio.h  |   2 +-
 8 files changed, 1713 insertions(+), 1768 deletions(-)

-- 
2.13.5
