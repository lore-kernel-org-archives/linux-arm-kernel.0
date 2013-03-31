From: alex@digriz.org.uk (Alexander Clouter)
Date: Sun, 31 Mar 2013 22:56:08 +0100
Subject: [PATCH 0/3] add devicetree bindings for rtc-m48t86
Message-ID: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there are two users of rtc-m48t86 (mach-ep93xx/ts72xx.c and
mach-orion5x/ts78xx-setup.c) and both just use {read,write}b against
a memory mapped region.  As I am devicetree'ing the TS-7800, this
driver needs converting and thats what this patchset does.

The patch does the following:
 * remove platform specific ops hooks, moving ioremap'ing and
	everything into the driver
 * utilises named resources to indicate index/data ranges
 * moves the RTC detection routine from ts78xx-setup.c into rtc-m48t86.c
 * and, of course, enable devicetree hooks and include documentation

Awkward step, the first patch breaks both boards, the two following
patches fix them.  Happy to re-work this if folks give me a pointer
on how to do this in an acceptable way.

My vote is to break fast, fix fast, spend the time writing other code :)

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>

Alexander Clouter (3):
  rtc: rtc-m48t86: add devicetree bindings
  arm: orion5x: fixup ts78xx to be able to use the rtc-m48t86 again.
  arm: ep93xx: fixup ts72xx to be able to use the rtc-m48t86 again.

 .../devicetree/bindings/rtc/rtc-m48t86.txt         |   17 ++
 arch/arm/mach-ep93xx/ts72xx.c                      |   29 +--
 arch/arm/mach-orion5x/ts78xx-setup.c               |   79 ++----
 drivers/rtc/rtc-m48t86.c                           |  254 +++++++++++++++-----
 include/linux/m48t86.h                             |   16 --
 5 files changed, 239 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
 delete mode 100644 include/linux/m48t86.h

-- 
1.7.10.4
