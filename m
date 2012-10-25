From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 15:25:08 +0300
Subject: [PATCH v2 0/7] I2C patches for v3.8 merge window
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Message-ID: <1351167915-15079-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

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

Changes since v1:
	- remove unnecessary omap_i2c_init() in case of NACK
	- drop "i2c: omap: fix error checking"

Felipe Balbi (6):
  i2c: omap: no need to access platform_device
  i2c: omap: reorder exit path of omap_i2c_xfer_msg()
  i2c: omap: also complete() when stat becomes zero
  i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to
    IRQSTATUS
  i2c: omap: wait for transfer completion before sending STP bit
  i2c: omap: implement handling for 'transferred' bytes

Shubhrajyoti D (1):
  i2c: add 'transferred' field to struct i2c_msg

 drivers/i2c/busses/i2c-omap.c | 124 ++++++++++++++++++++++--------------------
 include/uapi/linux/i2c.h      |   1 +
 2 files changed, 65 insertions(+), 60 deletions(-)

-- 
1.8.0
