From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue,  2 Apr 2013 00:22:39 +0100
Subject: [PATCHv2 0/6] add devicetree bindings for rtc-m48t86
Message-ID: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there are two users of rtc-m48t86 (mach-ep93xx/ts72xx.c and
mach-orion5x/ts78xx-setup.c) and both just use {read,write}b against
a memory mapped region.  As I am devicetree'ing the TS-7800, this
driver needs converting and thats what this patchset does.

The patch does the following:
 * moves m48t86.h to include/linux/platform_data/rtc-m48t86.h
 * adds a new additional interface to rtc-m48t86 via named
	resources that move the ioremap and {read,write}byte
	functionality into the driver (usable by ts7[28]xx)
 * moves the RTC detection routine from ts78xx-setup.c into rtc-m48t86.c
 * converts both ts7[28]xx to use the new interface
 * enable devicetree hooks and include documentation

Alexander Clouter (6):
  rtc: rtc-m48t86: move m48t86.h to platform_data
  rtc: rtc-m48t86: add hooks to support driver side memory mapping
  rtc: rtc-m48t86: add detect method for RTC
  arm: orion5x: move ts78xx to use rtc-m48t86 driver side memory
    interface
  arm: ep93xx: move ts72xx to use rtc-m48t86 driver side memory
    interface
  rtc: rtc-m48t86: add devicetree bindings

 .../devicetree/bindings/rtc/rtc-m48t86.txt         |   17 ++
 arch/arm/mach-ep93xx/ts72xx.c                      |   38 +--
 arch/arm/mach-orion5x/ts78xx-setup.c               |   78 ++----
 drivers/rtc/rtc-m48t86.c                           |  285 ++++++++++++++++----
 .../linux/{m48t86.h => platform_data/rtc-m48t86.h} |    0
 5 files changed, 267 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
 rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)

-- 
1.7.10.4
