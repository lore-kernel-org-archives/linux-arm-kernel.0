From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 13 Sep 2013 09:43:33 +0200
Subject: [RFC PATCH 0/4] pinctrl: at91: various fixes
Message-ID: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes some errors in the pinctrl drivers:
- typos in dt-binding macros and pinctrl-at91 driver (patch 1)
- fix several at91-pinctrl functions (patch 2 and 3)
- rework the debounce config handling (patches 4)

The last point is the most important one: the at91sam9x5/pio3 controller
does not provide a per pin debounce time config. Instead it provides a
common debounce time for all the pins on a given bank (PIOX).

In this series I proposed 2 solutions to gracefully handle this limitation:
1) Handle debounce time conflicts at config time (PATCH 4/4).
   In other words, all the pins on a given bank using the debounce option must
   use the same debounce time. If a device tries to configure a pin with
   conflicting a debounce time, this will result in an -EINVAL error return
   during the pin configuration.
2) Provide a device tree property to define the default debounce time on a
   given bank (PATCH alt 4/4)


I prefer the first solution, as it provides a more future proof approach:
- the generic pinconf layer provides a per pin debounce time config and if
  we plan to support it we should take this into consideration
- IMHO we should be able to (re)configure the debounce time after bootup and
  the second solution does not provide any way to do this

I might be wrong, so please feel free to share your thoughts about this.

Best Regards,

Boris


Boris BREZILLON (4):
  pinctrl: at91: fix typos
  pinctrl: at91: reset caller's config variable before setting flags
  pinctrl: at91: fix get_debounce/deglitch functions for sam9x5
    controller
  pinctrl: at91: check for debounce time conflicts

 drivers/pinctrl/pinctrl-at91.c     |   60 +++++++++++++++++++++++++++---------
 include/dt-bindings/pinctrl/at91.h |    2 +-
 2 files changed, 46 insertions(+), 16 deletions(-)

-- 
1.7.9.5
