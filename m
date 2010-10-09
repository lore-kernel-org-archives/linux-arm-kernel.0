From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Sat, 09 Oct 2010 17:49:39 +0300
Subject: [PATCH 0/2] S3C64XX: Fix 48M clock enable
Message-ID: <20101009143307.30918.15164.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable 48M clock USB PHY must be initialized since 48M
is output of USB PHY PLL.
So fix a problem where other devices requiring 48M clock will
not work unless USB OTG driver is enabled.
is_osc was removed from OTG drivers platform data and implemented
as separate function s3c6400_clk_xusbxti_is_osc which should be
called from machine_init. Currently there is no in-kernel users
of it.

This fix is only for S3C64xx family, but I am sure something
similar will be needed for S5P family. I have started the work
but I am unable to finnish it since I only have datasheet for
S5PC100. Maybe Samsung guys could help me with this..?
However current patches doesn't break S5P since it is not
using s3c-hsotg driver (yet?).

---

Paulius Zaleckas (2):
      USB: s3-hsotg: Remove PHY initialization code and use CLK API
      ARM: S3C64XX: Fix USB and 48M clock enable procedure


 arch/arm/mach-s3c64xx/clock.c               |   67 ++++++++++++++++++-
 arch/arm/plat-samsung/include/plat/clock.h  |    2 +
 arch/arm/plat-samsung/include/plat/udc-hs.h |    2 -
 drivers/usb/gadget/s3c-hsotg.c              |   94 +++++----------------------
 4 files changed, 79 insertions(+), 86 deletions(-)
