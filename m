From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Apr 2017 12:21:29 +0200
Subject: [GIT PULL] Reset controller fixes for v4.11, part 2
Message-ID: <1491387689.2381.75.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag for v4.11, which fixes another bug that
slipped through in commit bb475230b8e5 ("reset: make optional functions
really optional"). If RESET_CONTROLLER is enabled,
devm_reset_controller_get_optional must return NULL after the API
change, if called from a driver that is not probed via device tree
(dev->of_node == NULL). This is the case for recent Intel boards using
the 8250_dw driver, which will be changed to rely on that behaviour 
in v4.12.

regards
Philipp

The following changes since commit 0ca10b60ceeb5372da01798ca68c116ae45a6eb6:

  reset: fix optional reset_control_get stubs to return NULL (2017-03-21 18:19:43 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.11-2

for you to fetch changes up to 62e24c5775ecb387a3eb33701378ccfa6dbc98ee:

  reset: add exported __reset_control_get, return NULL if optional (2017-04-04 17:36:10 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.11

Fix devm_reset_controller_get_optional to return NULL for non-DT devices,
if the RESET_CONTROLLER Kconfig option is enabled. This fixes probe failures
of the 8250_dw driver on Intel platforms after commit acbdad8dd1ab ("serial:
8250_dw: simplify optional reset handling").

----------------------------------------------------------------
Philipp Zabel (1):
      reset: add exported __reset_control_get, return NULL if optional

 drivers/reset/core.c  | 22 ++++++++++++++++------
 include/linux/reset.h | 22 ++++++++++++++--------
 2 files changed, 30 insertions(+), 14 deletions(-)
