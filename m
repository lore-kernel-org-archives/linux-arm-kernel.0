From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Wed, 3 Jul 2013 14:17:01 +0530
Subject: [Patch V2 0/4] rtc: omap: handle rtc wakeup support in driver
Message-ID: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc-omap driver modules is used both by OMAP1/2, Davinci SoC platforms.

However, rtc wake support on OMAP1 is broken. Hence the
device_init_wakeup() was removed from rtc-omap driver and moved to
platform board files that supported it (DA850/OMAP-L138). [1]

However, recently [2] it was suggested that driver should always do a
device_init_wakeup(dev, true). Platforms that don't want/need
wakeup support can disable it from userspace via:

    echo disabled > /sys/devices/.../power/wakeup

Also, with the new DT boot-up, board file doesn't exist and hence there
is no way to have device wakeup support rtc.

The fix for above issues, is to hard code device_init_wakeup() inside
driver and let platforms that don't need this, handle it through the
sysfs power entry.


Also, update Davinci & AM335x files to above changes.

[1]
https://patchwork.kernel.org/patch/136731/

[2]
http://www.mail-archive.com/davinci-linux-open-source at linux.
davincidsp.com/msg26077.html

Changes in V2:
	- Coding style corrections (remove extra space, use lower case
	  for hex numbers
	- use prefix ARM: for commit subject keeping with arch/arm
	  convention)
	- use "[AM/am]3352" instead of "[AM/am]335x" to keep the all
	  usages in sync.
	- Use index defined for struct members so they remain in sync
	- Add new compatible to existing one so that when driver
	  supports enhanced features of hardware, they are available
	  to the user else the basic functionality still works

Hebbar Gururaja (4):
  rtc: omap: restore back (hard-code) wakeup support
  ARM: Davinci: da8xx/omap-l1: Remove hard coding of rtc device wakeup
  rtc: omap: add rtc wakeup support to alarm events
  ARM: dts: AM33XX: update rtc node compatibility

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    6 +-
 arch/arm/boot/dts/am33xx.dtsi                      |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c              |    9 +--
 drivers/rtc/rtc-omap.c                             |   62 +++++++++++++++++---
 4 files changed, 61 insertions(+), 18 deletions(-)

-- 
1.7.9.5
