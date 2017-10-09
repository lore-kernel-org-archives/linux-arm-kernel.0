From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:53:36 +0200
Subject: [PATCH v2 0/3] pinctrl: sunxi: Start to enforce the strict mode
Message-ID: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an attempt to enable pinctrl's strict mode on our pinctrl drivers.
Indeed, our controllers should have had that mode enabled since its
introduction.

However, there's a number of issues with old device trees that prevent from
just enabling it for all the devices. There's basically two of them:

  - Most of our old DTs have a pinctrl node for GPIOs, which will result in
    an error when the driver is going to request the gpio because it would
    already be requested automatically by pinctrl. We cannot break those.

  - Some of these GPIOs also need to change their pin configuration to add
    a bias or change the current output, and there isn't a migration path.

Let's just keep the old behaviour for the old SoCs, and enforce it on the
new one, and enabled it by default so that the situation at least doesn't
get worse.

This has been tested on an A83t (strict on) and an H3 (strict off) board.

Let me know what you think,
Maxime

Changes from v1:
  - Duplicate the pmx_ops before modifying them
  - Disable the strict mode for R_PIO as well

Maxime Ripard (3):
  pinctrl: sunxi: Introduce the strict flag
  pinctrl: sunxi: Disable strict mode for old pinctrl drivers
  pinctrl: sunxi: Enforce the strict mode by default

 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i.c       |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c  |  3 ++-
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c    |  3 ++-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 13 ++++++++++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       |  1 +
 13 files changed, 26 insertions(+), 3 deletions(-)

base-commit: bba731ac5505e73c9b0681762ee0cfa52ccfffed
-- 
git-series 0.9.1
