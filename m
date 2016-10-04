From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  4 Oct 2016 09:51:09 +0800
Subject: [PATCH 0/3] pinctrl: sunxi: Support generic pinconf functions
Message-ID: <20161004015112.20833-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series fixes up generic pinconf support for the sunxi pinctrl driver
library. The driver was doing some bits wrong, like a) storing the pinconf
config value in its struct, and not actually reading the hardware to get
the current config, and b) not using the right arguments for the bias
parameters.

Patch 1 makes the driver read out pinconf settings from the hardware, and
returns the correct value for unsupported features and disable features.
With this in place it also declares itself as generic pinconf compatible,
which enables us to read the config through the debugfs pinconf interface.

Patch 2 fixes the pin bias parameter arguments.

Patch 3 makes the sunxi_pconf_group_set callback use the helper function
introduced in patch 1. 

The patches will likely conflict with Maxime's generic pinctrl bindings
series. Lets figure something out.


Regards
ChenYu


Chen-Yu Tsai (3):
  pinctrl: sunxi: Add support for fetching pinconf settings from
    hardware
  pinctrl: sunxi: Fix PIN_CONFIG_BIAS_PULL_{DOWN,UP} argument
  pinctrl: sunxi: Make sunxi_pconf_group_set use sunxi_pconf_reg helper

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 152 ++++++++++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |   1 -
 2 files changed, 118 insertions(+), 35 deletions(-)

-- 
2.9.3
