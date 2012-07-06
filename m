From: zhouqiao@marvell.com (Qiao Zhou)
Date: Fri,  6 Jul 2012 14:48:46 +0800
Subject: [PATCH 0/4 V4] add 88pm80x mfd driver
Message-ID: <1341557330-24413-1-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change log [v4->v3]:
1, provide unified suspend/resume api for all sub-devices, and add
protection for 800 & 805 wakeup flag in SMP case.
2, clean register definition in 88pm80x.h, and thanks Arnd's help.
3, some minor changes in mfd Kconfig/Makefile.

change log [v3->v2]:
1, dynamically get the irq_base, for both regmap_add_irq_chip and
mfd_add_devices. add pm80x_request_irq & pm80x_free_irq for sub-driver
facility, and modify related irq thread operation. remove irq_base member
from 80x_chip & platform data.
2, split 88pm80x.o into 3 separate modules.
3, remove the 88pm80x r/w API, and directly use open-coded regmap api.
4, minor change: move pm80x_id_table from 80x-i2c.c to 800/805-core.c,
exported pm80x_init, pm80x_deinit, and pm80x_bulk_read, add callback in
pdata.

change log [v2->v1]:
1, split 88pm80x-core.c into 88pm800-core.c and 88pm805.c, per Arnd's
suggestion. after the re-arch, 88pm80x-i2c handles the 800 & 805 common
parts, while 800-core.c & 805-core.c handle the specific parts in each
chip.
2, add details about the workaround adding a i2c companion between 800 &
805, and make a separate patch for it, per Arnd's suggestion.
3, remove callback in pdata. but still keep the pdata currently.
4, only keep necessary register in 88pm80x.h, including registers for
regulator/rtc/onkey/power/codec etc, and remove other registers from global
visibility.
5, exported r/w API which requires regmap handle. as currently the pm800
chip has 3 i2c device, only passing a pm80x_chip info can't ensure r/w the
register in correct i2c device.

change log [v1]:
1, pm800 and pm805 are decoupled and probed separately;
2, re-used the most of API for pm800 and pm805 per Arnd's comments;
3, use regmap_irq, instead of previous 88pm80x_irq_data per Mark's comments.
use regmap_add_irq_chip, and remove previous 88pm80x irq handling.
4, remove callback function in rtc pdata per Arnd's comments.
5, updated some coding style issue.

Qiao Zhou (4):
  mfd: support 88pm80x in 80x driver
  mfd: workaround: add companion chip in 88pm80x
  rtc: add rtc support to 88PM80X PMIC
  input: add onkey support to 88PM80X PMIC

 drivers/input/misc/88pm80x_onkey.c |  176 +++++++++++
 drivers/input/misc/Kconfig         |   10 +
 drivers/input/misc/Makefile        |    1 +
 drivers/mfd/88pm800-core.c         |  593 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm805-core.c         |  299 ++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c          |  144 +++++++++
 drivers/mfd/Kconfig                |   24 ++
 drivers/mfd/Makefile               |    3 +
 drivers/rtc/Kconfig                |   10 +
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-88pm80x.c          |  371 ++++++++++++++++++++++
 include/linux/mfd/88pm80x.h        |  377 +++++++++++++++++++++++
 12 files changed, 2009 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c
 create mode 100644 drivers/mfd/88pm800-core.c
 create mode 100644 drivers/mfd/88pm805-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 drivers/rtc/rtc-88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h
