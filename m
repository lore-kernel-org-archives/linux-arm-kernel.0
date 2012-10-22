From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 12:46:50 +0300
Subject: [PATCH 0/8] I2C patches for v3.8 merge window
Message-ID: <1350899218-13624-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

here's another series for OMAP I2C driver. There are a few cleanups
and one very nice new feature: we can now report how many bytes
we transferred until NACK.

Note that the implemementation for OMAP-I2C turned out to be a
little more complex then I expected, mainly because of the way
I2C_CNT register behaves and because of the very buggy register
usage on that driver.

I have boot tested all patches on beagle xM (3630) and pandaboard
rev A3 (4430), will send boot-logs if anyone wants to see.

All patches are available at [1] if anyone wants an easy way to
test the patches.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-transferred-bytes-on-NACK

Felipe Balbi (7):
  i2c: omap: no need to access platform_device
  i2c: omap: reorder exit path of omap_i2c_xfer_msg()
  i2c: omap: fix error checking
  i2c: omap: also complete() when stat becomes zero
  i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
  i2c: omap: wait for transfer completion before sending STP bit
  i2c: omap: implement handling for 'transferred' bytes

Shubhrajyoti D (1):
  i2c: add 'transferred' field to struct i2c_msg

 arch/arm/mach-omap2/i2c.c                  |   3 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 +-
 drivers/i2c/busses/i2c-omap.c              | 156 ++++++++++++++++-------------
 include/linux/i2c-omap.h                   |   1 +
 include/uapi/linux/i2c.h                   |   1 +
 5 files changed, 89 insertions(+), 74 deletions(-)

-- 
1.8.0.rc0
