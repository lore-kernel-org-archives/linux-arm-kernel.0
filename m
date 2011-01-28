From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Jan 2011 13:21:21 +0100
Subject: [RFC] add pwmlib support
Message-ID: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

While implementing just another pwm driver I thought it's time to implement
generic pwm support. The following series adds drivers/pwm/pwmlib.c and
a i.MX23/28 pwm driver which serves as a usage example for pwmlib. The
code is inspired by gpiolib support and tested using the backlight pwm
driver by Eric Miao.

Currently the pwm_request, pwm_add, pwm_remove and pwm_free operations are
protected with a single mutex wherea the pwm_enable, pwm_disable and
pwm_config operations are unlocked. It is assumed that the owners of the
pwm handle the serialization of the pwm accesses. This may not be enough, so
i'd like to discuss the locking (and type of locking) here.

I Cced the people working with PWMs in the kernel in the hope that they can
give input on what's missing / wrong in this implementation

Sascha


The following changes since commit 2b1caf6ed7b888c95a1909d343799672731651a5:

  Merge branch 'core-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip (2011-01-20 18:30:37 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git pwmlib

Sascha Hauer (2):
      pwmlib: add pwm support
      pwm: Add a i.MX23/28 pwm driver

 drivers/Kconfig       |    2 +
 drivers/Makefile      |    1 +
 drivers/pwm/Kconfig   |   16 +++
 drivers/pwm/Makefile  |    3 +
 drivers/pwm/mxs-pwm.c |  275 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwmlib.c  |  246 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h   |   38 +++++++
 7 files changed, 581 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/mxs-pwm.c
 create mode 100644 drivers/pwm/pwmlib.c
